
# Additional note from the previously added code that was to fix the duplicate OSM rows found in Device. But if we are to address this issue after 03 prepared step then the logic should apply appropriately.

* If the code is applied with the step 3 of the pipeline to revmove the duplicate OSM rows after the rescue remap of the OSM rows, then following logic should apply in 
the four-step order: prepare, rescue, drop device copies, then route.
 * It keys on device_concept_id, not target_concept_id. PR #7 finds the rows by the concept name of device_concept_id (Lens, Lead, Graft, Plate) and breaks ties using that concept’s domain. In the 03 table, device_concept_id is still the site’s original value, because the prepared step and the rescue only write the target_* columns. The rescue also skips Lens, Lead and Graft entirely, so the same 193 rows are found.
* Copies must be removed from 03_device_exposure, not just flagged. This is the important part. Before routing, each copy still carries its own target_domain_id. If a copy is only flagged is_copy = 1 and left in the table, step 4 routes it on its own domain. For example, an NDF-RT copy whose target is a Drug concept would land in DRUG_EXPOSURE, and you’d get a duplicate there. So either:
* write 03_device_exposure without the copies (recommended; step 4 needs no changes), or
* keep the flag and add AND COALESCE(is_copy, 0) = 0 to every 04 notebook that reads 03_device_exposure. Device, drug, observation, measurement and procedure all pull from it, so this is easy to miss.
* Kept rows should be written with target_concept_id set to PR #7’s chosen concept and target_domain_id = 'Device', so step 4 keeps them in DEVICE_EXPOSURE. That includes concept 0, which PR #7 already labels 'Device'.
* All the copies have to be in the device table at step 3. After the union, PR #7 saw everything in ehr_union_clean.device_exposure, including rows that step 4 routed into DEVICE from procedure, drug or observation. Before routing, it only sees the site’s own device rows. If any of the 193 came from another table, the pre-routing version will miss them. Check this once, read-only, against the 04 output:


# Device OSM cleanup: moving the copy drop into step 3 (`03_device_exposure`)

Notes on running the device name-matched copy fix (`ehr_osm_device_name_fix_drop_osm_copies_fromDevice*.sql`, PR #7) **before** domain routing instead of after the union.

## Target pipeline order

1. **Prepared step** (`03_all_domains.py`): `Maps to` sets `target_concept_id` and `target_domain_id`.
2. **Meas Value rescue** (`rescue_meas_value()`, also in step 03): remaps Meas Value targets where possible. Lens, Lead and Graft are deliberately **not** in the crosswalk, so step 3 can still find them by name.
3. **Drop device copies** (this note): the PR #7 keep/copy logic, run on `{site}_ingestion.03_device_exposure`.
4. **Route** (`04-domain-map/*.py`): route every row on `target_domain_id`.

## Does keep / copy still work before routing? Yes, if these three conditions hold

### 1. Key on `device_concept_id`, not `target_concept_id`

PR #7 finds the rows by the concept name of `device_concept_id` (Lens, Lead, Graft, Plate). It breaks ties with that concept's domain and standard flag (the row that is already a standard Device concept is kept).

In the 03 table, `device_concept_id` is still the site's original value. The prepared step and the Meas Value rescue only write the `target_*` columns, and the rescue skips Lens, Lead and Graft. So the same rows are found.

### 2. Remove the copies from `03_device_exposure`; do not just flag them

This is the critical point. Before routing, each copy still carries its **own** `target_domain_id`. A copy left in the table with only `is_copy = 1` would be routed by step 4 on that domain. For example, an NDF-RT copy whose target is a Drug concept would end up in DRUG_EXPOSURE as a duplicate.

Do one of the following:
- **Recommended**: write `03_device_exposure` without the copies. Step 4 then needs no changes.
- **Or** keep the flag and add `AND COALESCE(is_copy, 0) = 0` to **every** 04 notebook that reads `03_device_exposure`. Device, drug, observation, measurement and procedure all read from it, so this one is easy to miss.

Write the kept rows with:
- `target_concept_id` = the concept PR #7 chose, or 0 when no procedure supports the device.
- `target_domain_id = 'Device'`. This includes concept 0, which PR #7 already labels `'Device'`, so step 4 keeps the row in DEVICE_EXPOSURE.
- `device_type_concept_id = 32817` (EHR), as in PR #7.

### 3. All the copies must already be in the device table at step 3

After the union, PR #7 saw everything in `ehr_union_clean.device_exposure`, including rows that step 4 routed **into** DEVICE from procedure, drug or observation. Before routing, it sees only the site's own device rows.

Check once (read-only) that every Lens, Lead, Graft and Plate row comes from the device table:

```sql
SELECT source_domain, c.concept_name, COUNT(*) AS n
FROM <site>_ingestion.04_device_exposure d
JOIN omop_vocab.concept c ON c.concept_id = d.device_concept_id
WHERE c.concept_name IN ('Lens','Lead','Graft','Plate')
GROUP BY 1, 2 ORDER BY 1, 2;
```

- `source_domain = 'DEVICE'` on every row: moving the logic to step 3 is safe.
- Any other value: keep PR #7 after routing for those rows, or run the same dedupe on the other 03 tables as well.

## Other differences from running after the union

- **Per site**: the logic reads and rewrites `{site}_ingestion.03_device_exposure` for each site. The `data_partner_id` filter in PR #7 becomes the site's own database.
- **Procedure evidence**: this comes from `{site}_ingestion.03_procedure_occurrence`. Procedures that only reach PROCEDURE_OCCURRENCE after routing (e.g. observation rows mapped to procedures) are not seen. For this partner the effect should be negligible; confirm with the expected counts below.
- **Concept 0 domain**: PR #7 marks unresolved devices as `'Device'`, while the Meas Value rescue uses NULL. Both keep the row in DEVICE_EXPOSURE, so step 4 behaves the same.
- **Pacemaker and Mesh**: these Meas Value device rows are currently rescued in step 2 (4030875 Cardiac pacemaker, 45768044 Surgical mesh). If they turn out to be copies of real device rows, move them from the Meas Value crosswalk into the step 3 name list. Check with the query below, which counts rows that have a real Device sibling on the same person and date.

```sql
SELECT c.concept_name AS meas_value_name,
       COUNT(*) AS n_rows,
       SUM(CASE WHEN sib.n_dev > 0 THEN 1 ELSE 0 END) AS has_real_device_sibling
FROM <site>_ingestion.03_device_exposure d
JOIN omop_vocab.concept c ON c.concept_id = d.device_concept_id AND c.domain_id = 'Meas Value'
LEFT JOIN (
  SELECT d2.person_id, d2.device_exposure_start_date, COUNT(*) AS n_dev
  FROM <site>_ingestion.03_device_exposure d2
  JOIN omop_vocab.concept c2 ON c2.concept_id = d2.device_concept_id AND c2.domain_id = 'Device'
  GROUP BY 1, 2
) sib ON sib.person_id = d.person_id AND sib.device_exposure_start_date = d.device_exposure_start_date
GROUP BY 1 ORDER BY n_rows DESC;
```

## Workflow change

In `ehr_data_harmonization_pipeline/omop_workflow_definition.yaml`:
- Add a task `prepare_03b_device_dedup` that depends on `prepare_03_all_domains`.
- Make the 04 tasks that read `03_device_exposure` (at least `domain_mapping_device_exposure`) depend on `prepare_03b_device_dedup`.

## Pass criteria after the full run

PR #7's checks should give the same results as when it ran after the union:
- **53 devices kept, 140 copies dropped** (193 rows in scope).
- **Kept by name**: Graft 14 (4124754), Lens 14 (2721881), Lead 14 (by procedure), Plate 11.
- **No other rows changed**: every other partner and every row outside the four names is unchanged.
- **Domain conformance**: `ehr_union_clean_logic/qa/domain_conformance_check.sql` shows no Meas Value rows left in DEVICE_EXPOSURE.

## Related

- `ehr_union_clean_logic/ehr_osm_device_name_fix_drop_osm_copies_fromDevice_v2_2dayswindow.sql`: the current device copy fix (PR #7).
- `ehr_data_harmonization_pipeline/03-prepared/meas_value_rescue_README.md`: the Meas Value rescue (step 2).
- `ehr_union_clean_logic/qa/domain_conformance_check.sql`: the post-routing check.
