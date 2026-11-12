-- Domain conformance check for ehr_union_clean (read-only).
-- Run after domain routing to confirm each table's main concept field holds concepts of the
-- table's domain. Replace <vocab> (e.g. omop_vocab).
-- Concept 0 / NULL is reported as unmapped, not as a mismatch.

WITH rows AS (
  SELECT 'condition_occurrence' AS tbl, 'Condition'   AS expected_domain, condition_concept_id   AS concept_id FROM ehr_union_clean.condition_occurrence
  UNION ALL
  SELECT 'procedure_occurrence',        'Procedure',                      procedure_concept_id                 FROM ehr_union_clean.procedure_occurrence
  UNION ALL
  SELECT 'measurement',                 'Measurement',                    measurement_concept_id               FROM ehr_union_clean.measurement
  UNION ALL
  SELECT 'observation',                 'Observation',                    observation_concept_id               FROM ehr_union_clean.observation
  UNION ALL
  SELECT 'drug_exposure',               'Drug',                           drug_concept_id                      FROM ehr_union_clean.drug_exposure
  UNION ALL
  SELECT 'device_exposure',             'Device',                         device_concept_id                    FROM ehr_union_clean.device_exposure
  UNION ALL
  SELECT 'provider',                    'Provider',                       specialty_concept_id                 FROM ehr_union_clean.provider
),
classified AS (
  SELECT r.tbl, r.expected_domain, r.concept_id,
         CASE
           WHEN r.concept_id IS NULL OR r.concept_id = 0 THEN 'unmapped (0/NULL)'
           WHEN c.concept_id IS NULL                     THEN 'not in vocab'
           WHEN c.domain_id = r.expected_domain          THEN 'match'
           ELSE c.domain_id
         END AS actual_domain
  FROM rows r
  LEFT JOIN <vocab>.concept c ON c.concept_id = r.concept_id
)

-- 1. Summary per table
SELECT tbl,
       COUNT(*)                                                                         AS total_rows,
       SUM(CASE WHEN actual_domain NOT IN ('match','unmapped (0/NULL)') THEN 1 ELSE 0 END) AS nonconformant_rows,
       ROUND(100.0 * SUM(CASE WHEN actual_domain NOT IN ('match','unmapped (0/NULL)') THEN 1 ELSE 0 END) / COUNT(*), 4) AS nonconformant_pct,
       SUM(CASE WHEN actual_domain = 'not in vocab'      THEN 1 ELSE 0 END)            AS not_in_vocab_rows,
       SUM(CASE WHEN actual_domain = 'unmapped (0/NULL)' THEN 1 ELSE 0 END)            AS unmapped_rows,
       ROUND(100.0 * SUM(CASE WHEN actual_domain = 'unmapped (0/NULL)' THEN 1 ELSE 0 END) / COUNT(*), 4) AS unmapped_pct
FROM classified
GROUP BY tbl
ORDER BY nonconformant_pct DESC;

-- 2. Detail: which domains the non-conformant rows belong to
-- (re-run the WITH block above before this statement if your client runs statements separately)
-- SELECT tbl, expected_domain, actual_domain,
--        COUNT(*)                                                         AS n_rows,
--        COUNT(DISTINCT concept_id)                                       AS n_concepts,
--        MAX(total_rows)                                                  AS total_rows,
--        ROUND(100.0 * COUNT(*) / MAX(total_rows), 4)                     AS pct_of_all_rows,
--        ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY tbl), 2) AS pct_of_table_mismatches
-- FROM (SELECT *, COUNT(*) OVER (PARTITION BY tbl) AS total_rows FROM classified)
-- WHERE actual_domain NOT IN ('match','unmapped (0/NULL)')
-- GROUP BY tbl, expected_domain, actual_domain
-- ORDER BY tbl, n_rows DESC;

-- Per-site breakdown: add data_partner_id to the rows CTE and to both GROUP BY clauses.
-- Pass criterion after rescue + routing: nonconformant_rows = 0 for every table except
-- known, documented exceptions (record them in the run log).
