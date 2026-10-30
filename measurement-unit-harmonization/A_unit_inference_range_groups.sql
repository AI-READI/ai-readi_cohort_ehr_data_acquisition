-- Databricks notebook source
-- Unit inference for measurement_unit_harmonized
--
-- Import with File > Import; each COMMAND block becomes a cell. A cell with
-- several statements runs them in order; Databricks shows the result of the
-- LAST statement, which is the one to look at.
--
-- Run order: A, B, C, D (files A_ to D_).
-- PART A: numeric records with NO unit but a reference range.
-- PART B: records with a unit STRING but no unit concept.
-- PART C: numeric records with no unit and no reference range.
-- PART D: conversion to a canonical unit per test.
--
-- unit_inference_method values written:
--   Setup:  copied_from_unit_concept_id (record arrived with a unit concept)
--   Part A: dataset_unit, partner_unit, range_match, explicit, source_name,
--           unitless, suspect_concept, needs_review, no_concept
--   Part B: mapped_string, reused_mapping, unitless, not_a_unit, unmapped_string
--
-- Setup also fills harmonized_measurement_concept_id: the record's
-- measurement_concept_id, or its replacement where
-- measurement_concept_corrections says the concept is wrong. Parts A-D
-- group records by it; measurement_concept_id stays as it arrived.
--
-- Units: real UCUM codes where OMOP has one, including the dimensionless
-- ones (pH, {ratio}, {index}, [score], {fraction}, {MOM}, {ISR}, [OD'U]).
-- unitless is left for what has no UCUM unit: specific gravity, counts,
-- Ct values, activity coefficients, RAST class.
--
-- canonical_unit_concept_id, canonical_unit_value, unit_conversion_method and
-- harmonized_value_as_number are filled in Part D; only unitless records get
-- harmonized_value_as_number here. Every apply (A, B, C) clears the Part D
-- columns on the records it writes, so a rerun of any part needs a rerun of
-- Part D after it.
--
-- Things learned the hard way:
--   * OMOP UCUM codes write international units as [iU] (lowercase i), and
--     prefixes as powers of ten: 10*-6.[iU]/mL = uIU/mL, 10*-3.eq/L = mEq/L.
--   * In Spark SQL an apostrophe inside a string is written \' (backslash);
--     '' silently joins two strings instead.


-- COMMAND ----------

-- ===== A1. Setup: target table, added columns, records that arrived with a unit =====

-- 1. Target table: a full copy of ehr_union_clean.measurement plus the added
--    columns. Does nothing if the table exists.
--      harmonized_measurement_concept_id  the test, corrected (cell 1d)
--      unit_inference_method       how the unit was decided
--      inferred_unit_concept_id    the record's unit (UCUM concept)
--      inferred_unit_source_value  its UCUM code
--      canonical_unit_concept_id   the test's canonical unit, where
--                                  harmonized_value_as_number is in it
--      canonical_unit_value        its UCUM code
--      harmonized_value_as_number  value in the canonical unit (unitless: value)
--      unit_conversion_method      how it was converted (Part D)
-- DROP TABLE IF EXISTS hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized;
CREATE TABLE IF NOT EXISTS hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized AS
SELECT m.*,
       CAST(NULL AS BIGINT) AS harmonized_measurement_concept_id,
       CAST(NULL AS STRING) AS inferred_unit_source_value,
       CAST(NULL AS BIGINT) AS inferred_unit_concept_id,
       CAST(NULL AS STRING) AS canonical_unit_value,
       CAST(NULL AS BIGINT) AS canonical_unit_concept_id,
       CAST(NULL AS DOUBLE) AS harmonized_value_as_number,
       CAST(NULL AS STRING) AS unit_inference_method,
       CAST(NULL AS STRING) AS unit_conversion_method
FROM hive_metastore.ehr_union_clean.measurement m;

-- COMMAND ----------

-- 1b. Records that arrived with a unit concept: copy it into the inferred
--     columns so every record with a unit has them filled. Rerunnable.
--     Parts A-C pick only records without a unit concept, so they never
--     overwrite these.
MERGE INTO hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized t
USING (
  SELECT k.unit_concept_id, u.concept_code
  FROM (SELECT DISTINCT unit_concept_id
        FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized
        WHERE COALESCE(unit_concept_id, 0) <> 0) k
  LEFT JOIN omop_vocab.concept u ON u.concept_id = k.unit_concept_id
) d
ON t.unit_concept_id = d.unit_concept_id
WHEN MATCHED THEN UPDATE SET
  t.unit_inference_method      = 'copied_from_unit_concept_id',
  t.inferred_unit_concept_id   = d.unit_concept_id,
  t.inferred_unit_source_value = d.concept_code;

-- Records with no numeric value and unit text but no unit concept get
-- inferred unit 0, OMOP's "source unit that can't be mapped". Part B does
-- the same for numeric records whose unit text maps to no unit.
UPDATE hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized
SET inferred_unit_concept_id = 0
WHERE value_as_number IS NULL
  AND unit_source_value IS NOT NULL
  AND COALESCE(unit_concept_id, 0) = 0;

-- COMMAND ----------

-- 1d. Concept corrections. Last result: check 1e, should be empty.
--     Records filed under the wrong concept: harmonized_measurement_concept_id
--     gets the right one; every other record gets its own concept (0 when
--     NULL). Rerunnable. A change here needs a full rerun of A-D, which group
--     by this column.
--     implausible_max: a corrected record at or below this value can't be
--     the new concept, and shows up in the check below.
CREATE OR REPLACE TABLE hive_metastore.ehr_union_clean_metrics.measurement_concept_corrections AS
SELECT * FROM VALUES
  (3023884, 3011163, 1D,
   'Filed as HDL/total, but every value is total/HDL (1.5-34, median 3.5): 6,454 of 6,457 Part C records and 5 of 6 Part A records equal the same person\'s same-day total/HDL (F4a); the rest have no same-day lipids. Partner 2084 files the same ratio under 3011163.')
AS t(measurement_concept_id, harmonized_measurement_concept_id, implausible_max, note);

UPDATE hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized
SET harmonized_measurement_concept_id = COALESCE(measurement_concept_id, 0)
WHERE harmonized_measurement_concept_id IS DISTINCT FROM COALESCE(measurement_concept_id, 0);

MERGE INTO hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized t
USING hive_metastore.ehr_union_clean_metrics.measurement_concept_corrections c
ON t.measurement_concept_id = c.measurement_concept_id
WHEN MATCHED THEN UPDATE SET
  t.harmonized_measurement_concept_id = c.harmonized_measurement_concept_id;

-- 1e. Check: corrected records whose value doesn't fit the new concept.
--     Should return no rows.
SELECT t.data_partner_id, t.measurement_concept_id, t.harmonized_measurement_concept_id,
       COUNT(*) AS n, min(t.value_as_number) AS min_value, max(t.value_as_number) AS max_value
FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized t
JOIN hive_metastore.ehr_union_clean_metrics.measurement_concept_corrections c
  ON c.measurement_concept_id = t.measurement_concept_id
WHERE t.value_as_number <= c.implausible_max
GROUP BY 1, 2, 3;

-- COMMAND ----------

-- 1f. Keyed view: numeric records in scope, with test_id and effective
--     unit. Parts C and D read it; D's MERGE (cell 20) uses the same keys.
--     The view's columns are fixed when it is created (SELECT * is expanded
--     then), so rerun this cell whenever the table is recreated or altered.
CREATE OR REPLACE VIEW hive_metastore.ehr_union_clean_metrics.measurement_unit_keyed AS
SELECT *,
       CASE WHEN COALESCE(harmonized_measurement_concept_id, 0) = 0
            THEN concat('src:', measurement_source_value)
            ELSE CAST(harmonized_measurement_concept_id AS STRING)
       END AS test_id,
       COALESCE(NULLIF(unit_concept_id, 0), NULLIF(inferred_unit_concept_id, 0)) AS effective_unit_concept_id
FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized
WHERE value_as_number IS NOT NULL
  AND COALESCE(unit_inference_method, '') <> 'suspect_concept';

-- COMMAND ----------

-- ===== A2. Rules, working views and decisions. Last result: check, should be empty =====

-- 2. Hand rules by concept (the harmonized concept, cell 1d).
--    unitless        : no unit expected and no UCUM unit for it (specific gravity)
--    suspect_concept : values don't fit the concept; looks like a concept-mapping error
--    explicit        : unit decided by hand, given as a UCUM code and looked up in cell 4
--                      (pH, ratios, indexes and scores have UCUM units too)
CREATE OR REPLACE TABLE hive_metastore.ehr_union_clean_metrics.unit_concept_rules AS
SELECT * FROM VALUES
  -- pH
  (3022621,  'explicit', 'pH', 'pH of Urine by Test strip'),
  (3029305,  'explicit', 'pH', 'pH of Urine by Automated test strip'),
  (3015736,  'explicit', 'pH', 'pH of Urine'),
  (3015501,  'explicit', 'pH', 'pH of 24 hour Urine'),
  (3019977,  'explicit', 'pH', 'pH of Arterial blood'),
  (3029473,  'explicit', 'pH', 'pH of Arterial blood, temp adjusted'),
  (3012544,  'explicit', 'pH', 'pH of Venous blood'),
  (3038999,  'explicit', 'pH', 'pH of Venous blood, temp adjusted'),
  (3030091,  'explicit', 'pH', 'pH of Blood, temp adjusted'),
  (3032186,  'explicit', 'pH', 'pH of Venous cord blood, temp adjusted'),
  (3030109,  'explicit', 'pH', 'pH of Arterial cord blood, temp adjusted'),
  (3018672,  'explicit', 'pH', 'pH of Body fluid'),
  -- specific gravity (3058 labels some as g/mL; SG is dimensionless)
  (3029991,  'unitless', NULL, 'Specific gravity of Urine by Refractometry automated'),
  (3033543,  'unitless', NULL, 'Specific gravity of Urine'),
  (3000330,  'unitless', NULL, 'Specific gravity of Urine by Test strip'),
  (3039919,  'unitless', NULL, 'Specific gravity of Urine by Automated test strip'),
  (3019150,  'unitless', NULL, 'Specific gravity of Urine by Refractometry'),
  -- INR
  (3022217,  'explicit', '{ratio}', 'INR in Platelet poor plasma'),
  (3051593,  'explicit', '{ratio}', 'INR in Capillary blood'),
  (3032080,  'explicit', '{ratio}', 'INR in Blood'),
  -- ratios
  (3018311,  'explicit', '{ratio}', 'BUN/Creatinine ratio'),
  (3020509,  'explicit', '{ratio}', 'Albumin/Globulin ratio'),
  (3053209,  'explicit', '{ratio}', 'Kappa/Lambda free light chain ratio'),
  (40757349, 'explicit', '{ratio}', 'CD4/CD8 ratio'),
  (3021492,  'explicit', '{ratio}', 'IgG/Albumin ratio'),
  (3011163,  'explicit', '{ratio}', 'Total/HDL cholesterol ratio, including the records corrected from 3023884 (cell 1d); partner 3058 has one labeled mg/dL record that would otherwise be copied'),
  -- indexes, fractions, scores
  (3032612,  'explicit', '{index}',    'Calcium oxalate index, 24h urine'),
  (3031809,  'explicit', '{fraction}', 'Calcium hydrogen phosphate saturation fraction'),
  (3000551,  'explicit', '{index}',    'T4 free index'),
  (21492175, 'explicit', '[score]',    'AlloMap score'),
  -- suspect concept mappings
  (3037816,  'suspect_concept', NULL, 'CD4+CD8+ cells/cells: range 0.8-4.2 and values look like a CD4/CD8 ratio'),
  (3046867,  'suspect_concept', NULL, 'Alpha 1 antitrypsin phenotype [Interpretation]: holds the same value and range as an IgA result'),
  (3016991,  'suspect_concept', NULL, 'Thyroxine (T4) total: ranges 0.82-1.77 and values ~1 are free T4 in ng/dL'),
  -- explicit units
  (3045462,  'explicit', 'mg/mg{creat}', 'Protein/Creatinine [Ratio]: range_high 0.2 implies mg/mg'),
  (3034485,  'explicit', 'mg/g{creat}',  'Albumin/Creatinine: median 22.8, 95th pct 1660 fit mg/g; in mg/mmol the 95th would be implausible'),
  (3034426,  'explicit', 's',            'Prothrombin time: range 9.2-12.1 is seconds'),
  (3000034,  'explicit', 'mg/L',         'Microalbumin [Mass/volume] in Urine: range 5-20 fits mg/L'),
  (3043722,  'explicit', '/[LPF]',       'Hyaline casts [#/area]: per low power field')
AS t(measurement_concept_id, rule, unit_code, note);

-- 3a. Numeric source records
CREATE OR REPLACE TEMP VIEW src AS
SELECT data_partner_id, harmonized_measurement_concept_id, range_low, range_high,
       unit_concept_id, unit_source_value, value_as_number
FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized
WHERE value_as_number IS NOT NULL;

-- 3b. Unlabeled groups: no unit at all, but a reference range
CREATE OR REPLACE TEMP VIEW unl AS
SELECT data_partner_id, harmonized_measurement_concept_id, range_low, range_high,
       COUNT(*) AS n,
       percentile_approx(value_as_number, 0.5) AS med
FROM src
WHERE range_high IS NOT NULL
  AND unit_source_value IS NULL
  AND COALESCE(unit_concept_id, 0) = 0
GROUP BY 1, 2, 3, 4;

-- 3c. Labeled records for the same concepts. Only records with a real
--     unit_concept_id count as evidence; junk strings like 'Possible' or
--     '**Please' with no concept are ignored.
CREATE OR REPLACE TEMP VIEW lab AS
SELECT s.*
FROM src s
WHERE COALESCE(s.unit_concept_id, 0) <> 0
  AND s.harmonized_measurement_concept_id IN (
        SELECT harmonized_measurement_concept_id FROM unl
        WHERE harmonized_measurement_concept_id <> 0);

-- 3d. Candidate units at three levels of evidence:
--     1 = same partner, same concept, same reference range
--     2 = same partner, same concept
--     3 = same concept, any partner
CREATE OR REPLACE TEMP VIEW cand AS
SELECT 1 AS lvl, data_partner_id, harmonized_measurement_concept_id, range_low, range_high,
       unit_concept_id, COUNT(*) AS n_lab,
       percentile_approx(value_as_number, 0.5) AS med_lab
FROM lab
GROUP BY data_partner_id, harmonized_measurement_concept_id, range_low, range_high, unit_concept_id
UNION ALL
SELECT 2, data_partner_id, harmonized_measurement_concept_id, NULL, NULL,
       unit_concept_id, COUNT(*), percentile_approx(value_as_number, 0.5)
FROM lab
GROUP BY data_partner_id, harmonized_measurement_concept_id, unit_concept_id
UNION ALL
SELECT 3, NULL, harmonized_measurement_concept_id, NULL, NULL,
       unit_concept_id, COUNT(*), percentile_approx(value_as_number, 0.5)
FROM lab
GROUP BY harmonized_measurement_concept_id, unit_concept_id;

-- 3e. Pick the best candidate per unlabeled group: strongest evidence level
--     first, then most records. An exact reference-range match (level 1) is
--     trusted as is. Weaker candidates only count if the unlabeled group's
--     median is within a factor of 2 of the candidate's median; that check is
--     what keeps body temperature from being called Celsius when values are ~98.
--     (Applying it at level 1 too rejected small groups of abnormal results,
--     e.g. a BUN of 44 against a typical 17.)
CREATE OR REPLACE TEMP VIEW pick AS
SELECT u.data_partner_id, u.harmonized_measurement_concept_id, u.range_low, u.range_high,
       c.lvl, c.unit_concept_id, c.n_lab, c.med_lab,
       ROW_NUMBER() OVER (
         PARTITION BY u.data_partner_id, u.harmonized_measurement_concept_id, u.range_low, u.range_high
         ORDER BY c.lvl, c.n_lab DESC, c.unit_concept_id) AS rk
FROM unl u
JOIN cand c
  ON  c.harmonized_measurement_concept_id = u.harmonized_measurement_concept_id
  AND (c.lvl = 3 OR c.data_partner_id = u.data_partner_id)
  AND (c.lvl > 1 OR (c.range_high = u.range_high AND c.range_low <=> u.range_low))
WHERE c.lvl = 1
   OR (u.med = 0 AND c.med_lab = 0)
   OR (c.med_lab > 0 AND u.med / c.med_lab BETWEEN 0.5 AND 2);

-- 4. Decisions table: one row per unlabeled group
CREATE OR REPLACE TABLE hive_metastore.ehr_union_clean_metrics.unit_inference_range_decisions AS
SELECT
  u.data_partner_id, u.harmonized_measurement_concept_id, cn.concept_name,
  u.range_low, u.range_high, u.n, u.med,
  CASE
    WHEN r.rule = 'unitless'                     THEN 'unitless'
    WHEN r.rule = 'suspect_concept'              THEN 'suspect_concept'
    WHEN u.harmonized_measurement_concept_id = 0 THEN 'no_concept'
    WHEN r.rule = 'explicit'                     THEN 'explicit'
    WHEN p.lvl = 1                               THEN 'range_match'
    WHEN p.lvl = 2                               THEN 'partner_unit'
    WHEN p.lvl = 3                               THEN 'dataset_unit'
    ELSE 'needs_review'
  END AS unit_inference_method,
  CASE
    WHEN r.rule = 'explicit' THEN ru.concept_id
    WHEN r.rule IS NULL AND u.harmonized_measurement_concept_id <> 0 THEN p.unit_concept_id
  END AS inferred_unit_concept_id,
  p.n_lab  AS evidence_n,
  p.med_lab AS evidence_median,
  r.note
FROM unl u
LEFT JOIN pick p
  ON  p.rk = 1
  AND p.data_partner_id = u.data_partner_id
  AND p.harmonized_measurement_concept_id = u.harmonized_measurement_concept_id
  AND p.range_high = u.range_high
  AND p.range_low <=> u.range_low
LEFT JOIN hive_metastore.ehr_union_clean_metrics.unit_concept_rules r
  ON r.measurement_concept_id = u.harmonized_measurement_concept_id
LEFT JOIN omop_vocab.concept ru
  ON  ru.vocabulary_id = 'UCUM'
  AND ru.concept_code = r.unit_code
  AND ru.invalid_reason IS NULL
LEFT JOIN omop_vocab.concept cn
  ON cn.concept_id = u.harmonized_measurement_concept_id;

-- 4b. Check: explicit rules whose UCUM code didn't resolve to a concept.
--     Should return no rows; fix the code in cell 2 if it does.
SELECT r.*
FROM hive_metastore.ehr_union_clean_metrics.unit_concept_rules r
LEFT JOIN omop_vocab.concept ru
  ON  ru.vocabulary_id = 'UCUM'
  AND ru.concept_code = r.unit_code
  AND ru.invalid_reason IS NULL
WHERE r.rule = 'explicit' AND ru.concept_id IS NULL;

-- COMMAND ----------

-- ===== A3. Review: summary by method =====

-- 5a. Review: how many groups and records each method covers
SELECT unit_inference_method, COUNT(*) AS n_groups, SUM(n) AS n_records
FROM hive_metastore.ehr_union_clean_metrics.unit_inference_range_decisions
GROUP BY 1
ORDER BY n_records DESC;

-- COMMAND ----------

-- ===== A4. Review: every group =====

-- 5b. Review: every group, with the chosen unit spelled out
SELECT d.unit_inference_method, d.data_partner_id, d.harmonized_measurement_concept_id, d.concept_name,
       d.range_low, d.range_high, d.n, d.med,
       uc.concept_code AS inferred_unit, d.evidence_n, d.evidence_median, d.note
FROM hive_metastore.ehr_union_clean_metrics.unit_inference_range_decisions d
LEFT JOIN omop_vocab.concept uc ON uc.concept_id = d.inferred_unit_concept_id
ORDER BY d.n DESC;

-- COMMAND ----------

-- ===== A5. Apply Part A decisions =====

-- 6. Apply to the target table. Rerunnable: it rewrites the same rows.
--    Groups marked needs_review / no_concept / suspect_concept get the
--    method recorded but no unit, so they stay visible.
MERGE INTO hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized t
USING (
  SELECT d.*, uc.concept_code AS unit_code
  FROM hive_metastore.ehr_union_clean_metrics.unit_inference_range_decisions d
  LEFT JOIN omop_vocab.concept uc ON uc.concept_id = d.inferred_unit_concept_id
) d
ON  t.data_partner_id = d.data_partner_id
AND t.harmonized_measurement_concept_id = d.harmonized_measurement_concept_id
AND t.range_high = d.range_high
AND t.range_low <=> d.range_low
AND t.value_as_number IS NOT NULL
AND t.unit_source_value IS NULL
AND COALESCE(t.unit_concept_id, 0) = 0
WHEN MATCHED THEN UPDATE SET
  t.unit_inference_method      = d.unit_inference_method,
  t.inferred_unit_concept_id   = d.inferred_unit_concept_id,
  t.inferred_unit_source_value = d.unit_code,
  t.canonical_unit_concept_id  = NULL,
  t.canonical_unit_value       = NULL,
  t.unit_conversion_method     = NULL,
  t.harmonized_value_as_number = CASE WHEN d.unit_inference_method = 'unitless'
                                      THEN t.value_as_number END;

-- COMMAND ----------

-- ===== A6. No-concept records: rules. Last result: check, should be empty =====

-- 7. Records with no concept (harmonized_measurement_concept_id = 0): the
--    unit for each source test name, matched exactly against
--    lower(trim(measurement_source_value)). Exact names, not patterns:
--    nothing checks these units against the values, so a new name (say
--    "Hemoglobin A1c, External") has to show up as no_concept in 8b, not
--    quietly inherit hemoglobin's g/dL. Part C (step 4) uses the same list.
--    Every name here is partner 3058's, and each was checked against its
--    values and reference ranges (8b, and F5 for Part C). Names are cut
--    at 30 characters in the source.
--    Run this AFTER cell 6: it overwrites the 'no_concept' rows cell 6 wrote.
CREATE OR REPLACE TABLE hive_metastore.ehr_union_clean_metrics.unit_source_name_rules AS
SELECT * FROM VALUES
  -- dimensionless units
  ('albumin/globulin ratio',          'source_name', '{ratio}'),
  ('bun/creatinine ratio',            'source_name', '{ratio}'),
  ('igg/albumin, csf',                'source_name', '{ratio}'),
  ('kappa/lambda flc ratio',          'source_name', '{ratio}'),
  ('cd4/cd8 ratio',                   'source_name', '{ratio}'),
  ('inr fingerstick, rapid lab',      'source_name', '{ratio}'),
  ('prothrombin inr',                 'source_name', '{ratio}'),
  ('prothrombin inr, external',       'source_name', '{ratio}'),
  ('immunoglobulin g index, csf',     'source_name', '{index}'),
  ('aspergillus gm index',            'source_name', '{index}'),
  ('aspergillus gm index, bal',       'source_name', '{index}'),
  ('aspergillus gm confirm, bal',     'source_name', '{index}'),
  ('teratozoospermia index',          'source_name', '{index}'),
  ('jcv index value',                 'source_name', '{index}'),
  ('nash score',                      'source_name', '[score]'),
  ('nash steatosis score',            'source_name', '[score]'),
  ('nash fibrosis score',             'source_name', '[score]'),
  ('ph, urn',                         'source_name', 'pH'),
  ('ph, urn (uwnc)',                  'source_name', 'pH'),
  ('ph, urn, external',               'source_name', 'pH'),
  ('ph, ven',                         'source_name', 'pH'),
  ('ph, mixed ven',                   'source_name', 'pH'),
  ('ph, wet mount',                   'source_name', 'pH'),
  -- unitless: no UCUM unit
  ('specific gravity, urine',         'unitless',    NULL),
  ('specific gravity, urn',           'unitless',    NULL),
  ('specific gravity, urn, externa',  'unitless',    NULL),
  -- units
  ('albumin/creatinine ratio, urn,',  'source_name', 'mg/g{creat}'),
  ('cholesterol (total), external',   'source_name', 'mg/dL'),
  ('non-hdl cholesterol, external',   'source_name', 'mg/dL'),
  ('triglyceride, external',          'source_name', 'mg/dL'),
  ('glucose, external',               'source_name', 'mg/dL'),
  ('glucose qual, urn, external',     'source_name', 'mg/dL'),
  ('calcium, external',               'source_name', 'mg/dL'),
  ('creatinine',                      'source_name', 'mg/dL'),
  ('creatinine, external',            'source_name', 'mg/dL'),
  ('creatinine/unit, urn (sendout)',  'source_name', 'mg/dL'),
  ('magnesium, external',             'source_name', 'mg/dL'),
  ('phosphate, external',             'source_name', 'mg/dL'),
  ('direct bilirubin (beckman)',      'source_name', 'mg/dL'),
  ('apolipoprotein b',                'source_name', 'mg/dL'),
  ('protein (total), external',       'source_name', 'g/dL'),
  ('albumin, external',               'source_name', 'g/dL'),
  ('globulin',                        'source_name', 'g/dL'),
  ('hemoglobin, external',            'source_name', 'g/dL'),
  ('hemoglobin, poct',                'source_name', 'g/dL'),
  ('hematocrit, external',            'source_name', '%'),
  ('rdw-cv, external',                'source_name', '%'),
  ('sodium',                          'source_name', 'mmol/L'),
  ('sodium, external',                'source_name', 'mmol/L'),
  ('potassium, external',             'source_name', 'mmol/L'),
  ('chloride',                        'source_name', 'mmol/L'),
  ('chloride, external',              'source_name', 'mmol/L'),
  ('platelet count, external',        'source_name', '10*3/uL'),
  ('lymphocyte count, external',      'source_name', '10*3/uL'),
  ('neutrophils, external',           'source_name', '10*3/uL'),
  ('monocytes, external',             'source_name', '10*3/uL'),
  ('basophils, external',             'source_name', '10*3/uL'),
  ('eosinophil count, external',      'source_name', '10*3/uL'),
  ('immature granulocytes',           'source_name', '10*3/uL'),
  ('immature granulocytes, externa',  'source_name', '10*3/uL'),
  ('alt (gpt), external',             'source_name', '[U]/L'),
  ('ast (got), external',             'source_name', '[U]/L'),
  ('alkaline phosphatase (total),',   'source_name', '[U]/L'),
  ('thyroid stimulating hormone, e',  'source_name', '10*-6.[iU]/mL'),
  ('insulin',                         'source_name', '10*-6.[iU]/mL'),
  ('insulin, external',               'source_name', '10*-6.[iU]/mL'),
  ('rbc sedimentation rate, extern',  'source_name', 'mm/h'),
  ('cortisol, external',              'source_name', 'ug/dL'),
  ('prolactin, external',             'source_name', 'ng/mL'),
  ('ferritin, external',              'source_name', 'ng/mL'),
  ('vit d (25_hydroxy) total, exte',  'source_name', 'ng/mL'),
  ('vitamin d2 (25_hydroxy), exter',  'source_name', 'ng/mL'),
  ('vitamin d3 (25_hydroxy), exter',  'source_name', 'ng/mL'),
  ('free t4 by equil.di.',            'source_name', 'ng/dL'),
  ('parathyroid hormone',             'source_name', 'pg/mL'),
  ('parathyroid hormone, external',   'source_name', 'pg/mL'),
  ('free testosterone, calculated,',  'source_name', 'pg/mL'),
  ('testosterone, external',          'source_name', 'ng/dL'),
  ('urobilinogen, urn, external',     'source_name', '[EU]/dL'),
  ('osmolality, urn',                 'source_name', 'mosm/kg')
AS t(source_name, rule, unit_code);

-- 7b. Check: unit codes that don't resolve to a UCUM concept.
--     Should return no rows; fix the code in cell 7 if it does.
SELECT r.*
FROM hive_metastore.ehr_union_clean_metrics.unit_source_name_rules r
LEFT JOIN omop_vocab.concept ru
  ON  ru.vocabulary_id = 'UCUM'
  AND ru.concept_code = r.unit_code
  AND ru.invalid_reason IS NULL
WHERE r.unit_code IS NOT NULL AND ru.concept_id IS NULL;

-- COMMAND ----------

-- ===== A7. No-concept records: decisions. Last result: review =====

-- 8. Decisions for the no-concept groups, keyed by partner + source name + range
CREATE OR REPLACE TABLE hive_metastore.ehr_union_clean_metrics.unit_inference_source_name_decisions AS
WITH g AS (
  SELECT data_partner_id, measurement_source_value, range_low, range_high,
         COUNT(*) AS n,
         percentile_approx(value_as_number, 0.5) AS med
  FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized
  WHERE harmonized_measurement_concept_id = 0
    AND measurement_source_value IS NOT NULL
    AND value_as_number IS NOT NULL
    AND range_high IS NOT NULL
    AND unit_source_value IS NULL
    AND COALESCE(unit_concept_id, 0) = 0
  GROUP BY 1, 2, 3, 4
),
m AS (
  SELECT g.*, r.rule, r.unit_code, r.source_name
  FROM g
  LEFT JOIN hive_metastore.ehr_union_clean_metrics.unit_source_name_rules r
    ON lower(trim(g.measurement_source_value)) = r.source_name
)
SELECT m.data_partner_id, m.measurement_source_value, m.range_low, m.range_high, m.n, m.med,
       COALESCE(m.rule, 'no_concept') AS unit_inference_method,
       ru.concept_id AS inferred_unit_concept_id,
       ru.concept_code AS inferred_unit,
       m.source_name AS matched_name
FROM m
LEFT JOIN omop_vocab.concept ru
  ON  ru.vocabulary_id = 'UCUM'
  AND ru.concept_code = m.unit_code
  AND ru.invalid_reason IS NULL;

-- 8b. Review
SELECT * FROM hive_metastore.ehr_union_clean_metrics.unit_inference_source_name_decisions
ORDER BY unit_inference_method, n DESC;

-- COMMAND ----------

-- ===== A8. Apply no-concept decisions (after A5) =====

-- 9. Apply the no-concept decisions. Rerunnable.
MERGE INTO hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized t
USING hive_metastore.ehr_union_clean_metrics.unit_inference_source_name_decisions d
ON  t.data_partner_id = d.data_partner_id
AND t.harmonized_measurement_concept_id = 0
AND t.measurement_source_value = d.measurement_source_value
AND t.range_high = d.range_high
AND t.range_low <=> d.range_low
AND t.value_as_number IS NOT NULL
AND t.unit_source_value IS NULL
AND COALESCE(t.unit_concept_id, 0) = 0
WHEN MATCHED THEN UPDATE SET
  t.unit_inference_method      = d.unit_inference_method,
  t.inferred_unit_concept_id   = d.inferred_unit_concept_id,
  t.inferred_unit_source_value = d.inferred_unit,
  t.canonical_unit_concept_id  = NULL,
  t.canonical_unit_value       = NULL,
  t.unit_conversion_method     = NULL,
  t.harmonized_value_as_number = CASE WHEN d.unit_inference_method = 'unitless'
                                      THEN t.value_as_number END;
