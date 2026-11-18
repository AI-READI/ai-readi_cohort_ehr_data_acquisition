# No "Maps to" fallback (step 03)

Code: `myproject/no_map_fallback.py`. How to add it to the pipeline: `PIPELINE_INTEGRATION.md`.

## Problem

Step 03 (`perform_standard_mapping()`) follows `Maps to` from the site's concept to a standard concept and writes `target_concept_id` and `target_domain_id`. When a concept has **no valid `Maps to`** (or is 0, or isn't in the vocabulary), both stay NULL. Step 04 then sends those rows to the `*_unmap` CTE of the table the site sent them in. That CTE keeps the site's **non-standard** concept in the main `*_concept_id` column, which fails the domain conformance check after the union (`conformance_check_with_maps_to_status.sql`).

Sites also put values in `*_source_concept_id` that aren't OMOP concept IDs. One partner sends SNOMED CT codes (e.g. `404684003` "Clinical finding") and 3-digit ICD-9-CM codes (e.g. `185`) in `condition_source_concept_id`.

## OMOP convention

- With a standard mapping, the domain of the **standard** concept decides the table.
- Without one, the domain of the **source** concept decides the table. The row is stored there with `*_concept_id = 0`, the site's concept in `*_source_concept_id`, and the code in `*_source_value`.
- `*_source_concept_id` holds an OMOP concept ID (or 0).
- A non-standard concept is never stored in the main `*_concept_id` column.

## Where it runs

Last in step 03: after `perform_standard_mapping()` and `rescue_meas_value()` (the Meas Value rescue matches on the Meas Value target concept, so it must run first). It only changes rows that are still unmapped, so a real mapping or a crosswalk entry always wins.

## Rules

**Rule 1 (target side): every row whose `target_concept_id` is still NULL.**
- `target_concept_id = 0`, `target_concept_name = 'No matching concept'`.
- `target_domain_id = source_domain_id` when the site's concept is in the vocabulary and its domain is one step 04 routes to (Condition, Procedure, Measurement, Observation, Drug, Device). Otherwise NULL, so the row stays in the table it was sent in. This covers concept 0/NULL and concept IDs not in the vocabulary.
- `<domain>_source_concept_id` = the site's concept when the site left it empty or 0 and that concept is in the vocabulary.
- `source_domain_id` is `concept.domain_id` of the site's concept, set by `perform_standard_mapping()`. It is not the table the row arrived in.

Step 04 then routes the row like any mapped row (`target_concept_id IS NOT NULL`) and writes concept 0, so the `*_unmap` CTEs receive no rows from these tables.

**Rule 2 (source side, fail-safe): every row with a `<domain>_source_concept_id` that isn't 0/NULL.**
1. **The value is an OMOP concept ID** in the concept table: kept.
2. **Otherwise, it matches a `concept_code`** in one of the domain's source vocabularies (`SOURCE_CODE_VOCABS`): replaced by that concept's ID. If several vocabularies match, the first in the list wins, so the join never adds rows.

   | Table | Vocabularies tried, in order |
   |---|---|
   | condition_occurrence | SNOMED, ICD10CM, ICD10, ICD9CM |
   | procedure_occurrence | SNOMED, CPT4, HCPCS, ICD10PCS, ICD9Proc |
   | measurement | LOINC, SNOMED |
   | observation | SNOMED, LOINC, ICD10CM |
   | drug_exposure | RxNorm, RxNorm Extension, NDC |

3. **Otherwise:** set to 0 when `ZERO_UNRESOLVED_SOURCE = True` (the default), else kept.

The site's value is always kept in `<domain>_source_concept_id_original`.

**Audit columns on the 03 tables:**

| Column | Meaning |
|---|---|
| `no_map_fallback` | 1 = target set to 0 by rule 1 |
| `<domain>_source_concept_id_original` | the site's value before rule 2 |
| `source_concept_resolution` | `concept_id`, `code:<vocabulary>`, `not found`; NULL when the site sent 0/NULL |

**Calling it:** `apply_no_map_fallback(df, concept_df, domain)`, where `concept_df` is `omop_vocab.concept`.

**Summaries for the run log or a preview:**
- `fallback_summary(df)`: rule 1, by reason (`concept 0/NULL`, `not in vocab`, `in vocab, no Maps to`) and target domain.
- `source_concept_summary(df, domain)`: rule 2, by resolution.
- `unresolved_source_values(df, domain)`: the most frequent values rule 2 couldn't resolve.

## What it changes

| Rows | Before (step 04) | After |
|---|---|---|
| Concept in the vocabulary, no `Maps to`, domain of another table (e.g. ICD10CM Y92.x "place of occurrence", Observation, sent in CONDITION) | stay in the table sent in, non-standard concept | move to that domain's table, concept 0, site concept in `*_source_concept_id` |
| Concept in the vocabulary, no `Maps to`, the table's own domain (e.g. retired CPT4 or SNOMED codes) | stay, non-standard concept | stay, concept 0 |
| Concept 0/NULL, or concept ID not in the vocabulary | `*_unmap` CTE: stay, with the site's value | stay, concept 0 |
| SNOMED or ICD-9-CM code in `*_source_concept_id` | kept as a number that isn't a concept ID | converted to the OMOP concept ID; the original kept in `_original` |
| `*_source_concept_id` that is neither a concept ID nor a known code | kept | 0; the original kept in `_original` |

**Preview (November 2026, three data partners, nothing written):**
- No rows change table.
- Rule 1 set the target to 0 for 248,445 rows at one partner (incl. 217,433 measurement rows already at concept 0), and for 352 and 427 rows at the other two.
- Rule 2, at one partner (10.43 M condition rows):
  - 8,786,482 SNOMED codes and 3,466 ICD-9-CM codes resolved (the ICD-9-CM matches checked against the source text: 32 of 33 agree);
  - 10 rows set to 0 (ICD-9 codes that lost a leading zero, e.g. `96` for `096`).
- Row counts unchanged in every table.

## Not changed (deliberately)

| Rows | Why |
|---|---|
| **DEVICE_EXPOSURE** (not included yet) | one partner's device concepts came from a name lookup (OSM, LOINC, NDF-RT concepts that share a device's name), so their domain says nothing about the record. Lens, Lead, Graft and Plate are corrected after the union (`ehr_union_clean_logic/ehr_osm_device_name_fix_drop_osm_copies_fromDevice*.sql`); the other unmapped device rows are under review. To enable later, uncomment `device_exposure` in `SOURCE_CONCEPT_COL`: unmapped device rows then stay in DEVICE with concept 0 (`KEEP_IN_TABLE`). |
| VISIT_OCCURRENCE, PROVIDER and tables without a concept column | not event tables |
| Standard concepts in a domain with no table (e.g. Meas Value, Geography, Unit, Note, Relationship, Provider) | they have a `Maps to` (to themselves), so they are not unmapped; they need crosswalk entries (see `meas_value_rescue_README.md`) |
| `value_as_concept_id` | not touched; e.g. one partner's TNM staging keeps its non-standard NAACCR value concepts (no `Maps to` in the current vocabulary) |
| ICD-9 codes with a lost leading zero | an integer column can't hold `096`; set to 0, original kept |

## Known limits

- A numeric code that happens to equal a real OMOP concept ID is treated as a concept ID (rule 2, step 1). Check `source_concept_summary` for anything unexpected.
- ICD-10 codes with a dot can only be resolved when `*_source_concept_id` is a string column.
- This fixes the concept columns, not duplicate rows: one partner's condition rows are written once per SNOMED ancestor, and its drug rows once per linked NDC. Those need separate de-duplication.

## Maintenance

- **After an Athena vocabulary refresh:** concepts that gain a `Maps to` are mapped by step 03 and skip rule 1 automatically.
- **Partner feedback:** report non-standard, unmapped source concepts and non-concept values in `*_source_concept_id` back to the site. The fallback is the safety net, not the fix.
- **Open items:**
  - enable `device_exposure` after the device rows are reviewed;
  - optionally try zero-padded ICD-9-CM codes in rule 2.
