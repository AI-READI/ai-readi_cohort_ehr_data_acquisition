# Meas Value rescue: adding it to the EHR pipeline

The files in this folder are staged here and are not yet part of `ehr_data_harmonization_pipeline/`. These steps add the rescue to the pipeline. It runs **after step 03 resolves `Maps to` and before step 04 routes rows on `target_domain_id`**. See `meas_value_rescue_README.md` for the mapping rules.

No changes are needed to the step 04 routing logic or to `omop_workflow_definition.yaml`. Every `domain_mapping_*` task already depends on `prepare_03_all_domains`. The keep-in-place filters in `observation.py` and `device_exposure.py` already accept `target_domain_id IS NULL`, which is the domain used for rows rescued to concept 0.

## Files in this folder

| File | Goes to (under `ehr_data_harmonization_pipeline/`) |
|---|---|
| `meas_value_rescue.py` | `myproject/meas_value_rescue.py` |
| `meas_value_rescue_crosswalk.csv` | `03-prepared/meas_value_rescue_crosswalk.csv` |
| `meas_value_rescue_README.md` | `03-prepared/meas_value_rescue_README.md` |
| `domain_conformance_check.sql` | stays here; a QA query run after the union |

## Steps

### Step 1. Copy the module
Copy `meas_value_rescue.py` to `myproject/meas_value_rescue.py`, unchanged.

### Step 2. Copy the crosswalk and README
Copy them to `03-prepared/`.

`expected_rows` is empty on purpose. Row counts stay in the Databricks run output only. Do not commit counts, per-site figures or notebook output.

### Step 3. Edit `03-prepared/03_all_domains.py`

a) With the other imports, next to `from myproject.standard_mapping import perform_standard_mapping`, add:
```python
from myproject.meas_value_rescue import load_crosswalk, rescue_meas_value, rescue_summary, unmatched_meas_value
```

b) Just above `def make_transform(domain,concept_col):`, add:
```python
# Meas Value rescue crosswalk (see 03-prepared/meas_value_rescue_README.md)
MEAS_VALUE_XWALK_PATH = "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/03-prepared/meas_value_rescue_crosswalk.csv"
meas_value_xwalk_df = load_crosswalk(spark, MEAS_VALUE_XWALK_PATH)
```

c) Inside `make_transform`, in the same `if concept_col:` block, add this directly under the `perform_standard_mapping(...)` line and before `processed_df.write`:
```python
        # Meas Value rescue: runs after 'Maps to', before step 04 routes on target_domain_id
        rows_before = processed_df.count()
        processed_df = rescue_meas_value(processed_df, concept_df, meas_value_xwalk_df, domain)
        rows_after = processed_df.count()
        if rows_after != rows_before:
            raise ValueError(f"Meas Value rescue changed the row count of {domain}: {rows_before} -> {rows_after}. "
                             "Two crosswalk value_regex entries overlap for the same concept.")
```

d) Recommended: add a run-log summary after `print(f"{dbname}.03_{domain} created")`:
```python
    if concept_col:
        mv = spark.table(f"{dbname}.03_{domain}")
        if "meas_value_original_target_concept_id" in mv.columns:
            print(f"Meas Value rescue, {domain}: rows rescued by crosswalk entry")
            rescue_summary(mv).show(truncate=False)
            print(f"Meas Value rescue, {domain}: Meas Value targets with no crosswalk entry (left unchanged)")
            unmatched_meas_value(mv).show(truncate=False)
```

### Step 4. Edit `04-domain-map/measurement.py`
Change one line, about line 140, in the observation → measurement block:
```diff
-            , CAST(null as string) as value_source_value
+            , value_as_string as value_source_value  -- MEASUREMENT has no value_as_string; keep the text result
```
This keeps the chest tube type text when the row moves to MEASUREMENT. It applies to **every** observation row routed to measurement, so review it as a separate change.

### Step 5. Sync to Databricks
Copy the changed and new files into `/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/`, keeping the same subfolders. Step 03 fails if `03-prepared/meas_value_rescue_crosswalk.csv` is missing.

### Step 6. Run step 03 and check its output before step 04
Run `prepare_03_all_domains`. The run log shows the rescue summary per table. Only Lens, Lead and Graft should appear under "no crosswalk entry"; the #7 device fix handles those.

Read-only check:
```sql
SELECT meas_value_xwalk_id, target_concept_id, target_domain_id, COUNT(*)
FROM <site>_ingestion.03_observation          -- repeat for 03_device_exposure
WHERE meas_value_xwalk_id IS NOT NULL
GROUP BY ALL ORDER BY 1;
```
Expected:
- xwalk 1 and 3 → `Measurement`.
- xwalk 6–8 → `Device`.
- The other entries → concept 0, `target_domain_id` NULL.

### Step 7. Run step 04 and confirm the routing
- `04_measurement` has rows with `measurement_concept_id IN (42537416, 3018480)` and `source_domain = 'OBSERVATION'`.
- On the chest tube rows, `value_source_value` holds the text.
- Concept-0 rows stay in `04_observation` and `04_device_exposure`, with the original concept kept in `*_source_concept_id`.

### Step 8. After the union, run the QA query
Run `domain_conformance_check.sql` (replace `<vocab>`). Meas Value mismatches should be 0 in OBSERVATION. In DEVICE_EXPOSURE they should be 0 once the #7 device-copy fix runs.

### Step 9. Commit the pipeline changes
Commit on a branch from `main`, with no counts and no notebook output that shows them.
