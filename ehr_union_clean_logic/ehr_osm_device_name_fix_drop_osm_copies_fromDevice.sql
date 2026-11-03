-- ehr_osm_device_name_fix_drop_osm_copies_fromDevice.sql  (v5, 2026-11-03)
-- v5 (replaces v4):
--   * copies are paired by GTIN: unique_device_id holds a valid GS1 GTIN-14 on 126 of the 193 rows, and every
--     copy of a device carries that device's GTIN. device_seq (row order) is used within a GTIN, or when there is
--     none. v4 paired by row order only, which mixed the 2 leads of a dual-chamber pacemaker (U1 check).
--   * the LV + pacemaker split uses the device number on the date (device_no), not device_seq.
--   * device_type_concept_id = 32817 (EHR) on the kept rows: the name lookup had put the matched concept ID there;
--     32817 is the type of the data partner's other (correctly mapped) device rows.
--   * unique_device_id is kept in this internal table (used for pairing); a GTIN is a device identifier and must be
--     removed (NULL or 'Not Required') in any released / Limited Data Set version.
-- Device rows of <one data partner> (data_partner_id) named Lens, Lead, Graft or Plate, in three visible steps:
--   Step 1  target_concept_id + target_domain_id on every row
--   Step 2  row_rank within each device; is_copy = 1 when row_rank > 1 (row_rank 1 = the row kept)
--   Step 3  corrected table: WHERE target_domain_id = 'Device' AND is_copy = 0
-- Expected: 193 rows -> 53 devices, 140 copies.
--
-- Reads ehr_union_clean; writes ONLY to <my_schema> (e.g. ehr_union_clean_metrics). The source is not changed.
-- Replace <my_schema>, <vocab> and <one data partner> (its data_partner_id). One statement per cell, in order.
--
-- Device key (all copies of one device share it): person_id, device_exposure_start_datetime,
-- visit_occurrence_id, device_name, gtin, device_seq.
--   gtin       = unique_device_id when it is a 14-digit GTIN, else NULL
--   device_seq = row order within each concept and gtin (separates 2 devices with the same GTIN, or with none)
-- device_type_concept_id is not in the key: the lookup wrote a different value on each copy.
-- device_no numbers the devices of one record key (date) and is used only for the LV + pacemaker split.

-- =====================================================================================
-- STEP 1. target_concept_id and target_domain_id on every row
-- =====================================================================================
CREATE OR REPLACE TABLE <my_schema>.device_fix_step1_target AS
WITH src AS (
  SELECT d.*, c.concept_name AS device_name, c.vocabulary_id AS source_vocabulary_id,
         c.domain_id AS source_domain_id, c.standard_concept AS source_standard_concept
  FROM ehr_union_clean.device_exposure d
  JOIN <vocab>.concept c ON c.concept_id = d.device_concept_id
  WHERE d.data_partner_id = <one data partner>
    AND c.concept_name IN ('Lens', 'Lead', 'Graft', 'Plate')
),
g AS (
  SELECT s.*, CASE WHEN s.unique_device_id RLIKE '^[0-9]{14}$' THEN s.unique_device_id END AS gtin
  FROM src s
),
seq0 AS (
  SELECT g.*,
         ROW_NUMBER() OVER (PARTITION BY g.person_id, g.device_exposure_start_datetime, g.visit_occurrence_id,
                                         g.device_name, g.device_concept_id, g.gtin
                            ORDER BY g.device_exposure_id) AS device_seq
  FROM g
),
seq AS (
  SELECT q.*,
         DENSE_RANK() OVER (PARTITION BY q.person_id, q.device_exposure_start_datetime, q.visit_occurrence_id,
                                         q.device_name
                            ORDER BY COALESCE(q.gtin, '~'), q.device_seq) AS device_no
  FROM seq0 q
),
proc AS (   -- same-day procedure evidence
  SELECT p.person_id, p.procedure_date,
         MAX(CASE WHEN p.procedure_concept_id IN (2111015, 4333163)                              THEN 1 ELSE 0 END) AS has_iol,
         MAX(CASE WHEN p.procedure_concept_id IN (2107049)                                       THEN 1 ELSE 0 END) AS has_icd,
         MAX(CASE WHEN p.procedure_concept_id IN (2107024)                                       THEN 1 ELSE 0 END) AS has_lv,
         MAX(CASE WHEN p.procedure_concept_id IN (2106988, 2106987, 2726188, 2726239, 2107029,
                                                  2756517, 2107005, 2107027, 2313938)            THEN 1 ELSE 0 END) AS has_pm,
         MAX(CASE WHEN p.procedure_concept_id IN (2313815)                                       THEN 1 ELSE 0 END) AS has_ecg,
         MAX(CASE WHEN p.procedure_concept_id IN (2104281, 2104293, 2105790, 2105631, 2105664,
                                                  2767538, 2767545, 2767062, 4119119, 2766021,
                                                  2766009, 2102977)                              THEN 1 ELSE 0 END) AS has_ortho
  FROM ehr_union_clean.procedure_occurrence p
  GROUP BY 1, 2
),
tgt AS (
  SELECT s.*,
         CASE
           -- the row already has a standard Device concept (Graft 4124754): keep it
           WHEN s.source_domain_id = 'Device' AND s.source_standard_concept = 'S' THEN s.device_concept_id
           -- Graft copies (OSM, LOINC): the Device concept the data partner already uses
           WHEN s.device_name = 'Graft'                                           THEN 4124754
           WHEN s.device_name = 'Lens'  AND COALESCE(pr.has_iol, 0) = 1           THEN 2721881
           WHEN s.device_name = 'Lead'  AND COALESCE(pr.has_icd, 0) = 1           THEN 2615787
           WHEN s.device_name = 'Lead'  AND COALESCE(pr.has_lv, 0) = 1 AND COALESCE(pr.has_pm, 0) = 1
                THEN CASE WHEN s.device_no = 1 THEN 2615876 ELSE 2615874 END     -- LV + pacemaker same day
           WHEN s.device_name = 'Lead'  AND COALESCE(pr.has_lv, 0) = 1            THEN 2615876
           WHEN s.device_name = 'Lead'  AND COALESCE(pr.has_pm, 0) = 1            THEN 2615874
           WHEN s.device_name = 'Lead'  AND COALESCE(pr.has_ecg, 0) = 1           THEN 4121561
           WHEN s.device_name = 'Plate' AND COALESCE(pr.has_ortho, 0) = 1         THEN 4098108   -- Bone plate (SNOMED)
           ELSE 0                                                                 -- no supporting procedure
         END AS target_concept_id
  FROM seq s
  LEFT JOIN proc pr ON pr.person_id = s.person_id AND pr.procedure_date = s.device_exposure_start_date
)
SELECT t.*,
       -- concept 0 has domain 'Metadata' in the vocabulary; an unresolved device is still a device row
       CASE WHEN t.target_concept_id = 0 THEN 'Device' ELSE c.domain_id END AS target_domain_id,
       c.concept_name AS target_concept_name
FROM tgt t
LEFT JOIN <vocab>.concept c ON c.concept_id = t.target_concept_id;

-- Step 1 check: every row has a target; all targets Device. Expect 193 rows; target_not_device = 0
SELECT device_name, source_vocabulary_id, source_domain_id, target_concept_id, target_concept_name, target_domain_id,
       COUNT(*) AS rows
FROM <my_schema>.device_fix_step1_target
GROUP BY 1, 2, 3, 4, 5, 6 ORDER BY 1, 2, 4;

SELECT COUNT(*) AS rows,
       SUM(CASE WHEN target_domain_id <> 'Device' OR target_domain_id IS NULL THEN 1 ELSE 0 END) AS target_not_device
FROM <my_schema>.device_fix_step1_target;

-- =====================================================================================
-- STEP 2. row_rank within each device; is_copy = 1 when row_rank > 1
-- =====================================================================================
CREATE OR REPLACE TABLE <my_schema>.device_fix_step2_rank AS
SELECT t.*,
       ROW_NUMBER() OVER (PARTITION BY t.person_id, t.device_exposure_start_datetime, t.visit_occurrence_id,
                                       t.device_name, t.gtin, t.device_seq
                          ORDER BY CASE WHEN t.source_domain_id = 'Device' AND t.source_standard_concept = 'S'
                                        THEN 0 ELSE 1 END,          -- prefer the row that is already a Device concept
                                   t.device_exposure_id) AS row_rank
FROM <my_schema>.device_fix_step1_target t;

CREATE OR REPLACE TABLE <my_schema>.device_fix_step2_rank AS
SELECT r.*, CASE WHEN r.row_rank > 1 THEN 1 ELSE 0 END AS is_copy
FROM <my_schema>.device_fix_step2_rank r;

-- Step 2 check A (the key groups all copies): rows per device should equal the number of concepts per name
--   Expect copies_per_device = concepts_per_name on every line: Graft 3, Lens 4, Lead 6, Plate 1
WITH per_device AS (
  SELECT device_name, person_id, device_exposure_start_datetime, visit_occurrence_id, gtin, device_seq, COUNT(*) AS copies
  FROM <my_schema>.device_fix_step2_rank GROUP BY 1, 2, 3, 4, 5, 6
),
per_name AS (
  SELECT device_name, COUNT(DISTINCT device_concept_id) AS concepts_per_name
  FROM <my_schema>.device_fix_step2_rank GROUP BY 1
)
SELECT d.device_name, n.concepts_per_name, d.copies AS copies_per_device, COUNT(*) AS devices
FROM per_device d JOIN per_name n USING (device_name)
GROUP BY 1, 2, 3 ORDER BY 1, 3;

-- Step 2 check C: copies of one device agree on every other column. Expect 0 in every differ_ column
SELECT device_name, COUNT(*) AS devices,
       SUM(CASE WHEN n_provider > 1 THEN 1 ELSE 0 END) AS differ_provider,
       SUM(CASE WHEN n_quantity > 1 THEN 1 ELSE 0 END) AS differ_quantity,
       SUM(CASE WHEN n_end      > 1 THEN 1 ELSE 0 END) AS differ_end_date,
       SUM(CASE WHEN n_detail   > 1 THEN 1 ELSE 0 END) AS differ_visit_detail,
       SUM(CASE WHEN n_udi      > 1 THEN 1 ELSE 0 END) AS differ_unique_device_id
FROM (
  SELECT device_name, person_id, device_exposure_start_datetime, visit_occurrence_id, gtin, device_seq,
         COUNT(DISTINCT COALESCE(CAST(provider_id AS STRING), '~'))              AS n_provider,
         COUNT(DISTINCT COALESCE(CAST(quantity AS STRING), '~'))                 AS n_quantity,
         COUNT(DISTINCT COALESCE(CAST(device_exposure_end_date AS STRING), '~')) AS n_end,
         COUNT(DISTINCT COALESCE(CAST(visit_detail_id AS STRING), '~'))          AS n_detail,
         COUNT(DISTINCT COALESCE(unique_device_id, '~'))                         AS n_udi
  FROM <my_schema>.device_fix_step2_rank
  GROUP BY 1, 2, 3, 4, 5, 6
) x
GROUP BY device_name ORDER BY device_name;

-- Step 2 check B: keep vs copy. Expect Graft 14/28, Lens 14/42, Lead 14/70, Plate 11/0; total 53/140
SELECT device_name,
       COUNT(*)                                   AS rows_before,
       SUM(CASE WHEN is_copy = 0 THEN 1 ELSE 0 END) AS kept_is_copy_0,
       SUM(CASE WHEN is_copy = 1 THEN 1 ELSE 0 END) AS copies_is_copy_1
FROM <my_schema>.device_fix_step2_rank
GROUP BY ROLLUP(device_name) ORDER BY device_name NULLS LAST;

-- =====================================================================================
-- STEP 3. Corrected table: WHERE target_domain_id = 'Device' AND is_copy = 0
-- =====================================================================================
CREATE OR REPLACE TABLE <my_schema>.device_exposure AS
SELECT d.*                                           -- every other device row, unchanged
FROM ehr_union_clean.device_exposure d
WHERE d.device_exposure_id NOT IN (SELECT device_exposure_id FROM <my_schema>.device_fix_step2_rank)
UNION ALL
SELECT r.device_exposure_id, r.person_id, r.provider_id, r.visit_occurrence_id,
       r.target_concept_id AS device_concept_id,
       r.device_exposure_start_date, r.device_exposure_start_datetime,
       r.device_exposure_end_date, r.device_exposure_end_datetime,
       32817 AS device_type_concept_id,              -- EHR (the lookup had copied the concept ID here)
       r.device_source_value,
       CASE WHEN r.target_concept_id = r.device_concept_id THEN r.device_source_concept_id ELSE 0 END
            AS device_source_concept_id,             -- 0 when the concept was corrected (name-matched IDs are not source concepts)
       r.unique_device_id, r.quantity, r.visit_detail_id, r.data_partner_id
FROM <my_schema>.device_fix_step2_rank r
WHERE r.target_domain_id = 'Device' AND r.is_copy = 0;

-- Step 3 checks. Pass: fixed_rows = source_rows - 140; osm_rows = 0; non_device_for_4_names = 0
SELECT (SELECT COUNT(*) FROM ehr_union_clean.device_exposure)                         AS source_rows,
       (SELECT COUNT(*) FROM <my_schema>.device_exposure)                             AS fixed_rows,
       (SELECT COUNT(*) FROM <my_schema>.device_fix_step2_rank WHERE is_copy = 1)     AS copies_set_aside,
       (SELECT COUNT(*) FROM <my_schema>.device_exposure x
          JOIN <vocab>.concept c ON c.concept_id = x.device_concept_id
         WHERE c.vocabulary_id = 'OSM')                                                AS osm_rows,
       (SELECT COUNT(*) FROM <my_schema>.device_exposure x
          JOIN <my_schema>.device_fix_step2_rank r ON r.device_exposure_id = x.device_exposure_id
          LEFT JOIN <vocab>.concept c ON c.concept_id = x.device_concept_id
         WHERE x.device_concept_id <> 0 AND c.domain_id <> 'Device')                   AS non_device_for_4_names;

-- Step 3 check: dates with both an LV-lead and a pacemaker procedure (counts only).
--   Expect each such date to have one 2615876 (LV lead) and the other lead(s) 2615874 (pacemaker lead)
WITH lvpm AS (
  SELECT p.person_id, p.procedure_date
  FROM ehr_union_clean.procedure_occurrence p
  GROUP BY 1, 2
  HAVING MAX(CASE WHEN p.procedure_concept_id = 2107024 THEN 1 ELSE 0 END) = 1
     AND MAX(CASE WHEN p.procedure_concept_id IN (2106988, 2106987, 2726188, 2726239, 2107029,
                                                  2756517, 2107005, 2107027, 2313938) THEN 1 ELSE 0 END) = 1
)
SELECT COUNT(DISTINCT r.person_id, r.device_exposure_start_date)        AS lv_pacemaker_dates,
       SUM(CASE WHEN x.device_concept_id = 2615876 THEN 1 ELSE 0 END)   AS lv_leads,
       SUM(CASE WHEN x.device_concept_id = 2615874 THEN 1 ELSE 0 END)   AS pacemaker_leads
FROM <my_schema>.device_exposure x
JOIN <my_schema>.device_fix_step2_rank r ON r.device_exposure_id = x.device_exposure_id
JOIN lvpm l ON l.person_id = r.person_id AND l.procedure_date = r.device_exposure_start_date
WHERE r.device_name = 'Lead';

-- Step 3 result by name. Expect Graft 14 (4124754), Lens 14 (2721881), Lead 14 (by procedure), Plate 11
SELECT r.device_name, x.device_concept_id, c.concept_name, COUNT(*) AS rows
FROM <my_schema>.device_exposure x
JOIN <my_schema>.device_fix_step2_rank r ON r.device_exposure_id = x.device_exposure_id
LEFT JOIN <vocab>.concept c ON c.concept_id = x.device_concept_id
GROUP BY 1, 2, 3 ORDER BY 1, 4 DESC;

-- =====================================================================================
-- FINAL CHECKS: nothing outside the 4 names changed, nothing inside is lost
-- =====================================================================================
-- S1. Scope. Expect 193 rows, 1 partner (<one data partner>), 4 names
SELECT COUNT(*) AS rows, COUNT(DISTINCT data_partner_id) AS partners,
       CONCAT_WS(', ', COLLECT_SET(device_name)) AS names
FROM <my_schema>.device_fix_step2_rank;

-- S2. Every row outside the scope is in the corrected table, identical in every column. Expect 0 and 0
WITH outside AS (
  SELECT * FROM ehr_union_clean.device_exposure
  WHERE device_exposure_id NOT IN (SELECT device_exposure_id FROM <my_schema>.device_fix_step2_rank)
)
SELECT (SELECT COUNT(*) FROM (SELECT * FROM outside
                              EXCEPT ALL
                              SELECT * FROM <my_schema>.device_exposure))                 AS missing_or_changed,
       (SELECT COUNT(*) FROM (SELECT * FROM <my_schema>.device_exposure
                              WHERE device_exposure_id NOT IN (SELECT device_exposure_id FROM <my_schema>.device_fix_step2_rank)
                              EXCEPT ALL
                              SELECT * FROM outside))                                    AS extra_rows;

-- S3. Totals by partner. Expect every other partner: difference 0; <one data partner>: difference 140
SELECT s.data_partner_id, s.source_rows, f.fixed_rows, s.source_rows - f.fixed_rows AS difference
FROM (SELECT data_partner_id, COUNT(*) AS source_rows FROM ehr_union_clean.device_exposure GROUP BY 1) s
JOIN (SELECT data_partner_id, COUNT(*) AS fixed_rows  FROM <my_schema>.device_exposure GROUP BY 1) f
  USING (data_partner_id)
ORDER BY 1;

-- S4. Every one of the 193 rows is either in the corrected table or a recorded copy. Expect 0
SELECT COUNT(*) AS unaccounted
FROM <my_schema>.device_fix_step2_rank r
WHERE NOT (r.is_copy = 1 OR r.device_exposure_id IN (SELECT device_exposure_id FROM <my_schema>.device_exposure));
