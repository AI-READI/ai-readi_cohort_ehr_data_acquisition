-- Databricks notebook source
-- Unit inference, Part E: review the outputs of a full A-D run.
--
-- Read-only: every cell is a SELECT. Run after 0, A, B, C and D, top to
-- bottom, and read every cell's result. Each cell repeats a check or review
-- query from A-D (named in its comment, which also says what to expect);
-- the queries stay in A-D too, so a change there has to be copied here.
-- Cells E1-E6 are the only queries that aren't in A-D.
--
-- Checks (should be empty): 0c, 1e, 1h, 1k, 1m, 4b, 7b, 14a, 14d, 17e,
-- 19h, E2, E3, E5.
--
-- Counts: the expected counts are from the 2026-11-03 run (7,027,806
-- numeric records). A change in the source table moves them slightly.


-- COMMAND ----------

-- 1e (Part A, cell 1d). Check: records moved to another concept by
--     measurement_concept_corrections whose value doesn't fit it
--     (total/HDL at or below 1).
--     Expect: no rows.
SELECT t.data_partner_id, t.measurement_concept_id, t.harmonized_measurement_concept_id,
       COUNT(*) AS n, min(t.value_as_number) AS min_value, max(t.value_as_number) AS max_value
FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized t
JOIN hive_metastore.ehr_union_clean_metrics.measurement_concept_corrections c
  ON c.measurement_concept_id = t.measurement_concept_id
WHERE t.value_as_number <= c.implausible_max
GROUP BY 1, 2, 3;


-- COMMAND ----------

-- 1h (Part A, cell A1b). Check: judgment rows that can't be used (target not standard
--     UCUM, decision and target disagree, no rationale, untrimmed text
--     key, duplicate key).
--     Expect: no rows.
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

-- 1k (Part A, cell A1c). Check: correction rows that clash (duplicate key, tie,
--     maps_to row on a standard UCUM code, chain).
--     Expect: no rows.
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

-- 1m (Part A, cell A1d). Check: text rows (key twice, non-standard unit, decision
--     and unit disagree, UCUM-code text decided by case, records with no
--     text row).
--     Expect: no rows.
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

-- 1n (Part A). Review: review rows, with candidates. These records have no
--     unit until a judgment row settles them.
--     Expect: 8492 {log} only (no Maps to target, left in
--     review like the other log viral loads).
SELECT kind, COALESCE(unit_source_value, unit_code) AS unit_text_or_code,
       rationale, candidates, n, tests, median, test_median
FROM hive_metastore.ehr_union_clean_metrics.unit_mapping
WHERE decision = 'review'
ORDER BY n DESC NULLS LAST, unit_text_or_code;

-- COMMAND ----------

-- 1o (Part A). Review: judgment rows an automatic source already covers.
--     Expect: one row, text U, covered since the correction u -> [U].
WITH a AS (
  SELECT t,
         COUNT(DISTINCT CASE WHEN exact THEN unit_concept_id END) AS n_exact_units,
         min(CASE WHEN exact THEN unit_concept_id END) AS exact_unit,
         COUNT(DISTINCT unit_concept_id) AS n_any_units,
         min(unit_concept_id) AS any_unit
  FROM hive_metastore.ehr_union_clean_metrics.unit_text_candidates
  GROUP BY t
)
SELECT m.kind, m.unit_source_value AS key, m.ucum_code, m.candidates, m.rationale, m.n
FROM hive_metastore.ehr_union_clean_metrics.unit_mapping m
JOIN a ON a.t = m.unit_source_value
WHERE m.kind = 'text' AND m.source = 'judgment' AND m.decision = 'unit'
  AND CASE WHEN a.n_exact_units > 0 THEN a.n_exact_units = 1 AND a.exact_unit = m.unit_concept_id
           ELSE a.n_any_units = 1 AND a.any_unit = m.unit_concept_id END
UNION ALL
SELECT m.kind, concat_ws(' | ', m.unit_code, m.test_pattern, CAST(m.data_partner_id AS STRING)),
       m.ucum_code, m.candidates, m.rationale, m.n
FROM hive_metastore.ehr_union_clean_metrics.unit_mapping m
WHERE m.kind = 'correction' AND m.source = 'judgment'
  AND m.candidates = concat('maps_to:', m.ucum_code)
ORDER BY kind, key;

-- COMMAND ----------

-- 1p (Part A). Review: text decided by ignoring case, or sent to review
--     because its case variants disagree.
--     Expect: 11 rows, none where case changes the meaning.
SELECT unit_source_value, decision, ucum_code, source, rationale, candidates, n, tests,
       median, test_median
FROM hive_metastore.ehr_union_clean_metrics.unit_mapping
WHERE kind = 'text' AND matched_by = 'ignoring_case'
ORDER BY decision, n DESC;

-- COMMAND ----------

-- 4b (Part A, cell A2). Check: explicit concept rules whose UCUM code
--     didn't resolve to a concept.
--     Expect: no rows.
SELECT r.*
FROM hive_metastore.ehr_union_clean_metrics.unit_concept_rules r
LEFT JOIN hive_metastore.ehr_union_clean_metrics.ucum_units ru ON ru.concept_code = r.unit_code
WHERE r.rule = 'explicit' AND ru.concept_id IS NULL;

-- COMMAND ----------

-- 5a (Part A, cell A3). Review: Part A concept-level decisions by method.
--     Expect: n_records total 205,116; explicit 22,853 (pH, INR, ratios,
--     indexes); no_ucum_unit 9,037 (specific gravity only); suspect_concept 82.
--     no_concept rows are the concept-0 groups that 8b decides.
SELECT unit_inference_method, COUNT(*) AS n_groups, SUM(n) AS n_records
FROM hive_metastore.ehr_union_clean_metrics.unit_inference_range_decisions
GROUP BY 1
ORDER BY n_records DESC;

-- COMMAND ----------

-- 7b (Part A, cell A6). Check: source-name rule codes that don't resolve
--     to a UCUM concept.
--     Expect: no rows.
SELECT r.*
FROM hive_metastore.ehr_union_clean_metrics.unit_source_name_rules r
LEFT JOIN hive_metastore.ehr_union_clean_metrics.ucum_units ru ON ru.concept_code = r.unit_code
WHERE r.unit_code IS NOT NULL AND ru.concept_id IS NULL;

-- COMMAND ----------

-- 8b (Part A, cell A7). Review: no-concept decisions, every group.
--     Expect: almost all source_name (ratios, pH, INR, indexes and NASH
--     scores with their UCUM unit); no_ucum_unit only for specific gravity.
--     no_concept only for PPD and "Viscosity, Serum"; any other no_concept
--     row is a source name missing from cell 7's list. Part A's
--     needs_review and no_concept together stay under 11 records (5a plus this).
SELECT * FROM hive_metastore.ehr_union_clean_metrics.unit_inference_source_name_decisions
ORDER BY unit_inference_method, n DESC;

-- COMMAND ----------

-- 11b (Part B, cell B1). Review: unit_mapping's text rows by decision and
--      source.
--      Expect: 55,255 records in all. Unit 54,544 (judgment 35,762,
--      ucum_code 14,483, arrived_unit 4,258, maps_to 41); unmapped 436;
--      not_a_unit 274; no_ucum_unit under 11; no review rows.
SELECT decision, source, matched_by, COUNT(*) AS n_texts, SUM(n) AS n_records
FROM hive_metastore.ehr_union_clean_metrics.unit_mapping
WHERE kind = 'text'
GROUP BY 1, 2, 3
ORDER BY n_records DESC;

-- COMMAND ----------

-- 14a (Part C, cell C1). Check: explicit name rules without a valid UCUM
--      code, and non-explicit rules with one.
--      Expect: no rows.
SELECT r.*
FROM hive_metastore.ehr_union_clean_metrics.unit_no_range_rules r
LEFT JOIN hive_metastore.ehr_union_clean_metrics.ucum_units ru ON ru.concept_code = r.unit_code
WHERE (r.rule = 'explicit') <> (ru.concept_id IS NOT NULL);

-- COMMAND ----------

-- 14d (Part C). Check: value bands with bad codes, gaps, overlaps, open ends.
--      Expect: no rows.
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

-- 15a (Part C). Review: Part C decisions by method, per (partner, test),
--      before 16 splits value_split groups into bands.
--      Expect: total 1,063,064; explicit 968,631 (scores, pain scales,
--      pH, ratios included); no_ucum_unit 14,784 (counts, Ct values, RAST
--      class; 108 of them "Specific Gravity, URN, Externa" from the
--      source-name list); needs_review 644; value_split 565; source_name 13
--      groups, 479 records (F5 lists them). E1 has the per-record counts
--      after the split.
SELECT unit_inference_method, COUNT(*) AS n_groups, SUM(n) AS n_records
FROM hive_metastore.ehr_union_clean_metrics.unit_no_range_decisions
GROUP BY 1
ORDER BY n_records DESC;

-- COMMAND ----------

-- 15c (Part C). Review: needs_review, one row per test across partners.
--      Expect: log viral loads, Treadmill MPH (28), Creatinine/Protein [Mass
--      Ratio] in Urine (94), Physical findings of Skin (69),
--      Aldosterone/Renin ratio (32), plus one-offs. Band-level needs_review
--      (15d) isn't here.
SELECT test_name, test_id, SUM(n) AS n, COUNT(*) AS n_partners,
       min(p05) AS min_p05, percentile_approx(med, 0.5) AS med_of_medians, max(p95) AS max_p95,
       round(sum(frac_integer * n) / SUM(n), 2) AS frac_integer,
       max(evidence_units) AS evidence_units
FROM hive_metastore.ehr_union_clean_metrics.unit_no_range_decisions
WHERE unit_inference_method = 'needs_review'
GROUP BY test_name, test_id
ORDER BY n DESC;

-- COMMAND ----------

-- 15d (Part C). Review: value_split records by band, as 16 assigns them.
--      Expect: six rows, no NULL band: body temperature Cel and [degF],
--      protein/creatinine mg/mg and mg/g, RV/TLC % and under 8
--      suspect_concept 225. No HDL/total row (it's corrected in Part A).
SELECT r.data_partner_id, d.test_name, v.value_min, v.value_max, v.unit_code, v.method,
       COUNT(*) AS n, min(r.value_as_number) AS min_value,
       percentile_approx(r.value_as_number, 0.5) AS median, max(r.value_as_number) AS max_value
FROM hive_metastore.ehr_union_clean_metrics.unit_no_range_records r
JOIN hive_metastore.ehr_union_clean_metrics.unit_no_range_decisions d
  ON  d.data_partner_id = r.data_partner_id
  AND d.test_id = r.test_id
  AND d.unit_inference_method = 'value_split'
LEFT JOIN hive_metastore.ehr_union_clean_metrics.unit_no_range_value_rules v
  ON  d.test_name RLIKE v.test_pattern
  AND (v.value_min IS NULL OR r.value_as_number >= v.value_min)
  AND (v.value_max IS NULL OR r.value_as_number <  v.value_max)
GROUP BY 1, 2, 3, 4, 5, 6
ORDER BY 1, 2, 3 NULLS FIRST;

-- COMMAND ----------

-- 17e (Part D). Check: bad or duplicate unit codes, duplicate bridges.
--      Expect: no rows.
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

-- 17f (Part D). Review: every correction row with the records it decided.
--      Expect: ratio near 1 on rows with n. maps_to rows for 9117
--      mL/min/1.73.m2 (about 6,264), 9540 l (835), 8644 s/{CO} (99),
--      8653 [degC] (86), 8608 [{index'value}] (34), 8500 {sau};
--      judgment rows for {sgu} and {smu}; S and H on clotting
--      times and durations. Withheld rows: under 11 records.
SELECT unit_code, test_pattern, data_partner_id, decision, ucum_code, source, n, tests,
       median, test_median, round(median / NULLIF(test_median, 0), 2) AS ratio,
       rationale, candidates
FROM hive_metastore.ehr_union_clean_metrics.unit_mapping
WHERE kind = 'correction'
ORDER BY n DESC NULLS LAST, unit_code;

-- COMMAND ----------

-- 0a (Part 0). Review: the REDCap list files this run loaded from
--      DataElementMaps, with their sha256 (the same hash means the same
--      file as an earlier run).
--      Expect: three rows, fetched during the Part 0 run.
SELECT * FROM hive_metastore.ehr_union_clean_metrics.redcap_sources;

-- COMMAND ----------

-- 0c (Part 0). Check: list rows that can't be used as they stand.
--      Expect: no rows.
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

-- 18d (Part D). Review: tests each canonical-unit rule hits.
--      Expect: n_rules_for_test 1 on every row, each test under the rule
--      meant for it (Body weight kg, Body height cm, Body temperature Cel,
--      HbA1c %, 24 h urine protein mg/(24.h), urine albumin mg/dL).
SELECT r.test_pattern, r.unit_code, t.test_name, SUM(t.n) AS n,
       COUNT(*) OVER (PARTITION BY t.test_id) AS n_rules_for_test
FROM hive_metastore.ehr_union_clean_metrics.canonical_unit_rules r
LEFT JOIN hive_metastore.ehr_union_clean_metrics.unit_test_units t
  ON t.test_name RLIKE r.test_pattern
GROUP BY r.test_pattern, r.unit_code, t.test_id, t.test_name
ORDER BY r.test_pattern, n DESC;

-- COMMAND ----------

-- 19a (Part D). Review: conversion decisions by method.
--      Expect: identity 5,984,535; same_base 943,360; analyte_bridge
--      65,385; no_conversion 4,643, equal to 20a's "has unit, no conversion".
SELECT conversion_method, COUNT(*) AS n_groups, SUM(n) AS n_records
FROM hive_metastore.ehr_union_clean_metrics.unit_conversion_decisions
GROUP BY 1 ORDER BY n_records DESC;

-- COMMAND ----------

-- 19d (Part D). Review: (partner, test, unit) with no conversion to the
--      canonical unit.
--      Expect: log viral loads, Lp(a), arbitrary antibody units, and tests
--      holding two different quantities. Nothing a factor would fix.
--      INR (canonical {ratio}) has 1,440 PT values in seconds, one s row
--      once S is corrected, half of them duplicates; dRVVT ratios sit under
--      tests whose canonical unit is s.
SELECT test_name, data_partner_id, unit_code, n, median_raw, canonical_unit_code, canonical_median, analyte
FROM hive_metastore.ehr_union_clean_metrics.unit_conversion_medians
WHERE conversion_method = 'no_conversion'
ORDER BY n DESC;

-- COMMAND ----------

-- 19e (Part D). Review: converted medians against canonical-unit medians.
--      Expect: ratios near 1 apart from small groups. Body weight, one
--      partner, [oz_av] (corrected from [lb_us], 17f), median_converted about
--      80.7 (kg).
SELECT test_name, data_partner_id, unit_code, canonical_unit_code, conversion_method, n,
       median_raw, median_converted, canonical_median, ratio
FROM hive_metastore.ehr_union_clean_metrics.unit_conversion_medians
WHERE conversion_method <> 'no_conversion' AND canonical_median IS NOT NULL
ORDER BY greatest(abs(ratio), abs(try_divide(1, ratio))) DESC NULLS FIRST;

-- COMMAND ----------

-- 19h (Part D). Check: list tests in our data whose limits can't be
--      converted to the canonical unit.
--      Expect: no rows.
SELECT test_name, list_unit_code, canonical_unit_code, analyte
FROM hive_metastore.ehr_union_clean_metrics.unit_plausibility_limits
WHERE conversion_method = 'no_conversion';

-- COMMAND ----------

-- 19i (Part D). Review: groups (partner, test, unit) on a list test whose
--      median converted value is outside the plausible limits, i.e. whose
--      unit looks wrong.
--      Expect: no rows. Records a correction leaves with
--      no unit, such as one partner's urine creatinine in ug/L, have no
--      converted value. Ounces labeled [lb_us] shouldn't
--      appear: they're corrected to [oz_av] (17d).
WITH rec AS (
  SELECT d.data_partner_id, d.test_id, d.test_name, d.unit_code,
         d.conversion_method, k.value_as_number,
         d.conversion_slope * k.value_as_number + d.conversion_intercept AS harmonized
  FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_keyed k
  JOIN hive_metastore.ehr_union_clean_metrics.unit_conversion_decisions d
    ON  d.data_partner_id = k.data_partner_id
    AND d.test_id = k.test_id
    AND d.unit_concept_id = k.effective_unit_concept_id
  WHERE d.test_id IN (SELECT test_id FROM hive_metastore.ehr_union_clean_metrics.unit_plausibility_limits)
)
SELECT r.test_name, r.data_partner_id, r.unit_code, r.conversion_method,
       COUNT(*) AS n,
       percentile_approx(r.value_as_number, 0.5) AS median_raw,
       percentile_approx(r.harmonized, 0.5) AS median_converted,
       l.canonical_unit_code, l.imp_lo, l.imp_hi
FROM rec r
JOIN hive_metastore.ehr_union_clean_metrics.unit_plausibility_limits l ON l.test_id = r.test_id
GROUP BY r.test_name, r.data_partner_id, r.unit_code, r.conversion_method,
         l.canonical_unit_code, l.imp_lo, l.imp_hi
HAVING median_converted < l.imp_lo OR median_converted > l.imp_hi
ORDER BY n DESC;

-- COMMAND ----------

-- 20a (Part D). Review: numeric records by harmonization status.
--      Expect: in canonical unit 6,993,280; no UCUM unit exists 24,413
--      (specific gravity, counts, Ct values, activity coefficients, RAST
--      class); failed to find unit 5,470 (E1's methods that leave no unit,
--      5,456, plus 14 records a correction leaves with no unit); has unit,
--      no conversion 4,643 (19d, including INR's seconds records).
SELECT CASE WHEN canonical_unit_concept_id IS NOT NULL  THEN 'in canonical unit'
            WHEN harmonized_value_as_number IS NOT NULL THEN 'no UCUM unit exists'
            WHEN COALESCE(inferred_unit_concept_id, 0) <> 0 THEN 'has unit, no conversion'
            ELSE 'failed to find unit'
       END AS status,
       COUNT(*) AS n
FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized
WHERE value_as_number IS NOT NULL
GROUP BY 1 ORDER BY n DESC;

-- COMMAND ----------

-- 20d (Part D). Review: the REDCap list against our data, one row per list
--      concept; value_plausibility counts, limits in the canonical unit.
--      Expect: 57 rows, 44 of them with records; not_checked 0 on the
--      rows without. Canonical units differ from the list's only as
--      equivalent codes (mmol/L for mEq/L, [U]/L for IU/L). Implausible counts mostly in vitals: heart
--      rate 1,733, systolic BP 1,477 (most from one partner), body weight
--      478, diastolic BP 208, BMI 132; under 100 for every lab.
SELECT l.concept_id, l.concept_name, COALESCE(l.lookup_fields, l.mapped_fields) AS fields,
       l.list_unit_code, array_join(collect_set(t.canonical_unit_value), ', ') AS canonical_unit,
       COUNT(t.value_as_number) AS n_numeric,
       COUNT_IF(COALESCE(t.unit_concept_id, 0) <> 0) AS n_arrived_with_unit,
       COUNT_IF(COALESCE(t.unit_concept_id, 0) = 0
                AND COALESCE(t.inferred_unit_concept_id, 0) <> 0) AS n_unit_inferred,
       COUNT_IF(t.value_plausibility = 'implausible') AS n_implausible,
       COUNT_IF(t.value_plausibility = 'extreme') AS n_extreme,
       COUNT_IF(t.value_as_number IS NOT NULL AND t.harmonized_value_as_number IS NULL) AS n_not_checked,
       percentile_approx(t.harmonized_value_as_number, 0.5) AS median_harmonized,
       concat(round(p.imp_lo, 3), ' to ', round(p.imp_hi, 3)) AS plausible,
       concat(round(p.ext_lo, 3), ' to ', round(p.ext_hi, 3)) AS usual
FROM hive_metastore.ehr_union_clean_metrics.redcap_list_tests l
LEFT JOIN hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized t
  ON t.harmonized_measurement_concept_id = l.concept_id AND t.value_as_number IS NOT NULL
LEFT JOIN hive_metastore.ehr_union_clean_metrics.unit_plausibility_limits p
  ON p.test_id = CAST(l.concept_id AS STRING)
GROUP BY l.concept_id, l.concept_name, l.lookup_fields, l.mapped_fields, l.list_unit_code,
         p.imp_lo, p.imp_hi, p.ext_lo, p.ext_hi
ORDER BY n_numeric DESC, l.concept_name;

-- COMMAND ----------

-- E1 (new, not in A-D). Review: numeric records by part and method, read
--    from the target table after every apply. Parts are told apart by raw
--    columns, as each part picks its records.
--    Expect:
--      has unit concept: copied_from_unit_concept_id only, 5,704,371
--      A: total 205,116; unit methods 195,400; no_ucum_unit 9,628 (specific
--         gravity); suspect_concept 82; needs_review plus no_concept under 11
--      B: total 55,255; mapped_string 54,544; unmapped_string 436;
--         not_a_unit 274; no_ucum_unit under 11 (ACTIVITY COEFF)
--      C: total 1,063,064; explicit 968,631 (the 6,457 HDL/total records
--         among them, {ratio} under 3011163); no_ucum_unit 14,784; partner_unit
--         plus dataset_unit 74,172; source_name 479; not_a_quantity 3,789;
--         suspect_concept 225; needs_review 644; value_split 340
SELECT CASE WHEN COALESCE(unit_concept_id, 0) <> 0 THEN 'has unit concept'
            WHEN unit_source_value IS NOT NULL      THEN 'B'
            WHEN range_high IS NOT NULL             THEN 'A'
            ELSE 'C'
       END AS part,
       unit_inference_method,
       COUNT(*) AS n
FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized
WHERE value_as_number IS NOT NULL
GROUP BY 1, 2
ORDER BY 1, n DESC;

-- COMMAND ----------

-- E2 (new, not in A-D). Check: records with a canonical unit or a
--    value_plausibility but no harmonized value. Part D sets them together,
--    and every apply clears them, so this catches stale values from an
--    earlier run.
--    Expect: no rows.
SELECT unit_inference_method,
       canonical_unit_concept_id IS NOT NULL AS has_canonical_unit,
       value_plausibility IS NOT NULL AS has_plausibility,
       COUNT(*) AS n
FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized
WHERE (canonical_unit_concept_id IS NOT NULL OR value_plausibility IS NOT NULL)
  AND harmonized_value_as_number IS NULL
GROUP BY 1, 2, 3;

-- COMMAND ----------

-- E3 (new, not in A-D). Check: numeric records with a unit whose added
--    columns aren't all filled. Every record with a unit should have a
--    method, an inferred unit, and a conversion method; a record in its
--    canonical unit should also have canonical_unit_value. A record's
--    unit is inferred_unit_concept_id (0 = none), so records a correction
--    leaves with no unit aren't counted.
--    Expect: no rows.
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

-- E4 (new, not in A-D). Review: records moved to another concept by
--    measurement_concept_corrections (Part A, 1d), next to the records
--    that arrived under the target concept, after D.
--    Expect: rows with measurement_concept_id 3023884 are one partner's,
--    about 6,464 records (F4a), all with canonical unit {ratio} (anything
--    that arrived as mg/dL is corrected to {ratio}, 17d), harmonized median
--    about 3.5;
--    rows with 3011163 are another partner's own, median about 3.2.
SELECT t.measurement_concept_id, t.harmonized_measurement_concept_id, t.data_partner_id,
       t.unit_inference_method, t.inferred_unit_source_value, t.canonical_unit_value,
       t.unit_conversion_method, COUNT(*) AS n,
       percentile_approx(t.harmonized_value_as_number, array(0.05, 0.5, 0.95)) AS harmonized_pct
FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized t
WHERE t.value_as_number IS NOT NULL
  AND t.harmonized_measurement_concept_id IN (
        SELECT harmonized_measurement_concept_id
        FROM hive_metastore.ehr_union_clean_metrics.measurement_concept_corrections)
GROUP BY ALL
ORDER BY 1, 2, 3, n DESC;

-- COMMAND ----------

-- 20b (Part D). Review: stored body weights by test, partner and unit.
--      Expect: kg_pct medians all near 80-90. One partner's [oz_av]
--      (corrected from [lb_us]): raw median about 2,848, kg median about
--      80.7.
SELECT test_name, data_partner_id, effective_unit_code AS unit, unit_source_value,
       unit_inference_method, COUNT(*) AS n,
       percentile_approx(value_as_number, array(0.05, 0.5, 0.95)) AS raw_pct,
       percentile_approx(harmonized_value_as_number, array(0.05, 0.5, 0.95)) AS kg_pct
FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_keyed
WHERE test_name RLIKE '(?i)^body weight'
GROUP BY 1, 2, 3, 4, 5
ORDER BY 1, 2, n DESC;

-- COMMAND ----------

-- 20c (Part D). Review: people with "Body weight" records in both kg and
--      [lb_us]; ratio = median converted lb record / median kg record.
--      Expect: ratio_pct median near 1 for the one partner listed. The
--      other partner's lb records are corrected to [oz_av], so it has no [lb_us] rows.
WITH w AS (
  SELECT person_id, data_partner_id, effective_unit_code AS unit,
         percentile_approx(harmonized_value_as_number, 0.5) AS kg
  FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_keyed
  WHERE harmonized_concept_name = 'Body weight'
    AND effective_unit_code IN ('kg', '[lb_us]')
  GROUP BY 1, 2, 3
)
SELECT lb.data_partner_id AS lb_partner, kg.data_partner_id AS kg_partner,
       COUNT(*) AS n_people,
       percentile_approx(lb.kg / kg.kg, array(0.05, 0.25, 0.5, 0.75, 0.95)) AS ratio_pct
FROM w lb
JOIN w kg ON kg.person_id = lb.person_id AND kg.unit = 'kg'
WHERE lb.unit = '[lb_us]'
GROUP BY 1, 2;

-- COMMAND ----------

-- E5 (new, not in A-D). Check: corrections written by D (17d) against
--    what unit_mapping says now. A record's unit (inferred, 0 = none)
--    should equal the view's corrected unit, and unit_corrected_from the
--    code the view corrects from. A row here is a correction not written
--    (rerun D), one written that no row makes any more (rerun the part that
--    set the record's unit, then D), or one written twice.
--    Expect: no rows.
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

-- E6 (new, not in A-D; the unmapped rows of B's 11c). Review: unit text no
--    source or judgment row maps. Records get inferred unit 0 and no
--    conversion, so anything a judgment row could map belongs in 1g.
--    Expect: 37 texts on 436 records.
SELECT unit_source_value, n, tests, median
FROM hive_metastore.ehr_union_clean_metrics.unit_mapping
WHERE kind = 'text' AND decision = 'unmapped'
ORDER BY n DESC;
