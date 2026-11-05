-- Meas Value rescue: runs AFTER the prepared step ('Maps to' -> target_concept_id, target_domain_id)
-- and BEFORE domain routing. Read-only SELECT over the prepared output; materialize as your pipeline does.
-- Shown for OBSERVATION; repeat per table (see the TABLE PARAMETERS note in the README).

CREATE OR REPLACE TEMP VIEW observation_prepared_rescued AS
SELECT
  p.* EXCEPT (target_concept_id, target_domain_id),
  CASE WHEN p.target_domain_id = 'Meas Value'
       THEN COALESCE(x.target_concept_id, 0)
       ELSE p.target_concept_id END                          AS target_concept_id,
  CASE WHEN p.target_domain_id = 'Meas Value'
       THEN f.domain_id                                      -- NULL when rescued to 0 => stay in source table
       ELSE p.target_domain_id END                           AS target_domain_id,
  p.target_concept_id                                        AS original_target_concept_id,
  p.target_domain_id                                         AS original_target_domain_id,
  x.xwalk_id                                                 AS meas_value_xwalk_id,
  -- value / unit fixes, applied by the routing step when the row is written
  CASE WHEN x.parse_number_regex IS NOT NULL
       THEN CAST(regexp_extract(p.value_as_string, x.parse_number_regex, 1) AS DOUBLE)
       ELSE p.value_as_number END                            AS rescued_value_as_number,
  COALESCE(x.target_unit_concept_id, p.unit_concept_id)     AS rescued_unit_concept_id,
  COALESCE(x.target_unit_source_value, p.unit_source_value) AS rescued_unit_source_value
FROM observation_prepared p
LEFT JOIN <your_schema>.meas_value_rescue_crosswalk x
       ON p.target_domain_id   = 'Meas Value'
      AND x.source_table       = 'observation'
      AND x.source_concept_id  = p.target_concept_id
      AND (x.value_regex IS NULL OR p.value_as_string RLIKE x.value_regex)
LEFT JOIN omop_vocab.concept f
       ON f.concept_id = x.target_concept_id
      AND x.target_concept_id <> 0;

-- GATE (expect 0 rows): nothing may reach routing as Meas Value
SELECT target_concept_id, COUNT(*) FROM observation_prepared_rescued
WHERE target_domain_id = 'Meas Value' GROUP BY 1;

-- GATE (expect 0 rows): no row fans out to more than one crosswalk entry
SELECT observation_id, COUNT(*) FROM observation_prepared_rescued GROUP BY 1 HAVING COUNT(*) > 1;

-- REPORT: Meas Value rows with no crosswalk entry (resolved to 0; add to the crosswalk if needed)
SELECT original_target_concept_id, COUNT(*) FROM observation_prepared_rescued
WHERE original_target_domain_id = 'Meas Value' AND meas_value_xwalk_id IS NULL GROUP BY 1;

-- REPORT: rescue outcome vs. expected_rows
SELECT r.meas_value_xwalk_id, x.source_concept_name, x.target_concept_name,
       COALESCE(r.target_domain_id, 'stay (0)') AS route, COUNT(*) AS n, MAX(x.expected_rows) AS expected
FROM observation_prepared_rescued r
JOIN <your_schema>.meas_value_rescue_crosswalk x ON x.xwalk_id = r.meas_value_xwalk_id
GROUP BY ALL ORDER BY 1;

-- DEVICE_EXPOSURE: same view with
--   FROM device_exposure_prepared p, x.source_table = 'device_exposure',
--   and drop the value_regex / parse / unit lines (device rows key on concept only).
