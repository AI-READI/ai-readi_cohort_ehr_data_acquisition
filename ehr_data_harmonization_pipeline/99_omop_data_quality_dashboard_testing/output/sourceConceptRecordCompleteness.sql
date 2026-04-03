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
 'CONDITION_OCCURRENCE.CONDITION_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 WHERE cdmTable.CONDITION_SOURCE_CONCEPT_ID = 0 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
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
 'DEATH.CAUSE_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DEATH cdmTable
 WHERE cdmTable.CAUSE_SOURCE_CONCEPT_ID = 0 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT COUNT(*) AS num_rows
 FROM ehr_union.DEATH cdmTable
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
 'DEVICE_EXPOSURE.DEVICE_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 WHERE cdmTable.DEVICE_SOURCE_CONCEPT_ID = 0 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT COUNT(*) AS num_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
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
 'DEVICE_EXPOSURE.UNIT_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 WHERE cdmTable.UNIT_SOURCE_CONCEPT_ID = 0 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT COUNT(*) AS num_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
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
 'DRUG_EXPOSURE.DRUG_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE cdmTable.DRUG_SOURCE_CONCEPT_ID = 0 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT COUNT(*) AS num_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
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
 'EPISODE.EPISODE_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.EPISODE cdmTable
 WHERE cdmTable.EPISODE_SOURCE_CONCEPT_ID = 0 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT COUNT(*) AS num_rows
 FROM ehr_union.EPISODE cdmTable
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
 'MEASUREMENT.MEASUREMENT_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.MEASUREMENT cdmTable
 WHERE cdmTable.MEASUREMENT_SOURCE_CONCEPT_ID = 0 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT cdmTable
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
 'MEASUREMENT.UNIT_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.MEASUREMENT cdmTable
 WHERE cdmTable.UNIT_SOURCE_CONCEPT_ID = 0 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT cdmTable
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
 'OBSERVATION.OBSERVATION_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.OBSERVATION cdmTable
 WHERE cdmTable.OBSERVATION_SOURCE_CONCEPT_ID = 0 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT COUNT(*) AS num_rows
 FROM ehr_union.OBSERVATION cdmTable
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
 'PROCEDURE_OCCURRENCE.PROCEDURE_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 WHERE cdmTable.PROCEDURE_SOURCE_CONCEPT_ID = 0 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT COUNT(*) AS num_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
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
 'PROVIDER.SPECIALTY_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PROVIDER cdmTable
 WHERE cdmTable.SPECIALTY_SOURCE_CONCEPT_ID = 0 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT COUNT(*) AS num_rows
 FROM ehr_union.PROVIDER cdmTable
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
 'VISIT_DETAIL.VISIT_DETAIL_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.VISIT_DETAIL cdmTable
 WHERE cdmTable.VISIT_DETAIL_SOURCE_CONCEPT_ID = 0 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT COUNT(*) AS num_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
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
 'VISIT_OCCURRENCE.VISIT_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 WHERE cdmTable.VISIT_SOURCE_CONCEPT_ID = 0 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT COUNT(*) AS num_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
) denominator;
