# No "Maps to" fallback: adding it to the EHR pipeline

The files in this folder are staged here and are not yet part of `ehr_data_harmonization_pipeline/`. These steps add the fallback to the pipeline. It runs **at the end of step 03, before step 04 routes rows on `target_domain_id`**. See `no_map_fallback_README.md` for the logic.

The fallback covers CONDITION_OCCURRENCE, PROCEDURE_OCCURRENCE, MEASUREMENT, OBSERVATION and DRUG_EXPOSURE. DEVICE_EXPOSURE is not included yet (see the README).

**Use the deployed code as the reference.** The code deployed in Databricks (`/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/`) is newer than the copy in this repository. Its `03_all_domains.py` already runs the Meas Value rescue, and its step 04 `measurement.py` already keeps `value_as_string` and routes some unmapped rows. Apply the edits below to the deployed files.

## Files in this folder

| File | Goes to |
|---|---|
| `no_map_fallback.py` | `ehr_data_harmonization_pipeline/myproject/no_map_fallback.py` (deployed: `.../logic/myproject/`) |
| `no_map_fallback_README.md` | `ehr_data_harmonization_pipeline/03-prepared/no_map_fallback_README.md` |
| `step03_no_map_fallback_check.sql` | stays here; QA after step 03 |
| `../conformance_check_with_maps_to_status.sql` | already in `ehr_union_clean_logic/`; QA after the union |

## Steps

### Step 1. Copy the module
Copy `no_map_fallback.py` to `myproject/` unchanged.

### Step 2. Preview, with no writes (recommended)
Run in a separate notebook for each site. It reads the existing 03 tables and writes nothing:
```python
import sys, importlib
sys.path.insert(0, "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
import myproject.no_map_fallback as nmf
importlib.reload(nmf)

site = "<site>"
concept_df = spark.table("omop_vocab.concept")
for domain in ["condition_occurrence", "procedure_occurrence", "measurement", "observation", "drug_exposure"]:
    df  = spark.table(f"{site}_ingestion.03_{domain}")
    out = nmf.apply_no_map_fallback(df=df, concept_df=concept_df, domain=domain)
    print(domain, "rows:", df.count(), "->", out.count())               # must be equal
    nmf.fallback_summary(out).show(truncate=False)                       # rule 1
    s = nmf.source_concept_summary(out, domain)                          # rule 2
    if s is not None: s.show(truncate=False)
    u = nmf.unresolved_source_values(out, domain)                        # values set to 0 by rule 2
    if u is not None: u.show(truncate=False)
```

### Step 3. Edit the deployed `03-prepared/03_all_domains.py`

a) With the other imports, add:
```python
from myproject.no_map_fallback import apply_no_map_fallback, fallback_summary, source_concept_summary
```

b) Inside `make_transform`, in the `if concept_col:` block, call the fallback right after `rescue_meas_value(...)`. Let the existing row-count guard cover both:
```python
    if concept_col:
        processed_df = perform_standard_mapping(processed_df, concept_df, concept_relationship_df, concept_col, domain)
        # Meas Value rescue, then the no-Maps-to fallback; neither adds or removes rows
        rows_before = processed_df.count()
        processed_df = rescue_meas_value(processed_df, concept_df, meas_value_xwalk_df, domain)
        processed_df = apply_no_map_fallback(processed_df, concept_df, domain)   # see 03-prepared/no_map_fallback_README.md
        rows_after = processed_df.count()
        if rows_after != rows_before:
            raise ValueError(f"Meas Value rescue / no-map fallback changed the row count of {domain}: "
                             f"{rows_before} -> {rows_after}.")
```

c) Recommended: add a run-log summary after `print(f"{dbname}.03_{domain} created")`:
```python
    if concept_col:
        t = spark.table(f"{dbname}.03_{domain}")
        if "no_map_fallback" in t.columns:
            print(f"No-map fallback, {domain}: rule 1 (target set to 0)")
            fallback_summary(t).show(truncate=False)
            s = source_concept_summary(t, domain)
            if s is not None:
                print(f"No-map fallback, {domain}: rule 2 (source concept resolution)")
                s.show(truncate=False)
```

### Step 4. Check the deployed step 04 (no edits expected)
In `condition_occurrence.py`, `procedure_occurrence.py`, `measurement.py`, `observation.py` and `drug_exposure.py`, confirm that every CTE moving rows in from another table:
- writes `COALESCE(target_concept_id, 0)` into the concept column;
- carries the other table's `*_source_concept_id` and `*_source_value`.

Some deployed CTEs already route unmapped rows (e.g. `measurement.py`: `source_domain_id = 'Measurement' and target_concept_id is null`). That's compatible: after the fallback those rows have `target_concept_id = 0` and `target_domain_id` = their source domain, so the main filters pick them up.

### Step 5. Run for one site, then the others
1. Run step 03 for one site and read the run-log summaries.
2. Run `step03_no_map_fallback_check.sql` (read-only).
3. Run step 04 and the union.
4. Run `ehr_union_clean_logic/conformance_check_with_maps_to_status.sql` (replace `<vocab>`).

Expected:
- No `no Maps to` rows in CONDITION, PROCEDURE, OBSERVATION, MEASUREMENT or DRUG.
- `not in vocab` rows show as concept 0.
- Device rows are unchanged.
- Row totals across all tables match the previous run. Rows move between tables; none are added or dropped.

If the vocabulary was updated since the last run, the same run also re-routes concepts the new vocabulary reclassified. Compare with the conformance results from before and after the vocabulary update, to tell the two effects apart.

### Step 6. Commit
Commit the deployed `03_all_domains.py` (and the module) to the repository on a branch, with no row counts and no notebook output that shows them.

## Later

- **DEVICE_EXPOSURE:** enable after the unmapped device rows are reviewed. Uncomment `device_exposure` in `SOURCE_CONCEPT_COL`, and move the device name fix into step 03 ahead of the fallback.
- **Rule 2:** optionally try zero-padded ICD-9-CM codes (`96` → `096`).
