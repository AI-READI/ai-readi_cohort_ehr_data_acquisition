-- Builds <your_schema>.meas_value_rescue_crosswalk (same content as meas_value_rescue_crosswalk.csv)
-- and validates it against the deployed vocabulary. Writes only to <your_schema>; replace it before running.
-- Regex literals use Spark SQL escaping ('\\s' in SQL = '\s' in the stored value).

CREATE OR REPLACE TABLE <your_schema>.meas_value_rescue_crosswalk AS
SELECT * FROM VALUES
  (1, 'observation', 4126842, 'Size of needle', '^\\s*\\d+\\s*gauge\\s*$', 42537416, 'Hemodialysis needle gauge', 'Measurement', 0, 'gauge', '^\\s*(\\d+)\\s*gauge', 105, '15-17G = dialysis fistula needles; no standard gauge unit (do not use 9312 [G])'),
  (2, 'observation', 4126840, 'Size of catheter', '^\\s*\\d+\\s*(Fr|French)\\s*$', 0, 'No matching concept', NULL, 9279, 'Fr', '^\\s*(\\d+)\\s*(Fr|French)', 485, 'Chest tube/drain French size; no standard size concept; 9279 = [Ch] charriere french'),
  (3, 'observation', 4126840, 'Size of catheter', '^\\s*Other:', 3018480, 'Type of Chest tube', 'Measurement', NULL, NULL, NULL, 70, 'Free-text tube type/location (PCT; MSCT; Blake); text goes to value_source_value'),
  (4, 'observation', 4118340, 'Traction weight applied', NULL, 0, 'No matching concept', NULL, NULL, NULL, NULL, 25, 'No standard Measurement/Observation equivalent'),
  (5, 'observation', 4128808, 'Number of oxygenators', NULL, 0, 'No matching concept', NULL, NULL, NULL, NULL, 1, 'No standard Measurement/Observation equivalent'),
  (6, 'device_exposure', 36310218, 'Pacemaker', NULL, 4030875, 'Cardiac pacemaker', 'Device', NULL, NULL, NULL, 7, 'Generic parent; subtype not determinable without UDI'),
  (7, 'device_exposure', 45876963, 'IUD', NULL, 40355609, 'Intrauterine contraceptive device', 'Device', NULL, NULL, NULL, 1, NULL),
  (8, 'device_exposure', 36310617, 'Mesh', NULL, 45768044, 'Surgical mesh', 'Device', NULL, NULL, NULL, 22, NULL),
  (9, 'device_exposure', 36309731, 'Lead', NULL, 4236068, 'Cardiac pacemaker lead', 'Device', NULL, NULL, NULL, 14, 'Generic parent; may be epicardial pacing wires (45762213) - confirm via UDI'),
  (10, 'device_exposure', 45880118, 'Bone', NULL, 0, 'No matching concept', NULL, NULL, NULL, NULL, 26, 'Ambiguous without UDI'),
  (11, 'device_exposure', 45877526, 'Graft', NULL, 0, 'No matching concept', NULL, NULL, NULL, NULL, 14, 'Ambiguous without UDI'),
  (12, 'device_exposure', 21498777, 'Lens', NULL, 0, 'No matching concept', NULL, NULL, NULL, NULL, 14, 'Ambiguous without UDI'),
  (13, 'device_exposure', 45881899, 'Breast', NULL, 0, 'No matching concept', NULL, NULL, NULL, NULL, 6, 'Ambiguous without UDI'),
  (14, 'device_exposure', 45883584, 'Patella', NULL, 0, 'No matching concept', NULL, NULL, NULL, NULL, 3, 'Ambiguous without UDI'),
  (15, 'device_exposure', 37079420, 'Nail', NULL, 0, 'No matching concept', NULL, NULL, NULL, NULL, 1, 'Ambiguous without UDI')
AS t(xwalk_id, source_table, source_concept_id, source_concept_name, value_regex,
       target_concept_id, target_concept_name, resolved_target_domain_id,
       target_unit_concept_id, target_unit_source_value, parse_number_regex, expected_rows, note);

-- Validation 1: every source concept is a valid Meas Value concept (expect 0 rows)
SELECT x.xwalk_id, x.source_concept_id, c.domain_id
FROM <your_schema>.meas_value_rescue_crosswalk x
LEFT JOIN omop_vocab.concept c ON c.concept_id = x.source_concept_id
WHERE c.concept_id IS NULL OR c.domain_id <> 'Meas Value';

-- Validation 2: every non-zero target is standard, valid, and its domain/name match the crosswalk (expect 0 rows)
SELECT x.xwalk_id, x.target_concept_id, c.domain_id, c.standard_concept, c.invalid_reason, c.concept_name
FROM <your_schema>.meas_value_rescue_crosswalk x
LEFT JOIN omop_vocab.concept c ON c.concept_id = x.target_concept_id
WHERE x.target_concept_id <> 0
  AND (c.concept_id IS NULL OR c.standard_concept <> 'S' OR c.invalid_reason IS NOT NULL
       OR c.domain_id <> x.resolved_target_domain_id OR c.concept_name <> x.target_concept_name);

-- Validation 3: target 0 has no resolved domain; non-zero target has one (expect 0 rows)
SELECT xwalk_id FROM <your_schema>.meas_value_rescue_crosswalk
WHERE (target_concept_id = 0) <> (resolved_target_domain_id IS NULL);

-- Validation 4: unit concepts are valid Unit-domain concepts (expect 0 rows)
SELECT x.xwalk_id, x.target_unit_concept_id, c.domain_id
FROM <your_schema>.meas_value_rescue_crosswalk x
LEFT JOIN omop_vocab.concept c ON c.concept_id = x.target_unit_concept_id
WHERE x.target_unit_concept_id IS NOT NULL AND x.target_unit_concept_id <> 0
  AND (c.concept_id IS NULL OR c.domain_id <> 'Unit');

-- Validation 5: regex rows for the same source concept must not overlap (check against the data;
-- expect 0 rows). Run per source table after the prepared step:
-- SELECT observation_id, COUNT(*) FROM obs_prepared p
-- JOIN <your_schema>.meas_value_rescue_crosswalk x
--   ON x.source_table='observation' AND x.source_concept_id=p.target_concept_id
--  AND (x.value_regex IS NULL OR p.value_as_string RLIKE x.value_regex)
-- GROUP BY 1 HAVING COUNT(*) > 1;

