# Meas Value target rescue (step 03)

## Problem

Some site concepts map (`Maps to`, usually to themselves) to standard concepts in the **Meas Value** domain. Meas Value concepts are answers, not events, so step 04 has no table to route them to:
- `obs2obs` keeps them in OBSERVATION with the Meas Value concept still in `observation_concept_id`.
- They then fail the domain conformance check.

In the Nov 2026 union this affected OBSERVATION and DEVICE_EXPOSURE rows.

## Where it runs

```
03_all_domains.py
  perform_standard_mapping()   'Maps to' -> target_concept_id, target_domain_id
  rescue_meas_value()          target_domain_id = 'Meas Value' -> crosswalk -> new target_concept_id, target_domain_id
04-domain-map/*.py             route on target_domain_id (unchanged)
```

Code: `myproject/meas_value_rescue.py`. Crosswalk: `03-prepared/meas_value_rescue_crosswalk.csv`.

The files are kept in `ehr_union_clean_logic/meas_value_rescue/` until they are added to the pipeline. `PIPELINE_INTEGRATION.md` in that folder says where each one goes.

## Rules

1. **Join**: `target_domain_id = 'Meas Value'`, crosswalk `source_table` = this table, crosswalk `source_concept_id` = `target_concept_id`, and `value_as_string RLIKE value_regex` when `value_regex` is set. Regexes for the same concept must not overlap; step 03 stops with an error if the row count changes.
2. **Crosswalk target is a real concept**: `target_concept_id` becomes that concept and `target_domain_id` becomes its vocabulary domain. Step 04 then routes the row; e.g. `obs2meas` picks up `target_domain_id = 'Measurement'`.
3. **Crosswalk target = 0**: `target_concept_id = 0` and `target_domain_id = NULL`. Step 04 keeps the row in its own table with concept 0, which is conformant (counted as unmapped).
4. **No crosswalk entry**: the row is unchanged and listed in the step 03 output ("no crosswalk entry"). This is deliberate. Lens, Lead and Graft device rows are name-matched copies that `ehr_union_clean_logic/ehr_osm_device_name_fix_drop_osm_copies_fromDevice*.sql` (#7) finds by concept name and de-duplicates; renaming them here would hide them from that fix.
5. **Source concept**: `*_source_concept_id` keeps the site's concept. If the site left it empty, it is filled from the original target.
6. **Values and units** (observation and measurement):
   - `parse_number_regex` fills `value_as_number` from `value_as_string`, only when `value_as_number` is empty.
   - `target_unit_concept_id` and `target_unit_source_value` replace the unit.
   - Unit present but unmappable gives `unit_concept_id = 0`. Do **not** use 9312 `[G]` for gauge; it is the Newtonian constant of gravitation.
7. **obs → measurement**: `04-domain-map/measurement.py` now carries `value_as_string` into `value_source_value`. MEASUREMENT has no `value_as_string`, and the column was previously NULL, which dropped text results.
8. **Audit columns** on the 03 tables:
   - `meas_value_xwalk_id`: the crosswalk entry used.
   - `meas_value_original_target_concept_id`: the Meas Value concept before the rescue.

## Crosswalk entries

| xwalk_id | Table | Meas Value concept | Match | New target | Routes to | Unit |
|---|---|---|---|---|---|---|
| 1 | observation | 4126842 Size of needle | `N gauge` | 42537416 Hemodialysis needle gauge | Measurement | 0 (gauge) |
| 2 | observation | 4126840 Size of catheter | `N Fr` / `N French` | 0 | stays (Observation) | 9279 [Ch] |
| 3 | observation | 4126840 Size of catheter | `Other:` text | 3018480 Type of Chest tube | Measurement | — |
| 4 | observation | 4118340 Traction weight applied | any | 0 | stays (Observation) | — |
| 5 | observation | 4128808 Number of oxygenators | any | 0 | stays (Observation) | — |
| 6 | device_exposure | 36310218 Pacemaker | any | 4030875 Cardiac pacemaker | Device | — |
| 7 | device_exposure | 45876963 IUD | any | 40355609 Intrauterine contraceptive device | Device | — |
| 8 | device_exposure | 36310617 Mesh | any | 45768044 Surgical mesh | Device | — |
| 10, 13–15 | device_exposure | Bone, Breast, Patella, Nail | any | 0 | stays (Device) | — |
| *(none)* | device_exposure | Lens, Lead, Graft | — | unchanged; handled by #7 | — | — |

IDs 9, 11 and 12 (Lead, Graft, Lens) were retired in favour of #7 and should not be reused.

### Rationale

- **Needles (15–17G)**: this is the dialysis fistula needle range; peripheral IVs are 18–24G.
- **Catheter sizes (8–32 Fr)**: the "Other:" text (PCT, MSCT/MDST mediastinal, Blake) shows these are post-cardiothoracic chest tubes and drains. No standard chest tube size concept exists, so the size is kept as a value under concept 0.
- **Devices**: generic parent concepts are used, since the subtype cannot be told apart without a source value. Bone, Breast, Patella and Nail are ambiguous and get 0 until their UDIs are looked up.

## Checks

- **Step 03 output**: per table, the notebook prints rows rescued by crosswalk entry and Meas Value targets with no entry. Only Lens, Lead and Graft are expected unmatched today. Compare the rescued counts with the previous run's output; a large change means a site changed what it sends.
- **After step 04 and the union**: run `domain_conformance_check.sql` (in this folder). The OBSERVATION Meas Value mismatch should be 0. The DEVICE Meas Value mismatch should be 0 after #7 runs.

## Maintenance

- **No row counts in the repository**: `expected_rows` is left empty on purpose. Row counts stay in the Databricks run output only. Do not commit counts, per-site figures or notebook output to this repository.
- **Add or change an entry**: edit the CSV and keep `xwalk_id` stable. Check the new target is standard, valid and in the expected domain:
  ```sql
  SELECT concept_id, concept_name, domain_id, standard_concept, invalid_reason FROM omop_vocab.concept WHERE concept_id IN (...);
  ```
- **After an Athena vocabulary refresh**: re-check that every non-zero target is still standard and still in its expected domain.
- **Partner feedback**: report Meas Value rows back to the site. The rescue is the safety net, not the fix.
- **Open items**:
  - UDI lookup (AccessGUDID → GMDN → SNOMED Device) for the concept-0 device rows.
  - A possible OHDSI Vocabulary issue to move Size of catheter, Size of needle, Traction weight applied and Number of oxygenators to the Measurement domain.
