WITH niv AS (   -- IDs missing from the current vocabulary
  SELECT d.drug_concept_id, COUNT(*) AS n_rows
  FROM ehr_union_clean.drug_exposure d
  LEFT JOIN <old_vocab>.concept c ON c.concept_id = d.drug_concept_id
  WHERE d.drug_concept_id <> 0 AND c.concept_id IS NULL
  GROUP BY 1
)
SELECT nc.vocabulary_id, nc.concept_class_id, nc.standard_concept,
       CASE WHEN nc.concept_id IS NULL THEN 'still missing'
            WHEN cr.concept_id_2 IS NULL THEN 'found, no Maps to'
            ELSE 'found, maps to ' || t.vocabulary_id || ' ' || t.concept_class_id END AS status,
       COUNT(DISTINCT n.drug_concept_id) AS n_concepts, SUM(n.n_rows) AS n_rows
FROM niv n
LEFT JOIN <new_vocab>.concept nc ON nc.concept_id = n.drug_concept_id
LEFT JOIN <new_vocab>.concept_relationship cr
       ON cr.concept_id_1 = n.drug_concept_id AND cr.relationship_id = 'Maps to' AND cr.invalid_reason IS NULL
LEFT JOIN <new_vocab>.concept t ON t.concept_id = cr.concept_id_2
GROUP BY ALL ORDER BY n_rows DESC;