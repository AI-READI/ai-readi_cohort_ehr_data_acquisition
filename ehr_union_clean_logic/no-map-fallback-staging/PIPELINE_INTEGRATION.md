# No "Maps to" fallback: adding it to the EHR pipeline

The files in this folder are staged here and are not yet part of `ehr_data_harmonization_pipeline/`. These steps add the fallback to the pipeline. It runs **at the end of step 03, before step 04 routes rows on `target_domain_id`**. See `no_map_fallback_README.md` for the logic.

The fallback covers CONDITION_OCCURRENCE, PROCEDURE_OCCURRENCE, MEASUREMENT, OBSERVATION and DRUG_EXPOSURE. DEVICE_EXPOSURE is not included yet (see the README).

## Files in this folder

| File | Goes to |
|---|---|
| `no_map_fallback.py` | `ehr_data_harmonization_pipeline/myproject/no_map_fallback.py` |
| `no_map_fallback_README.md` | `ehr_data_harmonization_pipeline/03-prepared/no_map_fallback_README.md` |
| `step03_no_map_fallback_check.sql` | stays here; QA after step 03 |
| `conformance_check_with_maps_to_status.sql` | `ehr_union_clean_logic/conformance_check_with_maps_to_status.sql`; QA after the union |

## Steps

### Step 1. Copy the module and README
Copy `no_map_fallback.py` to `myproject/` and the README to `03-prepared/`, unchanged.

### Step 2. Edit `03-prepared/03_all_domains.py`

a) With the other imports, next to `from myproject.standard_mapping import perform_standard_mapping`, add:
```python
from myproject.no_map_fallback import apply_no_map_fallback, fallback_summary
```

b) Inside `make_transform`, in the `if concept_col:` block, add the call as the **last** line, after `perform_standard_mapping(...)` (and after `rescue_meas_value(...)` once PR #12 is integrated), before `processed_df.write`:
```python
    if concept_col:
        processed_df = perform_standard_mapping(processed_df, concept_df, concept_relationship_df, concept_col, domain)
        # No 'Maps to' fallback: concept 0 + source-concept domain (see 03-prepared/no_map_fallback_README.md)
        rows_before = processed_df.count()
        processed_df = apply_no_map_fallback(processed_df, domain)
        if processed_df.count() != rows_before:
            raise ValueError(f"No-map fallback changed the row count of {domain}")
```

c) Recommended: add a run-log summary after `print(f"{dbname}.03_{domain} created")`:
```python
    if concept_col:
        nm = spark.table(f"{dbname}.03_{domain}")
        if "no_map_fallback" in nm.columns:
            print(f"No-map fallback, {domain}: rows set to concept 0, by source and target domain")
            fallback_summary(nm).show(truncate=False)
```

### Step 3. Check step 04 (no edits expected)
In `condition_occurrence.py`, `procedure_occurrence.py`, `measurement.py`, `observation.py` and `drug_exposure.py`, confirm that every CTE moving rows in from another table:
- writes `COALESCE(target_concept_id, 0)` into the concept column;
- carries the other table's `*_source_concept_id` and `*_source_value`.

The `COALESCE` and `*_source_concept_id` lines were confirmed on `main` in November 2026; confirm the `*_source_value` columns when you review.

### Step 4. Sync to Databricks
Copy the changed and new files into `/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/`, keeping the same subfolders.

### Step 5. Run step 03 and check it before step 04
Run `prepare_03_all_domains`. The run log shows the fallback summary per table. Then run `step03_no_map_fallback_check.sql` for each site (read-only).

Expected:
- `no_map_fallback = 1` only on rows with a source concept in the vocabulary and no `Maps to`.
- `03_device_exposure` has no `no_map_fallback` column.
- Y92.x codes in `03_condition_occurrence` have `target_concept_id = 0` and `target_domain_id = 'Observation'`.

### Step 6. Run step 04 and the union, then the conformance check
Run `ehr_union_clean_logic/conformance_check_with_maps_to_status.sql` (replace `<vocab>`).

Expected:
- No `no Maps to` rows in CONDITION, PROCEDURE, OBSERVATION, MEASUREMENT or DRUG.
- The Y92.x rows are in OBSERVATION with `observation_concept_id = 0`.
- `no Maps to` device rows and `not in vocab` rows are unchanged.

Row totals across all tables should match the previous run. Rows move between tables; none are added or dropped.

### Step 7. Commit
Commit on a branch from `main`, with no row counts and no notebook output that shows them.

## Later

- **Meas Value rescue (PR #12):** when integrated, call `rescue_meas_value()` between `perform_standard_mapping()` and `apply_no_map_fallback()`.
- **DEVICE_EXPOSURE:** enable it after the unmapped device rows are reviewed. Uncomment `device_exposure` in `SOURCE_CONCEPT_COL`, and move the device name fix into step 03 ahead of the fallback.
