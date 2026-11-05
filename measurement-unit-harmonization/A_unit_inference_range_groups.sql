-- Databricks notebook source
-- Unit inference for measurement_unit_harmonized
--
-- Import with File > Import; each COMMAND block becomes a cell. A cell with
-- several statements runs them in order; Databricks shows the result of the
-- LAST statement, which is the one to look at.
--
-- Run order: 0, A, B, C, D (files 0_ and A_ to D_). Part 0 loads the
-- AI-READI REDCap list that Part D checks values against.
-- PART A: numeric records with NO unit but a reference range.
-- PART B: records with a unit STRING but no unit concept.
-- PART C: numeric records with no unit and no reference range.
-- PART D: conversion to a canonical unit per test.
--
-- unit_inference_method values written:
--   Setup:  copied_from_unit_concept_id (record arrived with a unit concept)
--   Part A: dataset_unit, partner_unit, range_match, explicit, source_name,
--           no_ucum_unit, suspect_concept, needs_review, no_concept
--   Part B: mapped_string, no_ucum_unit, not_a_unit, unit_review, unmapped_string
--   Part D: inferred_unit_concept_id corrected by unit_mapping (17d), method
--           unchanged and unit_corrected_from set
--
-- Setup also fills harmonized_measurement_concept_id: the record's
-- measurement_concept_id, or its replacement where
-- measurement_concept_corrections says the concept is wrong. Parts A-D
-- group records by it; measurement_concept_id stays as it arrived.
--
-- Units: real UCUM codes where OMOP has one, including the dimensionless
-- ones (pH, {ratio}, {index}, [score], {fraction}, {MOM}, {ISR}, [OD'U]).
-- no_ucum_unit is left for what has no UCUM unit: specific gravity, counts,
-- Ct values, activity coefficients, RAST class.
--
-- canonical_unit_concept_id, canonical_unit_value, unit_conversion_method,
-- harmonized_value_as_number and value_plausibility are filled in Part D;
-- only no_ucum_unit records get harmonized_value_as_number here. Every apply
-- (A, B, C) clears the Part D columns on the records it writes, so a rerun
-- of any part needs a rerun of Part D after it.
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
--      inferred_unit_concept_id    the record's unit (UCUM concept); 0 for unit
--                                  text that maps to no unit (OMOP's convention)
--      inferred_unit_source_value  its UCUM code
--      canonical_unit_concept_id   the test's canonical unit, where
--                                  harmonized_value_as_number is in it
--      canonical_unit_value        its UCUM code
--      harmonized_value_as_number  value in the canonical unit (no_ucum_unit: value)
--      unit_conversion_method      how it was converted (Part D)
--      value_plausibility          the harmonized value against the AI-READI
--                                  REDCap list's limits (Part D, cell 20)
--      unit_corrected_from         the unit code a unit_mapping correction
--                                  replaced (Part D, cell 17d); NULL otherwise
DROP TABLE IF EXISTS hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized;
CREATE TABLE IF NOT EXISTS hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized AS
SELECT m.*,
       CAST(NULL AS BIGINT) AS harmonized_measurement_concept_id,
       CAST(NULL AS STRING) AS inferred_unit_source_value,
       CAST(NULL AS BIGINT) AS inferred_unit_concept_id,
       CAST(NULL AS STRING) AS canonical_unit_value,
       CAST(NULL AS BIGINT) AS canonical_unit_concept_id,
       CAST(NULL AS DOUBLE) AS harmonized_value_as_number,
       CAST(NULL AS STRING) AS unit_inference_method,
       CAST(NULL AS STRING) AS unit_conversion_method,
       CAST(NULL AS STRING) AS value_plausibility,
       CAST(NULL AS STRING) AS unit_corrected_from
FROM hive_metastore.ehr_union_clean.measurement m;

-- COMMAND ----------

-- 1b. Records that arrived with a unit concept: copy it into the inferred
--     columns so every record with a unit has them filled. Rerunnable.
--     Parts A-C pick only records without a unit concept, so they never
--     overwrite these. unit_corrected_from is cleared: D's 17d corrects
--     the copied unit again where unit_mapping says so.
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
  t.inferred_unit_source_value = d.concept_code,
  t.unit_corrected_from        = NULL;

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
   'Filed as HDL/total, but every value is above 1, so it is total/HDL, and values equal the same person\'s same-day total/HDL wherever those exist (F4a). Another partner files the same ratio under 3011163.')
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

-- 1f. ucum_units: standard, valid UCUM unit concepts, for looking up a
--     UCUM code (concept_code) written in a rule table. Only these are ever
--     assigned as a record's unit.
CREATE OR REPLACE VIEW hive_metastore.ehr_union_clean_metrics.ucum_units AS
SELECT concept_id, concept_code, concept_name
FROM omop_vocab.concept
WHERE vocabulary_id = 'UCUM' AND standard_concept = 'S' AND invalid_reason IS NULL;

-- COMMAND ----------

-- ===== A1b. What unit a record is in: judgment rows. Last result: check, should be empty =====

-- 1g. unit_judgments: the typed decisions about what unit a record is in.
--     unit_mapping (1i, 1l) merges them with the automatic sources (UCUM
--     code, OMOP "Maps to", REDCap lookup label, units records arrived
--     with). Every row needs a rationale that makes the mapping obvious.
--     text rows: unit text -> unit, for records with unit text and no unit
--       concept. Matched on the trimmed text, ignoring case, so one row
--       covers every case variant. decision: unit | no_ucum_unit (a
--       quantity UCUM has no unit for) | not_a_unit (junk).
--     correction rows: a unit code that is wrong for some records -> the
--       unit they are really in, on tests whose name matches test_pattern
--       (NULL = every test) and, if set, only for data_partner_id. A
--       partner rule wins over one with a pattern, and that over one with
--       neither. decision: unit | withheld (no unit makes the values fit;
--       the record gets no unit). Corrections apply to a record's unit
--       whatever set it: the unit it arrived with, a text row, or A's and
--       C's rules and copying. Rules based on a code's meaning apply to
--       every partner; rules based on medians only to the partners whose
--       medians showed it, so a new partner's records show up in D's
--       reviews instead.
--     target_code is the UCUM code assigned, as OMOP spells it (checked in 1h).
CREATE OR REPLACE TABLE hive_metastore.ehr_union_clean_metrics.unit_judgments AS
SELECT 'text' AS kind, unit_source_value, CAST(NULL AS STRING) AS unit_code,
       CAST(NULL AS STRING) AS test_pattern, CAST(NULL AS INT) AS data_partner_id,
       decision, target_code, rationale
FROM VALUES
  -- eGFR spellings
  ('mL/min/1.73m²',      'unit', 'mL/min/(173.10*-2.m2)', 'eGFR unit, mL/min per 1.73 m2'),
  ('mL/min/{1.73_m2}',   'unit', 'mL/min/(173.10*-2.m2)', 'eGFR unit, mL/min per 1.73 m2'),
  ('mL/min/1.73_m2',     'unit', 'mL/min/(173.10*-2.m2)', 'eGFR unit, mL/min per 1.73 m2'),
  ('mL/min/1.72m*2',     'unit', 'mL/min/(173.10*-2.m2)', 'typo for the eGFR unit mL/min/1.73m2'),
  ('mL/min/1.73,2',      'unit', 'mL/min/(173.10*-2.m2)', 'typo for the eGFR unit mL/min/1.73m2'),
  ('m/m/1.73',           'unit', 'mL/min/(173.10*-2.m2)', 'abbreviation of the eGFR unit mL/min/1.73m2'),
  ('mL/min/173m2',       'unit', 'mL/min/(173.10*-2.m2)', 'typo for the eGFR unit mL/min/1.73m2'),
  -- rates and times
  ('bpm',                'unit', '/min',      'beats per minute'),
  ('PBPM',               'unit', '/min',      'pulse beats per minute'),
  ('msec',               'unit', 'ms',        'abbreviation of millisecond'),
  ('minutes',            'unit', 'min',       'minutes'),
  ('days',               'unit', 'd',         'days'),
  ('weeks',              'unit', 'wk',        'weeks'),
  ('Month(s)',           'unit', 'mo',        'months'),
  ('yr',                 'unit', 'a',         'abbreviation of year; UCUM year is a'),
  ('years',              'unit', 'a',         'years; UCUM year is a'),
  -- flows and volumes
  ('mL/hr',              'unit', 'mL/h',      'spelling of mL/h'),
  ('L/sec',              'unit', 'L/s',       'spelling of L/s'),
  ('liter/min/m2',       'unit', 'L/min/m2',  'spelling of L/min/m2 (cardiac index)'),
  ('ml/min/mmHg',        'unit', 'mL/min/mm[Hg]', 'spelling of mL/min/mm[Hg] (DLCO)'),
  ('mL/beat',            'unit', 'mL/{hb}',   'mL per heartbeat (stroke volume); UCUM spells it mL/{hb}'),
  ('mL/24 hr',           'unit', 'mL/(24.h)', 'spelling of mL/(24.h)'),
  ('liters/day',         'unit', 'L/(24.h)',  'liters per day'),
  -- lengths, masses, speeds
  ('ft',                 'unit', '[ft_i]',    'abbreviation of foot; UCUM foot is [ft_i]'),
  ('cm/sec',             'unit', 'cm/s',      'spelling of cm/s'),
  ('[lb_av]',            'unit', '[lb_us]',   'avoirdupois pound; OMOP\'s pound concept is [lb_us]'),
  ('lbs',                'unit', '[lb_us]',   'abbreviation of pounds; OMOP\'s pound concept is [lb_us]'),
  -- angles, resistance, exercise
  ('degrees',            'unit', 'deg',       'degrees of angle (EKG axes)'),
  ('dynes-sec/cm5/m2',   'unit', 'dyn.s/cm5/m2', 'spelling of the SVR index unit'),
  ('METS',               'unit', '[MET]',     'metabolic equivalents'),
  -- temperature, pressure, electrical, radiation
  ('\'C',                'unit', 'Cel',       'degrees Celsius'),
  ('cmH2O',              'unit', 'cm[H2O]',   'spelling of cm[H2O]'),
  ('Ohms',               'unit', 'Ohm',       'plural of Ohm'),
  ('cGray',              'unit', 'cGy',       'centigray'),
  ('Gray',               'unit', 'Gy',        'gray'),
  ('Gy (RBE)',           'unit', 'Gy',        'RBE-weighted dose in gray'),
  ('ppm',                'unit', '[ppm]',     'parts per million; UCUM spells it [ppm]'),
  -- concentrations
  ('ATP ng/mL',          'unit', 'ng/mL',     'ng/mL with the analyte (ATP) in front'),
  ('ng/mL RBC',          'unit', 'ng/mL',     'ng/mL with the specimen (RBC) after'),
  ('mg/dL:',             'unit', 'mg/dL',     'mg/dL with a trailing colon'),
  ('mWq/L',              'unit', '10*-3.eq/L', 'typo for mEq/L'),
  ('mOsmol/kg',          'unit', 'mosm/kg',   'spelling of mosm/kg'),
  ('mOsm/K',             'unit', 'mosm/kg',   'mOsm/kg cut short'),
  ('mcg/mg',             'unit', 'ug/mg',     'mcg is microgram (ug)'),
  ('mcg/mL FEU',         'unit', 'ug{FEU}/mL', 'mcg is microgram; FEU as in ug{FEU}/mL (D-dimer)'),
  -- per creatinine
  ('ug/g creat',         'unit', 'ug/g{creat}', 'spelling of ug/g{creat}'),
  ('nmol{BCE}/mmol{creat}', 'unit', 'nmol{BColl}eq/mmol{creat}', 'bone collagen equivalents per creatinine; OMOP spells it nmol{BColl}eq/mmol{creat}'),
  ('nM BCE/mM Creat',    'unit', 'nmol{BColl}eq/mmol{creat}', 'nmol bone collagen equivalents per mmol creatinine'),
  ('mmol/g creat',       'unit', 'mmol/g{creat}', 'spelling of mmol/g{creat}'),
  ('umol/g CRT',         'unit', 'umol/g{creat}', 'CRT is creatinine; spelling of umol/g{creat}'),
  -- per 24 hours
  ('mg/24hr',            'unit', 'mg/(24.h)', 'spelling of mg/(24.h)'),
  ('ug/24 hr',           'unit', 'ug/(24.h)', 'spelling of ug/(24.h)'),
  ('mcg/24 h',           'unit', 'ug/(24.h)', 'mcg is microgram; spelling of ug/(24.h)'),
  ('mmol/24 hr',         'unit', 'mmol/(24.h)', 'spelling of mmol/(24.h)'),
  ('mmol/24 h',          'unit', 'mmol/(24.h)', 'spelling of mmol/(24.h)'),
  ('meq/24 hr',          'unit', '10*-3.eq/(24.h)', 'mEq per 24 hours'),
  ('meq/(24.h)',         'unit', '10*-3.eq/(24.h)', 'mEq per 24 hours'),
  ('meq/day',            'unit', '10*-3.eq/(24.h)', 'mEq per day'),
  ('g/24 hr',            'unit', 'g/(24.h)',  'spelling of g/(24.h)'),
  ('g/24hr',             'unit', 'g/(24.h)',  'spelling of g/(24.h)'),
  -- counts
  ('bil/L',              'unit', '10*9/L',    'billion per liter'),
  ('X 10E3/mm3',         'unit', '10*3/uL',   'thousand per mm3, which is per uL'),
  ('X 10E6/mm3',         'unit', '10*6/mm3',  'million per mm3'),
  ('M/mcl',              'unit', '10*6/uL',   'million per microliter'),
  ('Leu/uL',             'unit', '/uL',       'leukocytes per uL (urine)'),
  ('cell/uL',            'unit', '/uL',       'cells per uL'),
  ('million/mL',         'unit', '10*6/mL',   'million per mL'),
  ('mil sperm/mL',       'unit', '10*6/mL',   'million sperm per mL'),
  ('cp/mL',              'unit', '{copies}/mL', 'abbreviation of copies/mL'),
  ('{Log_copies}/mL',    'unit', 'lg({copies})/mL', 'log copies per mL; UCUM spells it lg({copies})/mL'),
  ('{Log_IU}/mL',        'unit', 'lg([iU])/mL', 'log international units per mL; UCUM spells it lg([iU])/mL'),
  -- percentages
  ('Unit%',              'unit', '%',         'percent (pulse oximetry)'),
  ('%PCV',               'unit', '%',         'percent packed cell volume (hematocrit)'),
  ('VOL%',               'unit', '%',         'volume percent'),
  ('% of CD19',          'unit', '%',         'percent, with what it is a percent of'),
  ('% Lymphs',           'unit', '%',         'percent, with what it is a percent of'),
  ('% fat',              'unit', '%',         'percent, with what it is a percent of'),
  ('% donor',            'unit', '%',         'percent, with what it is a percent of'),
  ('% normal',           'unit', '%',         'percent, with what it is a percent of'),
  ('% Inhibition',       'unit', '%',         'percent, with what it is a percent of'),
  -- international and arbitrary units
  ('k[IU]/L',            'unit', '10*3.[iU]/L', 'kilo international units per liter'),
  ('IU gamma IF/mL',     'unit', '[iU]/mL',   'international units of interferon gamma per mL (QuantiFERON)'),
  ('UI/L',               'unit', '[iU]/L',    'international units per liter, French word order'),
  ('UI/mL',              'unit', '[iU]/mL',   'international units per mL, French word order'),
  ('U',                  'unit', '[U]',       'arbitrary/enzyme unit; OMOP spells it [U]'),
  ('U/g{Hb}',            'unit', '[U]/g{HGB}', 'units per gram hemoglobin; OMOP spells it [U]/g{HGB}'),
  ('U/g Hgb',            'unit', '[U]/g{HGB}', 'units per gram hemoglobin'),
  ('GPL U/mL',           'unit', '[GPL\'U]/mL', 'IgG phospholipid units per mL'),
  ('MPL U/mL',           'unit', '[MPL\'U]/mL', 'IgM phospholipid units per mL'),
  ('APL U/mL',           'unit', '[APL\'U]/mL', 'IgA phospholipid units per mL'),
  ('APL',                'unit', '[APL\'U]',  'IgA phospholipid units (cardiolipin IgA)'),
  ('GPS',                'unit', '[GPS\'U]',  'IgG phosphatidylserine units'),
  ('MPS',                'unit', '[MPS\'U]',  'IgM phosphatidylserine units'),
  ('APS',                'unit', '[APS\'U]',  'IgA phosphatidylserine units'),
  ('E.U./dL',            'unit', '[EU]/dL',   'Ehrlich units per dL (urobilinogen)'),
  ('EU/dL (mg/dL)',      'unit', '[EU]/dL',   'Ehrlich units per dL (urobilinogen)'),
  ('{Ehrlich\'U}',       'unit', '[EU]/dL',   'Ehrlich units (urobilinogen, reported per dL)'),
  ('EHRLICH UNITS',      'unit', '[EU]/dL',   'Ehrlich units (urobilinogen, reported per dL)'),
  -- dimensionless units
  ('A/G Ratio',          'unit', '{ratio}',   'albumin/globulin ratio: a ratio'),
  ('S/CO',               'unit', '{signal}/[{CO\'ratio}]', 'signal to cutoff ratio'),
  ('{index_val}',        'unit', '{index}',   'an index value'),
  ('TSI Index',          'unit', '{index}',   'thyroid stimulating immunoglobulin index'),
  ('OD',                 'unit', '[OD\'U]',   'optical density'),
  -- no UCUM unit for the quantity
  ('ACTIVITY COEFF',     'no_ucum_unit', NULL, 'activity coefficient: dimensionless, and UCUM has no unit for it'),
  -- not a unit
  ('Urine',              'not_a_unit', NULL, 'a specimen, not a unit'),
  ('Possible',           'not_a_unit', NULL, 'a word, not a unit'),
  ('**Please',           'not_a_unit', NULL, 'the start of a comment, not a unit'),
  ('*Not Applicable',    'not_a_unit', NULL, 'a comment, not a unit'),
  ('No',                 'not_a_unit', NULL, 'a word, not a unit'),
  ('Normal',             'not_a_unit', NULL, 'a result, not a unit'),
  ('Performed',          'not_a_unit', NULL, 'a status, not a unit'),
  ('Corrected',          'not_a_unit', NULL, 'a status, not a unit'),
  ('calc',               'not_a_unit', NULL, 'says the value was calculated, not its unit'),
  ('Dose',               'not_a_unit', NULL, 'a word, not a unit'),
  ('PharmD',             'not_a_unit', NULL, 'a degree, not a unit'),
  ('MD',                 'not_a_unit', NULL, 'a degree, not a unit'),
  ('Dr',                 'not_a_unit', NULL, 'a title, not a unit'),
  ('TAC',                'not_a_unit', NULL, 'an abbreviation of a test, not a unit'),
  ('bands',              'not_a_unit', NULL, 'a cell type (band neutrophils), not a unit'),
  ('30.0-100.0',         'not_a_unit', NULL, 'a reference range in the unit field')
AS t(unit_source_value, decision, target_code, rationale)
UNION ALL
SELECT 'correction', NULL, unit_code, test_pattern, CAST(data_partner_id AS INT),
       decision, target_code, rationale
FROM VALUES
  -- mis-coded units: by the code's meaning, every partner
  ('S',        NULL,                  NULL, 'unit', 's',       'UCUM S is siemens; used for seconds'),
  ('H',        NULL,                  NULL, 'unit', 'h',       'UCUM H is henry; used for hours'),
  ('u',        NULL,                  NULL, 'unit', '[U]',     'UCUM u is atomic mass unit; used for [U] on an antibody test'),
  ('mm3',      NULL,                  NULL, 'unit', '/mm3',    'cubic millimeter on cell counts: per mm3'),
  ('[foz_us]', '(?i)weight',          NULL, 'unit', '[oz_av]', 'fluid ounce on a weight: avoirdupois ounce'),
  ('L',        '(?i)minute volume',   NULL, 'unit', 'L/min',   'minute volume is liters per minute'),
  ('l',        '(?i)minute volume',   NULL, 'unit', 'L/min',   'minute volume is liters per minute'),
  ('mL/(24.h)', '(?i)^volume',        NULL, 'unit', 'mL',      'a urine collection\'s volume, not a rate'),
  ('L/(24.h)', '(?i)^volume',         NULL, 'unit', 'L',       'a urine collection\'s volume, not a rate'),
  ('g/[dose]', '(?i)24 hour urine',   NULL, 'unit', 'g/(24.h)', 'per collection on a 24 hour urine test: per 24 hours'),
  ('{sgu}',    '(?i)^beta 2 glycoprotein 1 IgG', NULL, 'unit', '[GPI\'IgG\'U]', 'SGU is the IgG unit; every record is on the IgG test; OMOP maps it to the IgM unit'),
  ('{smu}',    '(?i)^beta 2 glycoprotein 1 IgM', NULL, 'unit', '[GPI\'IgM\'U]', 'SMU is the IgM unit; every record is on the IgM test; OMOP maps it to the IgG unit'),
  -- no unit makes the values fit: the records get no unit
  ('[U]/mL',   '(?i)^mycoplasma',     NULL, 'withheld', NULL,  'no unit makes the values fit'),
  ('ug/L',     '^Creatinine .Mass/volume. in Urine$', NULL, 'withheld', NULL, 'no unit makes the values fit'),
  -- values plainly in another unit, for the partners whose medians showed
  -- it; other partners' records in the unit are left as labeled
  ('[lb_us]',  '^Body weight$',       2084, 'unit', '[oz_av]', 'values fit body weights as ounces; another partner\'s lb records match its kg (20c)'),
  ('deg',      '(?i)temperature',     8469, 'unit', '[degF]',  'temperature values fit Fahrenheit'),
  ('m2',       '(?i)body mass index', 8469, 'unit', 'kg/m2',   'BMI values fit kg/m2'),
  ('mL/min',   '(?i)glomerular filtration|GFR', 2084, 'unit', 'mL/min/(173.10*-2.m2)', 'eGFR labeled mL/min; medians match eGFR in mL/min/1.73m2'),
  ('mL/min',   '(?i)glomerular filtration|GFR', 3058, 'unit', 'mL/min/(173.10*-2.m2)', 'eGFR labeled mL/min; medians match eGFR in mL/min/1.73m2'),
  ('%',        '(?i)^MCHC',           2084, 'unit', 'g/dL',    'MCHC values fit g/dL, not %'),
  ('mm[Hg]',   '(?i)oxygen saturation', 8469, 'unit', '%',     'pulse oximetry reports only %, so not PaO2'),
  ('10*3/uL',  '^Erythrocytes .#/volume. in Blood', 3058, 'unit', '10*6/uL', 'RBC values fit millions per uL'),
  ('kg',       '(?i)^tidal volume',   8469, 'unit', 'mL/kg',   'tidal volume values fit mL/kg'),
  ('mg/dL',    '^Carcinoembryonic Ag', 3058, 'unit', 'ng/mL',  'CEA values fit ng/mL'),
  ('nmol/mL',  '^Sex hormone binding globulin', 8469, 'unit', 'nmol/L', 'SHBG values fit nmol/L'),
  ('ug/dL',    '^Testosterone .Mass', 2084, 'unit', 'ng/mL',   'testosterone values fit ng/mL'),
  ('ng/dL',    '^Glucose$',           3058, 'unit', 'mg/dL',   'glucose values fit mg/dL'),
  ('mg/dL',    '^Albumin, External$', 3058, 'unit', 'g/dL',    'albumin values fit g/dL'),
  ('mg/dL',    '^Sodium, External$',  3058, 'unit', 'mmol/L',  'sodium values fit mmol/L'),
  ('mg/dL',    '^Cholesterol.total/Cholesterol in HDL', 3058, 'unit', '{ratio}', 'matches same-day total/HDL (F4b); corrected from 3023884')
AS t(unit_code, test_pattern, data_partner_id, decision, target_code, rationale);

-- 1h. Check (should return no rows): judgment rows that can't be used.
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

-- ===== A1c. unit_mapping: corrections, and the views that apply them. Last result: check, should be empty =====

-- 1i. unit_mapping: one row per decision about what unit a record is in.
--     This cell writes the correction rows; 1l adds the text rows.
--       kind              text | correction
--       unit_source_value text rows: the trimmed unit text (one row per
--                         spelling, so case variants are separate rows)
--       unit_code, test_pattern, data_partner_id
--                         correction rows: the key, as in unit_judgments
--       unit_concept_id, ucum_code
--                         the unit assigned (standard UCUM); NULL for none
--       decision          unit | no_ucum_unit | not_a_unit | withheld (a
--                         correction leaving no unit) | review (sources
--                         disagree: no unit until a judgment row settles
--                         it) | unmapped (no source)
--       source            ucum_code | maps_to | redcap_label |
--                         arrived_unit | judgment; NULL for review, unmapped
--       matched_by        text rows: exact | ignoring_case
--       rationale, candidates (every candidate as source:code)
--       n, tests, median, test_median
--                         evidence: record count, the tests (most records
--                         first), the records' median, and the median of the
--                         top test's records that arrived in the assigned
--                         unit. Filled for text rows in 1l, for correction
--                         rows in D (17d), once every part has set units.
--     Correction rows come from two sources:
--       maps_to   every unit concept records arrived with that isn't a
--                 standard, valid UCUM concept: OMOP's "Maps to" target if
--                 that is standard UCUM, else review (no unit).
--       judgment  unit_judgments' correction rows. One with no pattern or
--                 partner replaces the maps_to row for its code (which
--                 shows in candidates): a judgment may override the
--                 vocabulary, as for {sgu}/{smu}, whose Maps to are swapped.
CREATE OR REPLACE TABLE hive_metastore.ehr_union_clean_metrics.unit_mapping AS
WITH arrived AS (
  SELECT c.concept_id, c.concept_code, c.concept_name
  FROM (SELECT DISTINCT unit_concept_id
        FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized
        WHERE COALESCE(unit_concept_id, 0) <> 0) a
  JOIN omop_vocab.concept c ON c.concept_id = a.unit_concept_id
  LEFT ANTI JOIN hive_metastore.ehr_union_clean_metrics.ucum_units u ON u.concept_id = c.concept_id
),
maps_to AS (
  SELECT a.concept_code AS unit_code,
         array_join(sort_array(collect_set(concat(CAST(a.concept_id AS STRING), ' ', a.concept_name))), '; ')
           AS arrived_as,
         COUNT(DISTINCT u.concept_id) AS n_targets,
         min(u.concept_id) AS unit_concept_id,
         min(u.concept_code) AS ucum_code
  FROM arrived a
  LEFT JOIN omop_vocab.concept_relationship r
    ON  r.concept_id_1 = a.concept_id
    AND r.relationship_id = 'Maps to'
    AND r.invalid_reason IS NULL
  LEFT JOIN hive_metastore.ehr_union_clean_metrics.ucum_units u ON u.concept_id = r.concept_id_2
  GROUP BY a.concept_code
),
judged AS (
  SELECT j.*, u.concept_id AS unit_concept_id
  FROM hive_metastore.ehr_union_clean_metrics.unit_judgments j
  LEFT JOIN hive_metastore.ehr_union_clean_metrics.ucum_units u ON u.concept_code = j.target_code
  WHERE j.kind = 'correction'
)
SELECT 'correction' AS kind,
       CAST(NULL AS STRING) AS unit_source_value,
       COALESCE(j.unit_code, m.unit_code) AS unit_code,
       j.test_pattern,
       j.data_partner_id,
       CASE WHEN j.kind IS NOT NULL THEN j.unit_concept_id
            WHEN m.n_targets = 1    THEN m.unit_concept_id END AS unit_concept_id,
       CASE WHEN j.kind IS NOT NULL THEN j.target_code
            WHEN m.n_targets = 1    THEN m.ucum_code END AS ucum_code,
       CASE WHEN j.kind IS NOT NULL THEN j.decision
            WHEN m.n_targets = 1    THEN 'unit'
            ELSE 'review' END AS decision,
       CASE WHEN j.kind IS NOT NULL THEN 'judgment' ELSE 'maps_to' END AS source,
       CAST(NULL AS STRING) AS matched_by,
       CASE WHEN j.kind IS NOT NULL THEN j.rationale
            WHEN m.n_targets = 1 THEN concat('not standard UCUM (', m.arrived_as, '); OMOP maps it to ', m.ucum_code)
            WHEN m.n_targets = 0 THEN concat('not standard UCUM (', m.arrived_as, '); OMOP maps it to no standard UCUM unit')
            ELSE concat('not standard UCUM (', m.arrived_as, '); OMOP maps it to ',
                        CAST(m.n_targets AS STRING), ' standard UCUM units')
       END AS rationale,
       CASE WHEN m.unit_code IS NOT NULL
            THEN concat('maps_to:', COALESCE(CASE WHEN m.n_targets = 1 THEN m.ucum_code END, 'none'))
       END AS candidates,
       CAST(NULL AS BIGINT) AS n,
       CAST(NULL AS STRING) AS tests,
       CAST(NULL AS DOUBLE) AS median,
       CAST(NULL AS DOUBLE) AS test_median
FROM judged j
FULL OUTER JOIN maps_to m
  ON m.unit_code = j.unit_code AND j.test_pattern IS NULL AND j.data_partner_id IS NULL;

-- COMMAND ----------

-- 1j. Views. The views' columns are fixed when they are created (SELECT *
--     is expanded then), so rerun this cell whenever the table is
--     recreated or altered.
--     unit_correction_keys: one row per (partner, test, unit code) that a
--       correction row matches, with the unit it corrects to (NULL for
--       withheld and review). A partner rule wins over a pattern rule, and
--       that over a plain one. from_code is the code before correction:
--       unit_corrected_from once D (17d) has written the correction, else
--       the inferred unit's code. Correcting from the original code gives
--       the same result on every rerun. n_results > 1 means two equally
--       specific rules disagree (check 1k).
--     measurement_unit_named: every record, with names and codes added:
--       measurement_concept_name, harmonized_concept_name, test_id (the
--       harmonized concept, or 'src:' + measurement_source_value for
--       concept 0), test_name (its concept name or source value),
--       effective_unit_concept_id (the record's unit after correction:
--       inferred_unit_concept_id, 0 read as none, or what a correction row
--       makes of it), effective_unit_code, and correction_from_code (the
--       code a correction replaced; NULL when none applies). After D's
--       17d the effective unit equals NULLIF(inferred_unit_concept_id, 0)
--       (check E5).
--     measurement_unit_keyed: the numeric records in scope (not
--       suspect_concept) from measurement_unit_named. Parts C and D read
--       it; D's MERGE (cell 20) uses the same keys.
CREATE OR REPLACE VIEW hive_metastore.ehr_union_clean_metrics.unit_correction_keys AS
WITH k AS (
  SELECT DISTINCT t.data_partner_id,
         CASE WHEN COALESCE(t.harmonized_measurement_concept_id, 0) = 0
              THEN concat('src:', t.measurement_source_value)
              ELSE CAST(t.harmonized_measurement_concept_id AS STRING)
         END AS test_id,
         COALESCE(hc.concept_name, t.measurement_source_value) AS test_name,
         COALESCE(t.unit_corrected_from, t.inferred_unit_source_value) AS from_code
  FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized t
  LEFT JOIN omop_vocab.concept hc ON hc.concept_id = NULLIF(t.harmonized_measurement_concept_id, 0)
  WHERE t.unit_corrected_from IS NOT NULL OR COALESCE(t.inferred_unit_concept_id, 0) <> 0
),
m AS (
  SELECT k.*, c.unit_concept_id, c.ucum_code, c.decision,
         c.test_pattern, c.data_partner_id AS rule_data_partner_id,
         CASE WHEN c.data_partner_id IS NOT NULL THEN 0
              WHEN c.test_pattern IS NOT NULL    THEN 1
              ELSE 2 END AS tier
  FROM k
  JOIN hive_metastore.ehr_union_clean_metrics.unit_mapping c
    ON  c.kind = 'correction'
    AND c.unit_code = k.from_code
    AND (c.test_pattern IS NULL OR k.test_name RLIKE c.test_pattern)
    AND (c.data_partner_id IS NULL OR c.data_partner_id = k.data_partner_id)
),
best AS (
  SELECT *, struct(COALESCE(ucum_code, ''), COALESCE(test_pattern, ''),
                   COALESCE(rule_data_partner_id, -1)) AS pick,
         min(tier) OVER (PARTITION BY data_partner_id, test_id, from_code) AS best_tier
  FROM m
)
SELECT data_partner_id, test_id, test_name, from_code,
       min_by(unit_concept_id, pick)      AS unit_concept_id,
       min_by(ucum_code, pick)            AS ucum_code,
       min_by(decision, pick)             AS decision,
       min_by(test_pattern, pick)         AS rule_test_pattern,
       min_by(rule_data_partner_id, pick) AS rule_data_partner_id,
       COUNT(DISTINCT COALESCE(ucum_code, '')) AS n_results
FROM best
WHERE tier = best_tier
GROUP BY data_partner_id, test_id, test_name, from_code;

CREATE OR REPLACE VIEW hive_metastore.ehr_union_clean_metrics.measurement_unit_named AS
WITH r AS (
  SELECT t.*,
         mc.concept_name AS measurement_concept_name,
         hc.concept_name AS harmonized_concept_name,
         CASE WHEN COALESCE(t.harmonized_measurement_concept_id, 0) = 0
              THEN concat('src:', t.measurement_source_value)
              ELSE CAST(t.harmonized_measurement_concept_id AS STRING)
         END AS test_id,
         COALESCE(hc.concept_name, t.measurement_source_value) AS test_name
  FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized t
  LEFT JOIN omop_vocab.concept mc ON mc.concept_id = NULLIF(t.measurement_concept_id, 0)
  LEFT JOIN omop_vocab.concept hc ON hc.concept_id = NULLIF(t.harmonized_measurement_concept_id, 0)
),
c AS (
  SELECT r.*,
         CASE WHEN ck.from_code IS NOT NULL THEN ck.unit_concept_id
              ELSE NULLIF(r.inferred_unit_concept_id, 0)
         END AS effective_unit_concept_id,
         ck.from_code AS correction_from_code
  FROM r
  LEFT JOIN hive_metastore.ehr_union_clean_metrics.unit_correction_keys ck
    ON  ck.data_partner_id <=> r.data_partner_id
    AND ck.test_id <=> r.test_id
    AND ck.from_code = COALESCE(r.unit_corrected_from, r.inferred_unit_source_value)
    AND (r.unit_corrected_from IS NOT NULL OR COALESCE(r.inferred_unit_concept_id, 0) <> 0)
)
SELECT c.*, eu.concept_code AS effective_unit_code
FROM c
LEFT JOIN omop_vocab.concept eu ON eu.concept_id = c.effective_unit_concept_id;

CREATE OR REPLACE VIEW hive_metastore.ehr_union_clean_metrics.measurement_unit_keyed AS
SELECT *
FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_named
WHERE value_as_number IS NOT NULL
  AND COALESCE(unit_inference_method, '') <> 'suspect_concept';

-- 1k. Check (should return no rows): correction rows that clash.
--     duplicate key: two rows for one (unit code, pattern, partner).
--     tie: two equally specific rows match the same records and disagree.
--     maps_to row on a standard UCUM code: keyed by code, it would correct
--       every record in that standard unit, not just the non-standard one.
--     chain: records a row corrects into a code that another row would
--       correct again (only one correction is applied; write one row
--       straight to the final unit instead).
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

-- ===== A1d. unit_mapping: text rows. Last result: check, should be empty =====

-- 1l. Text rows: one per trimmed unit text on numeric records with no unit
--     concept (Part B's records; B applies them in cell 12).
--     unit_text_candidates: every automatic candidate for each text, with
--     cand_key, the spelling it matched (exact = same case):
--       ucum_code     the text is a standard UCUM code
--       redcap_label  the text is a unit label in the REDCap unit lookup
--                     (Part 0) whose concept is standard UCUM
--       arrived_unit  records with this text arrived with a unit concept,
--                     read after the corrections that apply to every test
--                     and partner (text sec on clotting times counts as s,
--                     not S). Per-test and per-partner corrections are left
--                     out: they apply to Part B's records too, in D's 17d,
--                     so text mL/min stays mL/min although one partner's
--                     eGFR records in mL/min are corrected. detail is
--                     their record count
--       maps_to       the text is a non-standard UCUM code that OMOP maps
--                     to a standard UCUM unit
--     A text's decision, in this order:
--       1. exact candidates give two units                -> review
--       2. a judgment row matches (ignoring case): it wins unless an exact
--          candidate other than maps_to gives another unit -> review.
--          (A judgment may override the vocabulary, not the data.)
--       3. exact candidates give one unit                  -> that unit
--       4. candidates ignoring case give one unit          -> that unit;
--          more than one (s vs S, h vs H)                  -> review
--       5. no candidate                                    -> unmapped
--     So text that is exactly a UCUM code never goes to review over a
--     case variant (s stays seconds although S is siemens).
CREATE OR REPLACE TABLE hive_metastore.ehr_union_clean_metrics.unit_text_candidates AS
WITH txt AS (
  SELECT DISTINCT trim(unit_source_value) AS t
  FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized
  WHERE value_as_number IS NOT NULL
    AND unit_source_value IS NOT NULL
    AND COALESCE(unit_concept_id, 0) = 0
),
auto AS (
  SELECT concept_code AS cand_key, 'ucum_code' AS source, 1 AS source_rank,
         concept_id AS unit_concept_id, CAST(NULL AS STRING) AS detail
  FROM hive_metastore.ehr_union_clean_metrics.ucum_units
  UNION ALL
  SELECT trim(l.unit_source_value), 'redcap_label', 2, u.concept_id,
         array_join(sort_array(collect_set(l.lookup_key)), ', ')
  FROM hive_metastore.ehr_union_clean_metrics.redcap_unit_lookup l
  JOIN hive_metastore.ehr_union_clean_metrics.ucum_units u
    ON u.concept_id = try_cast(l.unit_concept_id AS BIGINT)
  WHERE l.unit_source_value IS NOT NULL
  GROUP BY trim(l.unit_source_value), u.concept_id
  UNION ALL
  SELECT trim(n.unit_source_value), 'arrived_unit', 3,
         CASE WHEN c.unit_code IS NOT NULL THEN c.unit_concept_id ELSE n.unit_concept_id END,
         CAST(COUNT(*) AS STRING)
  FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized n
  LEFT JOIN hive_metastore.ehr_union_clean_metrics.unit_mapping c
    ON  c.kind = 'correction'
    AND c.test_pattern IS NULL
    AND c.data_partner_id IS NULL
    AND c.unit_code = COALESCE(n.unit_corrected_from, n.inferred_unit_source_value)
  JOIN hive_metastore.ehr_union_clean_metrics.ucum_units u
    ON u.concept_id = CASE WHEN c.unit_code IS NOT NULL THEN c.unit_concept_id ELSE n.unit_concept_id END
  WHERE COALESCE(n.unit_concept_id, 0) <> 0
    AND n.unit_source_value IS NOT NULL
  GROUP BY trim(n.unit_source_value),
           CASE WHEN c.unit_code IS NOT NULL THEN c.unit_concept_id ELSE n.unit_concept_id END
  UNION ALL
  SELECT c.concept_code, 'maps_to', 4, u.concept_id, CAST(c.concept_id AS STRING)
  FROM omop_vocab.concept c
  JOIN omop_vocab.concept_relationship r
    ON  r.concept_id_1 = c.concept_id
    AND r.relationship_id = 'Maps to'
    AND r.invalid_reason IS NULL
  JOIN hive_metastore.ehr_union_clean_metrics.ucum_units u ON u.concept_id = r.concept_id_2
  LEFT ANTI JOIN hive_metastore.ehr_union_clean_metrics.ucum_units s ON s.concept_id = c.concept_id
  WHERE c.vocabulary_id = 'UCUM'
)
SELECT x.t, a.source, a.source_rank, a.unit_concept_id, u.concept_code AS ucum_code,
       a.cand_key, a.cand_key = x.t AS exact, a.detail
FROM txt x
JOIN auto a ON lower(a.cand_key) = lower(x.t)
JOIN hive_metastore.ehr_union_clean_metrics.ucum_units u ON u.concept_id = a.unit_concept_id;

-- Rerunnable: the text rows are replaced, the correction rows kept.
DELETE FROM hive_metastore.ehr_union_clean_metrics.unit_mapping WHERE kind = 'text';

INSERT INTO hive_metastore.ehr_union_clean_metrics.unit_mapping
WITH txt AS (
  SELECT trim(unit_source_value) AS t, test_id, test_name, value_as_number
  FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_named
  WHERE value_as_number IS NOT NULL
    AND unit_source_value IS NOT NULL
    AND COALESCE(unit_concept_id, 0) = 0
),
per_test AS (
  SELECT t, test_id, COALESCE(test_name, test_id, '(no test name)') AS test_name, COUNT(*) AS n
  FROM txt GROUP BY 1, 2, 3
),
ev AS (
  SELECT t, SUM(n) AS n,
         max_by(test_id, struct(n, test_name, test_id)) AS top_test_id,
         array_join(transform(slice(sort_array(collect_list(struct(n, test_name)), false), 1, 5),
                              x -> concat(x.test_name, ' (', CAST(x.n AS STRING), ')')), '; ') AS tests
  FROM per_test GROUP BY t
),
med AS (
  SELECT t, percentile_approx(value_as_number, 0.5) AS median FROM txt GROUP BY t
),
jd AS (
  -- 1h allows one judgment text row per spelling ignoring case
  SELECT e.t, j.unit_source_value AS j_key, j.decision AS j_decision, j.target_code AS j_code,
         u.concept_id AS j_unit, j.rationale AS j_rationale
  FROM ev e
  JOIN hive_metastore.ehr_union_clean_metrics.unit_judgments j
    ON j.kind = 'text' AND lower(j.unit_source_value) = lower(e.t)
  LEFT JOIN hive_metastore.ehr_union_clean_metrics.ucum_units u ON u.concept_code = j.target_code
),
s AS (
  SELECT e.t,
         COUNT(DISTINCT CASE WHEN c.exact THEN c.unit_concept_id END) AS n_exact_units,
         min(CASE WHEN c.exact THEN c.unit_concept_id END) AS exact_unit,
         COUNT(DISTINCT c.unit_concept_id) AS n_any_units,
         min(c.unit_concept_id) AS any_unit,
         -- exact candidates, other than maps_to, that contradict the judgment
         COUNT_IF(c.exact AND c.source <> 'maps_to' AND jd.t IS NOT NULL
                  AND c.unit_concept_id IS DISTINCT FROM jd.j_unit) AS n_contradicting,
         COUNT_IF(c.exact AND c.source = 'ucum_code') AS n_exact_ucum,
         COUNT_IF(c.exact AND c.unit_concept_id = jd.j_unit) AS n_exact_judged,
         min_by(named_struct('source', c.source, 'detail', c.detail, 'cand_key', c.cand_key,
                             'ucum_code', c.ucum_code),
                struct(NOT c.exact, c.source_rank, c.cand_key)) AS best,
         array_join(sort_array(collect_list(
           concat(c.source, ':', c.ucum_code,
                  CASE WHEN c.exact THEN '' ELSE concat(' (as ', c.cand_key, ')') END))), ', ')
           AS auto_candidates
  FROM ev e
  LEFT JOIN hive_metastore.ehr_union_clean_metrics.unit_text_candidates c ON c.t = e.t
  LEFT JOIN jd ON jd.t = e.t
  GROUP BY e.t
),
s2 AS (
  -- Exact sources disagree and a judgment row picks one of their units (text
  -- bpm: /min and {counts}/min). Text that is itself a UCUM code stays in
  -- review, so a judgment can't overrule text S.
  SELECT s.*, s.n_exact_units > 1 AND s.n_exact_ucum = 0 AND s.n_exact_judged > 0
                AS judgment_picks
  FROM s
),
d AS (
  SELECT s.*, jd.j_key, jd.j_decision, jd.j_code, jd.j_unit, jd.j_rationale,
         CASE WHEN s.judgment_picks                             THEN 'judgment'
              WHEN s.n_exact_units > 1                          THEN 'review'
              WHEN jd.t IS NOT NULL AND s.n_contradicting = 0   THEN 'judgment'
              WHEN jd.t IS NOT NULL                             THEN 'review'
              WHEN s.n_exact_units = 1                          THEN 'exact'
              WHEN s.n_any_units = 1                            THEN 'ignoring_case'
              WHEN s.n_any_units > 1                            THEN 'review'
              ELSE 'unmapped'
         END AS rule,
         CASE WHEN s.judgment_picks    THEN NULL
              WHEN s.n_exact_units > 1 THEN 'sources disagree'
              WHEN jd.t IS NOT NULL AND s.n_contradicting > 0
                THEN concat('judgment (', COALESCE(jd.j_code, jd.j_decision),
                            ') contradicted by an automatic source')
              WHEN s.n_exact_units = 0 AND s.n_any_units > 1
                THEN 'case variants match different units'
         END AS review_reason
  FROM s2 s
  LEFT JOIN jd ON jd.t = s.t
),
f AS (
  SELECT d.*, e.n, e.tests, e.top_test_id, m.median,
         CASE d.rule WHEN 'judgment'      THEN d.j_unit
                     WHEN 'exact'         THEN d.exact_unit
                     WHEN 'ignoring_case' THEN d.any_unit
         END AS unit_concept_id
  FROM d
  JOIN ev e  ON e.t = d.t
  JOIN med m ON m.t = d.t
),
tm AS (
  -- median of the top test's records that arrived in the assigned unit
  SELECT f.t, percentile_approx(k.value_as_number, 0.5) AS test_median
  FROM f
  JOIN hive_metastore.ehr_union_clean_metrics.measurement_unit_keyed k
    ON  k.test_id = f.top_test_id
    AND k.effective_unit_concept_id = f.unit_concept_id
    AND COALESCE(k.unit_concept_id, 0) <> 0
  GROUP BY f.t
)
SELECT 'text' AS kind,
       f.t AS unit_source_value,
       CAST(NULL AS STRING) AS unit_code,
       CAST(NULL AS STRING) AS test_pattern,
       CAST(NULL AS INT) AS data_partner_id,
       f.unit_concept_id,
       u.concept_code AS ucum_code,
       CASE f.rule WHEN 'judgment' THEN f.j_decision
                   WHEN 'review'   THEN 'review'
                   WHEN 'unmapped' THEN 'unmapped'
                   ELSE 'unit'
       END AS decision,
       CASE f.rule WHEN 'judgment'      THEN 'judgment'
                   WHEN 'exact'         THEN f.best.source
                   WHEN 'ignoring_case' THEN f.best.source
       END AS source,
       CASE WHEN f.rule = 'judgment'
              THEN CASE WHEN f.j_key = f.t THEN 'exact' ELSE 'ignoring_case' END
            WHEN f.rule = 'ignoring_case'
              OR f.review_reason = 'case variants match different units' THEN 'ignoring_case'
            WHEN f.rule IN ('exact', 'review') THEN 'exact'
       END AS matched_by,
       CASE f.rule
         WHEN 'judgment' THEN concat(CASE WHEN f.j_key <> f.t THEN concat('as ', f.j_key, ': ') ELSE '' END,
                                     f.j_rationale)
         WHEN 'review'   THEN f.review_reason
         WHEN 'unmapped' THEN 'no source'
         ELSE concat(CASE WHEN f.rule = 'ignoring_case' THEN concat('as ', f.best.cand_key, ': ') ELSE '' END,
                     CASE f.best.source
                       WHEN 'ucum_code'    THEN 'is the UCUM code'
                       WHEN 'redcap_label' THEN concat('REDCap lookup label for ', f.best.detail)
                       WHEN 'arrived_unit' THEN concat('records with this text arrived in ', f.best.ucum_code,
                                                       ' (', f.best.detail, ' records)')
                       WHEN 'maps_to'      THEN concat('not standard UCUM; OMOP maps it to ', f.best.ucum_code)
                     END)
       END AS rationale,
       NULLIF(concat_ws(', ', NULLIF(f.auto_candidates, ''),
                        CASE WHEN f.j_key IS NOT NULL
                             THEN concat('judgment:', COALESCE(f.j_code, f.j_decision)) END), '')
         AS candidates,
       f.n, f.tests, f.median, tm.test_median
FROM f
LEFT JOIN tm ON tm.t = f.t
LEFT JOIN hive_metastore.ehr_union_clean_metrics.ucum_units u ON u.concept_id = f.unit_concept_id;

-- 1m. Check (should return no rows):
--     text key twice; a unit that isn't standard UCUM; a decision and unit
--     that disagree; text that is exactly a UCUM code but was decided by
--     ignoring case, or got another unit; numeric records with unit text
--     and no unit concept that have no text row (trimming must match).
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

-- 1n. Review: every review row, with its candidates. These records get no
--     unit until settled. A judgment row (1g) settles text with no exact
--     match whose case variants disagree, and exact sources that disagree
--     when it picks one of their units, unless the text is itself a UCUM
--     code. Otherwise the data has to agree first: a correction row for the
--     arrived units that are wrong. A review correction row is
--     an arrived unit OMOP maps to no standard UCUM unit, or to several;
--     a judgment correction row settles it.
SELECT kind, COALESCE(unit_source_value, unit_code) AS unit_text_or_code,
       rationale, candidates, n, tests, median, test_median
FROM hive_metastore.ehr_union_clean_metrics.unit_mapping
WHERE decision = 'review'
ORDER BY n DESC NULLS LAST, unit_text_or_code;

-- COMMAND ----------

-- 1o. Review: judgment rows an automatic source already covers with the
--     same unit; they can be deleted from 1g. A text judgment row covers
--     every case variant of its spelling, so delete it only if all its
--     spellings are listed. Correction rows: the judgment matches OMOP's
--     Maps to for the code.
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

-- 1p. Review: text decided by ignoring case (no exact match), or sent to
--     review because its case variants disagree. Look for case that
--     changes the meaning (s/S, h/H, mU/MU).
SELECT unit_source_value, decision, ucum_code, source, rationale, candidates, n, tests,
       median, test_median
FROM hive_metastore.ehr_union_clean_metrics.unit_mapping
WHERE kind = 'text' AND matched_by = 'ignoring_case'
ORDER BY decision, n DESC;

-- COMMAND ----------

-- ===== A2. Rules, working views and decisions. Last result: check, should be empty =====

-- 2. Hand rules by concept (the harmonized concept, cell 1d).
--    no_ucum_unit    : no unit expected and no UCUM unit for it (specific gravity)
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
  -- specific gravity (one partner labels some as g/mL; SG is dimensionless)
  (3029991,  'no_ucum_unit', NULL, 'Specific gravity of Urine by Refractometry automated'),
  (3033543,  'no_ucum_unit', NULL, 'Specific gravity of Urine'),
  (3000330,  'no_ucum_unit', NULL, 'Specific gravity of Urine by Test strip'),
  (3039919,  'no_ucum_unit', NULL, 'Specific gravity of Urine by Automated test strip'),
  (3019150,  'no_ucum_unit', NULL, 'Specific gravity of Urine by Refractometry'),
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
  (3011163,  'explicit', '{ratio}', 'Total/HDL cholesterol ratio, including the records corrected from 3023884 (cell 1d); set here so labeled mg/dL records are not copied'),
  -- indexes, fractions, scores
  (3032612,  'explicit', '{index}',    'Calcium oxalate index, 24h urine'),
  (3031809,  'explicit', '{fraction}', 'Calcium hydrogen phosphate saturation fraction'),
  (3000551,  'explicit', '{index}',    'T4 free index'),
  (21492175, 'explicit', '[score]',    'AlloMap score'),
  -- suspect concept mappings
  (3037816,  'suspect_concept', NULL, 'CD4+CD8+ cells/cells: range 0.8-4.2 and values look like a CD4/CD8 ratio'),
  (3046867,  'suspect_concept', NULL, 'Alpha 1 antitrypsin phenotype [Interpretation]: holds values and ranges of an IgA result'),
  (3016991,  'suspect_concept', NULL, 'Thyroxine (T4) total: ranges and values are those of free T4 in ng/dL'),
  -- explicit units
  (3045462,  'explicit', 'mg/mg{creat}', 'Protein/Creatinine [Ratio]: range_high 0.2 implies mg/mg'),
  (3034485,  'explicit', 'mg/g{creat}',  'Albumin/Creatinine: values fit mg/g; in mg/mmol they would be implausible'),
  (3034426,  'explicit', 's',            'Prothrombin time: range 9.2-12.1 is seconds'),
  (3000034,  'explicit', 'mg/L',         'Microalbumin [Mass/volume] in Urine: range 5-20 fits mg/L'),
  (3043722,  'explicit', '/[LPF]',       'Hyaline casts [#/area]: per low power field')
AS t(measurement_concept_id, rule, unit_code, note);

-- 3a. Numeric source records. labeled_unit_concept_id: for records that
--     arrived with a unit concept, that unit after unit_mapping's
--     corrections (1j), so evidence is in the corrected unit (seconds, not
--     siemens); NULL when a correction leaves no unit.
CREATE OR REPLACE TEMP VIEW src AS
SELECT data_partner_id, harmonized_measurement_concept_id, range_low, range_high,
       unit_concept_id, unit_source_value, value_as_number,
       CASE WHEN COALESCE(unit_concept_id, 0) <> 0 THEN effective_unit_concept_id END
         AS labeled_unit_concept_id
FROM hive_metastore.ehr_union_clean_metrics.measurement_unit_named
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
--     '**Please' with no concept are ignored. unit_concept_id here is the
--     corrected unit.
CREATE OR REPLACE TEMP VIEW lab AS
SELECT s.data_partner_id, s.harmonized_measurement_concept_id, s.range_low, s.range_high,
       s.labeled_unit_concept_id AS unit_concept_id, s.unit_source_value, s.value_as_number
FROM src s
WHERE s.labeled_unit_concept_id IS NOT NULL
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
    WHEN r.rule = 'no_ucum_unit'                     THEN 'no_ucum_unit'
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
LEFT JOIN hive_metastore.ehr_union_clean_metrics.ucum_units ru ON ru.concept_code = r.unit_code
LEFT JOIN omop_vocab.concept cn
  ON cn.concept_id = u.harmonized_measurement_concept_id;

-- 4b. Check: explicit rules whose UCUM code didn't resolve to a concept.
--     Should return no rows; fix the code in cell 2 if it does.
SELECT r.*
FROM hive_metastore.ehr_union_clean_metrics.unit_concept_rules r
LEFT JOIN hive_metastore.ehr_union_clean_metrics.ucum_units ru ON ru.concept_code = r.unit_code
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
  t.unit_corrected_from        = NULL,
  t.canonical_unit_concept_id  = NULL,
  t.canonical_unit_value       = NULL,
  t.unit_conversion_method     = NULL,
  t.value_plausibility         = NULL,
  t.harmonized_value_as_number = CASE WHEN d.unit_inference_method = 'no_ucum_unit'
                                      THEN t.value_as_number END;

-- COMMAND ----------

-- ===== A6. No-concept records: rules. Last result: check, should be empty =====

-- 7. Records with no concept (harmonized_measurement_concept_id = 0): the
--    unit for each source test name, matched exactly against
--    lower(trim(measurement_source_value)). Exact names, not patterns:
--    nothing checks these units against the values, so a new name (say
--    "Hemoglobin A1c, External") has to show up as no_concept in 8b, not
--    quietly inherit hemoglobin's g/dL. Part C (step 4) uses the same list.
--    Every name here is one partner's, and each was checked against its
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
  -- no_ucum_unit: no UCUM unit
  ('specific gravity, urine',         'no_ucum_unit',    NULL),
  ('specific gravity, urn',           'no_ucum_unit',    NULL),
  ('specific gravity, urn, externa',  'no_ucum_unit',    NULL),
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
  ('osmolality, urn',                 'source_name', 'mosm/kg'),
  ('gfr, calc, african american',     'source_name', 'mL/min/(173.10*-2.m2)')
AS t(source_name, rule, unit_code);

-- 7b. Check: unit codes that don't resolve to a UCUM concept.
--     Should return no rows; fix the code in cell 7 if it does.
SELECT r.*
FROM hive_metastore.ehr_union_clean_metrics.unit_source_name_rules r
LEFT JOIN hive_metastore.ehr_union_clean_metrics.ucum_units ru ON ru.concept_code = r.unit_code
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
LEFT JOIN hive_metastore.ehr_union_clean_metrics.ucum_units ru ON ru.concept_code = m.unit_code;

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
  t.unit_corrected_from        = NULL,
  t.canonical_unit_concept_id  = NULL,
  t.canonical_unit_value       = NULL,
  t.unit_conversion_method     = NULL,
  t.value_plausibility         = NULL,
  t.harmonized_value_as_number = CASE WHEN d.unit_inference_method = 'no_ucum_unit'
                                      THEN t.value_as_number END;
