-- Databricks notebook source
-- Unit harmonization, Part H: split the MacTel records out.
--
-- A harmonizes ehr_union_clean.measurement and
-- ehr_union_clean_mactel.measurement together, so the rules are built from
-- all the data. This notebook moves the MacTel records into
-- measurement_unit_harmonized_mactel and deletes them from
-- measurement_unit_harmonized, so each table matches its own source.
--
-- Run after 0, A-D and E_gate_checks, top to bottom. The last cell raises an
-- error if a join check fails. Rerunning H needs A-D first: after a split,
-- the main table no longer holds the MacTel records, and cell 1 stops.
-- MacTel records are matched by measurement_id, so no person ids are
-- written here.

-- COMMAND ----------

-- 1. Stop unless every MacTel record is in measurement_unit_harmonized
--    exactly once.
SELECT CASE WHEN COUNT(h.measurement_id) <> COUNT(*)
                 OR COUNT(*) <> (SELECT COUNT(*) FROM hive_metastore.ehr_union_clean_mactel.measurement)
            THEN raise_error('measurement_unit_harmonized does not hold each MacTel record once: rerun A-D and the gate, then H.')
            ELSE COUNT(*) END AS mactel_records
FROM hive_metastore.ehr_union_clean_mactel.measurement s
LEFT JOIN hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized h
  ON h.measurement_id = s.measurement_id;

-- COMMAND ----------

-- 2. Make the MacTel table, then take its records out of the main table.
CREATE OR REPLACE TABLE hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized_mactel AS
SELECT * FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized
WHERE measurement_id IN (SELECT measurement_id FROM hive_metastore.ehr_union_clean_mactel.measurement);

DELETE FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized
WHERE measurement_id IN (SELECT measurement_id FROM hive_metastore.ehr_union_clean_mactel.measurement);

-- COMMAND ----------

-- 3. Join checks: each harmonized table against its source, by
--    measurement_id. Pass: rows = ids on both sides, and the three mismatch
--    counts are 0. same_id_different_record catches a source rebuilt since
--    A ran, where ids match but point at other records.
CREATE OR REPLACE TEMP VIEW join_checks AS
SELECT 'main' AS tbl, m.measurement_id AS src_id, h.measurement_id AS harm_id,
       NOT (m.person_id <=> h.person_id
            AND m.measurement_concept_id <=> h.measurement_concept_id
            AND m.value_as_number <=> h.value_as_number
            AND m.measurement_date <=> h.measurement_date) AS differs
FROM hive_metastore.ehr_union_clean.measurement m
FULL OUTER JOIN hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized h
  ON m.measurement_id = h.measurement_id
UNION ALL
SELECT 'mactel', m.measurement_id, h.measurement_id,
       NOT (m.person_id <=> h.person_id
            AND m.measurement_concept_id <=> h.measurement_concept_id
            AND m.value_as_number <=> h.value_as_number
            AND m.measurement_date <=> h.measurement_date)
FROM hive_metastore.ehr_union_clean_mactel.measurement m
FULL OUTER JOIN hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized_mactel h
  ON m.measurement_id = h.measurement_id;

CREATE OR REPLACE TEMP VIEW join_summary AS
SELECT tbl,
  COUNT(src_id) AS src_rows, COUNT(DISTINCT src_id) AS src_ids,
  COUNT(harm_id) AS harm_rows, COUNT(DISTINCT harm_id) AS harm_ids,
  COUNT_IF(src_id IS NULL) AS only_in_harmonized,
  COUNT_IF(harm_id IS NULL) AS only_in_source,
  COUNT_IF(src_id IS NOT NULL AND harm_id IS NOT NULL AND differs) AS same_id_different_record
FROM join_checks
GROUP BY tbl;

SELECT * FROM join_summary ORDER BY tbl;

-- COMMAND ----------

-- 4. Fail the run if a join check failed. Cell 3's output shows which.
SELECT CASE WHEN COUNT_IF(src_rows <> src_ids OR harm_rows <> harm_ids OR src_rows <> harm_rows
                          OR only_in_harmonized > 0 OR only_in_source > 0
                          OR same_id_different_record > 0) > 0
            THEN raise_error('H join check failed: see cell 3.')
            ELSE 'all join checks passed' END AS result
FROM join_summary;
