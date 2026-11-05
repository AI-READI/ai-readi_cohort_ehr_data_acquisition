# Meas Value target rescue (ehr_union_clean)

## Problem

Some site-submitted rows resolve, through the `Maps to` relationship, to standard concepts whose `domain_id` is **Meas Value**. Meas Value concepts are *answers* (values). They belong in `value_as_concept_id`, never in an event table's main `*_concept_id`. These rows have no valid table to route to, so they fail the OHDSI domain conformance check.

In the current union, all Meas Value rows came from one partner each in OBSERVATION and DEVICE_EXPOSURE. Every one was a standard SNOMED concept that `Maps to` itself, so the vocabulary offers no better target. `*_source_value` was null on all rows.

| Table | Meas Value rows | Rescued to a real concept | Kept in place with concept 0 |
|---|---|---|---|
| OBSERVATION | 686 | 175 → Measurement | 511 |
| DEVICE_EXPOSURE | 108 | 44 → Device | 64 |
| **Total** | **794** | **219 (27.6%)** | **575** |

## Where it runs in the pipeline

```
Step 3  Prepared step      'Maps to' -> target_concept_id, target_domain_id
Step 3b Meas Value rescue  rows with target_domain_id = 'Meas Value' -> crosswalk -> new target_concept_id, target_domain_id
Step 4  Domain routing     route every row on the (rescued) target_domain_id
```

The rescue runs **after** `Maps to` and **before** routing. It overwrites only the rows whose target is Meas Value, so routing still uses a single pair of columns and never sees a Meas Value domain.

## Rules

1. **Join condition** (`apply_meas_value_rescue.sql`):
   ```sql
   ON  p.target_domain_id  = 'Meas Value'
   AND x.source_table      = '<table>'
   AND x.source_concept_id = p.target_concept_id          -- the Meas Value target from 'Maps to'
   AND (x.value_regex IS NULL OR p.value_as_string RLIKE x.value_regex)
   ```
   `value_regex` lets one concept be handled differently depending on its value. For example, Size of catheter has a French size on some rows and "Other:" text on others. Regexes for the same concept must not overlap.
2. **Resolved concept**: the crosswalk `target_concept_id`, or **0** when the Meas Value target has no crosswalk entry.
3. **Resolved domain**: taken from the vocabulary for the resolved concept (`concept.domain_id`), not from the crosswalk text. Concept 0 gives a **NULL** domain.
4. **Routing**:
   - A real domain routes the row to that table.
   - NULL keeps the row in the table the site sent it to, with concept 0.
   - Concept 0 is conformant, and the row counts as unmapped, not as a domain failure.
5. **Always keep the original concept** in `*_source_concept_id`, so the SNOMED meaning is preserved.
6. **Values and units** are applied when the row is written:
   - `parse_number_regex` parses `value_as_string` into `value_as_number`.
   - `target_unit_concept_id` and `target_unit_source_value` replace the row's unit.
   - When a row moves OBSERVATION → MEASUREMENT, carry `value_as_string` into `value_source_value`. MEASUREMENT has no `value_as_string` in CDM 5.3 or 5.4.
7. **Unit conventions**:
   - Unit present but no standard concept: `unit_concept_id = 0` (e.g., gauge).
   - No unit at all: `unit_concept_id = NULL`.
   - Do **not** use 9312 `[G]` for gauge. It is the Newtonian constant of gravitation.

## Crosswalk (`meas_value_rescue_crosswalk.csv`)

| Column | Meaning |
|---|---|
| `xwalk_id` | Stable row ID, reported on rescued rows as `meas_value_xwalk_id` |
| `source_table` | Table the row is in at the prepared step |
| `source_concept_id` / `source_concept_name` | The Meas Value target concept from `Maps to` |
| `value_regex` | Optional match on `value_as_string`; empty = any value |
| `target_concept_id` / `target_concept_name` | Replacement standard concept, or 0 |
| `resolved_target_domain_id` | Expected domain of the target, for documentation. Validated against the vocabulary at build time; routing uses the vocabulary value |
| `target_unit_concept_id` / `target_unit_source_value` | Unit to write; empty = keep the existing unit |
| `parse_number_regex` | Capture group 1 → `value_as_number`; empty = keep the existing number |
| `expected_rows` | Row count when the entry was created (checked at run time) |
| `note` | Rationale |

### Current entries

| xwalk_id | Table | Source concept | Match | Target concept | Resolved domain | Unit | Rows |
|---|---|---|---|---|---|---|---|
| 1 | observation | 4126842 Size of needle | `N gauge` | 42537416 Hemodialysis needle gauge | Measurement | 0 (gauge) | 105 |
| 2 | observation | 4126840 Size of catheter | `N Fr` / `N French` | 0 | stays (Observation) | 9279 [Ch] | 485 |
| 3 | observation | 4126840 Size of catheter | `Other:` text | 3018480 Type of Chest tube | Measurement | — | 70 |
| 4 | observation | 4118340 Traction weight applied | any | 0 | stays (Observation) | — | 25 |
| 5 | observation | 4128808 Number of oxygenators | any | 0 | stays (Observation) | — | 1 |
| 6 | device_exposure | 36310218 Pacemaker | any | 4030875 Cardiac pacemaker | Device | — | 7 |
| 7 | device_exposure | 45876963 IUD | any | 40355609 Intrauterine contraceptive device | Device | — | 1 |
| 8 | device_exposure | 36310617 Mesh | any | 45768044 Surgical mesh | Device | — | 22 |
| 9 | device_exposure | 36309731 Lead | any | 4236068 Cardiac pacemaker lead | Device | — | 14 |
| 10–15 | device_exposure | Bone, Graft, Lens, Breast, Patella, Nail | any | 0 | stays (Device) | — | 64 |

### Mapping rationale

- **Needles (15–17G)**: this is the standard dialysis fistula needle range. Peripheral IVs are usually 18–24G.
- **Catheter sizes (8–32 Fr)**: the "Other:" text (PCT, MSCT/MDST mediastinal, Blake) shows these are post-cardiothoracic chest tubes and drains. No standard chest tube size concept exists, so the size is kept as a value under concept 0.
- **Devices**: generic parent concepts are used because the subtype can't be determined without a source value. Bone, Graft, Lens, Breast, Patella and Nail are ambiguous, so they get 0 until their UDIs are looked up. 71 of 108 device rows carry a `unique_device_id`.

## Files

| File | Purpose |
|---|---|
| `meas_value_rescue_crosswalk.csv` | The crosswalk (source of truth; edit this) |
| `build_meas_value_rescue_crosswalk.sql` | Creates `<your_schema>.meas_value_rescue_crosswalk` from the CSV content and validates every concept against `omop_vocab` |
| `apply_meas_value_rescue.sql` | The rescue step (step 3b), with gates and reports |

## Run order

1. Run `build_meas_value_rescue_crosswalk.sql`. All five validation queries must return 0 rows.
2. Run the prepared step as usual.
3. Run `apply_meas_value_rescue.sql` for each table (OBSERVATION and DEVICE_EXPOSURE today).
4. Check the gates:
   - No `target_domain_id = 'Meas Value'` remains.
   - No row matches more than one crosswalk entry.
   - Rescue counts match `expected_rows`, or any difference is explained by new data.
5. Run domain routing on the rescued view.

## Maintenance

- **New Meas Value concepts**: the "no crosswalk entry" report lists Meas Value targets that fell through to 0. Add an entry if there is a good target; otherwise 0 is the correct outcome.
- **Vocabulary updates**: rerun `build_...sql` validation 2 after each Athena refresh. A deprecated or re-domained target makes it fail.
- **Count drift**: a large change from `expected_rows` means a partner changed what they send. Review before accepting.
- **Partner feedback**: report Meas Value rows to the contributing site in the data quality feedback. The fix belongs upstream; this rescue is the safety net.
- **Vocabulary feedback**: the four observation concepts (Size of catheter, Size of needle, Traction weight applied, Number of oxygenators) behave like observable entities. They are candidates for an OHDSI Vocabulary issue asking for them to be moved to the Measurement domain.

## Open items

- UDI lookup (FDA AccessGUDID → GMDN term → SNOMED Device concept) for the 64 device rows at concept 0, and to confirm xwalk 9 (Lead) versus epicardial pacing wires.
- Add MEASUREMENT, CONDITION, PROCEDURE and DRUG entries if their prepared steps surface Meas Value targets.
