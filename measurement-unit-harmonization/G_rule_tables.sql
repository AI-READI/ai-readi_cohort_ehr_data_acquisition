-- Databricks notebook source
-- Unit inference, Part G: the rules, for review outside Databricks.
--
-- Read-only. Run after a full A-D run, export the notebook as .ipynb to
-- ref_files/G_rule_tables.ipynb, then run make_tables.py, which writes one
-- CSV per cell to tables/.
--
-- These cells hold the rules behind the results, not the results per
-- partner and test. Patients must not be identifiable from them, so nothing
-- here carries record counts, medians, record values or partner ids. Notes
-- that quote a median or a value are replaced or blanked.
--
-- Each cell starts "-- G<n> <file name>: <title>", which make_tables.py reads.

-- COMMAND ----------

-- G1 conversions: every conversion applied, one row per from-unit, to-unit and factor.
--    canonical = multiply_by * value + add. multiply_by 1 and add 0 mean two
--    spellings of one unit. analyte is set where the conversion needs a molar
--    mass or charge.
SELECT unit_code AS from_unit,
       canonical_unit_code AS to_unit,
       round(conversion_slope, 6) AS multiply_by,
       round(conversion_intercept, 4) AS add,
       CASE WHEN conversion_method = 'analyte_bridge' THEN analyte END AS analyte,
       COUNT(DISTINCT test_id) AS n_tests,
       max_by(test_name, n) FILTER (WHERE test_id NOT LIKE 'src:%') AS example_test
FROM hive_metastore.ehr_union_clean_metrics.unit_conversion_decisions
WHERE conversion_method IN ('same_base', 'analyte_bridge')
GROUP BY 1, 2, 3, 4, 5
ORDER BY to_unit, from_unit, analyte;

-- COMMAND ----------

-- G2 canonical_unit_rules: tests whose canonical unit is set by hand.
--    Every other test uses its most common unit.
SELECT test_pattern,
       unit_code AS canonical_unit,
       regexp_replace(note, 'partner [0-9]+, ', '') AS note
FROM hive_metastore.ehr_union_clean_metrics.canonical_unit_rules
ORDER BY test_pattern;

-- COMMAND ----------

-- G3 unit_corrections: unit codes that are wrong for some records, and the unit
--    they are really in. partner_specific means the rule applies to the
--    partners whose values showed it. Rows that differ only by partner
--    collapse into one.
SELECT DISTINCT
       unit_code AS labeled_unit,
       test_pattern AS on_tests,
       data_partner_id IS NOT NULL AS partner_specific,
       decision,
       ucum_code AS corrected_unit,
       source,
       CASE WHEN decision = 'withheld' THEN 'no unit makes the values fit'
            WHEN rationale RLIKE '(?i)(median|value) [0-9]'
              THEN 'the values fit this unit, not the labeled one'
            ELSE regexp_replace(rationale, '; the one record.*$', '')
       END AS rationale
FROM hive_metastore.ehr_union_clean_metrics.unit_mapping
WHERE kind = 'correction'
ORDER BY labeled_unit, on_tests, partner_specific;

-- COMMAND ----------

-- G4 unit_text_judgments: unit text mapped by a typed judgment row.
--    Text that is a UCUM code, a REDCap label or matches an arrived unit needs
--    no judgment and isn't listed.
SELECT unit_source_value AS unit_text,
       ucum_code AS unit,
       rationale
FROM hive_metastore.ehr_union_clean_metrics.unit_mapping
WHERE kind = 'text' AND source = 'judgment' AND decision = 'unit'
ORDER BY lower(unit_source_value), unit_source_value;

-- COMMAND ----------

-- G5 test_name_rules: Part C's rules on the test name, first match wins.
SELECT priority,
       test_pattern,
       rule,
       unit_code AS unit,
       CASE WHEN note RLIKE '(?i)medians? [0-9]|value [0-9]' THEN NULL ELSE note END AS note
FROM hive_metastore.ehr_union_clean_metrics.unit_no_range_rules
ORDER BY priority;

-- COMMAND ----------

-- G6 test_concept_rules: Part A's rules for a test concept.
SELECT r.measurement_concept_id AS concept_id,
       c.concept_name,
       r.rule,
       r.unit_code AS unit,
       CASE WHEN r.note RLIKE '(?i)medians? [0-9]|values ~' THEN NULL
            ELSE regexp_replace(r.note, '; partner [0-9]+ has one labeled.*$', '')
       END AS note
FROM hive_metastore.ehr_union_clean_metrics.unit_concept_rules r
LEFT JOIN omop_vocab.concept c ON c.concept_id = r.measurement_concept_id
ORDER BY c.concept_name;

-- COMMAND ----------

-- G7 source_name_rules: units for records with no test concept, by exact source
--    test name. Nothing checks these units against limits, so they need
--    reading. no_ucum_unit rows have no unit.
SELECT source_name,
       rule,
       unit_code AS unit
FROM hive_metastore.ehr_union_clean_metrics.unit_source_name_rules
ORDER BY unit, source_name;
