# No "Maps to" fallback (step 03)

Code: `myproject/no_map_fallback.py`. How to add it to the pipeline: `PIPELINE_INTEGRATION.md`.

## Problem

Step 03 (`perform_standard_mapping()`) follows `Maps to` from the site's concept to a standard concept and writes `target_concept_id` and `target_domain_id`. When a concept has **no valid `Maps to`**, both stay NULL.

Step 04 then sends those rows to the `*_unmap` CTE of the table the site sent them in (`WHERE target_concept_id IS NULL`). That CTE keeps the site's **non-standard** concept in the main `*_concept_id` column. As a result:
- the row stays in the wrong table when the source concept belongs to another domain;
- a non-standard concept sits in a CDM concept field.

Both fail the domain conformance check after the union (`maps_to_status = 'no Maps to: standard concept not found'` in `conformance_check_with_maps_to_status.sql`).

Example: ICD10CM **Y92.x** "place of occurrence of the external cause" codes (Observation domain, no standard mapping) were sent in CONDITION_OCCURRENCE and stayed there.

## OMOP convention

- With a standard mapping, the domain of the **standard** concept decides the table.
- Without one, the domain of the **source** concept decides the table. The row is stored there with `*_concept_id = 0`, the site's concept in `*_source_concept_id`, and the code in `*_source_value`.
- A non-standard concept is never stored in the main `*_concept_id` column.

## Where it runs

Last in step 03, after `perform_standard_mapping()`. It only changes rows that are still unmapped, so a real mapping always wins. When the Meas Value rescue (PR #12) is integrated, it runs before this step: the rescue matches on the Meas Value target concept.

## Rules

1. **Applies to rows where all of these hold:**
   - `target_concept_id IS NULL` (no `Maps to`);
   - `source_concept_id` is not NULL and not 0;
   - `source_domain_id` is not NULL, meaning the site's concept is in `omop_vocab.concept`. `source_domain_id` is `concept.domain_id` of the site's concept, set by `perform_standard_mapping()`. It is not the table the row arrived in.
2. **Sets:**
   - `target_concept_id = 0` and `target_concept_name = 'No matching concept'`.
   - `target_domain_id = source_domain_id` when it is a domain step 04 routes to (Condition, Procedure, Measurement, Observation, Drug, Device); otherwise NULL, so the row stays in the table it was sent in.
   - `<domain>_source_concept_id` = the site's concept, when the site left it empty or 0.
3. **Step 04 needs no change for this.** With `target_concept_id = 0` (no longer NULL), the row skips the `*_unmap` CTE:
   - If the target domain is the table's own (or NULL), the main CTE keeps the row in place with `COALESCE(target_concept_id, 0) = 0`.
   - If the target domain is another table's, that table's CTE picks the row up (e.g. `observation.py` takes `03_condition_occurrence` rows where `target_domain_id = 'Observation'`). It writes concept 0 and carries `*_source_concept_id` and `*_source_value` across.
4. **Audit column on the 03 tables:** `no_map_fallback` (1 = changed by this step).

## What it changes

| Rows | Before (step 04) | After |
|---|---|---|
| Y92.x (Observation) sent in CONDITION | stay in CONDITION with the non-standard concept | move to OBSERVATION, concept 0, Y92 concept kept in `observation_source_concept_id` |
| Drug concept with no mapping, sent in OBSERVATION | stay in OBSERVATION, non-standard | move to DRUG_EXPOSURE, concept 0 |
| Observation concept with no mapping, sent in PROCEDURE | stay in PROCEDURE, non-standard | move to OBSERVATION, concept 0 |
| Unmapped concept of the table's own domain | stays, non-standard concept | stays, concept 0 |
| Unmapped concept in a domain with no table (Geography, Unit, Visit…) | stays, non-standard concept | stays, concept 0 |

## Not changed (deliberately)

| Rows | Why |
|---|---|
| Concept 0 or NULL | nothing to map |
| Concept ID not in the vocabulary (`source_domain_id` NULL), e.g. the "not in vocab" drug rows | they may come from a newer vocabulary version; decide after the vocabulary-version check |
| **DEVICE_EXPOSURE** (not included yet) | one partner's device concepts came from a name lookup (OSM, LOINC, NDF-RT concepts that share a device's name), so their domain says nothing about the record; moving them by domain would put devices in the wrong tables. Lens, Lead, Graft and Plate are corrected after the union (`ehr_union_clean_logic/ehr_osm_device_name_fix_drop_osm_copies_fromDevice*.sql`); the other unmapped device rows are under review. To enable later, uncomment `device_exposure` in `SOURCE_CONCEPT_COL`: unmapped device rows then stay in DEVICE with concept 0 (`KEEP_IN_TABLE`). |
| VISIT_OCCURRENCE and tables without a concept column | not event tables |
| Standard concepts in a domain with no table (e.g. Meas Value, Geography, Unit, Note, Relationship, Provider) | these have a `Maps to` (to themselves), so they are not "no Maps to". They need crosswalk entries (see `meas_value_rescue_README.md`) |

## Maintenance

- **After an Athena vocabulary refresh:** concepts that gain a `Maps to` are mapped by step 03 and skip the fallback automatically.
- **Partner feedback:** report non-standard, unmapped source concepts back to the site. The fallback is the safety net, not the fix.
- **Open items:**
  - Enable `device_exposure` after the unmapped device rows are reviewed (and the device name fix moves into step 03).
  - Decide on the "not in vocab" concepts after the vocabulary-version check.
