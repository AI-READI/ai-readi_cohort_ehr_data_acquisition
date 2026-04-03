SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'CARE_SITE.PLACE_OF_SERVICE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.CARE_SITE cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.PLACE_OF_SERVICE_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CARE_SITE cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'CDM_SOURCE.CDM_VERSION_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.CDM_SOURCE cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.CDM_VERSION_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CDM_SOURCE cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'COHORT_DEFINITION.DEFINITION_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM omop_dqd.COHORT_DEFINITION cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.DEFINITION_TYPE_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM omop_dqd.COHORT_DEFINITION cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'COHORT_DEFINITION.SUBJECT_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM omop_dqd.COHORT_DEFINITION cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.SUBJECT_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM omop_dqd.COHORT_DEFINITION cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'CONDITION_ERA.CONDITION_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.CONDITION_ERA cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.CONDITION_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_ERA cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'CONDITION_OCCURRENCE.CONDITION_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.CONDITION_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'CONDITION_OCCURRENCE.CONDITION_STATUS_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.CONDITION_STATUS_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'CONDITION_OCCURRENCE.CONDITION_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.CONDITION_TYPE_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'COST.COST_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.COST cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.COST_TYPE_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.COST cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DEATH.CAUSE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DEATH cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.CAUSE_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DEATH.DEATH_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DEATH cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.DEATH_TYPE_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DEVICE_EXPOSURE.DEVICE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.DEVICE_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DEVICE_EXPOSURE.DEVICE_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.DEVICE_TYPE_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DEVICE_EXPOSURE.UNIT_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.UNIT_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DOSE_ERA.DRUG_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DOSE_ERA cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.DRUG_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DOSE_ERA.UNIT_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DOSE_ERA cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.UNIT_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_ERA.DRUG_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DRUG_ERA cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.DRUG_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_EXPOSURE.DRUG_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.DRUG_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_EXPOSURE.DRUG_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.DRUG_TYPE_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_EXPOSURE.ROUTE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.ROUTE_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'EPISODE.EPISODE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.EPISODE cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.EPISODE_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'EPISODE.EPISODE_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.EPISODE cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.EPISODE_TYPE_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'EPISODE_EVENT.EPISODE_EVENT_FIELD_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.EPISODE_EVENT cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.EPISODE_EVENT_FIELD_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.EPISODE_EVENT cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'LOCATION.COUNTRY_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.LOCATION cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.COUNTRY_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.LOCATION cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'MEASUREMENT.MEAS_EVENT_FIELD_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.MEASUREMENT cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.MEAS_EVENT_FIELD_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'MEASUREMENT.MEASUREMENT_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.MEASUREMENT cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.MEASUREMENT_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'MEASUREMENT.MEASUREMENT_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.MEASUREMENT cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.MEASUREMENT_TYPE_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'MEASUREMENT.OPERATOR_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.MEASUREMENT cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.OPERATOR_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'MEASUREMENT.UNIT_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.MEASUREMENT cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.UNIT_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'NOTE.ENCODING_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.NOTE cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.ENCODING_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.NOTE cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'NOTE.LANGUAGE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.NOTE cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.LANGUAGE_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.NOTE cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'NOTE.NOTE_CLASS_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.NOTE cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.NOTE_CLASS_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.NOTE cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'NOTE.NOTE_EVENT_FIELD_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.NOTE cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.NOTE_EVENT_FIELD_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.NOTE cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'NOTE.NOTE_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.NOTE cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.NOTE_TYPE_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.NOTE cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'NOTE_NLP.NOTE_NLP_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.NOTE_NLP cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.NOTE_NLP_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.NOTE_NLP cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'NOTE_NLP.SECTION_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.NOTE_NLP cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.SECTION_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.NOTE_NLP cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'OBSERVATION.OBS_EVENT_FIELD_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.OBSERVATION cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.OBS_EVENT_FIELD_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'OBSERVATION.OBSERVATION_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.OBSERVATION cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.OBSERVATION_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'OBSERVATION.OBSERVATION_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.OBSERVATION cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.OBSERVATION_TYPE_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'OBSERVATION.QUALIFIER_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.OBSERVATION cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.QUALIFIER_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'OBSERVATION.UNIT_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.OBSERVATION cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.UNIT_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'OBSERVATION_PERIOD.PERIOD_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.OBSERVATION_PERIOD cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.PERIOD_TYPE_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.OBSERVATION_PERIOD cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'PERSON.ETHNICITY_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PERSON cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.ETHNICITY_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PERSON cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'PERSON.GENDER_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PERSON cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.GENDER_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PERSON cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'PERSON.RACE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PERSON cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.RACE_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PERSON cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'PROCEDURE_OCCURRENCE.MODIFIER_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.MODIFIER_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'PROCEDURE_OCCURRENCE.PROCEDURE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.PROCEDURE_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'PROCEDURE_OCCURRENCE.PROCEDURE_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.PROCEDURE_TYPE_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'PROVIDER.GENDER_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PROVIDER cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.GENDER_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'PROVIDER.SPECIALTY_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PROVIDER cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.SPECIALTY_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'SOURCE_TO_CONCEPT_MAP.TARGET_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.SOURCE_TO_CONCEPT_MAP cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.TARGET_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.SOURCE_TO_CONCEPT_MAP cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'SPECIMEN.ANATOMIC_SITE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.SPECIMEN cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.ANATOMIC_SITE_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.SPECIMEN cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'SPECIMEN.DISEASE_STATUS_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.SPECIMEN cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.DISEASE_STATUS_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.SPECIMEN cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'SPECIMEN.SPECIMEN_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.SPECIMEN cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.SPECIMEN_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.SPECIMEN cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'SPECIMEN.SPECIMEN_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.SPECIMEN cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.SPECIMEN_TYPE_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.SPECIMEN cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'SPECIMEN.UNIT_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.SPECIMEN cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.UNIT_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.SPECIMEN cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_DETAIL.ADMITTED_FROM_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.VISIT_DETAIL cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.ADMITTED_FROM_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_DETAIL.DISCHARGED_TO_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.VISIT_DETAIL cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.DISCHARGED_TO_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_DETAIL.VISIT_DETAIL_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.VISIT_DETAIL cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.VISIT_DETAIL_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_DETAIL.VISIT_DETAIL_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.VISIT_DETAIL cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.VISIT_DETAIL_TYPE_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
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
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_OCCURRENCE.ADMITTED_FROM_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.ADMITTED_FROM_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_OCCURRENCE.DISCHARGED_TO_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.DISCHARGED_TO_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_OCCURRENCE.VISIT_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.VISIT_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_OCCURRENCE.VISIT_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 JOIN ehr_union.concept co 
 ON cdmTable.VISIT_TYPE_CONCEPT_ID = co.concept_id
 WHERE co.concept_id != 0 
 AND (co.standard_concept != 'S' OR co.invalid_reason IS NOT NULL)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
) denominator;
