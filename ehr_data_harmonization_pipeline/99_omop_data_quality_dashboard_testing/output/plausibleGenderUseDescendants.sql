SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT cdmTable.* 
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 JOIN ehr_union.person p
 ON cdmTable.person_id = p.person_id
 JOIN ehr_union.concept_ancestor ca
 ON ca.descendant_concept_id = cdmTable.CONDITION_CONCEPT_ID
 WHERE ca.ancestor_concept_id IN (4090861, 4025213)
 AND p.gender_concept_id <> 8507 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 JOIN ehr_union.concept_ancestor ca
 ON ca.descendant_concept_id = cdmTable.CONDITION_CONCEPT_ID
 WHERE ca.ancestor_concept_id IN (4090861, 4025213)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT cdmTable.* 
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 JOIN ehr_union.person p
 ON cdmTable.person_id = p.person_id
 JOIN ehr_union.concept_ancestor ca
 ON ca.descendant_concept_id = cdmTable.CONDITION_CONCEPT_ID
 WHERE ca.ancestor_concept_id IN (4095793 , 443343, 4024004 , 4172857, 444094 , 197810, 4158481)
 AND p.gender_concept_id <> 8532 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 JOIN ehr_union.concept_ancestor ca
 ON ca.descendant_concept_id = cdmTable.CONDITION_CONCEPT_ID
 WHERE ca.ancestor_concept_id IN (4095793 , 443343, 4024004 , 4172857, 444094 , 197810, 4158481)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT cdmTable.* 
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 JOIN ehr_union.person p
 ON cdmTable.person_id = p.person_id
 JOIN ehr_union.concept_ancestor ca
 ON ca.descendant_concept_id = cdmTable.PROCEDURE_CONCEPT_ID
 WHERE ca.ancestor_concept_id IN (4041261)
 AND p.gender_concept_id <> 8532 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 JOIN ehr_union.concept_ancestor ca
 ON ca.descendant_concept_id = cdmTable.PROCEDURE_CONCEPT_ID
 WHERE ca.ancestor_concept_id IN (4041261)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT cdmTable.* 
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 JOIN ehr_union.person p
 ON cdmTable.person_id = p.person_id
 JOIN ehr_union.concept_ancestor ca
 ON ca.descendant_concept_id = cdmTable.PROCEDURE_CONCEPT_ID
 WHERE ca.ancestor_concept_id IN (4250917, 4077750, 4043199, 4040577)
 AND p.gender_concept_id <> 8507 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 JOIN ehr_union.concept_ancestor ca
 ON ca.descendant_concept_id = cdmTable.PROCEDURE_CONCEPT_ID
 WHERE ca.ancestor_concept_id IN (4250917, 4077750, 4043199, 4040577)
) denominator;
