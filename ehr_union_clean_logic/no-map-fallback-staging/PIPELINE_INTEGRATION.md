# Step 03 changes: site snapshot, Meas Value rescue and no "Maps to" fallback

The files in this folder are staged here and are not yet part of `ehr_data_harmonization_pipeline/`. These steps change step 03 (`03-prepared/03_all_domains.py`) so that, for each table with a concept column, it runs:

1. **Site snapshot** (`write_site_snapshot`): saves what the site sent, before anything changes it.
2. **Standard mapping** (`perform_standard_mapping`, already on `main`): `Maps to` → `target_concept_id`, `target_domain_id`.
3. **Meas Value rescue** (`rescue_meas_value`, staged in `ehr_union_clean_logic/meas-value-rescue-staging/`): Meas Value targets → crosswalk target.
4. **Reviewed concept replacements** (`apply_concept_replacements`): deprecated concepts with no `Maps to` and no `Concept replaced by`, listed in `concept_replacement_crosswalk.csv` → the reviewed current standard concept.
5. **No "Maps to" fallback** (`apply_no_map_fallback`): remaining NULL targets → 0; a `<domain>_source_concept_id` that is a source code (SNOMED, ICD-9-CM, …) → its concept ID, otherwise not in `concept` → 0 (original kept).

Step 04 then routes rows on `target_domain_id`, unchanged. See `no_map_fallback_README.md` for the fallback rules.

The fallback covers CONDITION_OCCURRENCE, PROCEDURE_OCCURRENCE, MEASUREMENT, OBSERVATION and DRUG_EXPOSURE. DEVICE_EXPOSURE is not included until the duplicate device rows are confirmed (see the README). The snapshot covers every table with a concept column, devices included.

## Files in this folder

| File | Goes to |
|---|---|
| `site_snapshot.py` | `ehr_data_harmonization_pipeline/myproject/site_snapshot.py` |
| `concept_replacement.py` | `ehr_data_harmonization_pipeline/myproject/concept_replacement.py` |
| `concept_replacement_crosswalk.csv` | `ehr_data_harmonization_pipeline/03-prepared/concept_replacement_crosswalk.csv` |
| `no_map_fallback.py` | `ehr_data_harmonization_pipeline/myproject/no_map_fallback.py` |
| `no_map_fallback_README.md` | `ehr_data_harmonization_pipeline/03-prepared/no_map_fallback_README.md` |
| `step03_no_map_fallback_check.sql` | stays here; QA after step 03 |

Related QA queries, already in `ehr_union_clean_logic/` (not in this folder):
- `conformance_check_with_maps_to_status.sql`: domain conformance after the union, with the `Maps to` status.
- `drug_not_in_vocab_investigation.sql`: drug concept IDs missing from the current vocabulary, checked against a newer release.

The Meas Value rescue files are added from `ehr_union_clean_logic/meas-value-rescue-staging/` (its own `PIPELINE_INTEGRATION.md`, steps 1–2). If they are not added yet, leave out the rescue lines below; the rest works without them.

**Use the deployed code as the reference.** The code deployed in Databricks (`/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/`) is newer than the copy in this repository: its `03_all_domains.py` already runs the Meas Value rescue (crosswalk read from the table `default.meas_value_rescue_crosswalk`), and its step 04 `measurement.py` already keeps `value_as_string` and routes some unmapped rows. Apply the edits below to the deployed files.

## Steps

### Step 1. Copy the modules and README
Copy `site_snapshot.py`, `concept_replacement.py` and `no_map_fallback.py` to `myproject/`, and `concept_replacement_crosswalk.csv` and the README to `03-prepared/`, unchanged.

### Step 1b. Preview, with no writes (recommended)
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

### Step 2. Edit `03-prepared/03_all_domains.py`

a) Imports, next to `from myproject.standard_mapping import perform_standard_mapping`:
```python
from myproject.standard_mapping import perform_standard_mapping
from myproject.site_snapshot import write_site_snapshot
from myproject.meas_value_rescue import load_crosswalk, rescue_meas_value, rescue_summary, unmatched_meas_value
from myproject.concept_replacement import load_replacements, apply_concept_replacements, replacement_summary
from myproject.no_map_fallback import apply_no_map_fallback, fallback_summary, source_concept_summary
```

b) Load the two crosswalks once, just above `def make_transform(domain,concept_col):`:
```python
LOGIC = "/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/03-prepared/"
meas_value_xwalk_df = load_crosswalk(spark, LOGIC + "meas_value_rescue_crosswalk.csv")
# (deployed pipeline: meas_value_xwalk_df = spark.sql("select * from default.meas_value_rescue_crosswalk"))
# validated against omop_vocab: fails the run if a replacement is not a valid standard concept
replacement_df = load_replacements(spark, LOGIC + "concept_replacement_crosswalk.csv",
                                   spark.sql("select * from omop_vocab.concept"))
```

c) Replace the body of `make_transform` up to the write with:
```python
def make_transform(domain, concept_col):
    processed_df = spark.sql(f"select * from {dbname}.02_{domain}")
    concept_df = spark.sql("select * from omop_vocab.concept")
    concept_relationship_df = spark.sql("select * from omop_vocab.concept_relationship")

    if concept_col:
        # 0. Site snapshot: what the site sent, before any change -> {dbname}.03_snapshot_{domain}
        write_site_snapshot(spark, processed_df, dbname, domain, concept_col)

        # 1. Maps to -> target_concept_id / target_domain_id
        #    (can add rows when a concept has more than one 'Maps to' target; this is expected)
        processed_df = perform_standard_mapping(processed_df, concept_df, concept_relationship_df, concept_col, domain)

        # steps 2-4 must not add or drop rows
        rows_before = processed_df.count()
        # 2. Meas Value rescue: targets in the Meas Value domain -> crosswalk target
        processed_df = rescue_meas_value(processed_df, concept_df, meas_value_xwalk_df, domain)
        # 3. Reviewed replacements: listed deprecated concepts with no 'Maps to' -> current standard concept
        processed_df = apply_concept_replacements(processed_df, concept_df, replacement_df, domain)
        # 4. No-map fallback: remaining NULL targets -> 0; source code -> concept ID, else 0 (original kept)
        processed_df = apply_no_map_fallback(processed_df, concept_df, domain)
        rows_after = processed_df.count()
        if rows_after != rows_before:
            raise ValueError(f"Step 03 rescue/replacement/fallback changed the row count of {domain}: {rows_before} -> {rows_after}")

    processed_df.write \
        .format("delta") \
        .option("mergeSchema", "true") \
        .mode("overwrite") \
        .saveAsTable(f"{dbname}.03_{domain}")

    print(f"{dbname}.03_{domain} created")
    # ... keep the existing timestamp_comment and the run-log summaries (d) below
```

The row-count check sits **after** `perform_standard_mapping()`. A check before it would fail on concepts with more than one `Maps to` target, which the pipeline already handles (`source_pkey` includes `TARGET_CONCEPT_ID`). This replaces the separate row-count checks in each staging guide.

d) Recommended: run-log summaries after `print(f"{dbname}.03_{domain} created")`:
```python
    if concept_col:
        t = spark.table(f"{dbname}.03_{domain}")
        if "meas_value_original_target_concept_id" in t.columns:
            print(f"Meas Value rescue, {domain}: rows rescued by crosswalk entry")
            rescue_summary(t).show(truncate=False)
            print(f"Meas Value rescue, {domain}: Meas Value targets with no crosswalk entry (left unchanged)")
            unmatched_meas_value(t).show(truncate=False)
        if "concept_replacement" in t.columns:
            print(f"Concept replacements, {domain}: rows given a reviewed replacement concept")
            replacement_summary(t).show(truncate=False)
        if "no_map_fallback" in t.columns:
            print(f"No-map fallback, {domain}: rows set to concept 0, by reason and target domain")
            fallback_summary(t).show(truncate=False)
            s = source_concept_summary(t, domain)
            if s is not None:
                print(f"No-map fallback, {domain}: source concept resolution")
                s.show(truncate=False)
```
These print row counts in the run log. Keep that output out of the repository.

### Step 3. Check step 04 (no edits expected)
In `condition_occurrence.py`, `procedure_occurrence.py`, `measurement.py`, `observation.py` and `drug_exposure.py`, confirm that every CTE moving rows in from another table:
- writes `COALESCE(target_concept_id, 0)` into the concept column;
- carries the other table's `*_source_concept_id` and `*_source_value`.

The `*_unmap` CTEs of these five tables receive no rows after this change. Leave them in place. `site_domain_id` and `source_domain` are unchanged.

### Step 4. Sync to Databricks
Copy the changed and new files into `/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/`, keeping the same subfolders.

### Step 5. Run step 03 and check it before step 04
In an interactive session, restart Python first (or add `%load_ext autoreload` / `%autoreload 2` at the top), so the notebook loads the new modules. Run `prepare_03_all_domains`. Then run `step03_no_map_fallback_check.sql` for each site (read-only).

Expected:
- `<site>_ingestion.03_snapshot_<domain>` exists for each table with a concept column, with the same row count as `02_<domain>` (`write_site_snapshot` raises an error otherwise).
- No row has `target_concept_id IS NULL` in the five fallback tables (query 2 returns no rows).
- `no_map_fallback = 1` on every row that had no `Maps to`: in vocabulary, not in vocabulary, and concept 0/NULL.
- No `<domain>_source_concept_id` other than 0/NULL is missing from `concept` (query 3 returns no rows); query 4 shows how the site's values were resolved (`concept_id`, `code:<vocabulary>`, `not found`).
- `03_device_exposure` has no `no_map_fallback` column.
- Y92.x codes in `03_condition_occurrence` have `target_concept_id = 0` and `target_domain_id = 'Observation'`.
- In `03_drug_exposure`, rows whose `source_concept_id` is a site concept in `concept_replacement_crosswalk.csv` have `concept_replacement = 1` and `target_concept_id` = its `replacement_concept_id`.

### Step 6. Run step 04 and the union, then the conformance check
Run `ehr_union_clean_logic/conformance_check_with_maps_to_status.sql` (replace `<vocab>`).

Expected:
- No `no Maps to` or `not in vocab` rows in CONDITION, PROCEDURE, OBSERVATION, MEASUREMENT or DRUG.
- The Y92.x rows are in OBSERVATION with `observation_concept_id = 0`.
- Device rows are unchanged (`no Maps to` and `not in vocab` device rows may still appear).

Row totals across all tables should match the previous run. Rows move between tables; none are added or dropped.

### Step 7. Commit
Commit on a branch from `main`, with no row counts and no notebook output that shows them.

## Site snapshot tables

`<site>_ingestion.03_snapshot_<domain>`, one per table with a concept column, overwritten on each run:

| Column | Value |
|---|---|
| `data_partner_id` | the site |
| `site_table` | the table the site sent the row in (`condition_occurrence`, …) |
| `site_domain_id` | the site's primary key for the row (`condition_occurrence_id`, …); the same value step 04 writes as `site_domain_id` |
| `site_person_id` | the site's `person_id` |
| `site_concept_id` | `<domain>_concept_id` as sent |
| `site_source_concept_id` | `<domain>_source_concept_id` as sent |
| `site_source_value` | `<domain>_source_value` as sent (the site's source code) |
| `snapshot_ts` | when the snapshot was taken |

- **Link to later steps** on `data_partner_id`, `site_table` and `site_domain_id`. Step 04 keeps `site_domain_id` and writes the site table, upper case, as `source_domain`. Both are carried to `06_<domain>`, which has the final `<domain>_id`, and through to `09_<domain>`. Step 10 drops them.
- **Use:** the audit trail of what was changed, and the flow from site table to final OMOP table.
- **Privacy:** the tables hold raw site codes. They stay in the site ingestion schema and are not delivered (step 13 exports only `ehr_union_clean`).

## Later

- **Concept replacements:** after each vocabulary refresh, the run fails if a replacement is no longer a valid standard concept or its name no longer matches. Fix the CSV, or delete the row if the vocabulary now has a `Maps to` for the site concept (the mapping then wins anyway).
- **DEVICE_EXPOSURE:** enable the fallback after the duplicate device rows are confirmed. Uncomment `device_exposure` in `SOURCE_CONCEPT_COL`, and move the device name fix into step 03 ahead of the fallback.
