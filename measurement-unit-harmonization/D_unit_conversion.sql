-- Databricks notebook source
-- Unit inference, Part D: conversion to a canonical unit per test.
-- Fills canonical_unit_concept_id, canonical_unit_value (its UCUM code),
-- unit_conversion_method and harmonized_value_as_number for every numeric
-- record with a unit: inferred_unit_concept_id, 0 read as none. Cell 17d
-- first writes unit_mapping's corrections into it (Part A, 1i): units
-- that are wrong for some records (S used for seconds, one partner's
-- "[lb_us]" weights that are ounces) become the unit the records are
-- really in, or none. The rest of this part picks canonical units and converts.
-- no_ucum_unit records (harmonized = value already) and suspect_concept records
-- are not touched.
--
-- A "test" is the harmonized measurement concept (Part A, cell 1d); for
-- concept 0 it is the measurement_source_value (test_id 'src:<source value>').
--
-- How conversion works:
--   unit_factors   every unit -> a base unit, base = slope * x + intercept.
--                  Units with the same base convert directly. Equivalent
--                  codes (/min = {counts}/min, % = %{of'HGB}, [iU]/L = [U]/L)
--                  are just units with the same factor.
--   unit_analytes  name patterns that give a test an analyte, with molar mass
--                  and/or charge. These bridge bases for that analyte only:
--                  g/L <-> mol/L by molar mass, eq/L <-> mol/L by charge
--                  (so mEq/L = mmol/L for monovalent ions, 0.5 for Ca, Mg).
--                  HbA1c % <-> mmol/mol is an affine bridge.
--   canonical unit the most common unit for the test (counting equivalent
--                  codes together, across partners), unless
--                  canonical_unit_rules says otherwise.
-- Conversion: canonical = slope * value_as_number + intercept, per
-- (partner, test, unit), in unit_conversion_decisions.
-- Methods written: identity, same_base, analyte_bridge, no_conversion.
-- canonical_unit_concept_id and canonical_unit_value are set only where
-- harmonized_value_as_number is, so a non-null harmonized value is always in
-- canonical_unit_concept_id. unit_conversion_method is set on every record
-- the apply matches, including no_conversion.
--
-- Plausibility: Part 0 loads the AI-READI REDCap list from
-- DataElementMaps (the value-set mapping, the unit lookup and the limits in
-- 09_validate_units_and_value_ranges.sql) into redcap_list_tests, one row
-- per OMOP concept; 19g converts the limits to each test's canonical unit. Cell 20 sets
-- value_plausibility on records of those tests (implausible, extreme,
-- plausible) without changing them; 19i lists groups whose median is
-- implausible, which means a wrong unit rather than bad values.
--
-- Run after Parts 0, A, B and C: A-C assign the units converted here (their
-- applies also clear this part's columns on their records), and 0 loads
-- the list. Run every cell in order; cells that end in a SELECT show a
-- result, the others build tables.


-- ===== D1. Hand-written rule tables =====

-- 17. Unit factors. base is just a label; units convert only within a base
--     (or across bases through an analyte bridge, 17b). A code with no row
--     here is its own class: it converts only to itself (identity, when it
--     is the canonical unit) and is no_conversion otherwise.
--     unit_code is the UCUM code as OMOP spells it (checked in 17e).
CREATE OR REPLACE TABLE hive_metastore.ehr_union_clean_metrics.unit_factors AS
SELECT unit_code, base, CAST(slope AS DOUBLE) AS slope,
       CAST(intercept AS DOUBLE) AS intercept, note
FROM VALUES
  -- mass (body weight)
  ('kg',               'g',       1000,          0, NULL),
  ('g',                'g',       1,             0, NULL),
  ('[lb_us]',          'g',       453.59237,     0, 'pound'),
  ('[oz_av]',          'g',       28.349523125,  0, 'ounce'),
  -- length (body height)
  ('m',                'm',       1,             0, NULL),
  ('cm',               'm',       0.01,          0, NULL),
  ('mm',               'm',       0.001,         0, NULL),
  ('[in_i]',           'm',       0.0254,        0, 'inch'),
  ('[in_us]',          'm',       0.0254,        0, 'US survey inch, treated as international'),
  ('[ft_i]',           'm',       0.3048,        0, 'foot'),
  -- temperature
  ('Cel',              'Cel',     1,             0, NULL),
  ('[degF]',           'Cel',     5 / 9,         -160 / 9, 'C = (F - 32) * 5/9'),
  ('K',                'Cel',     1,             -273.15, NULL),
  -- pressure
  ('kPa',              'kPa',     1,             0, NULL),
  ('mm[Hg]',           'kPa',     0.133322387415, 0, NULL),
  ('cm[H2O]',          'kPa',     0.0980665,     0, NULL),
  -- time
  ('s',                's',       1,             0, NULL),
  ('ms',               's',       0.001,         0, NULL),
  ('min',              's',       60,            0, NULL),
  ('h',                's',       3600,          0, NULL),
  ('d',                's',       86400,         0, NULL),
  ('wk',               's',       604800,        0, NULL),
  ('mo',               's',       2629800,       0, 'mean month'),
  ('a',                's',       31557600,      0, 'mean year'),
  -- rates
  ('/min',             '/min',    1,             0, NULL),
  ('{counts}/min',     '/min',    1,             0, 'same as /min'),
  -- volumes and flows
  ('L',                'L',       1,             0, NULL),
  ('dL',               'L',       0.1,           0, NULL),
  ('mL',               'L',       0.001,         0, NULL),
  ('uL',               'L',       1e-6,          0, NULL),
  ('L/min',            'L/min',   1,             0, NULL),
  ('mL/min',           'L/min',   0.001,         0, NULL),
  ('mL/h',             'L/min',   1 / 60000,     0, NULL),
  ('L/h',              'L/min',   1 / 60,        0, NULL),
  ('L/s',              'L/min',   60,            0, NULL),
  ('mL/s',             'L/min',   0.06,          0, NULL),
  ('mL/min/(173.10*-2.m2)', 'eGFR', 1,           0, NULL),
  -- radiation dose, osmolality
  ('Gy',               'Gy',      1,             0, NULL),
  ('cGy',              'Gy',      0.01,          0, NULL),
  ('mosm/kg',          'mosm/kg', 1,             0, NULL),
  ('mosm/kg{H20}',     'mosm/kg', 1,             0, 'same as mosm/kg'),
  -- mass concentration
  ('g/L',              'g/L',     1,             0, NULL),
  ('g/dL',             'g/L',     10,            0, NULL),
  ('mg/mL',            'g/L',     1,             0, NULL),
  ('mg/dL',            'g/L',     0.01,          0, NULL),
  ('mg/dL{calc}',      'g/L',     0.01,          0, 'same as mg/dL'),
  ('mg/L',             'g/L',     0.001,         0, NULL),
  ('ug/mL',            'g/L',     0.001,         0, NULL),
  ('ug/dL',            'g/L',     1e-5,          0, NULL),
  ('ug/L',             'g/L',     1e-6,          0, NULL),
  ('ng/mL',            'g/L',     1e-6,          0, NULL),
  ('ng/dL',            'g/L',     1e-8,          0, NULL),
  ('ng/L',             'g/L',     1e-9,          0, NULL),
  ('pg/mL',            'g/L',     1e-9,          0, NULL),
  ('ng{FEU}/mL',       'g{FEU}/L', 1e-6,         0, 'D-dimer'),
  ('ug{FEU}/mL',       'g{FEU}/L', 1e-3,         0, 'D-dimer'),
  ('mg{FEU}/L',        'g{FEU}/L', 1e-3,         0, 'D-dimer'),
  -- mass ratios (per creatinine and plain)
  ('mg/mg{creat}',     'g/g',     1,             0, NULL),
  ('mg/g{creat}',      'g/g',     1e-3,          0, NULL),
  ('ug/mg{creat}',     'g/g',     1e-3,          0, NULL),
  ('ug/g{creat}',      'g/g',     1e-6,          0, NULL),
  ('mg/mg',            'g/g',     1,             0, NULL),
  ('mg/g',             'g/g',     1e-3,          0, NULL),
  ('ug/mg',            'g/g',     1e-3,          0, NULL),
  -- molar and equivalent concentration
  ('mol/L',            'mol/L',   1,             0, NULL),
  ('mmol/L',           'mol/L',   1e-3,          0, NULL),
  ('umol/L',           'mol/L',   1e-6,          0, NULL),
  ('nmol/L',           'mol/L',   1e-9,          0, NULL),
  ('pmol/L',           'mol/L',   1e-12,         0, NULL),
  ('nmol/mL',          'mol/L',   1e-6,          0, NULL),
  ('10*-3.eq/L',       'eq/L',    1e-3,          0, 'mEq/L'),
  -- per 24 hours
  ('g/(24.h)',         'g/d',     1,             0, NULL),
  ('mg/(24.h)',        'g/d',     1e-3,          0, NULL),
  ('ug/(24.h)',        'g/d',     1e-6,          0, NULL),
  ('mmol/(24.h)',      'mol/d',   1e-3,          0, NULL),
  ('10*-3.eq/(24.h)',  'eq/d',    1e-3,          0, 'mEq/24 h'),
  ('L/(24.h)',         'L/d',     1,             0, NULL),
  ('mL/(24.h)',        'L/d',     1e-3,          0, NULL),
  -- counts per volume
  ('/L',               '/L',      1,             0, NULL),
  ('10*6/L',           '/L',      1e6,           0, NULL),
  ('10*9/L',           '/L',      1e9,           0, NULL),
  ('10*12/L',          '/L',      1e12,          0, NULL),
  ('/uL',              '/L',      1e6,           0, NULL),
  ('/mm3',             '/L',      1e6,           0, NULL),
  ('{cells}/uL',       '/L',      1e6,           0, NULL),
  ('10*3/uL',          '/L',      1e9,           0, NULL),
  ('10*3/mm3',         '/L',      1e9,           0, 'same as 10*3/uL'),
  ('10*6/uL',          '/L',      1e12,          0, NULL),
  ('10*6/mm3',         '/L',      1e12,          0, 'same as 10*6/uL'),
  -- percent (mmol/mol gets its own base so it never meets % without a bridge)
  ('%',                '%',       1,             0, NULL),
  ('%{of\'HGB}',       '%',       1,             0, 'same as %'),
  ('%{calc}',          '%',       1,             0, 'same as %'),
  ('mmol/mol',         'mol/mol', 1e-3,          0, NULL),
  -- dimensionless: each its own base, so a ratio never converts to an index
  ('{ratio}',          'ratio',   1,             0, NULL),
  ('{calc}',           'ratio',   1,             0, 'only seen on ratio tests'),
  ('[ratio\'U]',       'ratio',   1,             0, NULL),
  ('pH',               'pH',      1,             0, NULL),
  ('{index}',          'index',   1,             0, NULL),
  ('[score]',          'score',   1,             0, NULL),
  ('{fraction}',       'fraction', 1,            0, NULL),
  ('{MOM}',            'MOM',     1,             0, 'multiple of the median'),
  ('{ISR}',            'ISR',     1,             0, 'immune status ratio'),
  ('[OD\'U]',          'OD',      1,             0, 'optical density'),
  ('{signal}/[{CO\'ratio}]', 'signal to cutoff', 1, 0, 'signal to cutoff'),
  -- enzyme and international units ([iU] = [U])
  ('[iU]/L',           'U/L',     1,             0, NULL),
  ('[U]/L',            'U/L',     1,             0, 'same as [iU]/L'),
  ('10*3.[iU]/L',      'U/L',     1000,          0, NULL),
  ('10*3.[U]/L',       'U/L',     1000,          0, NULL),
  ('[iU]/mL',          'U/L',     1000,          0, NULL),
  ('[U]/mL',           'U/L',     1000,          0, NULL),
  ('10*-3.[iU]/mL',    'U/L',     1,             0, 'mIU/mL'),
  ('10*-3.[iU]/L',     'U/L',     0.001,         0, 'mIU/L'),
  ('10*-6.[iU]/mL',    'U/L',     0.001,         0, 'uIU/mL'),
  ('10*-6.[U]/mL',     'U/L',     0.001,         0, 'uU/mL')
AS t(unit_code, base, slope, intercept, note);

-- 17a. Analytes. A test gets the first analyte (lowest priority) whose
--      pattern matches its concept name (or source value, for concept 0).
--      molar_mass bridges g/L <-> mol/L and g/d <-> mol/d;
--      charge bridges eq/L <-> mol/L and eq/d <-> mol/d;
--      both together bridge eq/L <-> g/L and eq/d <-> g/d.
--      A loose pattern is harmless unless the test carries units in two
--      bridged bases; 18c lists every assignment.
CREATE OR REPLACE TABLE hive_metastore.ehr_union_clean_metrics.unit_analytes AS
SELECT analyte, priority, pattern, CAST(molar_mass AS DOUBLE) AS molar_mass,
       CAST(charge AS INT) AS charge, note
FROM VALUES
  ('hba1c',          1,  '(?i)a1c',                     NULL,   NULL, 'affine bridge in 17b'),
  ('urea_nitrogen',  2,  '(?i)urea nitrogen|(?-i:BUN)', 28.014, NULL, 'as N2: mg/dL x 0.357 = mmol/L urea'),
  ('creatinine',     3,  '(?i)creatinine',              113.12, NULL, NULL),
  ('glucose',        4,  '(?i)glucose',                 180.16, NULL, NULL),
  ('triglyceride',   5,  '(?i)triglyceride',            885.7,  NULL, 'mg/dL x 0.01129 = mmol/L'),
  ('cholesterol',    6,  '(?i)cholesterol',             386.65, NULL, 'total, HDL, LDL'),
  ('vitamin_d_25oh', 7,  '(?i)25-hydroxyvitamin d|calcidiol|calcifediol', 400.64, NULL, NULL),
  ('calcium',        8,  '(?i)calcium',                 40.078, 2,    NULL),
  ('magnesium',      9,  '(?i)magnesium',               24.305, 2,    NULL),
  ('phosphorus',     10, '(?i)phosph',                  30.974, NULL, 'reported as P'),
  ('uric_acid',      11, '(?i)^urate|uric acid',       168.11, NULL, NULL),
  ('bilirubin',      12, '(?i)bilirubin',               584.66, NULL, NULL),
  ('iron',           13, '(?i)iron',                    55.845, NULL, NULL),
  ('sodium',         14, '(?i)sodium',                  22.990, 1,    NULL),
  ('potassium',      15, '(?i)potassium',               39.098, 1,    NULL),
  ('chloride',       16, '(?i)chloride',                35.453, 1,    NULL),
  ('bicarbonate',    17, '(?i)bicarbonate|carbon dioxide', 61.017, 1, 'total CO2 reported as HCO3'),
  ('lithium',        18, '(?i)lithium',                 6.94,   1,    NULL),
  ('anion_gap',      19, '(?i)anion gap',               NULL,   1,    NULL),
  ('base_excess',    20, '(?i)base excess',             NULL,   1,    NULL),
  ('lactate',        21, '(?i)^lactate(?! dehydrogenase)', 90.08, NULL, NULL),
  ('beta_hydroxybutyrate', 22, '(?i)hydroxybutyrate',   104.1,  NULL, NULL),
  ('pyridoxine',     23, '(?i)^pyridoxine',             169.18, NULL, NULL)
AS t(analyte, priority, pattern, molar_mass, charge, note);

-- 17b. Bridges between bases, per analyte, both directions.
--      to_base = slope * from_base + intercept.
CREATE OR REPLACE TABLE hive_metastore.ehr_union_clean_metrics.unit_analyte_bridges AS
WITH one_way AS (
  SELECT * FROM (
    SELECT a.analyte, p.from_base, p.to_base,
           CASE p.via WHEN 'mass'   THEN 1 / a.molar_mass
                      WHEN 'charge' THEN 1 / a.charge
                      ELSE a.molar_mass / a.charge
           END AS slope,
           0D AS intercept
    FROM hive_metastore.ehr_union_clean_metrics.unit_analytes a
    CROSS JOIN VALUES
      ('mass',      'g/L',  'mol/L'),
      ('mass',      'g/d',  'mol/d'),
      ('charge',    'eq/L', 'mol/L'),
      ('charge',    'eq/d', 'mol/d'),
      ('charge_mass', 'eq/L', 'g/L'),
      ('charge_mass', 'eq/d', 'g/d')
    AS p(via, from_base, to_base)
  ) WHERE slope IS NOT NULL
  UNION ALL
  -- IFCC mmol/mol = 10.929 * (NGSP % - 2.15)
  SELECT 'hba1c', '%', 'mol/mol', 0.010929D, -0.010929D * 2.15D
)
SELECT * FROM one_way
UNION ALL
SELECT analyte, to_base, from_base, 1 / slope, -intercept / slope FROM one_way;

-- 17c. Canonical-unit overrides, for tests whose name (concept name, or
--      source value for concept 0) matches test_pattern. 18d lists the
--      tests each rule hits. Everything else gets its most common unit.
CREATE OR REPLACE TABLE hive_metastore.ehr_union_clean_metrics.canonical_unit_rules AS
SELECT * FROM VALUES
  ('^(Body weight|PR Maternal Weight|NASH Weight, lbs)$', 'kg', 'the last two: no concept, mostly [lb_us]'),
  ('^Body height$',              'cm',        NULL),
  ('^Body temperature$',         'Cel',       NULL),
  ('^Hemoglobin A1c/Hemoglobin.total in Blood$', '%', NULL),
  ('^Protein .Mass/time. in 24 hour Urine$', 'mg/(24.h)', 'most common was mg/dL'),
  ('^Albumin .Mass/volume. in Urine$', 'mg/dL', 'the REDCap list\'s unit; most common was mg/L')
AS t(test_pattern, unit_code, note);

-- COMMAND ----------
-- ===== D1b. Corrections =====

-- 17d. Write unit_mapping's corrections (Part A, 1i) into the table: the
--      corrected unit into inferred_unit_concept_id and _source_value (0
--      and NULL where the correction leaves no unit), the code it replaced
--      into unit_corrected_from. Part D's columns are cleared on the
--      records changed; cell 20 fills them. Rerunnable: unit_correction_keys
--      corrects from unit_corrected_from, so a rerun matches the values
--      already written and changes nothing.
--      Then fills the correction rows' evidence in unit_mapping, now that
--      A-C have set every unit: n and tests (the numeric records each row
--      decided), median (their values, as recorded) and test_median (the
--      top test's records that arrived in the target unit). A correction
--      changes the label, not the value, so median and test_median are close
--      when it is right.
MERGE INTO hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized t
USING hive_metastore.ehr_union_clean_metrics.unit_correction_keys c
ON  c.data_partner_id <=> t.data_partner_id
AND c.test_id <=> CASE WHEN COALESCE(t.harmonized_measurement_concept_id, 0) = 0
                       THEN concat('src:', t.measurement_source_value)
                       ELSE CAST(t.harmonized_measurement_concept_id AS STRING)
                  END
AND c.from_code = COALESCE(t.unit_corrected_from, t.inferred_unit_source_value)
AND (t.unit_corrected_from IS NOT NULL OR COALESCE(t.inferred_unit_concept_id, 0) <> 0)
AND (t.unit_corrected_from IS NULL
     OR t.inferred_unit_concept_id IS DISTINCT FROM COALESCE(c.unit_concept_id, 0))
WHEN MATCHED THEN UPDATE SET
  t.inferred_unit_concept_id   = COALESCE(c.unit_concept_id, 0),
  t.inferred_unit_source_value = c.ucum_code,
  t.unit_corrected_from        = c.from_code,
  t.canonical_unit_concept_id  = NULL,
  t.canonical_unit_value       = NULL,
  t.unit_conversion_method     = NULL,
  t.value_plausibility         = NULL,
  t.harmonized_value_as_number = NULL;

UPDATE hive_metastore.ehr_union_clean_metrics.unit_mapping
SET n = NULL, tests = NULL, median = NULL, test_median = NULL
WHERE kind = 'correction';

MERGE INTO hive_metastore.ehr_union_clean_metrics.unit_mapping m
USING (
  WITH r AS (
    SELECT c.from_code AS unit_code, c.rule_test_pattern AS test_pattern,
           c.rule_data_partner_id AS data_partner_id,
           k.test_id, COALESCE(k.test_name, k.test_id, '(no test name)') AS test_name, k.value_as_number
    FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_keyed k
    JOIN hive_metastore.ehr_union_clean_metrics.unit_correction_keys c
      ON  c.data_partner_id <=> k.data_partner_id
      AND c.test_id <=> k.test_id
      AND c.from_code = k.correction_from_code
  ),
  per_test AS (
    SELECT unit_code, test_pattern, data_partner_id, test_id, test_name, COUNT(*) AS n
    FROM r GROUP BY 1, 2, 3, 4, 5
  ),
  ev AS (
    SELECT unit_code, test_pattern, data_partner_id, SUM(n) AS n,
           max_by(test_id, struct(n, test_name, test_id)) AS top_test_id,
           array_join(transform(slice(sort_array(collect_list(struct(n, test_name)), false), 1, 5),
                                x -> concat(x.test_name, ' (', CAST(x.n AS STRING), ')')), '; ') AS tests
    FROM per_test GROUP BY 1, 2, 3
  ),
  med AS (
    SELECT unit_code, test_pattern, data_partner_id, percentile_approx(value_as_number, 0.5) AS median
    FROM r GROUP BY 1, 2, 3
  ),
  tm AS (
    SELECT e.unit_code, e.test_pattern, e.data_partner_id,
           percentile_approx(k.value_as_number, 0.5) AS test_median
    FROM ev e
    JOIN hive_metastore.ehr_union_clean_metrics.unit_mapping um
      ON  um.kind = 'correction'
      AND um.unit_code = e.unit_code
      AND um.test_pattern <=> e.test_pattern
      AND um.data_partner_id <=> e.data_partner_id
    JOIN hive_metastore.ehr_union_clean_metrics.measurement_unit_keyed k
      ON  k.test_id = e.top_test_id
      AND k.effective_unit_code = um.ucum_code
      AND COALESCE(k.unit_concept_id, 0) <> 0
      AND k.correction_from_code IS NULL
    GROUP BY 1, 2, 3
  )
  SELECT e.unit_code, e.test_pattern, e.data_partner_id, e.n, e.tests, d.median, tm.test_median
  FROM ev e
  JOIN med d
    ON d.unit_code = e.unit_code AND d.test_pattern <=> e.test_pattern AND d.data_partner_id <=> e.data_partner_id
  LEFT JOIN tm
    ON tm.unit_code = e.unit_code AND tm.test_pattern <=> e.test_pattern AND tm.data_partner_id <=> e.data_partner_id
) s
ON  m.kind = 'correction'
AND m.unit_code = s.unit_code
AND m.test_pattern <=> s.test_pattern
AND m.data_partner_id <=> s.data_partner_id
WHEN MATCHED THEN UPDATE SET
  m.n = s.n, m.tests = s.tests, m.median = s.median, m.test_median = s.test_median;

-- COMMAND ----------
-- 17e. CHECK (should return no rows): bad or duplicate codes, duplicate bridges.
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
-- 17f. Review: every correction row (Part A, 1i), with the records it
--      decided (17d). ratio = median / test_median: near 1 when the
--      records look like the test's records already in the target unit.
--      maps_to rows are OMOP's Maps to for an arrived unit that isn't
--      standard UCUM; a wrong one gets a judgment row in 1g. Rows with no
--      n matched no numeric records.
SELECT unit_code, test_pattern, data_partner_id, decision, ucum_code, source, n, tests,
       median, test_median, round(median / NULLIF(test_median, 0), 2) AS ratio,
       rationale, candidates
FROM hive_metastore.ehr_union_clean_metrics.unit_mapping
WHERE kind = 'correction'
ORDER BY n DESC NULLS LAST, unit_code;


-- COMMAND ----------
-- ===== D2. Tests and their units =====

-- 18. Keyed view measurement_unit_keyed: created in Part A (cell 1j).

-- 18a. One row per (partner, test, effective unit)
CREATE OR REPLACE TABLE hive_metastore.ehr_union_clean_metrics.unit_test_units AS
SELECT data_partner_id, test_id, test_name,
       effective_unit_concept_id AS unit_concept_id, effective_unit_code AS unit_code,
       COUNT(*) AS n
FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_keyed
WHERE effective_unit_concept_id IS NOT NULL
GROUP BY data_partner_id, test_id, test_name, effective_unit_concept_id, effective_unit_code;

-- 18b. Analyte per test
CREATE OR REPLACE TABLE hive_metastore.ehr_union_clean_metrics.unit_test_analytes AS
SELECT t.test_id, min_by(a.analyte, a.priority) AS analyte
FROM (SELECT DISTINCT test_id, test_name
      FROM hive_metastore.ehr_union_clean_metrics.unit_test_units) t
JOIN hive_metastore.ehr_union_clean_metrics.unit_analytes a
  ON t.test_name RLIKE a.pattern
GROUP BY t.test_id;


-- COMMAND ----------
-- 18c. Review: analyte assignments, with each test's units.
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
-- 18d. Review: tests each canonical-unit rule hits. Each test should appear
--      once, under the rule you meant.
SELECT r.test_pattern, r.unit_code, t.test_name, SUM(t.n) AS n,
       COUNT(*) OVER (PARTITION BY t.test_id) AS n_rules_for_test
FROM hive_metastore.ehr_union_clean_metrics.canonical_unit_rules r
LEFT JOIN hive_metastore.ehr_union_clean_metrics.unit_test_units t
  ON t.test_name RLIKE r.test_pattern
GROUP BY r.test_pattern, r.unit_code, t.test_id, t.test_name
ORDER BY r.test_pattern, n DESC;


-- COMMAND ----------
-- ===== D3. Conversion decisions =====

-- 19. Decisions: one row per (partner, test, unit), the unit after
--     unit_mapping's corrections (17d). The canonical unit is per test,
--     chosen across partners.
CREATE OR REPLACE TABLE hive_metastore.ehr_union_clean_metrics.unit_conversion_decisions AS
WITH cls AS (
  -- equivalent codes (same base, slope, intercept) count as one unit
  SELECT r.test_id, r.unit_concept_id, r.unit_code, r.n,
         CASE WHEN f.base IS NULL THEN concat('code:', COALESCE(r.unit_code, CAST(r.unit_concept_id AS STRING)))
              ELSE concat_ws(':', f.base, CAST(f.slope AS STRING), CAST(f.intercept AS STRING))
         END AS class_key
  FROM hive_metastore.ehr_union_clean_metrics.unit_test_units r
  LEFT JOIN hive_metastore.ehr_union_clean_metrics.unit_factors f ON f.unit_code = r.unit_code
),
-- max_by keys include the code so ties in n resolve the same way every run
cls_n AS (
  SELECT test_id, class_key, SUM(n) AS n,
         max_by(unit_code, struct(n, unit_code, unit_concept_id)) AS top_code,
         max_by(unit_concept_id, struct(n, unit_code, unit_concept_id)) AS top_unit_concept_id
  FROM cls GROUP BY 1, 2
),
most_common AS (
  SELECT test_id, max_by(top_code, struct(n, top_code, top_unit_concept_id)) AS unit_code,
         max_by(top_unit_concept_id, struct(n, top_code, top_unit_concept_id)) AS unit_concept_id
  FROM cls_n GROUP BY 1
),
rule AS (
  SELECT t.test_id, max(r.unit_code) AS unit_code
  FROM (SELECT DISTINCT test_id, test_name
        FROM hive_metastore.ehr_union_clean_metrics.unit_test_units) t
  JOIN hive_metastore.ehr_union_clean_metrics.canonical_unit_rules r
    ON t.test_name RLIKE r.test_pattern
  GROUP BY t.test_id
),
canonical AS (
  SELECT m.test_id,
         COALESCE(r.unit_code, m.unit_code) AS canonical_unit_code,
         -- fall back to the data's own concept when the code isn't in UCUM
         COALESCE(ru.concept_id, CASE WHEN r.unit_code IS NULL THEN m.unit_concept_id END)
           AS canonical_unit_concept_id,
         CASE WHEN r.unit_code IS NOT NULL THEN 'rule' ELSE 'most_common' END AS canonical_source
  FROM most_common m
  LEFT JOIN rule r ON r.test_id = m.test_id
  LEFT JOIN hive_metastore.ehr_union_clean_metrics.ucum_units ru ON ru.concept_code = COALESCE(r.unit_code, m.unit_code)
),
pairs AS (
  SELECT r.*, a.analyte,
         c.canonical_unit_concept_id, c.canonical_unit_code, c.canonical_source,
         fu.base AS u_base, fu.slope AS u_slope, fu.intercept AS u_intercept,
         fk.base AS k_base, fk.slope AS k_slope, fk.intercept AS k_intercept,
         CASE WHEN fu.base = fk.base THEN 1D ELSE b.slope END     AS b_slope,
         CASE WHEN fu.base = fk.base THEN 0D ELSE b.intercept END AS b_intercept
  FROM hive_metastore.ehr_union_clean_metrics.unit_test_units r
  JOIN canonical c ON c.test_id = r.test_id
  LEFT JOIN hive_metastore.ehr_union_clean_metrics.unit_test_analytes a ON a.test_id = r.test_id
  LEFT JOIN hive_metastore.ehr_union_clean_metrics.unit_factors fu ON fu.unit_code = r.unit_code
  LEFT JOIN hive_metastore.ehr_union_clean_metrics.unit_factors fk ON fk.unit_code = c.canonical_unit_code
  LEFT JOIN hive_metastore.ehr_union_clean_metrics.unit_analyte_bridges b
    ON  b.analyte = a.analyte
    AND b.from_base = fu.base
    AND b.to_base = fk.base
)
-- unit -> base -> (bridge) -> canonical:
--   canonical = (b_slope * (u_slope * x + u_intercept) + b_intercept - k_intercept) / k_slope
SELECT data_partner_id, test_id, test_name, unit_concept_id, unit_code, n, analyte,
       canonical_unit_concept_id, canonical_unit_code, canonical_source,
       CASE WHEN unit_code = canonical_unit_code THEN 'identity'
            WHEN u_base = k_base                 THEN 'same_base'
            WHEN b_slope IS NOT NULL             THEN 'analyte_bridge'
            ELSE 'no_conversion'
       END AS conversion_method,
       CASE WHEN unit_code = canonical_unit_code THEN 1D
            ELSE b_slope * u_slope / k_slope
       END AS conversion_slope,
       CASE WHEN unit_code = canonical_unit_code THEN 0D
            ELSE (b_slope * u_intercept + b_intercept - k_intercept) / k_slope
       END AS conversion_intercept
FROM pairs;


-- COMMAND ----------
-- 19a. Review: summary
SELECT conversion_method, COUNT(*) AS n_groups, SUM(n) AS n_records
FROM hive_metastore.ehr_union_clean_metrics.unit_conversion_decisions
GROUP BY 1 ORDER BY n_records DESC;


-- COMMAND ----------
-- 19b. Review: canonical unit for every test that has more than one unit.
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
-- 19c. Medians per (partner, test, unit): median raw and converted value vs
--        the median of the test's records in the canonical unit (all
--        partners).
CREATE OR REPLACE TABLE hive_metastore.ehr_union_clean_metrics.unit_conversion_medians AS
WITH rec AS (
  SELECT d.*, k.value_as_number
  FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_keyed k
  JOIN hive_metastore.ehr_union_clean_metrics.unit_conversion_decisions d
    ON  d.data_partner_id = k.data_partner_id
    AND d.test_id = k.test_id
    AND d.unit_concept_id = k.effective_unit_concept_id
),
per_unit AS (
  SELECT data_partner_id, test_id, test_name, unit_code, canonical_unit_code,
         conversion_method, analyte, COUNT(*) AS n,
         percentile_approx(value_as_number, 0.5) AS median_raw,
         percentile_approx(conversion_slope * value_as_number + conversion_intercept, 0.5)
           AS median_converted
  FROM rec
  GROUP BY 1, 2, 3, 4, 5, 6, 7
),
canon AS (
  SELECT test_id, percentile_approx(value_as_number, 0.5) AS canonical_median
  FROM rec
  WHERE unit_code = canonical_unit_code
  GROUP BY 1
)
SELECT p.*, c.canonical_median,
       p.median_converted / NULLIF(c.canonical_median, 0) AS ratio
FROM per_unit p
LEFT JOIN canon c ON c.test_id = p.test_id
WHERE p.unit_code <> p.canonical_unit_code;


-- COMMAND ----------
-- 19d. Review: (partner, test, unit) with no conversion to the canonical unit.
--      Compare median_raw with canonical_median to judge what the unit really is.
SELECT test_name, data_partner_id, unit_code, n, median_raw, canonical_unit_code, canonical_median, analyte
FROM hive_metastore.ehr_union_clean_metrics.unit_conversion_medians
WHERE conversion_method = 'no_conversion'
ORDER BY n DESC;


-- COMMAND ----------
-- 19e. Review: do converted values look like canonical-unit values?
--      ratio far from 1 = wrong factor, wrong analyte, or the source unit
--      label is wrong (add a correction row, A 1g). Most extreme first.
SELECT test_name, data_partner_id, unit_code, canonical_unit_code, conversion_method, n,
       median_raw, median_converted, canonical_median, ratio
FROM hive_metastore.ehr_union_clean_metrics.unit_conversion_medians
WHERE conversion_method <> 'no_conversion' AND canonical_median IS NOT NULL
ORDER BY greatest(abs(ratio), abs(try_divide(1, ratio))) DESC NULLS FIRST;


-- COMMAND ----------
-- 19f. Review: tests whose canonical unit is a judgment call. A unit class is
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
-- ===== D3b. Plausibility limits =====

-- 19g. The REDCap list's limits (Part 0) for each test in our data, converted
--      from the list's unit to the test's canonical unit the same way 19
--      converts records (factors, then an analyte bridge if the bases
--      differ). list_* are the limits as 09 gives them.
CREATE OR REPLACE TABLE hive_metastore.ehr_union_clean_metrics.unit_plausibility_limits AS
WITH t AS (
  SELECT l.*, k.test_id, k.canonical_unit_code, a.analyte
  FROM hive_metastore.ehr_union_clean_metrics.redcap_list_tests l
  JOIN (SELECT DISTINCT test_id, canonical_unit_code
        FROM hive_metastore.ehr_union_clean_metrics.unit_conversion_decisions) k
    ON k.test_id = CAST(l.concept_id AS STRING)
  LEFT JOIN hive_metastore.ehr_union_clean_metrics.unit_test_analytes a ON a.test_id = k.test_id
  WHERE l.imp_lo IS NOT NULL
),
c AS (
  -- limit in the canonical unit = ca * limit + cb
  SELECT t.*,
         CASE WHEN t.list_unit_code = t.canonical_unit_code THEN 'identity'
              WHEN fl.base = fk.base                       THEN 'same_base'
              WHEN b.slope IS NOT NULL                     THEN 'analyte_bridge'
              ELSE 'no_conversion'
         END AS conversion_method,
         CASE WHEN t.list_unit_code = t.canonical_unit_code THEN 1D
              WHEN fl.base = fk.base THEN fl.slope / fk.slope
              ELSE b.slope * fl.slope / fk.slope
         END AS ca,
         CASE WHEN t.list_unit_code = t.canonical_unit_code THEN 0D
              WHEN fl.base = fk.base THEN (fl.intercept - fk.intercept) / fk.slope
              ELSE (b.slope * fl.intercept + b.intercept - fk.intercept) / fk.slope
         END AS cb
  FROM t
  LEFT JOIN hive_metastore.ehr_union_clean_metrics.unit_factors fl ON fl.unit_code = t.list_unit_code
  LEFT JOIN hive_metastore.ehr_union_clean_metrics.unit_factors fk ON fk.unit_code = t.canonical_unit_code
  LEFT JOIN hive_metastore.ehr_union_clean_metrics.unit_analyte_bridges b
    ON  b.analyte = t.analyte
    AND b.from_base = fl.base
    AND b.to_base = fk.base
)
SELECT test_id, concept_name AS test_name, limit_fields, list_unit_code, canonical_unit_code,
       analyte, conversion_method,
       imp_lo AS list_imp_lo, imp_hi AS list_imp_hi, ext_lo AS list_ext_lo, ext_hi AS list_ext_hi,
       ca * imp_lo + cb AS imp_lo, ca * imp_hi + cb AS imp_hi,
       ca * ext_lo + cb AS ext_lo, ca * ext_hi + cb AS ext_hi
FROM c;

-- 19h. CHECK (should return no rows): list tests in our data whose limits
--      can't be converted to the canonical unit. Fix with a factor (17) or
--      an analyte (17a).
SELECT test_name, list_unit_code, canonical_unit_code, analyte
FROM hive_metastore.ehr_union_clean_metrics.unit_plausibility_limits
WHERE conversion_method = 'no_conversion';


-- COMMAND ----------
-- 19i. Review: is a group's unit wrong? Groups (partner, test, unit) on a
--      list test whose median converted value is outside the plausible
--      limits. A few bad values don't move a median, so a group listed here
--      is almost certainly in another unit than its label (as one
--      partner's "[lb_us]" body weights are ounces). Fix with a correction
--      row (A 1g); nothing here changes the data. Groups with no
--      conversion are in 19d instead.
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
-- ===== D4. Apply conversion decisions =====

-- 20. Apply. Rerunnable. Keys are the same as in the view (18).
--     value_plausibility, for records on a list test with limits (19g):
--     implausible (outside imp), extreme (inside imp, outside ext) or
--     plausible. Empty for other tests and for records with no harmonized
--     value. It only flags: the unit and value stay as they are.
MERGE INTO hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized t
USING (
  SELECT d.*, l.imp_lo, l.imp_hi, l.ext_lo, l.ext_hi
  FROM hive_metastore.ehr_union_clean_metrics.unit_conversion_decisions d
  LEFT JOIN hive_metastore.ehr_union_clean_metrics.unit_plausibility_limits l
    ON l.test_id = d.test_id AND l.conversion_method <> 'no_conversion'
) d
ON  d.data_partner_id = t.data_partner_id
AND d.test_id = CASE WHEN COALESCE(t.harmonized_measurement_concept_id, 0) = 0
                     THEN concat('src:', t.measurement_source_value)
                     ELSE CAST(t.harmonized_measurement_concept_id AS STRING)
                END
AND d.unit_concept_id = NULLIF(t.inferred_unit_concept_id, 0)
AND t.value_as_number IS NOT NULL
AND COALESCE(t.unit_inference_method, '') <> 'suspect_concept'
WHEN MATCHED THEN UPDATE SET
  t.canonical_unit_concept_id  = CASE WHEN d.conversion_slope IS NOT NULL
                                      THEN d.canonical_unit_concept_id END,
  t.canonical_unit_value       = CASE WHEN d.conversion_slope IS NOT NULL
                                      THEN d.canonical_unit_code END,
  t.unit_conversion_method     = d.conversion_method,
  t.harmonized_value_as_number = d.conversion_slope * t.value_as_number + d.conversion_intercept,
  t.value_plausibility         =
    CASE WHEN d.imp_lo IS NULL OR d.conversion_slope IS NULL THEN NULL
         WHEN d.conversion_slope * t.value_as_number + d.conversion_intercept
              NOT BETWEEN d.imp_lo AND d.imp_hi THEN 'implausible'
         WHEN d.conversion_slope * t.value_as_number + d.conversion_intercept
              NOT BETWEEN d.ext_lo AND d.ext_hi THEN 'extreme'
         ELSE 'plausible'
    END;


-- COMMAND ----------
-- 20a. Review: numeric records by harmonization status
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
-- 20b. Review: stored body weights by test, partner and unit (run after 20).
--      kg_pct medians should all be near 80-90 kg. One partner's records
--      that arrived as [lb_us] are ounces (raw median 2,848): corrected to
--      [oz_av] (A 1g, D 17d). Another partner's stay [lb_us].
SELECT test_name, data_partner_id, effective_unit_code AS unit, unit_source_value,
       unit_inference_method, COUNT(*) AS n,
       percentile_approx(value_as_number, array(0.05, 0.5, 0.95)) AS raw_pct,
       percentile_approx(harmonized_value_as_number, array(0.05, 0.5, 0.95)) AS kg_pct
FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_keyed
WHERE test_name RLIKE '(?i)^body weight'
GROUP BY 1, 2, 3, 4, 5
ORDER BY 1, 2, n DESC;


-- COMMAND ----------
-- 20c. Review: people with "Body weight" records in both kg and [lb_us].
--      ratio = person's median converted lb record / median kg record.
--      Near 1: the lb records are fine and the gap is who gets weighed in
--      lb. Near 1.3 for everyone: the lb label or factor is wrong.
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
-- 20d. Review: the REDCap list against our data, one row per list concept
--      (Part 0), matched by the harmonized concept only (a list test recorded
--      under another concept isn't counted). Records by how they got their
--      unit, the canonical unit next to the list's, and value_plausibility
--      counts; limits are in the canonical unit. not_checked: numeric
--      records with no harmonized value (no unit, no conversion, suspect).
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
