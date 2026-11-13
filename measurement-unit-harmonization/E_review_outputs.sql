-- Databricks notebook source
-- Unit inference, Part E: review the outputs of a full run, for someone
-- reading the results. It isn't part of the batch run.
--
-- Read-only: every cell is a SELECT. Run after E_gate_checks.sql, top to
-- bottom. Cells are numbered after the step of 0 or A-D they review, and each
-- says what to expect where that's been settled.
--
-- Counts: the expected counts are from the 2026-11-03 run (7,027,806
-- numeric records). A change in the source table moves them slightly.

-- COMMAND ----------

-- 1n (Part A). Review: every review row, with its candidates. These records get no
--     unit until settled. A judgment row (1g) settles text with no exact
--     match whose case variants disagree, and exact sources that disagree
--     when it picks one of their units, unless the text is itself a UCUM
--     code. Otherwise the data has to agree first: a correction row for the
--     arrived units that are wrong. A review correction row is
--     an arrived unit OMOP maps to no standard UCUM unit, or to several;
--     a judgment correction row settles it.
--     Expect: 8492 {log} only (no Maps to target, left in
--     review like the other log viral loads).
SELECT kind, COALESCE(unit_source_value, unit_code) AS unit_text_or_code,
       rationale, candidates, n, tests, median, test_median
FROM hive_metastore.ehr_union_clean_metrics.unit_mapping
WHERE decision = 'review'
ORDER BY n DESC NULLS LAST, unit_text_or_code;

-- COMMAND ----------

-- 1o (Part A). Review: judgment rows an automatic source already covers with the
--     same unit; they can be deleted from 1g. A text judgment row covers
--     every case variant of its spelling, so delete it only if all its
--     spellings are listed. Correction rows: the judgment matches OMOP's
--     Maps to for the code.
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

-- 1p (Part A). Review: text decided by ignoring case (no exact match), or sent to
--     review because its case variants disagree. Look for case that
--     changes the meaning (s/S, h/H, mU/MU).
--     Expect: 11 rows, none where case changes the meaning.
SELECT unit_source_value, decision, ucum_code, source, rationale, candidates, n, tests,
       median, test_median
FROM hive_metastore.ehr_union_clean_metrics.unit_mapping
WHERE kind = 'text' AND matched_by = 'ignoring_case'
ORDER BY decision, n DESC;

-- COMMAND ----------

-- 5a (Part A). Review: how many groups and records each method covers
--     Expect: n_records total 205,116; explicit 22,853 (pH, INR, ratios,
--     indexes); no_ucum_unit 9,037 (specific gravity only); suspect_concept about 80.
--     no_concept rows are the concept-0 groups that 8b decides.
SELECT unit_inference_method, COUNT(*) AS n_groups, SUM(n) AS n_records
FROM hive_metastore.ehr_union_clean_metrics.unit_inference_range_decisions
GROUP BY 1
ORDER BY n_records DESC;

-- COMMAND ----------

-- 5b (Part A). Review: every group, with the chosen unit spelled out
SELECT d.unit_inference_method, d.data_partner_id, d.harmonized_measurement_concept_id, d.concept_name,
       d.range_low, d.range_high, d.n, d.med,
       uc.concept_code AS inferred_unit, d.evidence_n, d.evidence_median, d.note
FROM hive_metastore.ehr_union_clean_metrics.unit_inference_range_decisions d
LEFT JOIN omop_vocab.concept uc ON uc.concept_id = d.inferred_unit_concept_id
ORDER BY d.n DESC;

-- COMMAND ----------

-- 8b (Part A). Review: no-concept decisions, every group.
--     Expect: almost all source_name (ratios, pH, INR, indexes and NASH
--     scores with their UCUM unit); no_ucum_unit only for specific gravity.
--     no_concept only for PPD and "Viscosity, Serum"; any other no_concept
--     row is a source name missing from cell 7's list. Part A's
--     needs_review and no_concept together stay under 11 records (5a plus this).
SELECT * FROM hive_metastore.ehr_union_clean_metrics.unit_inference_source_name_decisions
ORDER BY unit_inference_method, n DESC;

-- COMMAND ----------

-- 11b (Part B). Review: unit_mapping's text rows by decision and
--      source.
--      Expect: 55,255 records in all. Unit 54,544 (judgment 35,762,
--      ucum_code 14,483, arrived_unit 4,258, maps_to 41); unmapped plus
--      no_ucum_unit 437 (no_ucum_unit under 11); not_a_unit 274; no
--      review rows.
SELECT decision, source, matched_by, COUNT(*) AS n_texts, SUM(n) AS n_records
FROM hive_metastore.ehr_union_clean_metrics.unit_mapping
WHERE kind = 'text'
GROUP BY 1, 2, 3
ORDER BY n_records DESC;

-- COMMAND ----------

-- 11c (Part B). Review: every text, with the unit it got, where from, and the tests
--      it's on
SELECT decision, source, unit_source_value, ucum_code, n, tests, median, test_median,
       rationale, candidates
FROM hive_metastore.ehr_union_clean_metrics.unit_mapping
WHERE kind = 'text'
ORDER BY decision, source, n DESC;

-- COMMAND ----------

-- 13b (Part C). Review: overall shape
SELECT CASE WHEN COALESCE(r.harmonized_measurement_concept_id, 0) = 0 THEN 'concept 0'
            ELSE 'has concept' END AS concept,
       mt.concept_name AS measurement_type,
       r.range_low IS NOT NULL AS has_range_low,
       COUNT(*) AS n,
       COUNT(DISTINCT r.test_id) AS n_tests,
       COUNT(DISTINCT r.data_partner_id) AS n_partners
FROM hive_metastore.ehr_union_clean_metrics.unit_no_range_records r
LEFT JOIN omop_vocab.concept mt ON mt.concept_id = r.measurement_type_concept_id
GROUP BY 1, 2, 3
ORDER BY n DESC;

-- COMMAND ----------

-- 13c (Part C). Review: one row per test, biggest first. cum_pct shows how many tests
--      cover most of the records. frac_integer near 1 with a small range
--      or few distinct values suggest a score; n_evidence is how many
--      records of the same test have a unit to copy.
--      (The table has no value_source_value column.)
WITH t AS (
  SELECT r.test_id, r.test_name,
         COUNT(*) AS n,
         COUNT(DISTINCT r.data_partner_id) AS n_partners,
         percentile_approx(r.value_as_number, array(0.05, 0.5, 0.95)) AS pct,
         min(r.value_as_number) AS min_value,
         max(r.value_as_number) AS max_value,
         avg(CASE WHEN r.value_as_number = floor(r.value_as_number) THEN 1D ELSE 0D END) AS frac_integer,
         COUNT(DISTINCT r.value_as_number) AS n_distinct
  FROM hive_metastore.ehr_union_clean_metrics.unit_no_range_records r
  GROUP BY r.test_id, r.test_name
),
ev AS (
  SELECT test_id, COUNT(*) AS n_evidence
  FROM hive_metastore.ehr_union_clean_metrics.unit_no_range_evidence
  WHERE test_id IN (SELECT test_id FROM t)
  GROUP BY 1
)
SELECT t.test_name, t.test_id, t.n,
       round(100 * SUM(t.n) OVER (ORDER BY t.n DESC ROWS UNBOUNDED PRECEDING)
                 / SUM(t.n) OVER (), 1) AS cum_pct,
       t.n_partners, t.min_value, t.pct[0] AS p05, t.pct[1] AS median, t.pct[2] AS p95,
       t.max_value, round(t.frac_integer, 2) AS frac_integer, t.n_distinct,
       COALESCE(ev.n_evidence, 0) AS n_evidence
FROM t
LEFT JOIN ev ON ev.test_id = t.test_id
ORDER BY t.n DESC;

-- COMMAND ----------

-- 13d (Part C). Lookup: OMOP UCUM spellings for units the name rules need.
--      'data' rows: the unit concepts that unit strings like dynes-sec/cm5
--      and mph already carry in the table. 'UCUM' rows: candidate concepts.
--      Rules 45 and 46 in cell 14 (SVR) use the codes found here (OMOP
--      spells the two inconsistently: dyn.sec/cm5, dyn.s/cm5/m2). There is
--      no mile-per-hour concept, so Treadmill MPH has no rule.
SELECT 'data' AS src, m.unit_source_value AS unit_string, u.concept_id, u.concept_code,
       u.concept_name, u.vocabulary_id, u.invalid_reason, COUNT(*) AS n
FROM ehr_union_clean.measurement m
JOIN omop_vocab.concept u ON u.concept_id = m.unit_concept_id
WHERE m.unit_source_value RLIKE '(?i)dyn|mph|mi/h|mile'
GROUP BY 1, 2, 3, 4, 5, 6, 7
UNION ALL
SELECT 'UCUM', NULL, concept_id, concept_code, concept_name, vocabulary_id, invalid_reason, NULL
FROM omop_vocab.concept
WHERE vocabulary_id = 'UCUM'
  AND (concept_code RLIKE 'dyn|mi_' OR concept_name RLIKE '(?i)dyne|mile')
ORDER BY src, n DESC, concept_code;

-- COMMAND ----------

-- 14b (Part C). Review: tests each name rule hits, with the rule that wins.
--      Look for tests a pattern catches by accident.
WITH t AS (
  SELECT r.test_id, r.test_name,
         COUNT(*) AS n, percentile_approx(r.value_as_number, 0.5) AS median
  FROM hive_metastore.ehr_union_clean_metrics.unit_no_range_records r
  GROUP BY r.test_id, r.test_name
)
SELECT ru.priority, ru.test_pattern, ru.rule, ru.unit_code, t.test_name, t.n, t.median,
       ru.priority = min(ru.priority) OVER (PARTITION BY t.test_id) AS wins
FROM hive_metastore.ehr_union_clean_metrics.unit_no_range_rules ru
LEFT JOIN t ON t.test_name RLIKE ru.test_pattern
ORDER BY ru.priority, t.n DESC;

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

-- 15b (Part C). Review: every group with a unit or rule, biggest first. Compare med
--      with evidence_median, and scan evidence_units for a test that carries
--      two units close enough to both pass the factor-2 check (kg vs lb).
SELECT d.unit_inference_method, d.test_name, d.data_partner_id, d.n,
       d.p05, d.med, d.p95, u.concept_code AS inferred_unit,
       d.evidence_n, d.evidence_median, d.evidence_units, d.note
FROM hive_metastore.ehr_union_clean_metrics.unit_no_range_decisions d
LEFT JOIN omop_vocab.concept u ON u.concept_id = d.inferred_unit_concept_id
WHERE d.unit_inference_method <> 'needs_review'
ORDER BY d.n DESC;

-- COMMAND ----------

-- 15c (Part C). Review: needs_review, one row per test across partners. These are
--      what the name rules (14) are for. evidence_units shows units the test
--      has elsewhere whose medians didn't fit.
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

-- 15d (Part C). Review: value_split records by band, as 16 assigns them. Each band's medians should look like its unit; band NULL means
--      the test matched no band pattern (14c) and goes to needs_review.
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

-- 15e (Part C). Review: Residual volume/Total capacity against the
--      lung-volume tests that have units. A median near TLC in L would
--      mean the field holds TLC, not the ratio.
--      part_d marks Part C's records, which show the unit C gave them;
--      suspect_concept records show no unit.
SELECT test_id, test_name, effective_unit_code AS unit,
       range_high IS NULL AND unit_source_value IS NULL AS part_d,
       COUNT(*) AS n,
       percentile_approx(value_as_number, array(0.05, 0.25, 0.5, 0.75, 0.95)) AS pct
FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_named
WHERE value_as_number IS NOT NULL
  AND test_name RLIKE '(?i)residual volume|total (lung )?capacity|^TLC|RV/TLC'
GROUP BY test_id, test_name, effective_unit_code, 4
ORDER BY test_name, n DESC;

-- COMMAND ----------

-- 15f (Part C). Review: RV/TLC holds two values per exam (438 = 2 x 219), one near
--      3-6 and one near 30-40. If the low one is TLC in L, then
--      100 * RV / low should equal high. match_2pt counts exams where they
--      agree within 2 points.
--      Expect: 214 exams, all matching.
WITH r AS (
  SELECT person_id, measurement_date, harmonized_measurement_concept_id AS c, value_as_number AS v
  FROM hive_metastore.ehr_union_clean_metrics.unit_no_range_records
  WHERE harmonized_measurement_concept_id IN (21493446, 21493126)  -- RV/TLC, RV
),
e AS (
  SELECT person_id, measurement_date,
         max(CASE WHEN c = 21493126 THEN v END) AS rv,
         min(CASE WHEN c = 21493446 THEN v END) AS low,
         max(CASE WHEN c = 21493446 THEN v END) AS high,
         count_if(c = 21493446) AS n_ratio
  FROM r GROUP BY 1, 2
)
SELECT COUNT(*) AS n_exams,
       count_if(abs(100 * rv / low - high) <= 2) AS match_2pt
FROM e;

-- COMMAND ----------

-- 17f (Part D). Review: every correction row (Part A, 1i), with the records it
--      decided (17d). ratio = median / test_median: near 1 when the
--      records look like the test's records already in the target unit.
--      maps_to rows are OMOP's Maps to for an arrived unit that isn't
--      standard UCUM; a wrong one gets a judgment row in 1g. Rows with no
--      n matched no numeric records.
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

-- 0d (Part 0). Review: the list as the EHR notebooks use it, one row per concept.
--     list_unit_code: the list's unit as a UCUM code (only used to convert
--     the limits; our canonical units stay UCUM, e.g. mmol/L not mEq/L).
--     imp: outside = implausible; ext: outside = clinically extreme. Rows
--     with no limits are tests 09 gives none for; Part D only flags tests
--     with limits.
SELECT concept_id, concept_name, COALESCE(lookup_fields, mapped_fields) AS fields,
       list_unit_code, limit_fields, imp_lo, imp_hi, ext_lo, ext_hi
FROM hive_metastore.ehr_union_clean_metrics.redcap_list_tests
ORDER BY imp_lo IS NULL, concept_name;

-- COMMAND ----------

-- 18c (Part D). Review: analyte assignments, with each test's units.
--      Look for tests that got the wrong analyte.
SELECT a.analyte, t.test_name, SUM(t.n) AS n,
       array_join(collect_list(concat(t.unit_code, ' (', CAST(t.n AS STRING), ')')), ', ') AS units
FROM hive_metastore.ehr_union_clean_metrics.unit_test_analytes a
JOIN (SELECT test_id, test_name, unit_code, SUM(n) AS n
      FROM hive_metastore.ehr_union_clean_metrics.unit_test_units
      GROUP BY 1, 2, 3) t ON t.test_id = a.test_id
GROUP BY a.analyte, t.test_id, t.test_name
ORDER BY a.analyte, n DESC;

-- COMMAND ----------

-- 18d (Part D). Review: tests each canonical-unit rule hits. Each test should appear
--      once, under the rule you meant.
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

-- 19b (Part D). Review: canonical unit for every test that has more than one unit.
--      Look for canonical units you'd not choose; add them to 17c.
SELECT test_name, canonical_unit_code, canonical_source, SUM(n) AS n,
       array_join(collect_list(concat_ws(' ', concat(CAST(data_partner_id AS STRING), ':'),
                                         unit_code,
                                         CAST(n AS STRING), conversion_method)), '; ') AS units
FROM hive_metastore.ehr_union_clean_metrics.unit_conversion_decisions
GROUP BY test_id, test_name, canonical_unit_code, canonical_source
HAVING COUNT(DISTINCT unit_concept_id) > 1
ORDER BY n DESC;

-- COMMAND ----------

-- 19d (Part D). Review: (partner, test, unit) with no conversion to the canonical unit.
--      Compare median_raw with canonical_median to judge what the unit really is.
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

-- 19e (Part D). Review: do converted values look like canonical-unit values?
--      ratio far from 1 = wrong factor, wrong analyte, or the source unit
--      label is wrong (add a correction row, A 1g). Most extreme first.
--      Expect: ratios near 1 apart from small groups. Body weight, one
--      partner, [oz_av] (corrected from [lb_us], 17f), median_converted about
--      80.7 (kg).
SELECT test_name, data_partner_id, unit_code, canonical_unit_code, conversion_method, n,
       median_raw, median_converted, canonical_median, ratio
FROM hive_metastore.ehr_union_clean_metrics.unit_conversion_medians
WHERE conversion_method <> 'no_conversion' AND canonical_median IS NOT NULL
ORDER BY greatest(abs(ratio), abs(try_divide(1, ratio))) DESC NULLS FIRST;

-- COMMAND ----------

-- 19f (Part D). Review: tests whose canonical unit is a judgment call. A unit class is
--      a set of equivalent codes (same base and factor), so mg/dL vs mmol/L
--      counts and [iU]/L vs [U]/L doesn't. Listed: tests whose canonical
--      unit comes from a rule, and tests where a second class holds at
--      least 20% of records. Settle one by adding it to 17c.
WITH d AS (
  SELECT d.test_id, d.test_name, d.canonical_unit_code, d.canonical_source, d.n,
         d.unit_code AS code,
         COALESCE(concat_ws(':', f.base, CAST(f.slope AS STRING), CAST(f.intercept AS STRING)),
                  concat('code:', d.unit_code)) AS class_key
  FROM hive_metastore.ehr_union_clean_metrics.unit_conversion_decisions d
  LEFT JOIN hive_metastore.ehr_union_clean_metrics.unit_factors f ON f.unit_code = d.unit_code
),
cls AS (
  SELECT test_id, test_name, canonical_unit_code, canonical_source, class_key,
         max_by(code, struct(n, code)) AS code, SUM(n) AS n
  FROM d GROUP BY 1, 2, 3, 4, 5
),
ranked AS (
  SELECT *, SUM(n) OVER (PARTITION BY test_id) AS test_n,
         ROW_NUMBER() OVER (PARTITION BY test_id ORDER BY n DESC, code) AS rk
  FROM cls
)
SELECT test_name, canonical_unit_code, canonical_source, test_n,
       round(max(CASE WHEN rk = 1 THEN n END) / test_n, 2) AS top_share,
       max(CASE WHEN rk = 2 THEN code END) AS runner_up,
       round(max(CASE WHEN rk = 2 THEN n END) / test_n, 2) AS runner_up_share,
       array_join(collect_list(concat(code, ' (', CAST(n AS STRING), ')')), ', ') AS unit_classes
FROM ranked
GROUP BY test_id, test_name, canonical_unit_code, canonical_source, test_n
HAVING canonical_source = 'rule'
    OR (count(*) > 1 AND max(CASE WHEN rk = 2 THEN n END) >= 0.2 * test_n)
ORDER BY test_n DESC;

-- COMMAND ----------

-- 19i (Part D). Review: is a group's unit wrong? Groups (partner, test, unit) on a
--      list test whose median converted value is outside the plausible
--      limits. A few bad values don't move a median, so a group listed here
--      is almost certainly in another unit than its label (as one
--      partner's "[lb_us]" body weights are ounces). Fix with a correction
--      row (A 1g); nothing here changes the data. Groups with no
--      conversion are in 19d instead.
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
--      Expect: in canonical unit 6,993,280; no UCUM unit exists plus
--      failed to find unit 29,883 (no UCUM unit: specific gravity, counts,
--      Ct values, activity coefficients, RAST class; failed: E1's methods
--      that leave no unit, plus 14 records a correction leaves with no
--      unit); has unit, no conversion 4,643 (19d, including INR's seconds records).
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

-- 20d (Part D). Review: the REDCap list against our data, one row per list concept
--      (Part 0), matched by the harmonized concept only (a list test recorded
--      under another concept isn't counted). Records by how they got their
--      unit, the canonical unit next to the list's, and value_plausibility
--      counts; limits are in the canonical unit. not_checked: numeric
--      records with no harmonized value (no unit, no conversion, suspect).
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

-- E1. Review: numeric records by part and method, read
--    from the target table after every apply. Parts are told apart by raw
--    columns, as each part picks its records.
--    Expect:
--      has unit concept: copied_from_unit_concept_id only, 5,704,371
--      A: total 205,116; unit methods 195,400; no_ucum_unit 9,628 (specific
--         gravity); suspect_concept, needs_review and no_concept together 88
--      B: total 55,255; mapped_string 54,544; unmapped_string plus
--         no_ucum_unit 437 (no_ucum_unit under 11: ACTIVITY COEFF);
--         not_a_unit 274
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

-- E4. Review: records moved to another concept by
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
--      kg_pct medians should all be near 80-90 kg. One partner's records
--      that arrived as [lb_us] are ounces (raw median 2,848): corrected to
--      [oz_av] (A 1g, D 17d). Another partner's stay [lb_us].
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

-- 20c (Part D). Review: people with "Body weight" records in both kg and [lb_us].
--      ratio = person's median converted lb record / median kg record.
--      Near 1: the lb records are fine and the gap is who gets weighed in
--      lb. Near 1.3 for everyone: the lb label or factor is wrong.
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

-- E6 (the unmapped rows of 11c). Review: unit text no
--    source or judgment row maps. Records get inferred unit 0 and no
--    conversion, so anything a judgment row could map belongs in 1g.
--    Expect: 37 texts on about 440 records.
SELECT unit_source_value, n, tests, median
FROM hive_metastore.ehr_union_clean_metrics.unit_mapping
WHERE kind = 'text' AND decision = 'unmapped'
ORDER BY n DESC;
