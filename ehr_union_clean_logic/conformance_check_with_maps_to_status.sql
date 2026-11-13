-- Domain conformance check on ehr_union_clean (read-only), with the 'Maps to' target domain.
-- Run after the union. Replace <vocab> (e.g. omop_vocab).
--   current_domain   = domain of the table the row is in now
--   vocab_domain_id  = concept.domain_id of the concept stored in the row
--   standard_concept = 'S' if the stored concept is standard
--   target_domain_id = domain of the stored concept's 'Maps to' target(s)
--   maps_to_status   = whether a standard concept was found through 'Maps to'

WITH rows AS (
  SELECT 'condition_occurrence' AS tbl, 'Condition'   AS current_domain, condition_concept_id   AS concept_id FROM ehr_union_clean.condition_occurrence
  UNION ALL
  SELECT 'procedure_occurrence', 'Procedure', procedure_concept_id FROM ehr_union_clean.procedure_occurrence
  UNION ALL
  SELECT 'measurement', 'Measurement', measurement_concept_id FROM ehr_union_clean.measurement
  UNION ALL
  SELECT 'observation', 'Observation', observation_concept_id FROM ehr_union_clean.observation
  UNION ALL
  SELECT 'drug_exposure', 'Drug', drug_concept_id FROM ehr_union_clean.drug_exposure
  UNION ALL
  SELECT 'device_exposure', 'Device', device_concept_id  FROM ehr_union_clean.device_exposure
  UNION ALL
  SELECT 'provider', 'Provider', specialty_concept_id FROM ehr_union_clean.provider
),
-- 'Maps to' targets, one row per concept (several targets are listed with commas; no fan-out)
maps_to AS (
  SELECT cr.concept_id_1 AS concept_id,
         CONCAT_WS(',', SORT_ARRAY(COLLECT_SET(CAST(c2.concept_id AS STRING)))) AS maps_to_concept_ids,
         CONCAT_WS(',', SORT_ARRAY(COLLECT_SET(c2.domain_id)))                  AS target_domain_id
  FROM <vocab>.concept_relationship cr
  JOIN <vocab>.concept c2 ON c2.concept_id = cr.concept_id_2
  WHERE cr.relationship_id = 'Maps to'
    AND cr.invalid_reason IS NULL
    AND cr.concept_id_1 IN (SELECT DISTINCT concept_id FROM rows WHERE concept_id <> 0)
  GROUP BY cr.concept_id_1
),
classified AS (
  SELECT r.tbl, r.current_domain, r.concept_id,
         CASE
           WHEN r.concept_id IS NULL OR r.concept_id = 0 THEN 'unmapped (0/NULL)'
           WHEN c.concept_id IS NULL                     THEN 'not in vocab'
           ELSE c.domain_id
         END                                             AS vocab_domain_id,
         c.standard_concept,
         m.target_domain_id,
         CASE
           WHEN r.concept_id IS NULL OR r.concept_id = 0 THEN 'unmapped (0/NULL)'
           WHEN c.concept_id IS NULL                     THEN 'not in vocab'
           WHEN m.concept_id IS NULL                     THEN 'no Maps to: standard concept not found'
           WHEN c.standard_concept = 'S'                 THEN 'standard (maps to itself)'
           ELSE 'non-standard: Maps to found, not applied'
         END                                             AS maps_to_status
  FROM rows r
  LEFT JOIN <vocab>.concept c ON c.concept_id = r.concept_id
  LEFT JOIN maps_to m         ON m.concept_id = r.concept_id
)

SELECT tbl, current_domain, vocab_domain_id, standard_concept, target_domain_id, maps_to_status,
       COUNT(*)                                                         AS n_rows,
       COUNT(DISTINCT concept_id)                                       AS n_concepts,
       MAX(total_rows)                                                  AS total_rows,
       ROUND(100.0 * COUNT(*) / MAX(total_rows), 4)                     AS pct_of_all_rows,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY tbl), 2) AS pct_of_table_mismatches
FROM (SELECT *, COUNT(*) OVER (PARTITION BY tbl) AS total_rows FROM classified)
WHERE vocab_domain_id NOT IN (current_domain, 'unmapped (0/NULL)')
GROUP BY ALL
ORDER BY tbl, n_rows DESC;

-- Expected after the no-map fallback:
--   * no 'no Maps to: standard concept not found' rows, except in device_exposure (not included yet)
--   * 'not in vocab' rows unchanged (pending the vocabulary-version check)
--   * 'standard (maps to itself)' rows only for domains with no table and no crosswalk entry yet
