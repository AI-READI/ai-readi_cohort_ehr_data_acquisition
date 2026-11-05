-- Databricks notebook source
-- Unit inference, Part F: experimental probes. Read-only queries for
-- questions that come up in review, run against the output of a full A-D
-- run. Nothing here writes a table, and nothing in A-E depends on it.
-- Cells are numbered F1, F2, ... and say what question they answer.


-- COMMAND ----------

-- F1. HDL/cholesterol ratio records (Part A marks concept 3023884
--     suspect_concept while Part C inverts values over 1).
--     Every concept whose name has HDL, cholesterol and a ratio, plus
--     concept-0 records with such a source name, by part, partner, arrived
--     unit, method and value band. Expected values: HDL/total 0.1-0.4,
--     total/HDL 2.5-10; the other bands are outliers either way.
--     Answers: does Part A have values <= 1; what Part A's reference ranges
--     look like; how many records fall outside both expected bands.
WITH r AS (
  SELECT COALESCE(m.measurement_concept_id, 0) AS concept_id,
         COALESCE(m.measurement_concept_name, m.measurement_source_value) AS test_name,
         CASE WHEN COALESCE(m.unit_concept_id, 0) <> 0 THEN 'has unit concept'
              WHEN m.unit_source_value IS NOT NULL     THEN 'B'
              WHEN m.range_high IS NOT NULL            THEN 'A'
              ELSE 'C' END AS part,
         m.data_partner_id, u.concept_code AS unit_code, m.unit_inference_method,
         m.value_as_number AS v, m.harmonized_value_as_number AS h,
         m.range_low, m.range_high
  FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_named m
  LEFT JOIN omop_vocab.concept u ON u.concept_id = NULLIF(m.unit_concept_id, 0)
  WHERE m.value_as_number IS NOT NULL
    AND lower(COALESCE(m.measurement_concept_name, m.measurement_source_value)) LIKE '%hdl%'
    AND lower(COALESCE(m.measurement_concept_name, m.measurement_source_value)) LIKE '%cholesterol%'
    AND (COALESCE(m.measurement_concept_name, m.measurement_source_value) LIKE '%/%'
         OR lower(COALESCE(m.measurement_concept_name, m.measurement_source_value)) LIKE '%ratio%')
)
SELECT concept_id, test_name, part, data_partner_id, unit_code, unit_inference_method,
       CASE WHEN v < 0.1  THEN '1: < 0.1'
            WHEN v <= 0.4 THEN '2: 0.1-0.4 (HDL/total)'
            WHEN v <= 1   THEN '3: 0.4-1'
            WHEN v < 2.5  THEN '4: 1-2.5'
            WHEN v <= 10  THEN '5: 2.5-10 (total/HDL)'
            ELSE               '6: > 10' END AS value_band,
       COUNT(*) AS n,
       min(v) AS min_v, percentile_approx(v, 0.5) AS median_v, max(v) AS max_v,
       percentile_approx(h, 0.5) AS median_harmonized,
       percentile_approx(range_low, 0.5) AS median_range_low,
       percentile_approx(range_high, 0.5) AS median_range_high,
       COUNT(DISTINCT concat_ws('-', range_low, range_high)) AS n_distinct_ranges
FROM r
GROUP BY ALL
ORDER BY test_name, part, data_partner_id, unit_code, value_band;


-- COMMAND ----------

-- F3a. Listed tests with no records under their concept (D 20d),
--      searched by name: are they in the data under another concept, or
--      as concept 0 with a source name?
--      Patterns are loose on purpose; expect unrelated hits (insulin
--      antibodies, IGF). All records, numeric or not.
WITH pat AS (
  SELECT * FROM VALUES
    ('insulin',              '(?i)insulin'),
    ('uACR',                 '(?i)albumin.{0,3}/.{0,3}creat|microalb|alb.{0,3}/.{0,3}creat'),
    ('creatinine/BUN ratio', '(?i)creatinine.{0,3}/.{0,3}(urea|bun)|(urea nitrogen|bun).{0,3}/.{0,3}creatinine'),
    ('globulin',             '(?i)^globulin|globulin, total|globulin .mass'),
    ('waist / hip',          '(?i)waist|hip circ|hip ratio'),
    ('autorefractor',        '(?i)autorefract|refraction|sphere|cylinder'),
    ('visual acuity',        '(?i)visual acuity|snellen|logmar|letter score'),
    ('contrast sensitivity', '(?i)contrast sens|pelli|mars'),
    ('MoCA / cognitive',     '(?i)montreal|moca|cognitive|trail making'),
    ('monofilament',         '(?i)monofilament|semmes')
  AS t(item, pattern)
),
m AS (
  SELECT COALESCE(m.measurement_concept_id, 0) AS concept_id,
         COALESCE(m.measurement_concept_name, m.measurement_source_value) AS test_name,
         m.data_partner_id, m.value_as_number, m.unit_source_value
  FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_named m
)
SELECT p.item, m.concept_id, m.test_name,
       COUNT(*) AS n, COUNT(m.value_as_number) AS n_numeric,
       array_join(sort_array(collect_set(CAST(m.data_partner_id AS STRING))), ', ') AS partners,
       array_join(slice(collect_set(m.unit_source_value), 1, 5), ', ') AS unit_source_values,
       percentile_approx(m.value_as_number, 0.5) AS median_value
FROM pat p
JOIN m ON m.test_name RLIKE p.pattern
GROUP BY p.item, m.concept_id, m.test_name
ORDER BY p.item, n DESC;


-- COMMAND ----------

-- F3b. Any custom concept (id 2,000,000,000 and up) in the measurement
--      table at all, whether or not it's on the list.
SELECT m.measurement_concept_id, c.concept_name, c.vocabulary_id,
       array_join(slice(collect_set(m.measurement_source_value), 1, 3), ' | ') AS source_values,
       array_join(sort_array(collect_set(CAST(m.data_partner_id AS STRING))), ', ') AS partners,
       COUNT(*) AS n, COUNT(m.value_as_number) AS n_numeric
FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized m
LEFT JOIN omop_vocab.concept c ON c.concept_id = m.measurement_concept_id
WHERE m.measurement_concept_id >= 2000000000
GROUP BY 1, 2, 3
ORDER BY n DESC;


-- COMMAND ----------

-- F3c. The two listed ratios with many records and no list unit
--      (A/G ratio 3020509, BUN/creatinine ratio 3018311): were they marked
--      no_ucum_unit, or left with nothing?
SELECT m.measurement_concept_name AS concept_name,
       CASE WHEN COALESCE(m.unit_concept_id, 0) <> 0 THEN 'has unit concept'
            WHEN m.unit_source_value IS NOT NULL     THEN 'B'
            WHEN m.range_high IS NOT NULL            THEN 'A'
            ELSE 'C' END AS part,
       m.data_partner_id, m.unit_source_value, m.unit_inference_method,
       m.inferred_unit_source_value, m.unit_conversion_method,
       COUNT(*) AS n,
       percentile_approx(m.value_as_number, 0.5) AS median_value,
       COUNT(m.harmonized_value_as_number) AS n_harmonized
FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_named m
WHERE m.measurement_concept_id IN (3020509, 3018311)
  AND m.value_as_number IS NOT NULL
GROUP BY ALL
ORDER BY 1, n DESC;


-- COMMAND ----------

-- F4. The total/HDL cases. Records: every cholesterol ratio involving HDL
--     (by concept name, or source name for concept 0), plus HDL mass
--     records (3007070) under 15, which look like ratios filed as HDL.
--     Each is checked against the same person's same-day total cholesterol,
--     HDL and LDL (harmonized, mg/dL; HDL 15 and up only):
--       matches   total/HDL, HDL/total or LDL/HDL when within 10% of it;
--                 none when it fits none of them; no same-day lipids when
--                 there's no total and HDL that day.
--     F4a summarizes by case; F4b shows up to 5 records per case.
CREATE OR REPLACE TEMP VIEW f4_records AS
WITH ldl_ids AS (
  SELECT concept_id FROM omop_vocab.concept
  WHERE domain_id = 'Measurement' AND concept_name LIKE 'Cholesterol in LDL [Mass/volume]%'
),
lipids AS (
  SELECT person_id, measurement_date,
         avg(CASE WHEN measurement_concept_id = 3027114 THEN harmonized_value_as_number END) AS tc,
         avg(CASE WHEN measurement_concept_id = 3007070 AND value_as_number >= 15
                  THEN harmonized_value_as_number END) AS hdl,
         avg(CASE WHEN measurement_concept_id IN (SELECT concept_id FROM ldl_ids)
                  THEN harmonized_value_as_number END) AS ldl
  FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized
  WHERE measurement_concept_id IN (3027114, 3007070)
     OR measurement_concept_id IN (SELECT concept_id FROM ldl_ids)
  GROUP BY 1, 2
),
r AS (
  SELECT m.measurement_id, m.person_id, m.measurement_date, m.data_partner_id,
         COALESCE(m.measurement_concept_id, 0) AS concept_id,
         COALESCE(m.measurement_concept_name, m.measurement_source_value) AS test_name,
         m.measurement_source_value, m.unit_source_value,
         CASE WHEN COALESCE(m.unit_concept_id, 0) <> 0 THEN 'has unit concept'
              WHEN m.unit_source_value IS NOT NULL     THEN 'B'
              WHEN m.range_high IS NOT NULL            THEN 'A'
              ELSE 'C' END AS part,
         m.unit_inference_method, m.value_as_number AS v, m.harmonized_value_as_number AS h,
         m.range_low, m.range_high
  FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_named m
  WHERE m.value_as_number IS NOT NULL
    AND (   (m.measurement_concept_id = 3007070 AND m.value_as_number < 15)
         OR (    lower(COALESCE(m.measurement_concept_name, m.measurement_source_value)) LIKE '%hdl%'
             AND lower(COALESCE(m.measurement_concept_name, m.measurement_source_value)) LIKE '%chol%'
             AND (   lower(COALESCE(m.measurement_concept_name, m.measurement_source_value)) LIKE '%ratio%'
                  OR COALESCE(m.measurement_concept_name, m.measurement_source_value) RLIKE '(?i)hdl.?/|/.?(cholesterol in )?hdl')))
)
SELECT r.*, l.tc, l.hdl, l.ldl,
       round(l.tc / l.hdl, 2) AS tc_over_hdl, round(l.ldl / l.hdl, 2) AS ldl_over_hdl,
       CASE WHEN l.tc IS NULL OR l.hdl IS NULL           THEN 'no same-day lipids'
            WHEN abs(r.v - l.tc / l.hdl) <= 0.1 * l.tc / l.hdl THEN 'total/HDL'
            WHEN abs(r.v - l.hdl / l.tc) <= 0.1 * l.hdl / l.tc THEN 'HDL/total'
            WHEN abs(r.v - l.ldl / l.hdl) <= 0.1 * l.ldl / l.hdl THEN 'LDL/HDL'
            ELSE 'none' END AS matches
FROM r
LEFT JOIN lipids l ON l.person_id = r.person_id AND l.measurement_date = r.measurement_date;


-- COMMAND ----------

-- F4a. Cases: one row per (test, partner, part, method, match).
SELECT concept_id, test_name, data_partner_id, part, unit_inference_method, matches,
       COUNT(*) AS n,
       min(v) AS min_v, percentile_approx(v, 0.5) AS median_v, max(v) AS max_v,
       percentile_approx(h, 0.5) AS median_harmonized,
       percentile_approx(tc_over_hdl, 0.5) AS median_tc_over_hdl,
       array_join(slice(collect_set(measurement_source_value), 1, 3), ' | ') AS source_values,
       array_join(slice(collect_set(unit_source_value), 1, 3), ' | ') AS unit_source_values,
       array_join(slice(collect_set(concat_ws('-', range_low, range_high)), 1, 4), ', ') AS ranges
FROM f4_records
GROUP BY ALL
ORDER BY test_name, data_partner_id, part, unit_inference_method, n DESC;


-- COMMAND ----------

-- F4b. Sample records: up to 5 per case, and every Part A suspect_concept
--      record of 3023884.
SELECT concept_id, test_name, data_partner_id, part, unit_inference_method, matches,
       measurement_id, measurement_date, measurement_source_value, unit_source_value,
       v AS value_as_number, range_low, range_high, h AS harmonized,
       tc, hdl, ldl, tc_over_hdl, ldl_over_hdl
FROM (
  SELECT *, ROW_NUMBER() OVER (
           PARTITION BY concept_id, test_name, data_partner_id, part, unit_inference_method, matches
           ORDER BY hash(measurement_id)) AS rn
  FROM f4_records
)
WHERE rn <= 5 OR (concept_id = 3023884 AND part = 'A')
ORDER BY test_name, data_partner_id, part, unit_inference_method, matches, v;


-- COMMAND ----------

-- F5. Part C groups whose source name is on Part A's source-name list
--     (cell 7), whatever method they got: source_name, no_ucum_unit (specific
--     gravity), or an earlier step's. E 15a shows only totals. Expect: all
--     one partner; 12 source_name groups (469 records) with units that fit
--     their values, and "Specific Gravity, URN, Externa" no_ucum_unit (108).
SELECT d.data_partner_id, d.test_name, d.unit_inference_method, d.n, d.p05, d.med, d.p95,
       u.concept_code AS unit, r.source_name
FROM hive_metastore.ehr_union_clean_metrics.unit_no_range_decisions d
JOIN hive_metastore.ehr_union_clean_metrics.unit_source_name_rules r
  ON lower(trim(d.test_name)) = r.source_name
LEFT JOIN omop_vocab.concept u ON u.concept_id = d.inferred_unit_concept_id
WHERE d.harmonized_measurement_concept_id = 0
ORDER BY d.unit_inference_method, d.n DESC;


-- COMMAND ----------

-- F6. The s/S (INR) and L/l (expiratory minute volume) rows in
--     19d/19e have the same counts and medians: is each event stored twice?
--     Last run: yes. Every (person, datetime, value) has as many S as s
--     records, and as many L as l (unit text "sec" for INR, none for minute
--     volume). unit_code is the code before unit_mapping's corrections
--     (correction_from_code), since after them both copies read s or L/min.
WITH r AS (
  SELECT harmonized_concept_name AS concept_name, person_id, measurement_datetime, value_as_number,
         COALESCE(correction_from_code, effective_unit_code) AS unit_code,
         COALESCE(unit_source_value, '-') AS unit_text
  FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_keyed
  WHERE harmonized_concept_name IN ('INR in Platelet poor plasma by Coagulation assay', 'Expiratory minute volume')
    AND COALESCE(correction_from_code, effective_unit_code) IN ('s', 'S', 'L', 'l')
)
SELECT concept_name, units, unit_texts, COUNT(*) AS n_events
FROM (SELECT concept_name, person_id, measurement_datetime, value_as_number,
             array_join(sort_array(collect_list(unit_code)), ',') AS units,
             array_join(sort_array(collect_list(unit_text)), ',') AS unit_texts
      FROM r GROUP BY 1, 2, 3, 4)
GROUP BY 1, 2, 3
ORDER BY 1, 4 DESC;


-- COMMAND ----------

-- F7. F6 for every test: events stored under two unit codes that differ
--     only in case (s/S, l/L, h/H, ...). Last run: all one partner, 17
--     tests, 4,067 events (S/s on 14 tests, L/l on 1, H/h on 2). Codes are
--     before unit_mapping's corrections, as in F6.
WITH k AS (
  SELECT *, COALESCE(correction_from_code, effective_unit_code) AS code
  FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_keyed
),
e AS (
  SELECT data_partner_id, test_id, test_name, person_id, measurement_datetime, value_as_number,
         array_join(sort_array(collect_set(code)), ',') AS codes
  FROM k
  WHERE code IS NOT NULL
  GROUP BY 1, 2, 3, 4, 5, 6, lower(code)
  HAVING COUNT(DISTINCT code) > 1
)
SELECT data_partner_id, test_id, test_name, codes, COUNT(*) AS n_events
FROM e
GROUP BY 1, 2, 3, 4
ORDER BY n_events DESC;


-- COMMAND ----------

-- F8. Reference ranges: which records have them, how much they vary, and
--     whether missing ones could be inferred. Sets up the view f8 used by
--     F8a-F8c. Numeric records in scope (measurement_unit_keyed: no
--     suspect_concept). part comes from the raw columns, the way A-C pick
--     their records:
--       arrived  record has a unit concept
--       B        unit text, no unit concept
--       A        no unit text or concept, range_high present
--       C        no unit text or concept, no range_high
--     unit_code is the record's unit after unit_mapping's corrections.
CREATE OR REPLACE TEMP VIEW f8 AS
SELECT k.*,
       CASE WHEN COALESCE(k.unit_concept_id, 0) <> 0 THEN 'arrived'
            WHEN k.unit_source_value IS NOT NULL      THEN 'B'
            WHEN k.range_high IS NOT NULL             THEN 'A'
            ELSE 'C' END AS part,
       CASE WHEN k.range_low IS NOT NULL AND k.range_high IS NOT NULL THEN 'low and high'
            WHEN k.range_high IS NOT NULL THEN 'high only'
            WHEN k.range_low IS NOT NULL  THEN 'low only'
            ELSE 'none' END AS range_shape,
       k.effective_unit_code AS unit_code
FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_keyed k;

-- F8a. Records by part, partner and range shape.
SELECT part, data_partner_id, range_shape, COUNT(*) AS n,
       COUNT(DISTINCT test_id) AS n_tests
FROM f8
GROUP BY 1, 2, 3
ORDER BY 1, 2, 3;

-- COMMAND ----------

-- F8b. Range variation per test and unit (records with range_high). Ranges
--      can differ legitimately by partner, sex, age and assay.
--      top_range_share: share of the test's ranged records with its most
--      common range. high_spread: max range_high / min range_high.
WITH r AS (
  SELECT test_id, test_name, unit_code, data_partner_id, range_low, range_high, COUNT(*) AS n
  FROM f8
  WHERE range_high IS NOT NULL
  GROUP BY 1, 2, 3, 4, 5, 6
)
SELECT r.test_id, r.test_name, r.unit_code,
       SUM(r.n) AS n, COUNT(DISTINCT r.data_partner_id) AS n_partners,
       COUNT(*) AS n_distinct_ranges,
       max_by(concat(COALESCE(CAST(r.range_low AS STRING), ''), ' - ', CAST(r.range_high AS STRING)),
              struct(r.n, r.range_high, r.range_low)) AS top_range,
       round(max(r.n) / SUM(r.n), 3) AS top_range_share,
       min(r.range_high) AS min_high, max(r.range_high) AS max_high,
       round(max(r.range_high) / NULLIF(min(r.range_high), 0), 2) AS high_spread
FROM r
GROUP BY 1, 2, 3
ORDER BY n DESC
LIMIT 500;

-- COMMAND ----------

-- F8c. Records with no range_high: could a range be inferred? Evidence is
--      ranged records (any part) of the same partner, test and unit.
WITH pr AS (
  SELECT data_partner_id, test_id, unit_code, SUM(n) AS n_ranged, max(n) / SUM(n) AS top_share
  FROM (SELECT data_partner_id, test_id, unit_code, range_low, range_high, COUNT(*) AS n
        FROM f8 WHERE range_high IS NOT NULL GROUP BY 1, 2, 3, 4, 5)
  GROUP BY 1, 2, 3
),
tr AS (SELECT DISTINCT test_id FROM f8 WHERE range_high IS NOT NULL)
SELECT f.part,
       CASE WHEN pr.n_ranged IS NOT NULL AND pr.top_share >= 0.9
              THEN '1 same partner, test, unit: one range covers 90%+'
            WHEN pr.n_ranged IS NOT NULL
              THEN '2 same partner, test, unit: several ranges'
            WHEN tr.test_id IS NOT NULL
              THEN '3 ranges only at other partners or in other units'
            ELSE '4 no ranged records for the test'
       END AS evidence,
       COUNT(*) AS n,
       COUNT(DISTINCT f.data_partner_id, f.test_id) AS n_partner_tests
FROM f8 f
LEFT JOIN pr ON  pr.data_partner_id = f.data_partner_id
             AND pr.test_id = f.test_id
             AND pr.unit_code <=> f.unit_code
LEFT JOIN tr ON tr.test_id = f.test_id
WHERE f.range_high IS NULL
GROUP BY 1, 2
ORDER BY 1, 2;
