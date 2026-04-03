SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DOSE_ERA.DRUG_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DOSE_ERA cdmTable
 LEFT JOIN ehr_union.concept co
 ON cdmTable.DRUG_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.concept_class_id != 'Ingredient') 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DOSE_ERA cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_ERA.DRUG_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DRUG_ERA cdmTable
 LEFT JOIN ehr_union.concept co
 ON cdmTable.DRUG_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.concept_class_id != 'Ingredient') 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_ERA cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_STRENGTH.INGREDIENT_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DRUG_STRENGTH cdmTable
 LEFT JOIN ehr_union.concept co
 ON cdmTable.INGREDIENT_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.concept_class_id != 'Ingredient') 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_STRENGTH cdmTable
) denominator;
