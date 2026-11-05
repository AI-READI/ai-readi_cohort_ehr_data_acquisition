-- count mismatcheded_of_total_domain_conformance_check <using ehr_union_clean as schema>
WITH rows_by_concept AS (
  SELECT 'condition_occurrence' AS tbl, 'Condition'   AS expected_domain, condition_concept_id   AS cid FROM ehr_union_clean.condition_occurrence
  UNION ALL SELECT 'device_exposure',      'Device',      device_concept_id      FROM ehr_union_clean.device_exposure
  UNION ALL SELECT 'drug_exposure',        'Drug',        drug_concept_id        FROM ehr_union_clean.drug_exposure
  UNION ALL SELECT 'measurement',          'Measurement', measurement_concept_id FROM ehr_union_clean.measurement
  UNION ALL SELECT 'observation',          'Observation', observation_concept_id FROM ehr_union_clean.observation
  UNION ALL SELECT 'procedure_occurrence', 'Procedure',   procedure_concept_id   FROM ehr_union_clean.procedure_occurrence
  UNION ALL SELECT 'visit_occurrence',     'Visit',       visit_concept_id       FROM ehr_union_clean.visit_occurrence
  UNION ALL SELECT 'provider',             'Provider',    specialty_concept_id   FROM ehr_union_clean.provider
),
classified AS (
  SELECT r.tbl, r.expected_domain, r.cid,
         CASE WHEN r.cid IS NULL OR r.cid = 0 THEN 'concept 0 / null'
              WHEN c.concept_id IS NULL       THEN 'not in vocab'
              ELSE c.domain_id END AS actual_domain
  FROM rows_by_concept r
  LEFT JOIN omop_vocab.concept c ON c.concept_id = r.cid
),
totals AS (
  SELECT tbl, COUNT(*) AS total_rows FROM classified GROUP BY tbl
),
mism AS (
  SELECT tbl, expected_domain, actual_domain, COUNT(*) AS n_rows, COUNT(DISTINCT cid) AS n_concepts
  FROM classified
  WHERE actual_domain NOT IN ('concept 0 / null')
    AND actual_domain <> expected_domain
  GROUP BY 1, 2, 3
)
SELECT m.tbl, m.expected_domain, m.actual_domain, m.n_rows, m.n_concepts,
       t.total_rows,
       CONCAT(FORMAT_NUMBER(m.n_rows, 0), ' / ', FORMAT_NUMBER(t.total_rows, 0))     AS mismatched_of_total,
       ROUND(100.0 * m.n_rows / t.total_rows, 4)                                    AS pct_of_all_rows,
       ROUND(100.0 * m.n_rows / SUM(m.n_rows) OVER (PARTITION BY m.tbl), 2)         AS pct_of_table_mismatches
FROM mism m
JOIN totals t USING (tbl)
ORDER BY m.tbl, m.n_rows DESC;