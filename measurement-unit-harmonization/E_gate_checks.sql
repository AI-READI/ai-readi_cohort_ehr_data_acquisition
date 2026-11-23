-- Databricks notebook source
-- Unit inference, Part E gate: fails the run if a check finds a problem.
--
-- Run after 0, A, B, C and D, top to bottom; the last cell raises an error
-- if any check returned rows, which fails the notebook and the job. The
-- problem rows are in that cell's output. Each check should return no rows.
-- The cell numbers are the steps of 0 and A-D that a check belongs to.

-- COMMAND ----------

-- 0c (Part 0). Check: list rows that can't be used as they
--     stand. Any row here is a question for the list's maintainers.
CREATE OR REPLACE TEMP VIEW check_0c AS
SELECT 'two units for one concept' AS problem, concept_name AS item
FROM hive_metastore.ehr_union_clean_metrics.redcap_list_tests WHERE n_units > 1
UNION ALL
SELECT 'two sets of limits for one concept', concept_name
FROM hive_metastore.ehr_union_clean_metrics.redcap_list_tests WHERE n_limit_sets > 1
UNION ALL
SELECT 'list unit is not a UCUM concept', concat(concept_name, ': ', CAST(list_unit_concept_id AS STRING))
FROM hive_metastore.ehr_union_clean_metrics.redcap_list_tests
WHERE list_unit_concept_id IS NOT NULL AND COALESCE(list_unit_vocabulary, '') <> 'UCUM'
UNION ALL
SELECT 'limits but no list unit', concept_name
FROM hive_metastore.ehr_union_clean_metrics.redcap_list_tests
WHERE imp_lo IS NOT NULL AND list_unit_code IS NULL
UNION ALL
SELECT '09 field not in the unit lookup', r.field
FROM hive_metastore.ehr_union_clean_metrics.redcap_value_limits r
LEFT JOIN hive_metastore.ehr_union_clean_metrics.redcap_unit_lookup u ON u.lookup_key = r.field
WHERE u.lookup_key IS NULL
UNION ALL
SELECT 'lookup concept not in the mapping', concat(u.lookup_key, ': ', u.target_concept_id)
FROM hive_metastore.ehr_union_clean_metrics.redcap_unit_lookup u
JOIN omop_vocab.concept c ON c.concept_id = try_cast(u.target_concept_id AS BIGINT)
LEFT JOIN hive_metastore.ehr_union_clean_metrics.redcap_list_tests l ON l.concept_id = c.concept_id
WHERE l.concept_id IS NULL;

-- COMMAND ----------

-- 1e (Part A). Check: records moved to another concept by
--     measurement_concept_corrections whose value doesn't fit it
--     (total/HDL at or below 1).
CREATE OR REPLACE TEMP VIEW check_1e AS
SELECT t.data_partner_id, t.measurement_concept_id, t.harmonized_measurement_concept_id,
       COUNT(*) AS n, min(t.value_as_number) AS min_value, max(t.value_as_number) AS max_value
FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized t
JOIN hive_metastore.ehr_union_clean_metrics.measurement_concept_corrections c
  ON c.measurement_concept_id = t.measurement_concept_id
WHERE t.value_as_number <= c.implausible_max
GROUP BY 1, 2, 3;

-- COMMAND ----------

-- 1h (Part A). Check: judgment rows that can't be used (target not standard
--     UCUM, decision and target disagree, no rationale, untrimmed text
--     key, duplicate key).
CREATE OR REPLACE TEMP VIEW check_1h AS
SELECT 'target not a standard UCUM code' AS problem, j.*
FROM hive_metastore.ehr_union_clean_metrics.unit_judgments j
LEFT JOIN hive_metastore.ehr_union_clean_metrics.ucum_units u ON u.concept_code = j.target_code
WHERE j.target_code IS NOT NULL AND u.concept_id IS NULL
UNION ALL
SELECT 'decision and target disagree', j.*
FROM hive_metastore.ehr_union_clean_metrics.unit_judgments j
WHERE (j.decision = 'unit') <> (j.target_code IS NOT NULL)
   OR NOT (j.kind = 'text' AND j.decision IN ('unit', 'no_ucum_unit', 'not_a_unit')
           OR j.kind = 'correction' AND j.decision IN ('unit', 'withheld'))
UNION ALL
SELECT 'no rationale', j.*
FROM hive_metastore.ehr_union_clean_metrics.unit_judgments j
WHERE trim(COALESCE(j.rationale, '')) = ''
UNION ALL
SELECT 'text key not trimmed', j.*
FROM hive_metastore.ehr_union_clean_metrics.unit_judgments j
WHERE j.kind = 'text' AND j.unit_source_value <> trim(j.unit_source_value)
UNION ALL
SELECT 'duplicate key (text ignoring case)', j.kind, j.unit_source_value, j.unit_code,
       j.test_pattern, j.data_partner_id, j.decision, j.target_code, j.rationale
FROM (SELECT *, COUNT(*) OVER (PARTITION BY kind, lower(unit_source_value), unit_code,
                                            test_pattern, data_partner_id) AS n_same_key
      FROM hive_metastore.ehr_union_clean_metrics.unit_judgments) j
WHERE j.n_same_key > 1;

-- COMMAND ----------

-- 1k (Part A). Check: correction rows that clash.
--     duplicate key: two rows for one (unit code, pattern, partner).
--     tie: two equally specific rows match the same records and disagree.
--     maps_to row on a standard UCUM code: keyed by code, it would correct
--       every record in that standard unit, not just the non-standard one.
--     chain: records a row corrects into a code that another row would
--       correct again (only one correction is applied; write one row
--       straight to the final unit instead).
CREATE OR REPLACE TEMP VIEW check_1k AS
SELECT 'duplicate key' AS problem,
       concat_ws(' | ', unit_code, test_pattern, CAST(data_partner_id AS STRING)) AS item,
       COUNT(*) AS n
FROM hive_metastore.ehr_union_clean_metrics.unit_mapping
WHERE kind = 'correction'
GROUP BY unit_code, test_pattern, data_partner_id
HAVING COUNT(*) > 1
UNION ALL
SELECT 'tie', concat_ws(' | ', CAST(data_partner_id AS STRING), test_name, from_code), n_results
FROM hive_metastore.ehr_union_clean_metrics.unit_correction_keys
WHERE n_results > 1
UNION ALL
SELECT 'maps_to row on a standard UCUM code (would hit every record in that unit)',
       unit_code, 1
FROM hive_metastore.ehr_union_clean_metrics.unit_mapping
WHERE kind = 'correction' AND source = 'maps_to'
  AND unit_code IN (SELECT concept_code FROM hive_metastore.ehr_union_clean_metrics.ucum_units)
UNION ALL
SELECT 'chain', concat_ws(' | ', CAST(k.data_partner_id AS STRING), k.test_name,
                          concat(k.from_code, ' -> ', k.ucum_code, ' -> ', COALESCE(c.ucum_code, c.decision))),
       1
FROM hive_metastore.ehr_union_clean_metrics.unit_correction_keys k
JOIN hive_metastore.ehr_union_clean_metrics.unit_mapping c
  ON  c.kind = 'correction'
  AND c.unit_code = k.ucum_code
  AND (c.test_pattern IS NULL OR k.test_name RLIKE c.test_pattern)
  AND (c.data_partner_id IS NULL OR c.data_partner_id = k.data_partner_id);

-- COMMAND ----------

-- 1m (Part A). Check:
--     text key twice; a unit that isn't standard UCUM; a decision and unit
--     that disagree; text that is exactly a UCUM code but was decided by
--     ignoring case, or got another unit; numeric records with unit text
--     and no unit concept that have no text row (trimming must match).
CREATE OR REPLACE TEMP VIEW check_1m AS
SELECT 'text key twice' AS problem, unit_source_value AS item, COUNT(*) AS n
FROM hive_metastore.ehr_union_clean_metrics.unit_mapping
WHERE kind = 'text'
GROUP BY unit_source_value HAVING COUNT(*) > 1
UNION ALL
SELECT 'unit not standard UCUM', COALESCE(m.unit_source_value, m.unit_code), 1
FROM hive_metastore.ehr_union_clean_metrics.unit_mapping m
LEFT JOIN hive_metastore.ehr_union_clean_metrics.ucum_units u ON u.concept_id = m.unit_concept_id
WHERE m.unit_concept_id IS NOT NULL AND u.concept_id IS NULL
UNION ALL
SELECT concat('decision ', decision, ' with unit ', COALESCE(ucum_code, 'none')),
       COALESCE(unit_source_value, unit_code), 1
FROM hive_metastore.ehr_union_clean_metrics.unit_mapping
WHERE (decision = 'unit') <> (unit_concept_id IS NOT NULL)
UNION ALL
SELECT concat('UCUM code text decided as ', m.decision, ' ', COALESCE(m.ucum_code, ''),
              ' by ', COALESCE(m.matched_by, '-')),
       m.unit_source_value, 1
FROM hive_metastore.ehr_union_clean_metrics.unit_mapping m
JOIN hive_metastore.ehr_union_clean_metrics.ucum_units u ON u.concept_code = m.unit_source_value
WHERE m.kind = 'text'
  AND (m.matched_by IS DISTINCT FROM 'exact'
       OR m.decision NOT IN ('unit', 'review')
       OR (m.decision = 'unit' AND m.ucum_code <> m.unit_source_value))
UNION ALL
SELECT 'text with no row', trim(t.unit_source_value), COUNT(*)
FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized t
LEFT ANTI JOIN hive_metastore.ehr_union_clean_metrics.unit_mapping m
  ON m.kind = 'text' AND m.unit_source_value = trim(t.unit_source_value)
WHERE t.value_as_number IS NOT NULL
  AND t.unit_source_value IS NOT NULL
  AND COALESCE(t.unit_concept_id, 0) = 0
GROUP BY trim(t.unit_source_value);

-- COMMAND ----------

-- 4b (Part A). Check: explicit rules whose UCUM code didn't resolve to a concept.
--     If it returns rows, fix the code in cell 2.
CREATE OR REPLACE TEMP VIEW check_4b AS
SELECT r.*
FROM hive_metastore.ehr_union_clean_metrics.unit_concept_rules r
LEFT JOIN hive_metastore.ehr_union_clean_metrics.ucum_units ru ON ru.concept_code = r.unit_code
WHERE r.rule = 'explicit' AND ru.concept_id IS NULL;

-- COMMAND ----------

-- 7b (Part A). Check: unit codes that don't resolve to a UCUM concept.
--     If it returns rows, fix the code in cell 7.
CREATE OR REPLACE TEMP VIEW check_7b AS
SELECT r.*
FROM hive_metastore.ehr_union_clean_metrics.unit_source_name_rules r
LEFT JOIN hive_metastore.ehr_union_clean_metrics.ucum_units ru ON ru.concept_code = r.unit_code
WHERE r.unit_code IS NOT NULL AND ru.concept_id IS NULL;

-- COMMAND ----------

-- 14a (Part C). Check: explicit name rules without a valid UCUM
--      code, and non-explicit rules with one.
CREATE OR REPLACE TEMP VIEW check_14a AS
SELECT r.*
FROM hive_metastore.ehr_union_clean_metrics.unit_no_range_rules r
LEFT JOIN hive_metastore.ehr_union_clean_metrics.ucum_units ru ON ru.concept_code = r.unit_code
WHERE (r.rule = 'explicit') <> (ru.concept_id IS NOT NULL);

-- COMMAND ----------

-- 14d (Part C). Check: value bands with bad codes, gaps, overlaps, open ends.
CREATE OR REPLACE TEMP VIEW check_14d AS
WITH v AS (
  SELECT v.*, ru.concept_id AS ucum_concept_id,
         lag(v.value_max) OVER (PARTITION BY v.test_pattern ORDER BY v.value_min NULLS FIRST) AS prev_max,
         ROW_NUMBER() OVER (PARTITION BY v.test_pattern ORDER BY v.value_min NULLS FIRST) AS rn,
         COUNT(*) OVER (PARTITION BY v.test_pattern) AS n_bands
  FROM hive_metastore.ehr_union_clean_metrics.unit_no_range_value_rules v
  LEFT JOIN hive_metastore.ehr_union_clean_metrics.ucum_units ru ON ru.concept_code = v.unit_code
)
SELECT * FROM (
  SELECT CASE WHEN v.unit_code IS NOT NULL AND v.ucum_concept_id IS NULL THEN 'not a UCUM code'
              WHEN (v.method = 'value_split') <> (v.unit_code IS NOT NULL)
                OR v.method NOT IN ('value_split', 'no_ucum_unit', 'needs_review', 'suspect_concept')
                                                                         THEN 'method and unit_code disagree'
              WHEN v.rn = 1 AND v.value_min IS NOT NULL                  THEN 'first band has a lower bound'
              WHEN v.rn = v.n_bands AND v.value_max IS NOT NULL          THEN 'last band has an upper bound'
              WHEN v.rn > 1 AND NOT (v.value_min <=> v.prev_max)         THEN 'gap or overlap with previous band'
              WHEN v.value_min >= v.value_max                            THEN 'empty band'
         END AS problem,
         v.*
  FROM v
) WHERE problem IS NOT NULL;

-- COMMAND ----------

-- 17e (Part D). Check: bad or duplicate unit codes, duplicate bridges.
CREATE OR REPLACE TEMP VIEW check_17e AS
WITH codes AS (
  SELECT 'unit_factors' AS src, unit_code FROM hive_metastore.ehr_union_clean_metrics.unit_factors
  UNION ALL
  SELECT 'canonical_unit_rules', unit_code FROM hive_metastore.ehr_union_clean_metrics.canonical_unit_rules
)
SELECT concat(c.src, ': not a UCUM code') AS problem, c.unit_code AS item
FROM codes c
LEFT JOIN hive_metastore.ehr_union_clean_metrics.ucum_units ru ON ru.concept_code = c.unit_code
WHERE ru.concept_id IS NULL
UNION ALL
SELECT 'unit_factors: duplicate code', unit_code
FROM hive_metastore.ehr_union_clean_metrics.unit_factors
GROUP BY unit_code HAVING COUNT(*) > 1
UNION ALL
SELECT 'duplicate bridge', concat_ws(' ', analyte, from_base, to_base)
FROM hive_metastore.ehr_union_clean_metrics.unit_analyte_bridges
GROUP BY analyte, from_base, to_base HAVING COUNT(*) > 1;

-- COMMAND ----------

-- 19h (Part D). Check: list tests in our data whose limits
--      can't be converted to the canonical unit. Fix with a factor (17) or
--      an analyte (17a).
CREATE OR REPLACE TEMP VIEW check_19h AS
SELECT test_name, list_unit_code, canonical_unit_code, analyte
FROM hive_metastore.ehr_union_clean_metrics.unit_plausibility_limits
WHERE conversion_method = 'no_conversion';

-- COMMAND ----------

-- E2. Check: records with a canonical unit or a
--    value_plausibility but no harmonized value. Part D sets them together,
--    and every apply clears them, so this catches stale values from an
--    earlier run.
CREATE OR REPLACE TEMP VIEW check_E2 AS
SELECT unit_inference_method,
       canonical_unit_concept_id IS NOT NULL AS has_canonical_unit,
       value_plausibility IS NOT NULL AS has_plausibility,
       COUNT(*) AS n
FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized
WHERE (canonical_unit_concept_id IS NOT NULL OR value_plausibility IS NOT NULL)
  AND harmonized_value_as_number IS NULL
GROUP BY 1, 2, 3;

-- COMMAND ----------

-- E3. Check: numeric records with a unit whose added
--    columns aren't all filled. Every record with a unit should have a
--    method, an inferred unit, and a conversion method; a record in its
--    canonical unit should also have canonical_unit_value. A record's
--    unit is inferred_unit_concept_id (0 = none), so records a correction
--    leaves with no unit aren't counted.
CREATE OR REPLACE TEMP VIEW check_E3 AS
SELECT unit_inference_method, unit_conversion_method,
       inferred_unit_concept_id IS NULL AS no_inferred_unit,
       canonical_unit_concept_id IS NOT NULL AND canonical_unit_value IS NULL AS no_canonical_code,
       COUNT(*) AS n
FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized
WHERE value_as_number IS NOT NULL
  AND COALESCE(inferred_unit_concept_id, 0) <> 0
GROUP BY 1, 2, 3, 4
HAVING unit_inference_method IS NULL OR unit_conversion_method IS NULL
    OR no_inferred_unit OR no_canonical_code;

-- COMMAND ----------

-- E5. Check: corrections written by D (17d) against
--    what unit_mapping says now. A record's unit (inferred, 0 = none)
--    should equal the view's corrected unit, and unit_corrected_from the
--    code the view corrects from. A row here is a correction not written
--    (rerun D), one written that no row makes any more (rerun the part that
--    set the record's unit, then D), or one written twice.
CREATE OR REPLACE TEMP VIEW check_E5 AS
SELECT data_partner_id, test_name, unit_corrected_from, correction_from_code,
       inferred_unit_source_value, effective_unit_code, COUNT(*) AS n
FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_named
WHERE value_as_number IS NOT NULL
  AND (effective_unit_concept_id IS DISTINCT FROM NULLIF(inferred_unit_concept_id, 0)
       OR unit_corrected_from IS DISTINCT FROM correction_from_code
       OR unit_corrected_from = inferred_unit_source_value)
GROUP BY ALL
ORDER BY n DESC;

-- COMMAND ----------

-- MAGIC %python
-- MAGIC # Fails the notebook, and the job, if a check above returned rows.
-- MAGIC CHECKS = ['0c', '1e', '1h', '1k', '1m', '4b', '7b', '14a', '14d', '17e', '19h', 'E2', 'E3', 'E5']
-- MAGIC failed = []
-- MAGIC for check in CHECKS:
-- MAGIC     rows = spark.table(f'check_{check}')
-- MAGIC     n = rows.count()
-- MAGIC     print(f'{check}: {n} rows')
-- MAGIC     if n:
-- MAGIC         failed.append(check)
-- MAGIC         rows.show(50, truncate=False)
-- MAGIC if failed:
-- MAGIC     raise RuntimeError(f'Unit harmonization checks failed: {", ".join(failed)}')
