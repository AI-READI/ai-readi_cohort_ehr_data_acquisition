-- Databricks notebook source
-- Unit inference, Part F: experimental probes. Read-only queries for
-- questions that come up in review, run against the output of a full A-D
-- run. Nothing here writes a table, and nothing in A-E depends on it.
-- Cells are numbered F1, F2, ... and say what question they answer.


-- COMMAND ----------

-- F1. HDL/cholesterol ratio records (PR review: Part A marks concept 3023884
--     suspect_concept while Part C inverts values over 1).
--     Every concept whose name has HDL, cholesterol and a ratio, plus
--     concept-0 records with such a source name, by part, partner, arrived
--     unit, method and value band. Expected values: HDL/total 0.1-0.4,
--     total/HDL 2.5-10; the other bands are outliers either way.
--     Answers: does Part A have values <= 1; what Part A's reference ranges
--     look like; how many records fall outside both expected bands.
WITH r AS (
  SELECT COALESCE(m.measurement_concept_id, 0) AS concept_id,
         COALESCE(c.concept_name, m.measurement_source_value) AS test_name,
         CASE WHEN COALESCE(m.unit_concept_id, 0) <> 0 THEN 'has unit concept'
              WHEN m.unit_source_value IS NOT NULL     THEN 'B'
              WHEN m.range_high IS NOT NULL            THEN 'A'
              ELSE 'C' END AS part,
         m.data_partner_id, u.concept_code AS unit_code, m.unit_inference_method,
         m.value_as_number AS v, m.harmonized_value_as_number AS h,
         m.range_low, m.range_high
  FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized m
  LEFT JOIN omop_vocab.concept c ON c.concept_id = NULLIF(m.measurement_concept_id, 0)
  LEFT JOIN omop_vocab.concept u ON u.concept_id = NULLIF(m.unit_concept_id, 0)
  WHERE m.value_as_number IS NOT NULL
    AND lower(COALESCE(c.concept_name, m.measurement_source_value)) LIKE '%hdl%'
    AND lower(COALESCE(c.concept_name, m.measurement_source_value)) LIKE '%cholesterol%'
    AND (COALESCE(c.concept_name, m.measurement_source_value) LIKE '%/%'
         OR lower(COALESCE(c.concept_name, m.measurement_source_value)) LIKE '%ratio%')
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

-- F2. AI-READI REDCap list against our data (PR review: target the tests in
--     DataElementMaps' _ai_readi_redcap_value_set_mapping_common.csv).
--     Every Measurement-domain concept in the list (112, duplicates
--     dropped), including the AI-READI custom concepts (2005200xxx), which
--     may also turn up in the EHR data. list_unit is the list's unit, NULL
--     where it gives none; the MoCA items' units are listed by item name
--     after moca_total and matched by name.
--     Answers: which listed tests have no EHR records; where our canonical
--     unit differs from the list's; how much unit inference touched them.
--     Misses a listed test recorded under a different concept.
WITH list AS (
  SELECT * FROM VALUES
    (1,'bcva','Right eye Sphere Autorefractor.auto',3000744,NULL),
    (2,'bcva','Right eye Cylinder Autorefractor.auto',3033346,NULL),
    (3,'bcva','Right eye Axis Autorefractor.auto',3034190,NULL),
    (4,'bcva','Left eye Sphere Autorefractor.auto',3003500,NULL),
    (5,'bcva','Left eye Cylinder Autorefractor.auto',3002343,NULL),
    (6,'bcva','Left eye Axis Autorefractor.auto',3001254,NULL),
    (7,'bcva','Snellen fraction - Photopic VA - OD',2005200012,NULL),
    (8,'bcva','Snellen fraction - Photopic VA - OS',2005200013,NULL),
    (9,'bcva','VA Letter Score - Photopic VA - OD',2005200042,NULL),
    (10,'bcva','VA Letter Score - Photopic VA - OS',2005200043,NULL),
    (11,'bcva','Photopic LogMAR OD Score',2005200052,NULL),
    (12,'bcva','Photopic LogMAR OS Score',2005200053,NULL),
    (13,'bcva','Snellen fraction - Mesopic VA - OD',2005200054,NULL),
    (14,'bcva','Snellen fraction - Mesopic VA - OS',2005200055,NULL),
    (15,'bcva','LLVA Letter Score - Mesopic VA - OD',2005200056,NULL),
    (16,'bcva','LLVA Letter Score - Mesopic VA - OS',2005200057,NULL),
    (17,'bcva','Mesopic LogMAR OD Score',2005200336,NULL),
    (18,'bcva','Mesopic LogMAR OS Score',2005200337,NULL),
    (19,'imported','import_nt_probnp',3029187,'pg/mL'),
    (20,'imported','import_troponin_t',40769783,'ng/L'),
    (21,'imported','import_c_peptide',3010084,'ng/L'),
    (22,'imported','import_insulin',3022466,'ng/mL'),
    (23,'imported','import_crp_hs',3010156,'mg/L'),
    (24,'imported','import_total_cholesterol',3027114,'mg/dL'),
    (25,'imported','import_triglycerides',3022192,'mg/dL'),
    (26,'imported','import_hdl_cholesterol',3007070,'mg/dL'),
    (27,'imported','import_ldl_cholesterol_calculation',3028288,'mg/dL'),
    (28,'imported','import_glucose',3004501,'mg/dL'),
    (29,'imported','import_bun',3013682,'mg/dL'),
    (30,'imported','import_creatinine',3016723,'mg/dL'),
    (31,'imported','import_buncreatinineratio',3033837,NULL),
    (32,'imported','import_sodium',3019550,'10*-3.eq/L'),
    (33,'imported','import_potassium',3023103,'10*-3.eq/L'),
    (34,'imported','import_chloride',3014576,'10*-3.eq/L'),
    (35,'imported','import_carbon_dioxide_total',3015632,'10*-3.eq/L'),
    (36,'imported','import_calcium',3006906,'mg/dL'),
    (37,'imported','import_protein_total',3020630,'g/dL'),
    (38,'imported','import_albumin',3024561,'g/dL'),
    (39,'imported','import_globulin_total_norc',3021886,NULL),
    (40,'imported','import_ag_ratio',3020509,NULL),
    (41,'imported','import_bilirubin_total',3024128,NULL),
    (42,'imported','import_alkaline_phosphatase',3035995,'[iU]/L'),
    (43,'imported','import_ast_got',3013721,'[iU]/L'),
    (44,'imported','import_alt_got',3006923,'[iU]/L'),
    (45,'imported','import_hba1c',3004410,'%'),
    (46,'imported','import_urine_creatinine',3017250,'mg/dL'),
    (47,'imported','import_urine_albumin',3012516,'mg/L'),
    (48,'imported','trails_visuospatial_executive',2005200344,'[score]'),
    (49,'imported','trails_visuospatial_executive_time',2005200345,'s'),
    (50,'imported','cube_visuospatial_executive',2005200346,'[score]'),
    (51,'imported','cube_visuospatial_executive_time',2005200347,'s'),
    (52,'imported','clock_visuospatial_executive',2005200348,'[score]'),
    (53,'imported','clock_visuospatial_executive_time',2005200349,'s'),
    (54,'imported','naming',2005200350,NULL),
    (55,'imported','naming_time',2005200351,'s'),
    (56,'imported','memory_trial1',2005200352,NULL),
    (57,'imported','memory_trial1_time',2005200353,'s'),
    (58,'imported','memory_trial2',2005200354,NULL),
    (59,'imported','memory_trial2_time',2005200355,'s'),
    (60,'imported','digitspan',2005200356,NULL),
    (61,'imported','digitspan_time',2005200357,'s'),
    (62,'imported','lettera',2005200358,'[score]'),
    (63,'imported','lettera_time',2005200359,'s'),
    (64,'imported','subtraction',2005200360,NULL),
    (65,'imported','subtraction_time',2005200361,'s'),
    (66,'imported','repetition',2005200362,NULL),
    (67,'imported','repetition_time',2005200363,'s'),
    (68,'imported','fluency_language',2005200364,NULL),
    (69,'imported','fluency_language_time',2005200365,'s'),
    (70,'imported','moca_abstraction',2005200366,NULL),
    (71,'imported','moca_abstraction_time',2005200367,'s'),
    (72,'imported','delayed_recall_with_no_clue',2005200368,NULL),
    (73,'imported','delayed_recall_with_no_clue_time',2005200369,'s'),
    (74,'imported','moca_orientation',2005200370,NULL),
    (75,'imported','moca_orientation_time',2005200371,'s'),
    (76,'imported','moca_combined_mis_score',2005200373,'[score]'),
    (77,'imported','moca_total_score',606671,'[score]'),
    (78,'lab_results','Leukocytes [#/volume] in Blood by Automated c',3000905,NULL),
    (79,'lab_results','Erythrocytes [#/volume] in Blood by Automated',3020416,NULL),
    (80,'lab_results','Hemoglobin [Mass/volume] in Blood',3000963,NULL),
    (81,'lab_results','Hematocrit [Volume Fraction] of Blood by Auto',3023314,NULL),
    (82,'lab_results','MCV [Entitic mean volume] in Red Blood Cells ',3023599,NULL),
    (83,'lab_results','MCH [Entitic mass] by Automated count',3012030,NULL),
    (84,'lab_results','MCHC [Entitic Mass/volume] in Red Blood Cells',3009744,NULL),
    (85,'lab_results','Erythrocyte [DistWidth] in Red Blood Cells by',3019897,NULL),
    (86,'lab_results','Platelets [#/volume] in Blood by Automated co',3024929,NULL),
    (87,'mesopic_mars','OD: Value of final correct letter - Mesopic, ',2005200486,NULL),
    (88,'mesopic_mars','OD: Number of misses prior to stopping - Meso',2005200487,NULL),
    (89,'mesopic_mars','OD: Log Contrast Sensitivity - Mesopic, right',2005200552,NULL),
    (90,'mesopic_mars','OS: Value of final correct letter - Mesopic, ',2005200488,NULL),
    (91,'mesopic_mars','OS: Number of misses prior to stopping - Meso',2005200489,NULL),
    (92,'mesopic_mars','OS: Log Contrast Sensitivity - Mesopic, left ',2005200553,NULL),
    (93,'monofilament','Right Foot - Felt:',2005200159,NULL),
    (94,'monofilament','Left Foot - Felt:',2005200161,NULL),
    (95,'photopic_mars','OD: Value of final correct letter - Photopic,',2005200338,NULL),
    (96,'photopic_mars','OD: Number of misses prior to stopping - Phot',2005200339,NULL),
    (97,'photopic_mars','OD: Log Contrast Sensitivity - Photopic, righ',2005200155,NULL),
    (98,'photopic_mars','OS: Value of final correct letter - Photopic,',2005200340,NULL),
    (99,'photopic_mars','OS: Number of misses prior to stopping - Phot',2005200341,NULL),
    (100,'photopic_mars','OS: Log Contrast Sensitivity - Photopic, left',2005200156,NULL),
    (101,'physical_assessment','Body height',3036277,NULL),
    (102,'physical_assessment','Body weight',3025315,NULL),
    (103,'physical_assessment','Body mass index (BMI) [Ratio]',3038553,NULL),
    (104,'physical_assessment','Waist Circumference at umbilicus by Tape meas',3016258,NULL),
    (105,'physical_assessment','Hip circumference',4111665,NULL),
    (106,'physical_assessment','Waist/hip ratio',4087501,NULL),
    (107,'physical_assessment','Systolic blood pressure',3004249,NULL),
    (108,'physical_assessment','Diastolic blood pressure',3012888,NULL),
    (109,'physical_assessment','Heart rate',3027018,NULL),
    (110,'imported','import_uarc',3020682,NULL),
    (111,'imported','import_bun_creatinine_ratio',3018311,'{ratio}'),
    (112,'lab_results','Nucleated erythrocytes/Leukocytes [Ratio] in ',40761514,'%')
  AS t(ord, form, field, concept_id, list_unit)
),
arrived AS (
  SELECT test_id, array_join(collect_list(concat(unit_code, ' (', CAST(n AS STRING), ')')), ', ') AS units_in_data
  FROM (SELECT test_id, unit_code, SUM(n) AS n
        FROM hive_metastore.ehr_union_clean_metrics.unit_test_units
        GROUP BY 1, 2 ORDER BY n DESC)
  GROUP BY 1
)
SELECT l.form, l.field, l.concept_id, c.concept_name, l.list_unit,
       COUNT(m.value_as_number) AS n_numeric,
       COUNT_IF(COALESCE(m.unit_concept_id, 0) <> 0) AS n_arrived_with_unit,
       COUNT_IF(COALESCE(m.unit_concept_id, 0) = 0 AND m.inferred_unit_concept_id IS NOT NULL) AS n_unit_inferred,
       COUNT_IF(m.value_as_number IS NOT NULL AND COALESCE(m.unit_concept_id, 0) = 0
                AND m.inferred_unit_concept_id IS NULL) AS n_no_unit,
       COUNT_IF(m.canonical_unit_concept_id IS NOT NULL) AS n_in_canonical,
       array_join(collect_set(m.canonical_unit_value), ', ') AS our_canonical_unit,
       first(a.units_in_data) AS units_in_data,
       percentile_approx(m.harmonized_value_as_number, 0.5) AS median_harmonized
FROM list l
LEFT JOIN omop_vocab.concept c ON c.concept_id = l.concept_id
LEFT JOIN hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized m
  ON m.measurement_concept_id = l.concept_id AND m.value_as_number IS NOT NULL
LEFT JOIN arrived a ON a.test_id = CAST(l.concept_id AS STRING)
GROUP BY l.ord, l.form, l.field, l.concept_id, c.concept_name, l.list_unit
ORDER BY l.ord;


-- COMMAND ----------

-- F3a. Listed tests F2 found no records for, searched by name: are they in
--      the data under another concept, or as concept 0 with a source name?
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
         COALESCE(c.concept_name, m.measurement_source_value) AS test_name,
         m.data_partner_id, m.value_as_number, m.unit_source_value
  FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized m
  LEFT JOIN omop_vocab.concept c ON c.concept_id = NULLIF(m.measurement_concept_id, 0)
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

-- F3c. The two listed ratios with many records and no unit in F2
--      (A/G ratio 3020509, BUN/creatinine ratio 3018311): were they marked
--      unitless, or left with nothing?
SELECT c.concept_name,
       CASE WHEN COALESCE(m.unit_concept_id, 0) <> 0 THEN 'has unit concept'
            WHEN m.unit_source_value IS NOT NULL     THEN 'B'
            WHEN m.range_high IS NOT NULL            THEN 'A'
            ELSE 'C' END AS part,
       m.data_partner_id, m.unit_source_value, m.unit_inference_method,
       m.inferred_unit_source_value, m.unit_conversion_method,
       COUNT(*) AS n,
       percentile_approx(m.value_as_number, 0.5) AS median_value,
       COUNT(m.harmonized_value_as_number) AS n_harmonized
FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized m
JOIN omop_vocab.concept c ON c.concept_id = m.measurement_concept_id
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
         COALESCE(c.concept_name, m.measurement_source_value) AS test_name,
         m.measurement_source_value, m.unit_source_value,
         CASE WHEN COALESCE(m.unit_concept_id, 0) <> 0 THEN 'has unit concept'
              WHEN m.unit_source_value IS NOT NULL     THEN 'B'
              WHEN m.range_high IS NOT NULL            THEN 'A'
              ELSE 'C' END AS part,
         m.unit_inference_method, m.value_as_number AS v, m.harmonized_value_as_number AS h,
         m.range_low, m.range_high
  FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized m
  LEFT JOIN omop_vocab.concept c ON c.concept_id = NULLIF(m.measurement_concept_id, 0)
  WHERE m.value_as_number IS NOT NULL
    AND (   (m.measurement_concept_id = 3007070 AND m.value_as_number < 15)
         OR (    lower(COALESCE(c.concept_name, m.measurement_source_value)) LIKE '%hdl%'
             AND lower(COALESCE(c.concept_name, m.measurement_source_value)) LIKE '%chol%'
             AND (   lower(COALESCE(c.concept_name, m.measurement_source_value)) LIKE '%ratio%'
                  OR COALESCE(c.concept_name, m.measurement_source_value) RLIKE '(?i)hdl.?/|/.?(cholesterol in )?hdl')))
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
--     (cell 7), whatever method they got: source_name, unitless (specific
--     gravity), or an earlier step's. E 15a shows only totals. Expect: all
--     partner 3058; 12 source_name groups (469 records) with units that fit
--     their values, and "Specific Gravity, URN, Externa" unitless (108).
SELECT d.data_partner_id, d.test_name, d.unit_inference_method, d.n, d.p05, d.med, d.p95,
       u.concept_code AS unit, r.source_name
FROM hive_metastore.ehr_union_clean_metrics.unit_no_range_decisions d
JOIN hive_metastore.ehr_union_clean_metrics.unit_source_name_rules r
  ON lower(trim(d.test_name)) = r.source_name
LEFT JOIN omop_vocab.concept u ON u.concept_id = d.inferred_unit_concept_id
WHERE d.harmonized_measurement_concept_id = 0
ORDER BY d.unit_inference_method, d.n DESC;


-- COMMAND ----------

-- F6. Partner 2084's s/S (INR) and L/l (expiratory minute volume) rows in
--     19d/19e have the same counts and medians: is each event stored twice?
--     Last run: yes. Every (person, datetime, value) has as many S as s
--     records, and as many L as l (unit text "sec" for INR, none for minute
--     volume).
WITH r AS (
  SELECT c.concept_name, k.person_id, k.measurement_datetime, k.value_as_number,
         u.concept_code AS unit_code, COALESCE(k.unit_source_value, '-') AS unit_text
  FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_keyed k
  JOIN omop_vocab.concept c ON c.concept_id = k.harmonized_measurement_concept_id
  JOIN omop_vocab.concept u ON u.concept_id = k.effective_unit_concept_id
  WHERE k.data_partner_id = 2084
    AND c.concept_name IN ('INR in Platelet poor plasma by Coagulation assay', 'Expiratory minute volume')
    AND u.concept_code IN ('s', 'S', 'L', 'l')
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
--     only in case (s/S, l/L, h/H, ...). Last run: all partner 2084, 17
--     tests, 4,119 events (S/s on 14 tests, L/l on 1, H/h on 2).
WITH k AS (
  SELECT k.data_partner_id, k.test_id, k.person_id, k.measurement_datetime,
         k.value_as_number, u.concept_code AS unit_code
  FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_keyed k
  JOIN omop_vocab.concept u ON u.concept_id = k.effective_unit_concept_id
),
e AS (
  SELECT data_partner_id, test_id, person_id, measurement_datetime, value_as_number,
         array_join(sort_array(collect_set(unit_code)), ',') AS codes
  FROM k
  GROUP BY 1, 2, 3, 4, 5, lower(unit_code)
  HAVING COUNT(DISTINCT unit_code) > 1
)
SELECT e.data_partner_id, e.test_id, c.concept_name AS test_name, e.codes,
       COUNT(*) AS n_events
FROM e
LEFT JOIN omop_vocab.concept c ON CAST(c.concept_id AS STRING) = e.test_id
GROUP BY 1, 2, 3, 4
ORDER BY n_events DESC;
