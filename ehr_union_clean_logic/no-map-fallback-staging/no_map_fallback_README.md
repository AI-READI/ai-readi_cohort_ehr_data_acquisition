# No "Maps to" fallback (step 03)

Code: `myproject/no_map_fallback.py`. How to add it to the pipeline: `PIPELINE_INTEGRATION.md`.

## Problem

Step 03 (`perform_standard_mapping()`) follows `Maps to` from the site's concept to a standard concept and writes `target_concept_id` and `target_domain_id`. When a concept has **no valid `Maps to`**, both stay NULL.

Step 04 then sends those rows to the `*_unmap` CTE of the table the site sent them in (`WHERE target_concept_id IS NULL`). That CTE keeps the site's **non-standard** concept in the main `*_concept_id` column. As a result:
- the row stays in the wrong table when the source concept belongs to another domain;
- a non-standard concept, or an ID that is not in the vocabulary, sits in a CDM concept field.

A second problem is on the source side: `<domain>_source_concept_id` is passed through as the site sent it, even when the ID is not in the concept table.

Example: ICD10CM **Y92.x** "place of occurrence of the external cause" codes (Observation domain, no standard mapping) were sent in CONDITION_OCCURRENCE and stayed there.

## OMOP convention

| Side | Looked up in | Rule |
|---|---|---|
| Target (`<domain>_concept_id`) | `concept_relationship` (`Maps to`, valid) | No match → **0** |
| Source (`<domain>_source_concept_id`) | `concept` | Not found → **0** |
| Table | `concept.domain_id` | With a mapping: the standard concept's domain. Without one: the source concept's domain. Not in the vocabulary: the table the site sent it in |

A non-standard concept is never stored in the main `*_concept_id` column. What the site sent stays in `<domain>_source_value` and in the step 03 site snapshot.

## Where it runs

In `03_all_domains.py`, `make_transform()`, for each table with a concept column:

```
write_site_snapshot()       0. what the site sent -> <site>_ingestion.03_snapshot_<domain>
perform_standard_mapping()  1. 'Maps to' -> target_concept_id, target_domain_id
rescue_meas_value()         2. Meas Value targets -> crosswalk target
apply_concept_replacements() 3. listed deprecated concepts with no 'Maps to' -> reviewed standard concept
apply_no_map_fallback()     4. LAST: remaining NULL targets -> 0; source concept not in concept -> 0
write 03_<domain>
04-domain-map/*.py          route on target_domain_id (unchanged)
```

It runs last, so a real mapping, a Meas Value rescue or a reviewed replacement always wins. The snapshot runs first, so the values the site sent are kept before any of these steps changes them.

## Rules (do not change without review)

1. **Target side: applies to every row with `target_concept_id IS NULL`** (no valid `Maps to`), whatever the reason: no `Maps to`, concept ID not in the vocabulary, or concept 0/NULL.
   - `target_concept_id = 0`, `target_concept_name = 'No matching concept'`.
   - `target_domain_id = source_domain_id` when the site's concept is in the vocabulary and its domain is one step 04 routes to (Condition, Procedure, Measurement, Observation, Drug, Device). Otherwise NULL, so the row stays in the table it was sent in. `source_domain_id` is `concept.domain_id` of the site's `<domain>_concept_id`, set by `perform_standard_mapping()`.
   - `<domain>_source_concept_id` = the site's concept, when the site left it empty or 0 and that concept is in the vocabulary.
2. **Source side: applies to every row, mapped or not.** A `<domain>_source_concept_id` that is not 0/NULL and is not in `concept` becomes 0. This needs its own join on `concept`, because `source_domain_id` describes `<domain>_concept_id`, not `<domain>_source_concept_id`.
3. **Step 04 needs no change.** With `target_concept_id = 0` (no longer NULL), the row skips the `*_unmap` CTE:
   - If the target domain is the table's own (or NULL), the main CTE keeps the row in place with `COALESCE(target_concept_id, 0) = 0`.
   - If the target domain is another table's, that table's CTE picks the row up (e.g. `observation.py` takes `03_condition_occurrence` rows where `target_domain_id = 'Observation'`). It writes concept 0 and carries `*_source_concept_id` and `*_source_value` across.
   - The `*_unmap` CTEs of these five tables receive no rows. They are left in place, unchanged.
4. **Audit columns on the 03 tables:**
   - `no_map_fallback`: 1 = target set to 0 by rule 1.
   - `source_concept_not_in_vocab`: 1 = `<domain>_source_concept_id` set to 0 by rule 2.

## What it changes

| Rows | Before (step 04) | After |
|---|---|---|
| Y92.x (Observation) sent in CONDITION | stay in CONDITION with the non-standard concept | move to OBSERVATION, concept 0, Y92 concept kept in `observation_source_concept_id` |
| Drug concept with no mapping, sent in OBSERVATION | stay in OBSERVATION, non-standard | move to DRUG_EXPOSURE, concept 0 |
| Unmapped concept of the table's own domain | stays, non-standard concept | stays, concept 0 |
| Unmapped concept in a domain with no table (Geography, Unit, Gender…) | stays, non-standard concept | stays, concept 0 |
| Concept ID not in the vocabulary | stays, ID not in the vocabulary | stays, concept 0 |
| Concept 0/NULL | stays, 0/NULL | stays, 0 |
| `<domain>_source_concept_id` not in the vocabulary (any row) | passed through | 0 |

`source_pkey` and `hashed_id` change for rows that used to go through `*_unmap` (`…|CONDITION_CONCEPT_ID:<site concept>` becomes `…|TARGET_CONCEPT_ID:0`), so their final IDs differ from the previous release. Row counts do not change. Link old and new IDs through the site snapshot (`data_partner_id`, site table, `site_domain_id`).

## Reviewed concept replacements (runs just before the fallback)

Some site concepts are deprecated with no `Maps to` and no `Concept replaced by`. Without help the fallback sets them to 0. A short, hand-reviewed list in `concept_replacement_crosswalk.csv` gives a current standard concept for those with an exact-name match (same drug, strength, volume and dose form). Code: `myproject/concept_replacement.py`.

- Only rows with no target (`target_concept_id IS NULL`) are changed, so a vocabulary mapping always wins.
- `load_replacements()` fails the run if a replacement is not a valid standard concept, the site concept is missing, or the names no longer match.
- Audit column: `concept_replacement` (1 = target set from the crosswalk).
- Current entries: 8 deprecated RxNorm Quant Clinical Drug / Clinical Drug concepts (prefilled syringes: rocuronium, gadoteridol, labetalol, succinylcholine, ropivacaine). Deprecated concepts with no exact-name match keep concept 0.
- The CSV holds concept IDs and names only, no row counts.

## Not changed (deliberately)

| Rows | Why |
|---|---|
| **DEVICE_EXPOSURE** (not included yet) | one partner's device concepts came from a name lookup (OSM, LOINC, NDF-RT concepts that share a device's name), and the duplicate device rows are not yet confirmed. Lens, Lead, Graft and Plate are corrected after the union (`ehr_union_clean_logic/ehr_osm_device_name_fix_drop_osm_copies_fromDevice*.sql`). Device rows keep today's behaviour, including `device_unmap`. To enable later, uncomment `device_exposure` in `SOURCE_CONCEPT_COL`: unmapped device rows then stay in DEVICE with concept 0 (`KEEP_IN_TABLE`). |
| VISIT_OCCURRENCE and tables without a concept column | not event tables |
| Standard concepts in a domain with no table (e.g. Meas Value, Geography, Unit, Note, Relationship, Provider) | these have a `Maps to` (to themselves), so they are not "no Maps to". They need crosswalk entries (see `meas_value_rescue_README.md`) |

## Vocabulary version

Concepts not in the vocabulary get concept 0 now rather than waiting for the vocabulary-version check. When `omop_vocab` is upgraded, step 03 maps any of them that a newer release contains, and they skip this step automatically. Concept IDs that are still missing (vocabularies not in the download, local IDs of 2,000,000,000 and above, source codes stored as concept IDs, typos) stay at 0. `drug_not_in_vocab_investigation.sql` shows which is which.

## Maintenance

- **Partner feedback:** report unmapped and not-in-vocabulary source concepts back to the site. The fallback is the safety net, not the fix.
- **Open items:**
  - Enable `device_exposure` after the duplicate device rows are confirmed (and the device name fix moves into step 03).
  - Upgrade the vocabulary after the investigation query is reviewed.
