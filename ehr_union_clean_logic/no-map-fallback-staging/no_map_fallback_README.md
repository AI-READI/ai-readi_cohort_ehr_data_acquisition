# No "Maps to" fallback (step 03)

Code: `myproject/no_map_fallback.py`. How to add it to the pipeline: `PIPELINE_INTEGRATION.md`.

## Problem

Step 03 (`perform_standard_mapping()`) follows `Maps to` from the site's concept to a standard concept and writes `target_concept_id` and `target_domain_id`. When a concept has **no valid `Maps to`**, both stay NULL.

Step 04 then sends those rows to the `*_unmap` CTE of the table the site sent them in (`WHERE target_concept_id IS NULL`). That CTE keeps the site's **non-standard** concept in the main `*_concept_id` column. As a result:
- the row stays in the wrong table when the source concept belongs to another domain;
- a non-standard concept, or an ID that is not in the vocabulary, sits in a CDM concept field.

A second problem is on the source side: `<domain>_source_concept_id` is passed through as the site sent it, even when the value is not an OMOP concept ID. One partner sends SNOMED CT codes (e.g. `404684003` "Clinical finding") and 3-digit ICD-9-CM codes (e.g. `185`) in `condition_source_concept_id`.

Example: ICD10CM **Y92.x** "place of occurrence of the external cause" codes (Observation domain, no standard mapping) were sent in CONDITION_OCCURRENCE and stayed there.

## OMOP convention

| Side | Looked up in | Rule |
|---|---|---|
| Target (`<domain>_concept_id`) | `concept_relationship` (`Maps to`, valid) | No match → **0** |
| Source (`<domain>_source_concept_id`) | `concept` (`concept_id`, else `concept_code`) | A source code → its concept ID; not found → **0** |
| Table | `concept.domain_id` | With a mapping: the standard concept's domain. Without one: the source concept's domain. Not in the vocabulary: the table the site sent it in |

A non-standard concept is never stored in the main `*_concept_id` column. What the site sent stays in `<domain>_source_value` and in the step 03 site snapshot.

## Where it runs

In `03_all_domains.py`, `make_transform()`, for each table with a concept column:

```
write_site_snapshot()       0. what the site sent -> <site>_ingestion.03_snapshot_<domain>
perform_standard_mapping()  1. 'Maps to' -> target_concept_id, target_domain_id
rescue_meas_value()         2. Meas Value targets -> crosswalk target
apply_concept_replacements() 3. listed deprecated concepts with no 'Maps to' -> reviewed standard concept
apply_no_map_fallback()     4. LAST: remaining NULL targets -> 0; source code -> concept ID, else 0
write 03_<domain>
04-domain-map/*.py          route on target_domain_id (unchanged)
```

It runs last, so a real mapping, a Meas Value rescue or a reviewed replacement always wins. The snapshot runs first, so the values the site sent are kept before any of these steps changes them.

## Rules (do not change without review)

1. **Target side: applies to every row with `target_concept_id IS NULL`** (no valid `Maps to`), whatever the reason: no `Maps to`, concept ID not in the vocabulary, or concept 0/NULL.
   - `target_concept_id = 0`, `target_concept_name = 'No matching concept'`.
   - `target_domain_id = source_domain_id` when the site's concept is in the vocabulary and its domain is one step 04 routes to (Condition, Procedure, Measurement, Observation, Drug, Device). Otherwise NULL, so the row stays in the table it was sent in. Concepts listed in `KEEP_IN_PLACE_CONCEPTS` always stay in the table sent in (e.g. 4237085 Nitrogen dioxide at one partner: observation rows with value 3 and no source value, which are not drug exposures). `source_domain_id` is `concept.domain_id` of the site's `<domain>_concept_id`, set by `perform_standard_mapping()`.
   - `<domain>_source_concept_id` = the site's concept, when the site left it empty or 0 and that concept is in the vocabulary.
2. **Source side (fail-safe): applies to every row, mapped or not, with a `<domain>_source_concept_id` that is not 0/NULL.** It needs its own join on `concept`, because `source_domain_id` describes `<domain>_concept_id`, not `<domain>_source_concept_id`.
   1. **An OMOP concept ID** in `concept`: kept.
   2. **Otherwise, a `concept_code`** in one of the domain's source vocabularies (`SOURCE_CODE_VOCABS`): replaced by that concept's ID. The first vocabulary in the list wins, so the join never adds rows.

      | Table | Vocabularies tried, in order |
      |---|---|
      | condition_occurrence | SNOMED, ICD10CM, ICD10, ICD9CM |
      | procedure_occurrence | SNOMED, CPT4, HCPCS, ICD10PCS, ICD9Proc |
      | measurement | LOINC, SNOMED |
      | observation | SNOMED, LOINC, ICD10CM |
      | drug_exposure | RxNorm, RxNorm Extension, NDC |
   3. **Otherwise:** 0 when `ZERO_UNRESOLVED_SOURCE = True` (the default), else kept.

   The site's value is also kept in `<domain>_source_concept_id_original` (and in the site snapshot).
3. **Step 04 needs no change.** With `target_concept_id = 0` (no longer NULL), the row skips the `*_unmap` CTE:
   - If the target domain is the table's own (or NULL), the main CTE keeps the row in place with `COALESCE(target_concept_id, 0) = 0`.
   - If the target domain is another table's, that table's CTE picks the row up (e.g. `observation.py` takes `03_condition_occurrence` rows where `target_domain_id = 'Observation'`). It writes concept 0 and carries `*_source_concept_id` and `*_source_value` across.
   - The `*_unmap` CTEs of these five tables receive no rows. They are left in place, unchanged.
4. **Audit columns on the 03 tables:**
   - `no_map_fallback`: 1 = target set to 0 by rule 1.
   - `<domain>_source_concept_id_original`: the site's value before rule 2.
   - `source_concept_resolution`: `concept_id`, `code:<vocabulary>` or `not found` (NULL when the site sent 0/NULL).

## What it changes

| Rows | Before (step 04) | After |
|---|---|---|
| Y92.x (Observation) sent in CONDITION | stay in CONDITION with the non-standard concept | move to OBSERVATION, concept 0, Y92 concept kept in `observation_source_concept_id` |
| Drug concept with no mapping, sent in OBSERVATION | stay in OBSERVATION, non-standard | move to DRUG_EXPOSURE, concept 0 |
| Unmapped concept of the table's own domain | stays, non-standard concept | stays, concept 0 |
| Unmapped concept in a domain with no table (Geography, Unit, Gender…) | stays, non-standard concept | stays, concept 0 |
| Concept ID not in the vocabulary | stays, ID not in the vocabulary | stays, concept 0 |
| Concept 0/NULL | stays, 0/NULL | stays, 0 |
| SNOMED or ICD-9-CM code in `<domain>_source_concept_id` | passed through | the code's OMOP concept ID; original kept |
| `<domain>_source_concept_id` neither a concept ID nor a known code | passed through | 0; original kept |

`source_pkey` and `hashed_id` change for rows that used to go through `*_unmap` (`…|CONDITION_CONCEPT_ID:<site concept>` becomes `…|TARGET_CONCEPT_ID:0`), so their final IDs differ from the previous release. Row counts do not change. Link old and new IDs through the site snapshot (`data_partner_id`, site table, `site_domain_id`).

## Reviewed concept replacements (runs just before the fallback)

Some site concepts are deprecated with no `Maps to` and no `Concept replaced by`. Without help the fallback sets them to 0. A short, hand-reviewed list in `concept_replacement_crosswalk.csv` gives a current standard concept for those with an exact-name match (same drug, strength, volume and dose form). Code: `myproject/concept_replacement.py`.

- Only rows with no target (`target_concept_id IS NULL`) are changed, so a vocabulary mapping always wins.
- `load_replacements()` fails the run if a replacement is not a valid standard concept, the site concept is missing, or the names no longer match.
- Audit column: `concept_replacement` (1 = target set from the crosswalk).
- Current entries: 8 deprecated RxNorm Quant Clinical Drug / Clinical Drug concepts (prefilled syringes: rocuronium, gadoteridol, labetalol, succinylcholine, ropivacaine). Deprecated concepts with no exact-name match keep concept 0.
- The CSV holds concept IDs and names only, no row counts.

## Preview (November 2026, three data partners)

- No rows changed table, except one partner's Drug-domain observation concept, which is now held in place by `KEEP_IN_PLACE_CONCEPTS`.
- Row counts unchanged in every table.
- Rule 2 at one partner (10.43 M condition rows): 8,786,482 SNOMED codes and 3,466 ICD-9-CM codes resolved (the ICD-9-CM matches checked against the source text: 32 of 33 agree; the exception is a site mapping error), 10 rows set to 0 (ICD-9 codes that lost a leading zero, e.g. `96` for `096`).
- The other two partners send concept IDs or no source concept at all.

## Known limits

- A numeric code that happens to equal a real OMOP concept ID is treated as a concept ID (rule 2, step 1).
- An integer column cannot hold ICD-9-CM or ICD-10 codes with a leading zero or a dot; those can only be resolved from a string column.
- This fixes the concept columns, not duplicate rows: one partner's condition rows are written once per SNOMED ancestor, and its drug rows once per linked NDC. Those need separate de-duplication.

## Not changed (deliberately)

| Rows | Why |
|---|---|
| **DEVICE_EXPOSURE** (not included yet) | one partner's device concepts came from a name lookup (OSM, LOINC, NDF-RT concepts that share a device's name), and the duplicate device rows are not yet confirmed. Lens, Lead, Graft and Plate are corrected after the union (`ehr_union_clean_logic/ehr_osm_device_name_fix_drop_osm_copies_fromDevice*.sql`). Device rows keep today's behaviour, including `device_unmap`. To enable later, uncomment `device_exposure` in `SOURCE_CONCEPT_COL`: unmapped device rows then stay in DEVICE with concept 0 (`KEEP_IN_TABLE`). |
| VISIT_OCCURRENCE, PROVIDER and tables without a concept column | not event tables |
| `value_as_concept_id` | not touched (e.g. one partner's TNM staging keeps its non-standard NAACCR value concepts, which have no `Maps to`) |
| Standard concepts in a domain with no table (e.g. Meas Value, Geography, Unit, Note, Relationship, Provider) | these have a `Maps to` (to themselves), so they are not "no Maps to". They need crosswalk entries (see `meas_value_rescue_README.md`) |

## Vocabulary version

Concepts not in the vocabulary get concept 0 now rather than waiting for the vocabulary-version check. When `omop_vocab` is upgraded, step 03 maps any of them that a newer release contains, and they skip this step automatically. Concept IDs that are still missing (vocabularies not in the download, local IDs of 2,000,000,000 and above, source codes stored as concept IDs, typos) stay at 0. `drug_not_in_vocab_investigation.sql` shows which is which.

## Maintenance

- **Partner feedback:** report unmapped and not-in-vocabulary source concepts back to the site. The fallback is the safety net, not the fix.
- **Open items:**
  - Enable `device_exposure` after the duplicate device rows are confirmed (and the device name fix moves into step 03).
  - Optionally try zero-padded ICD-9-CM codes in rule 2 (`96` → `096`).
