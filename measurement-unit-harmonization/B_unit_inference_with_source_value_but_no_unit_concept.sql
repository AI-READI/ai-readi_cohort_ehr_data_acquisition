-- Databricks notebook source
-- ===== B1. Unit-text decisions. Last result: summary =====
-- PART B: records that HAVE a unit string but no unit concept.
-- What each unit text means is decided in Part A (cells 1g-1p), in
-- unit_mapping's text rows, keyed by the trimmed text: from its UCUM code,
-- the REDCap lookup label, the units records with the same text arrived
-- with, OMOP's Maps to, or a judgment row (1g). This part applies them.
-- Only numeric records are touched.
--
-- Record methods: mapped_string (a unit, from any source; unit_mapping
-- says which), no_ucum_unit, not_a_unit, unit_review (sources disagree,
-- listed in A 1n), unmapped_string. Text that maps to no unit gets
-- inferred unit 0, OMOP's "source unit that can't be mapped"; NULL is for
-- records with no unit text and for records with no numeric value.
--
-- Run after Part A and before Part C (C_unit_inference_no_unit_no_range.sql),
-- which uses the units assigned here as evidence.

-- 11b. Review: text rows by decision and source
SELECT decision, source, matched_by, COUNT(*) AS n_texts, SUM(n) AS n_records
FROM hive_metastore.ehr_union_clean_metrics.unit_mapping
WHERE kind = 'text'
GROUP BY 1, 2, 3
ORDER BY n_records DESC;

-- COMMAND ----------

-- ===== B2. Review: every unit text =====

-- 11c. Review: every text, with the unit it got, where from, and the tests
--      it's on
SELECT decision, source, unit_source_value, ucum_code, n, tests, median, test_median,
       rationale, candidates
FROM hive_metastore.ehr_union_clean_metrics.unit_mapping
WHERE kind = 'text'
ORDER BY decision, source, n DESC;

-- COMMAND ----------

-- ===== B3. Apply unit_mapping's text rows =====

-- 12. Apply. Rerunnable. Matches on the trimmed text, as unit_mapping is
--     keyed. Clears Part D's columns and unit_corrected_from: Part D
--     corrects and converts the units written here.
MERGE INTO hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized t
USING (
  SELECT unit_source_value, ucum_code, decision,
         COALESCE(unit_concept_id, 0) AS inferred_unit_concept_id,
         CASE decision WHEN 'unit'         THEN 'mapped_string'
                       WHEN 'no_ucum_unit' THEN 'no_ucum_unit'
                       WHEN 'not_a_unit'   THEN 'not_a_unit'
                       WHEN 'review'       THEN 'unit_review'
                       ELSE 'unmapped_string'
         END AS unit_inference_method
  FROM hive_metastore.ehr_union_clean_metrics.unit_mapping
  WHERE kind = 'text'
) d
ON  trim(t.unit_source_value) = d.unit_source_value
AND t.value_as_number IS NOT NULL
AND COALESCE(t.unit_concept_id, 0) = 0
WHEN MATCHED THEN UPDATE SET
  t.unit_inference_method      = d.unit_inference_method,
  t.inferred_unit_concept_id   = d.inferred_unit_concept_id,
  t.inferred_unit_source_value = d.ucum_code,
  t.unit_corrected_from        = NULL,
  t.canonical_unit_concept_id  = NULL,
  t.canonical_unit_value       = NULL,
  t.unit_conversion_method     = NULL,
  t.value_plausibility         = NULL,
  t.harmonized_value_as_number = CASE WHEN d.decision = 'no_ucum_unit'
                                      THEN t.value_as_number END;
