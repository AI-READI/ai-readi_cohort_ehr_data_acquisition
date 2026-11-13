-- No 'Maps to' fallback: step 03 check (read-only). Run after 03_all_domains.py, before step 04.
-- Replace <site> with the site widget value (tables are <site>_ingestion.03_<domain>).
--   current_domain    = the table the row is in now (the table the site sent it in)
--   source_domain_id  = vocabulary domain of the site's concept
--   target_domain_id  = where step 04 will route it (after the fallback: the source domain for unmapped rows)

WITH rows AS (
  SELECT 'Condition'   AS current_domain, source_concept_id, source_domain_id, source_vocabulary_id, target_concept_id, target_domain_id, no_map_fallback FROM <site>_ingestion.03_condition_occurrence
  UNION ALL
  SELECT 'Procedure',                     source_concept_id, source_domain_id, source_vocabulary_id, target_concept_id, target_domain_id, no_map_fallback FROM <site>_ingestion.03_procedure_occurrence
  UNION ALL
  SELECT 'Measurement',                   source_concept_id, source_domain_id, source_vocabulary_id, target_concept_id, target_domain_id, no_map_fallback FROM <site>_ingestion.03_measurement
  UNION ALL
  SELECT 'Observation',                   source_concept_id, source_domain_id, source_vocabulary_id, target_concept_id, target_domain_id, no_map_fallback FROM <site>_ingestion.03_observation
  UNION ALL
  SELECT 'Drug',                          source_concept_id, source_domain_id, source_vocabulary_id, target_concept_id, target_domain_id, no_map_fallback FROM <site>_ingestion.03_drug_exposure
)

-- 1. Rows changed by the fallback: where they are now and where step 04 will put them
SELECT current_domain, source_domain_id, source_vocabulary_id,
       COALESCE(target_domain_id, '(stays, no table for domain)') AS target_domain_id,
       CASE WHEN target_domain_id IS NULL OR target_domain_id = current_domain THEN 'stays, concept 0'
            ELSE 'moves to ' || target_domain_id || ', concept 0' END AS step04_result,
       COUNT(*) AS n_rows, COUNT(DISTINCT source_concept_id) AS n_concepts
FROM rows
WHERE no_map_fallback = 1
GROUP BY ALL
ORDER BY current_domain, n_rows DESC;

-- 2. Still NULL target after step 03 (expected: concept 0/NULL, or concept not in the vocabulary only)
-- SELECT current_domain,
--        CASE WHEN source_concept_id IS NULL OR source_concept_id = 0 THEN 'concept 0/NULL'
--             WHEN source_domain_id IS NULL THEN 'not in vocab'
--             ELSE 'UNEXPECTED: in vocab, no Maps to, not handled' END AS reason,
--        COUNT(*) AS n_rows, COUNT(DISTINCT source_concept_id) AS n_concepts
-- FROM rows
-- WHERE target_concept_id IS NULL
-- GROUP BY ALL ORDER BY current_domain, n_rows DESC;

-- 3. Device rows are not touched: 03_device_exposure should have no no_map_fallback column (expect it absent)
-- SHOW COLUMNS IN <site>_ingestion.03_device_exposure;   -- look for no_map_fallback
