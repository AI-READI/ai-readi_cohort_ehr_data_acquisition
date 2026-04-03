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
 'CARE_SITE.CARE_SITE_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.CARE_SITE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.CARE_SITE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.CARE_SITE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.CARE_SITE_ID) AS STRING),'.') != 0))
 AND cdmTable.CARE_SITE_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CARE_SITE
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
 'CARE_SITE.LOCATION_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.CARE_SITE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.LOCATION_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.LOCATION_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.LOCATION_ID) AS STRING),'.') != 0))
 AND cdmTable.LOCATION_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CARE_SITE
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
 'CARE_SITE.PLACE_OF_SERVICE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.CARE_SITE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PLACE_OF_SERVICE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PLACE_OF_SERVICE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PLACE_OF_SERVICE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.PLACE_OF_SERVICE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CARE_SITE
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
 WHERE 
 (CASE WHEN CAST(cdmTable.CDM_VERSION_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.CDM_VERSION_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.CDM_VERSION_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.CDM_VERSION_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CDM_SOURCE
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
 'COHORT.COHORT_DEFINITION_ID' AS violating_field, 
 cdmTable.* 
 FROM omop_dqd.COHORT cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.COHORT_DEFINITION_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.COHORT_DEFINITION_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.COHORT_DEFINITION_ID) AS STRING),'.') != 0))
 AND cdmTable.COHORT_DEFINITION_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM omop_dqd.COHORT
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
 'COHORT.SUBJECT_ID' AS violating_field, 
 cdmTable.* 
 FROM omop_dqd.COHORT cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.SUBJECT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.SUBJECT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.SUBJECT_ID) AS STRING),'.') != 0))
 AND cdmTable.SUBJECT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM omop_dqd.COHORT
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
 'COHORT_DEFINITION.COHORT_DEFINITION_ID' AS violating_field, 
 cdmTable.* 
 FROM omop_dqd.COHORT_DEFINITION cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.COHORT_DEFINITION_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.COHORT_DEFINITION_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.COHORT_DEFINITION_ID) AS STRING),'.') != 0))
 AND cdmTable.COHORT_DEFINITION_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM omop_dqd.COHORT_DEFINITION
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
 WHERE 
 (CASE WHEN CAST(cdmTable.DEFINITION_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.DEFINITION_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.DEFINITION_TYPE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.DEFINITION_TYPE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM omop_dqd.COHORT_DEFINITION
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
 WHERE 
 (CASE WHEN CAST(cdmTable.SUBJECT_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.SUBJECT_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.SUBJECT_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.SUBJECT_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM omop_dqd.COHORT_DEFINITION
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
 WHERE 
 (CASE WHEN CAST(cdmTable.CONDITION_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.CONDITION_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.CONDITION_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.CONDITION_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_ERA
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
 'CONDITION_ERA.CONDITION_ERA_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.CONDITION_ERA cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.CONDITION_ERA_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.CONDITION_ERA_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.CONDITION_ERA_ID) AS STRING),'.') != 0))
 AND cdmTable.CONDITION_ERA_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_ERA
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
 'CONDITION_ERA.CONDITION_OCCURRENCE_COUNT' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.CONDITION_ERA cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.CONDITION_OCCURRENCE_COUNT AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.CONDITION_OCCURRENCE_COUNT AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.CONDITION_OCCURRENCE_COUNT) AS STRING),'.') != 0))
 AND cdmTable.CONDITION_OCCURRENCE_COUNT IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_ERA
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
 'CONDITION_ERA.PERSON_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.CONDITION_ERA cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PERSON_ID) AS STRING),'.') != 0))
 AND cdmTable.PERSON_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_ERA
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
 WHERE 
 (CASE WHEN CAST(cdmTable.CONDITION_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.CONDITION_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.CONDITION_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.CONDITION_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_OCCURRENCE
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
 'CONDITION_OCCURRENCE.CONDITION_OCCURRENCE_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.CONDITION_OCCURRENCE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.CONDITION_OCCURRENCE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.CONDITION_OCCURRENCE_ID) AS STRING),'.') != 0))
 AND cdmTable.CONDITION_OCCURRENCE_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_OCCURRENCE
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
 'CONDITION_OCCURRENCE.CONDITION_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.CONDITION_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.CONDITION_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.CONDITION_SOURCE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.CONDITION_SOURCE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_OCCURRENCE
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
 WHERE 
 (CASE WHEN CAST(cdmTable.CONDITION_STATUS_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.CONDITION_STATUS_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.CONDITION_STATUS_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.CONDITION_STATUS_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_OCCURRENCE
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
 WHERE 
 (CASE WHEN CAST(cdmTable.CONDITION_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.CONDITION_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.CONDITION_TYPE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.CONDITION_TYPE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_OCCURRENCE
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
 'CONDITION_OCCURRENCE.PERSON_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PERSON_ID) AS STRING),'.') != 0))
 AND cdmTable.PERSON_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_OCCURRENCE
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
 'CONDITION_OCCURRENCE.PROVIDER_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PROVIDER_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PROVIDER_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PROVIDER_ID) AS STRING),'.') != 0))
 AND cdmTable.PROVIDER_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_OCCURRENCE
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
 'CONDITION_OCCURRENCE.VISIT_DETAIL_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.VISIT_DETAIL_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.VISIT_DETAIL_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.VISIT_DETAIL_ID) AS STRING),'.') != 0))
 AND cdmTable.VISIT_DETAIL_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_OCCURRENCE
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
 'CONDITION_OCCURRENCE.VISIT_OCCURRENCE_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.VISIT_OCCURRENCE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.VISIT_OCCURRENCE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.VISIT_OCCURRENCE_ID) AS STRING),'.') != 0))
 AND cdmTable.VISIT_OCCURRENCE_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_OCCURRENCE
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
 'COST.COST_EVENT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.COST cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.COST_EVENT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.COST_EVENT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.COST_EVENT_ID) AS STRING),'.') != 0))
 AND cdmTable.COST_EVENT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.COST
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
 'COST.COST_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.COST cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.COST_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.COST_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.COST_ID) AS STRING),'.') != 0))
 AND cdmTable.COST_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.COST
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
 WHERE 
 (CASE WHEN CAST(cdmTable.COST_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.COST_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.COST_TYPE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.COST_TYPE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.COST
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
 'COST.CURRENCY_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.COST cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.CURRENCY_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.CURRENCY_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.CURRENCY_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.CURRENCY_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.COST
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
 'COST.DRG_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.COST cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.DRG_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.DRG_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.DRG_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.DRG_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.COST
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
 'COST.PAYER_PLAN_PERIOD_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.COST cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PAYER_PLAN_PERIOD_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PAYER_PLAN_PERIOD_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PAYER_PLAN_PERIOD_ID) AS STRING),'.') != 0))
 AND cdmTable.PAYER_PLAN_PERIOD_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.COST
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
 'COST.REVENUE_CODE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.COST cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.REVENUE_CODE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.REVENUE_CODE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.REVENUE_CODE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.REVENUE_CODE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.COST
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
 WHERE 
 (CASE WHEN CAST(cdmTable.CAUSE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.CAUSE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.CAUSE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.CAUSE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DEATH
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
 'DEATH.CAUSE_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DEATH cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.CAUSE_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.CAUSE_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.CAUSE_SOURCE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.CAUSE_SOURCE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DEATH
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
 WHERE 
 (CASE WHEN CAST(cdmTable.DEATH_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.DEATH_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.DEATH_TYPE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.DEATH_TYPE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DEATH
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
 'DEATH.PERSON_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DEATH cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PERSON_ID) AS STRING),'.') != 0))
 AND cdmTable.PERSON_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DEATH
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
 WHERE 
 (CASE WHEN CAST(cdmTable.DEVICE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.DEVICE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.DEVICE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.DEVICE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DEVICE_EXPOSURE
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
 'DEVICE_EXPOSURE.DEVICE_EXPOSURE_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.DEVICE_EXPOSURE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.DEVICE_EXPOSURE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.DEVICE_EXPOSURE_ID) AS STRING),'.') != 0))
 AND cdmTable.DEVICE_EXPOSURE_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DEVICE_EXPOSURE
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
 'DEVICE_EXPOSURE.DEVICE_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.DEVICE_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.DEVICE_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.DEVICE_SOURCE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.DEVICE_SOURCE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DEVICE_EXPOSURE
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
 WHERE 
 (CASE WHEN CAST(cdmTable.DEVICE_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.DEVICE_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.DEVICE_TYPE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.DEVICE_TYPE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DEVICE_EXPOSURE
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
 'DEVICE_EXPOSURE.PERSON_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PERSON_ID) AS STRING),'.') != 0))
 AND cdmTable.PERSON_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DEVICE_EXPOSURE
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
 'DEVICE_EXPOSURE.PROVIDER_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PROVIDER_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PROVIDER_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PROVIDER_ID) AS STRING),'.') != 0))
 AND cdmTable.PROVIDER_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DEVICE_EXPOSURE
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
 'DEVICE_EXPOSURE.QUANTITY' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.QUANTITY AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.QUANTITY AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.QUANTITY) AS STRING),'.') != 0))
 AND cdmTable.QUANTITY IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DEVICE_EXPOSURE
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
 WHERE 
 (CASE WHEN CAST(cdmTable.UNIT_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.UNIT_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.UNIT_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.UNIT_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DEVICE_EXPOSURE
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
 'DEVICE_EXPOSURE.UNIT_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.UNIT_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.UNIT_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.UNIT_SOURCE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.UNIT_SOURCE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DEVICE_EXPOSURE
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
 'DEVICE_EXPOSURE.VISIT_DETAIL_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.VISIT_DETAIL_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.VISIT_DETAIL_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.VISIT_DETAIL_ID) AS STRING),'.') != 0))
 AND cdmTable.VISIT_DETAIL_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DEVICE_EXPOSURE
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
 'DEVICE_EXPOSURE.VISIT_OCCURRENCE_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.VISIT_OCCURRENCE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.VISIT_OCCURRENCE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.VISIT_OCCURRENCE_ID) AS STRING),'.') != 0))
 AND cdmTable.VISIT_OCCURRENCE_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DEVICE_EXPOSURE
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
 'DOSE_ERA.DOSE_ERA_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DOSE_ERA cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.DOSE_ERA_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.DOSE_ERA_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.DOSE_ERA_ID) AS STRING),'.') != 0))
 AND cdmTable.DOSE_ERA_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DOSE_ERA
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
 WHERE 
 (CASE WHEN CAST(cdmTable.DRUG_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.DRUG_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.DRUG_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.DRUG_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DOSE_ERA
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
 'DOSE_ERA.PERSON_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DOSE_ERA cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PERSON_ID) AS STRING),'.') != 0))
 AND cdmTable.PERSON_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DOSE_ERA
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
 WHERE 
 (CASE WHEN CAST(cdmTable.UNIT_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.UNIT_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.UNIT_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.UNIT_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DOSE_ERA
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
 WHERE 
 (CASE WHEN CAST(cdmTable.DRUG_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.DRUG_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.DRUG_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.DRUG_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_ERA
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
 'DRUG_ERA.DRUG_ERA_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DRUG_ERA cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.DRUG_ERA_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.DRUG_ERA_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.DRUG_ERA_ID) AS STRING),'.') != 0))
 AND cdmTable.DRUG_ERA_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_ERA
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
 'DRUG_ERA.DRUG_EXPOSURE_COUNT' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DRUG_ERA cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.DRUG_EXPOSURE_COUNT AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.DRUG_EXPOSURE_COUNT AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.DRUG_EXPOSURE_COUNT) AS STRING),'.') != 0))
 AND cdmTable.DRUG_EXPOSURE_COUNT IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_ERA
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
 'DRUG_ERA.GAP_DAYS' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DRUG_ERA cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.GAP_DAYS AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.GAP_DAYS AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.GAP_DAYS) AS STRING),'.') != 0))
 AND cdmTable.GAP_DAYS IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_ERA
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
 'DRUG_ERA.PERSON_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DRUG_ERA cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PERSON_ID) AS STRING),'.') != 0))
 AND cdmTable.PERSON_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_ERA
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
 'DRUG_EXPOSURE.DAYS_SUPPLY' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.DAYS_SUPPLY AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.DAYS_SUPPLY AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.DAYS_SUPPLY) AS STRING),'.') != 0))
 AND cdmTable.DAYS_SUPPLY IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_EXPOSURE
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
 WHERE 
 (CASE WHEN CAST(cdmTable.DRUG_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.DRUG_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.DRUG_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.DRUG_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_EXPOSURE
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
 'DRUG_EXPOSURE.DRUG_EXPOSURE_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.DRUG_EXPOSURE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.DRUG_EXPOSURE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.DRUG_EXPOSURE_ID) AS STRING),'.') != 0))
 AND cdmTable.DRUG_EXPOSURE_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_EXPOSURE
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
 'DRUG_EXPOSURE.DRUG_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.DRUG_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.DRUG_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.DRUG_SOURCE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.DRUG_SOURCE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_EXPOSURE
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
 WHERE 
 (CASE WHEN CAST(cdmTable.DRUG_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.DRUG_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.DRUG_TYPE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.DRUG_TYPE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_EXPOSURE
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
 'DRUG_EXPOSURE.PERSON_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PERSON_ID) AS STRING),'.') != 0))
 AND cdmTable.PERSON_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_EXPOSURE
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
 'DRUG_EXPOSURE.PROVIDER_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PROVIDER_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PROVIDER_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PROVIDER_ID) AS STRING),'.') != 0))
 AND cdmTable.PROVIDER_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_EXPOSURE
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
 'DRUG_EXPOSURE.REFILLS' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.REFILLS AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.REFILLS AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.REFILLS) AS STRING),'.') != 0))
 AND cdmTable.REFILLS IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_EXPOSURE
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
 WHERE 
 (CASE WHEN CAST(cdmTable.ROUTE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.ROUTE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.ROUTE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.ROUTE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_EXPOSURE
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
 'DRUG_EXPOSURE.VISIT_DETAIL_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.VISIT_DETAIL_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.VISIT_DETAIL_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.VISIT_DETAIL_ID) AS STRING),'.') != 0))
 AND cdmTable.VISIT_DETAIL_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_EXPOSURE
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
 'DRUG_EXPOSURE.VISIT_OCCURRENCE_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.VISIT_OCCURRENCE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.VISIT_OCCURRENCE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.VISIT_OCCURRENCE_ID) AS STRING),'.') != 0))
 AND cdmTable.VISIT_OCCURRENCE_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_EXPOSURE
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
 'DRUG_STRENGTH.AMOUNT_UNIT_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DRUG_STRENGTH cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.AMOUNT_UNIT_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.AMOUNT_UNIT_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.AMOUNT_UNIT_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.AMOUNT_UNIT_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_STRENGTH
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
 'DRUG_STRENGTH.BOX_SIZE' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DRUG_STRENGTH cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.BOX_SIZE AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.BOX_SIZE AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.BOX_SIZE) AS STRING),'.') != 0))
 AND cdmTable.BOX_SIZE IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_STRENGTH
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
 'DRUG_STRENGTH.DENOMINATOR_UNIT_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DRUG_STRENGTH cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.DENOMINATOR_UNIT_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.DENOMINATOR_UNIT_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.DENOMINATOR_UNIT_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.DENOMINATOR_UNIT_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_STRENGTH
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
 'DRUG_STRENGTH.DRUG_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DRUG_STRENGTH cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.DRUG_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.DRUG_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.DRUG_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.DRUG_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_STRENGTH
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
 'DRUG_STRENGTH.INGREDIENT_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DRUG_STRENGTH cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.INGREDIENT_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.INGREDIENT_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.INGREDIENT_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.INGREDIENT_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_STRENGTH
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
 'DRUG_STRENGTH.NUMERATOR_UNIT_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DRUG_STRENGTH cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.NUMERATOR_UNIT_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.NUMERATOR_UNIT_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.NUMERATOR_UNIT_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.NUMERATOR_UNIT_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_STRENGTH
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
 WHERE 
 (CASE WHEN CAST(cdmTable.EPISODE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.EPISODE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.EPISODE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.EPISODE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.EPISODE
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
 'EPISODE.EPISODE_NUMBER' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.EPISODE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.EPISODE_NUMBER AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.EPISODE_NUMBER AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.EPISODE_NUMBER) AS STRING),'.') != 0))
 AND cdmTable.EPISODE_NUMBER IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.EPISODE
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
 'EPISODE.EPISODE_OBJECT_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.EPISODE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.EPISODE_OBJECT_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.EPISODE_OBJECT_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.EPISODE_OBJECT_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.EPISODE_OBJECT_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.EPISODE
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
 'EPISODE.EPISODE_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.EPISODE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.EPISODE_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.EPISODE_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.EPISODE_SOURCE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.EPISODE_SOURCE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.EPISODE
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
 WHERE 
 (CASE WHEN CAST(cdmTable.EPISODE_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.EPISODE_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.EPISODE_TYPE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.EPISODE_TYPE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.EPISODE
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
 WHERE 
 (CASE WHEN CAST(cdmTable.EPISODE_EVENT_FIELD_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.EPISODE_EVENT_FIELD_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.EPISODE_EVENT_FIELD_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.EPISODE_EVENT_FIELD_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.EPISODE_EVENT
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
 'FACT_RELATIONSHIP.DOMAIN_CONCEPT_ID_1' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.FACT_RELATIONSHIP cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.DOMAIN_CONCEPT_ID_1 AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.DOMAIN_CONCEPT_ID_1 AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.DOMAIN_CONCEPT_ID_1) AS STRING),'.') != 0))
 AND cdmTable.DOMAIN_CONCEPT_ID_1 IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.FACT_RELATIONSHIP
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
 'FACT_RELATIONSHIP.DOMAIN_CONCEPT_ID_2' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.FACT_RELATIONSHIP cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.DOMAIN_CONCEPT_ID_2 AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.DOMAIN_CONCEPT_ID_2 AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.DOMAIN_CONCEPT_ID_2) AS STRING),'.') != 0))
 AND cdmTable.DOMAIN_CONCEPT_ID_2 IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.FACT_RELATIONSHIP
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
 'FACT_RELATIONSHIP.FACT_ID_1' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.FACT_RELATIONSHIP cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.FACT_ID_1 AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.FACT_ID_1 AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.FACT_ID_1) AS STRING),'.') != 0))
 AND cdmTable.FACT_ID_1 IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.FACT_RELATIONSHIP
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
 'FACT_RELATIONSHIP.FACT_ID_2' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.FACT_RELATIONSHIP cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.FACT_ID_2 AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.FACT_ID_2 AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.FACT_ID_2) AS STRING),'.') != 0))
 AND cdmTable.FACT_ID_2 IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.FACT_RELATIONSHIP
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
 'FACT_RELATIONSHIP.RELATIONSHIP_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.FACT_RELATIONSHIP cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.RELATIONSHIP_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.RELATIONSHIP_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.RELATIONSHIP_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.RELATIONSHIP_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.FACT_RELATIONSHIP
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
 WHERE 
 (CASE WHEN CAST(cdmTable.COUNTRY_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.COUNTRY_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.COUNTRY_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.COUNTRY_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.LOCATION
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
 'LOCATION.LOCATION_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.LOCATION cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.LOCATION_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.LOCATION_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.LOCATION_ID) AS STRING),'.') != 0))
 AND cdmTable.LOCATION_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.LOCATION
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
 WHERE 
 (CASE WHEN CAST(cdmTable.MEAS_EVENT_FIELD_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.MEAS_EVENT_FIELD_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.MEAS_EVENT_FIELD_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.MEAS_EVENT_FIELD_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT
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
 WHERE 
 (CASE WHEN CAST(cdmTable.MEASUREMENT_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.MEASUREMENT_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.MEASUREMENT_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.MEASUREMENT_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT
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
 'MEASUREMENT.MEASUREMENT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.MEASUREMENT cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.MEASUREMENT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.MEASUREMENT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.MEASUREMENT_ID) AS STRING),'.') != 0))
 AND cdmTable.MEASUREMENT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT
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
 'MEASUREMENT.MEASUREMENT_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.MEASUREMENT cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.MEASUREMENT_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.MEASUREMENT_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.MEASUREMENT_SOURCE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.MEASUREMENT_SOURCE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT
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
 WHERE 
 (CASE WHEN CAST(cdmTable.MEASUREMENT_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.MEASUREMENT_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.MEASUREMENT_TYPE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.MEASUREMENT_TYPE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT
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
 WHERE 
 (CASE WHEN CAST(cdmTable.OPERATOR_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.OPERATOR_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.OPERATOR_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.OPERATOR_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT
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
 'MEASUREMENT.PERSON_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.MEASUREMENT cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PERSON_ID) AS STRING),'.') != 0))
 AND cdmTable.PERSON_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT
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
 'MEASUREMENT.PROVIDER_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.MEASUREMENT cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PROVIDER_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PROVIDER_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PROVIDER_ID) AS STRING),'.') != 0))
 AND cdmTable.PROVIDER_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT
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
 WHERE 
 (CASE WHEN CAST(cdmTable.UNIT_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.UNIT_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.UNIT_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.UNIT_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT
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
 'MEASUREMENT.UNIT_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.MEASUREMENT cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.UNIT_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.UNIT_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.UNIT_SOURCE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.UNIT_SOURCE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT
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
 'MEASUREMENT.VALUE_AS_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.MEASUREMENT cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.VALUE_AS_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.VALUE_AS_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.VALUE_AS_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.VALUE_AS_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT
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
 'MEASUREMENT.VISIT_DETAIL_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.MEASUREMENT cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.VISIT_DETAIL_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.VISIT_DETAIL_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.VISIT_DETAIL_ID) AS STRING),'.') != 0))
 AND cdmTable.VISIT_DETAIL_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT
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
 'MEASUREMENT.VISIT_OCCURRENCE_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.MEASUREMENT cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.VISIT_OCCURRENCE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.VISIT_OCCURRENCE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.VISIT_OCCURRENCE_ID) AS STRING),'.') != 0))
 AND cdmTable.VISIT_OCCURRENCE_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT
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
 'METADATA.METADATA_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.METADATA cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.METADATA_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.METADATA_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.METADATA_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.METADATA_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.METADATA
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
 'METADATA.METADATA_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.METADATA cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.METADATA_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.METADATA_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.METADATA_ID) AS STRING),'.') != 0))
 AND cdmTable.METADATA_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.METADATA
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
 'METADATA.METADATA_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.METADATA cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.METADATA_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.METADATA_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.METADATA_TYPE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.METADATA_TYPE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.METADATA
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
 'METADATA.VALUE_AS_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.METADATA cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.VALUE_AS_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.VALUE_AS_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.VALUE_AS_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.VALUE_AS_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.METADATA
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
 WHERE 
 (CASE WHEN CAST(cdmTable.ENCODING_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.ENCODING_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.ENCODING_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.ENCODING_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.NOTE
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
 WHERE 
 (CASE WHEN CAST(cdmTable.LANGUAGE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.LANGUAGE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.LANGUAGE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.LANGUAGE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.NOTE
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
 WHERE 
 (CASE WHEN CAST(cdmTable.NOTE_CLASS_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.NOTE_CLASS_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.NOTE_CLASS_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.NOTE_CLASS_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.NOTE
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
 WHERE 
 (CASE WHEN CAST(cdmTable.NOTE_EVENT_FIELD_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.NOTE_EVENT_FIELD_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.NOTE_EVENT_FIELD_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.NOTE_EVENT_FIELD_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.NOTE
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
 'NOTE.NOTE_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.NOTE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.NOTE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.NOTE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.NOTE_ID) AS STRING),'.') != 0))
 AND cdmTable.NOTE_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.NOTE
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
 WHERE 
 (CASE WHEN CAST(cdmTable.NOTE_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.NOTE_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.NOTE_TYPE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.NOTE_TYPE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.NOTE
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
 'NOTE.PERSON_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.NOTE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PERSON_ID) AS STRING),'.') != 0))
 AND cdmTable.PERSON_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.NOTE
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
 'NOTE.PROVIDER_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.NOTE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PROVIDER_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PROVIDER_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PROVIDER_ID) AS STRING),'.') != 0))
 AND cdmTable.PROVIDER_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.NOTE
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
 'NOTE.VISIT_DETAIL_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.NOTE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.VISIT_DETAIL_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.VISIT_DETAIL_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.VISIT_DETAIL_ID) AS STRING),'.') != 0))
 AND cdmTable.VISIT_DETAIL_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.NOTE
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
 'NOTE.VISIT_OCCURRENCE_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.NOTE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.VISIT_OCCURRENCE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.VISIT_OCCURRENCE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.VISIT_OCCURRENCE_ID) AS STRING),'.') != 0))
 AND cdmTable.VISIT_OCCURRENCE_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.NOTE
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
 'NOTE_NLP.NOTE_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.NOTE_NLP cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.NOTE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.NOTE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.NOTE_ID) AS STRING),'.') != 0))
 AND cdmTable.NOTE_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.NOTE_NLP
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
 WHERE 
 (CASE WHEN CAST(cdmTable.NOTE_NLP_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.NOTE_NLP_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.NOTE_NLP_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.NOTE_NLP_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.NOTE_NLP
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
 'NOTE_NLP.NOTE_NLP_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.NOTE_NLP cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.NOTE_NLP_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.NOTE_NLP_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.NOTE_NLP_ID) AS STRING),'.') != 0))
 AND cdmTable.NOTE_NLP_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.NOTE_NLP
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
 'NOTE_NLP.NOTE_NLP_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.NOTE_NLP cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.NOTE_NLP_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.NOTE_NLP_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.NOTE_NLP_SOURCE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.NOTE_NLP_SOURCE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.NOTE_NLP
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
 WHERE 
 (CASE WHEN CAST(cdmTable.SECTION_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.SECTION_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.SECTION_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.SECTION_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.NOTE_NLP
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
 WHERE 
 (CASE WHEN CAST(cdmTable.OBS_EVENT_FIELD_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.OBS_EVENT_FIELD_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.OBS_EVENT_FIELD_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.OBS_EVENT_FIELD_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.OBSERVATION
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
 WHERE 
 (CASE WHEN CAST(cdmTable.OBSERVATION_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.OBSERVATION_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.OBSERVATION_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.OBSERVATION_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.OBSERVATION
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
 'OBSERVATION.OBSERVATION_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.OBSERVATION cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.OBSERVATION_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.OBSERVATION_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.OBSERVATION_ID) AS STRING),'.') != 0))
 AND cdmTable.OBSERVATION_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.OBSERVATION
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
 'OBSERVATION.OBSERVATION_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.OBSERVATION cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.OBSERVATION_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.OBSERVATION_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.OBSERVATION_SOURCE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.OBSERVATION_SOURCE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.OBSERVATION
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
 WHERE 
 (CASE WHEN CAST(cdmTable.OBSERVATION_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.OBSERVATION_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.OBSERVATION_TYPE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.OBSERVATION_TYPE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.OBSERVATION
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
 'OBSERVATION.PERSON_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.OBSERVATION cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PERSON_ID) AS STRING),'.') != 0))
 AND cdmTable.PERSON_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.OBSERVATION
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
 'OBSERVATION.PROVIDER_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.OBSERVATION cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PROVIDER_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PROVIDER_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PROVIDER_ID) AS STRING),'.') != 0))
 AND cdmTable.PROVIDER_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.OBSERVATION
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
 WHERE 
 (CASE WHEN CAST(cdmTable.QUALIFIER_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.QUALIFIER_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.QUALIFIER_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.QUALIFIER_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.OBSERVATION
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
 WHERE 
 (CASE WHEN CAST(cdmTable.UNIT_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.UNIT_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.UNIT_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.UNIT_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.OBSERVATION
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
 'OBSERVATION.VISIT_DETAIL_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.OBSERVATION cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.VISIT_DETAIL_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.VISIT_DETAIL_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.VISIT_DETAIL_ID) AS STRING),'.') != 0))
 AND cdmTable.VISIT_DETAIL_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.OBSERVATION
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
 'OBSERVATION.VISIT_OCCURRENCE_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.OBSERVATION cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.VISIT_OCCURRENCE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.VISIT_OCCURRENCE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.VISIT_OCCURRENCE_ID) AS STRING),'.') != 0))
 AND cdmTable.VISIT_OCCURRENCE_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.OBSERVATION
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
 'OBSERVATION_PERIOD.OBSERVATION_PERIOD_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.OBSERVATION_PERIOD cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.OBSERVATION_PERIOD_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.OBSERVATION_PERIOD_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.OBSERVATION_PERIOD_ID) AS STRING),'.') != 0))
 AND cdmTable.OBSERVATION_PERIOD_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.OBSERVATION_PERIOD
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
 WHERE 
 (CASE WHEN CAST(cdmTable.PERIOD_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PERIOD_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PERIOD_TYPE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.PERIOD_TYPE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.OBSERVATION_PERIOD
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
 'OBSERVATION_PERIOD.PERSON_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.OBSERVATION_PERIOD cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PERSON_ID) AS STRING),'.') != 0))
 AND cdmTable.PERSON_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.OBSERVATION_PERIOD
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
 'PAYER_PLAN_PERIOD.PAYER_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PAYER_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PAYER_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PAYER_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.PAYER_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PAYER_PLAN_PERIOD
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
 'PAYER_PLAN_PERIOD.PAYER_PLAN_PERIOD_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PAYER_PLAN_PERIOD_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PAYER_PLAN_PERIOD_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PAYER_PLAN_PERIOD_ID) AS STRING),'.') != 0))
 AND cdmTable.PAYER_PLAN_PERIOD_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PAYER_PLAN_PERIOD
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
 'PAYER_PLAN_PERIOD.PAYER_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PAYER_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PAYER_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PAYER_SOURCE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.PAYER_SOURCE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PAYER_PLAN_PERIOD
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
 'PAYER_PLAN_PERIOD.PERSON_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PERSON_ID) AS STRING),'.') != 0))
 AND cdmTable.PERSON_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PAYER_PLAN_PERIOD
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
 'PAYER_PLAN_PERIOD.PLAN_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PLAN_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PLAN_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PLAN_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.PLAN_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PAYER_PLAN_PERIOD
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
 'PAYER_PLAN_PERIOD.PLAN_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PLAN_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PLAN_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PLAN_SOURCE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.PLAN_SOURCE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PAYER_PLAN_PERIOD
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
 'PAYER_PLAN_PERIOD.SPONSOR_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.SPONSOR_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.SPONSOR_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.SPONSOR_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.SPONSOR_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PAYER_PLAN_PERIOD
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
 'PAYER_PLAN_PERIOD.SPONSOR_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.SPONSOR_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.SPONSOR_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.SPONSOR_SOURCE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.SPONSOR_SOURCE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PAYER_PLAN_PERIOD
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
 'PAYER_PLAN_PERIOD.STOP_REASON_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.STOP_REASON_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.STOP_REASON_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.STOP_REASON_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.STOP_REASON_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PAYER_PLAN_PERIOD
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
 'PAYER_PLAN_PERIOD.STOP_REASON_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.STOP_REASON_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.STOP_REASON_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.STOP_REASON_SOURCE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.STOP_REASON_SOURCE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PAYER_PLAN_PERIOD
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
 'PERSON.CARE_SITE_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PERSON cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.CARE_SITE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.CARE_SITE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.CARE_SITE_ID) AS STRING),'.') != 0))
 AND cdmTable.CARE_SITE_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PERSON
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
 'PERSON.DAY_OF_BIRTH' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PERSON cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.DAY_OF_BIRTH AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.DAY_OF_BIRTH AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.DAY_OF_BIRTH) AS STRING),'.') != 0))
 AND cdmTable.DAY_OF_BIRTH IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PERSON
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
 WHERE 
 (CASE WHEN CAST(cdmTable.ETHNICITY_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.ETHNICITY_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.ETHNICITY_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.ETHNICITY_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PERSON
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
 'PERSON.ETHNICITY_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PERSON cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.ETHNICITY_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.ETHNICITY_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.ETHNICITY_SOURCE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.ETHNICITY_SOURCE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PERSON
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
 WHERE 
 (CASE WHEN CAST(cdmTable.GENDER_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.GENDER_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.GENDER_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.GENDER_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PERSON
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
 'PERSON.GENDER_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PERSON cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.GENDER_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.GENDER_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.GENDER_SOURCE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.GENDER_SOURCE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PERSON
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
 'PERSON.LOCATION_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PERSON cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.LOCATION_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.LOCATION_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.LOCATION_ID) AS STRING),'.') != 0))
 AND cdmTable.LOCATION_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PERSON
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
 'PERSON.MONTH_OF_BIRTH' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PERSON cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.MONTH_OF_BIRTH AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.MONTH_OF_BIRTH AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.MONTH_OF_BIRTH) AS STRING),'.') != 0))
 AND cdmTable.MONTH_OF_BIRTH IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PERSON
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
 'PERSON.PERSON_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PERSON cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PERSON_ID) AS STRING),'.') != 0))
 AND cdmTable.PERSON_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PERSON
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
 'PERSON.PROVIDER_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PERSON cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PROVIDER_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PROVIDER_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PROVIDER_ID) AS STRING),'.') != 0))
 AND cdmTable.PROVIDER_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PERSON
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
 WHERE 
 (CASE WHEN CAST(cdmTable.RACE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.RACE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.RACE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.RACE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PERSON
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
 'PERSON.RACE_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PERSON cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.RACE_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.RACE_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.RACE_SOURCE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.RACE_SOURCE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PERSON
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
 'PERSON.YEAR_OF_BIRTH' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PERSON cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.YEAR_OF_BIRTH AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.YEAR_OF_BIRTH AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.YEAR_OF_BIRTH) AS STRING),'.') != 0))
 AND cdmTable.YEAR_OF_BIRTH IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PERSON
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
 WHERE 
 (CASE WHEN CAST(cdmTable.MODIFIER_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.MODIFIER_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.MODIFIER_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.MODIFIER_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE
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
 'PROCEDURE_OCCURRENCE.PERSON_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PERSON_ID) AS STRING),'.') != 0))
 AND cdmTable.PERSON_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE
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
 WHERE 
 (CASE WHEN CAST(cdmTable.PROCEDURE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PROCEDURE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PROCEDURE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.PROCEDURE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE
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
 'PROCEDURE_OCCURRENCE.PROCEDURE_OCCURRENCE_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PROCEDURE_OCCURRENCE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PROCEDURE_OCCURRENCE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PROCEDURE_OCCURRENCE_ID) AS STRING),'.') != 0))
 AND cdmTable.PROCEDURE_OCCURRENCE_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE
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
 'PROCEDURE_OCCURRENCE.PROCEDURE_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PROCEDURE_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PROCEDURE_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PROCEDURE_SOURCE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.PROCEDURE_SOURCE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE
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
 WHERE 
 (CASE WHEN CAST(cdmTable.PROCEDURE_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PROCEDURE_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PROCEDURE_TYPE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.PROCEDURE_TYPE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE
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
 'PROCEDURE_OCCURRENCE.PROVIDER_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PROVIDER_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PROVIDER_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PROVIDER_ID) AS STRING),'.') != 0))
 AND cdmTable.PROVIDER_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE
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
 'PROCEDURE_OCCURRENCE.QUANTITY' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.QUANTITY AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.QUANTITY AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.QUANTITY) AS STRING),'.') != 0))
 AND cdmTable.QUANTITY IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE
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
 'PROCEDURE_OCCURRENCE.VISIT_DETAIL_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.VISIT_DETAIL_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.VISIT_DETAIL_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.VISIT_DETAIL_ID) AS STRING),'.') != 0))
 AND cdmTable.VISIT_DETAIL_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE
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
 'PROCEDURE_OCCURRENCE.VISIT_OCCURRENCE_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.VISIT_OCCURRENCE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.VISIT_OCCURRENCE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.VISIT_OCCURRENCE_ID) AS STRING),'.') != 0))
 AND cdmTable.VISIT_OCCURRENCE_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE
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
 'PROVIDER.CARE_SITE_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PROVIDER cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.CARE_SITE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.CARE_SITE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.CARE_SITE_ID) AS STRING),'.') != 0))
 AND cdmTable.CARE_SITE_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PROVIDER
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
 WHERE 
 (CASE WHEN CAST(cdmTable.GENDER_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.GENDER_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.GENDER_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.GENDER_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PROVIDER
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
 'PROVIDER.GENDER_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PROVIDER cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.GENDER_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.GENDER_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.GENDER_SOURCE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.GENDER_SOURCE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PROVIDER
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
 'PROVIDER.PROVIDER_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PROVIDER cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PROVIDER_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PROVIDER_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PROVIDER_ID) AS STRING),'.') != 0))
 AND cdmTable.PROVIDER_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PROVIDER
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
 WHERE 
 (CASE WHEN CAST(cdmTable.SPECIALTY_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.SPECIALTY_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.SPECIALTY_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.SPECIALTY_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PROVIDER
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
 'PROVIDER.SPECIALTY_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PROVIDER cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.SPECIALTY_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.SPECIALTY_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.SPECIALTY_SOURCE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.SPECIALTY_SOURCE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PROVIDER
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
 'PROVIDER.YEAR_OF_BIRTH' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PROVIDER cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.YEAR_OF_BIRTH AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.YEAR_OF_BIRTH AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.YEAR_OF_BIRTH) AS STRING),'.') != 0))
 AND cdmTable.YEAR_OF_BIRTH IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PROVIDER
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
 'SOURCE_TO_CONCEPT_MAP.SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.SOURCE_TO_CONCEPT_MAP cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.SOURCE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.SOURCE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.SOURCE_TO_CONCEPT_MAP
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
 WHERE 
 (CASE WHEN CAST(cdmTable.TARGET_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.TARGET_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.TARGET_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.TARGET_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.SOURCE_TO_CONCEPT_MAP
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
 WHERE 
 (CASE WHEN CAST(cdmTable.ANATOMIC_SITE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.ANATOMIC_SITE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.ANATOMIC_SITE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.ANATOMIC_SITE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.SPECIMEN
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
 WHERE 
 (CASE WHEN CAST(cdmTable.DISEASE_STATUS_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.DISEASE_STATUS_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.DISEASE_STATUS_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.DISEASE_STATUS_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.SPECIMEN
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
 'SPECIMEN.PERSON_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.SPECIMEN cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PERSON_ID) AS STRING),'.') != 0))
 AND cdmTable.PERSON_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.SPECIMEN
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
 WHERE 
 (CASE WHEN CAST(cdmTable.SPECIMEN_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.SPECIMEN_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.SPECIMEN_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.SPECIMEN_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.SPECIMEN
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
 'SPECIMEN.SPECIMEN_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.SPECIMEN cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.SPECIMEN_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.SPECIMEN_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.SPECIMEN_ID) AS STRING),'.') != 0))
 AND cdmTable.SPECIMEN_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.SPECIMEN
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
 WHERE 
 (CASE WHEN CAST(cdmTable.SPECIMEN_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.SPECIMEN_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.SPECIMEN_TYPE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.SPECIMEN_TYPE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.SPECIMEN
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
 WHERE 
 (CASE WHEN CAST(cdmTable.UNIT_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.UNIT_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.UNIT_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.UNIT_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.SPECIMEN
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
 'VISIT_DETAIL.CARE_SITE_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.VISIT_DETAIL cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.CARE_SITE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.CARE_SITE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.CARE_SITE_ID) AS STRING),'.') != 0))
 AND cdmTable.CARE_SITE_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_DETAIL
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
 WHERE 
 (CASE WHEN CAST(cdmTable.DISCHARGED_TO_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.DISCHARGED_TO_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.DISCHARGED_TO_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.DISCHARGED_TO_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_DETAIL
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
 'VISIT_DETAIL.PARENT_VISIT_DETAIL_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.VISIT_DETAIL cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PARENT_VISIT_DETAIL_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PARENT_VISIT_DETAIL_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PARENT_VISIT_DETAIL_ID) AS STRING),'.') != 0))
 AND cdmTable.PARENT_VISIT_DETAIL_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_DETAIL
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
 'VISIT_DETAIL.PERSON_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.VISIT_DETAIL cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PERSON_ID) AS STRING),'.') != 0))
 AND cdmTable.PERSON_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_DETAIL
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
 'VISIT_DETAIL.PRECEDING_VISIT_DETAIL_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.VISIT_DETAIL cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PRECEDING_VISIT_DETAIL_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PRECEDING_VISIT_DETAIL_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PRECEDING_VISIT_DETAIL_ID) AS STRING),'.') != 0))
 AND cdmTable.PRECEDING_VISIT_DETAIL_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_DETAIL
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
 'VISIT_DETAIL.PROVIDER_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.VISIT_DETAIL cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PROVIDER_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PROVIDER_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PROVIDER_ID) AS STRING),'.') != 0))
 AND cdmTable.PROVIDER_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_DETAIL
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
 WHERE 
 (CASE WHEN CAST(cdmTable.VISIT_DETAIL_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.VISIT_DETAIL_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.VISIT_DETAIL_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.VISIT_DETAIL_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_DETAIL
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
 'VISIT_DETAIL.VISIT_DETAIL_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.VISIT_DETAIL cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.VISIT_DETAIL_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.VISIT_DETAIL_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.VISIT_DETAIL_ID) AS STRING),'.') != 0))
 AND cdmTable.VISIT_DETAIL_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_DETAIL
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
 WHERE 
 (CASE WHEN CAST(cdmTable.VISIT_DETAIL_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.VISIT_DETAIL_TYPE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.VISIT_DETAIL_TYPE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.VISIT_DETAIL_TYPE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_DETAIL
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
 'VISIT_DETAIL.VISIT_OCCURRENCE_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.VISIT_DETAIL cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.VISIT_OCCURRENCE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.VISIT_OCCURRENCE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.VISIT_OCCURRENCE_ID) AS STRING),'.') != 0))
 AND cdmTable.VISIT_OCCURRENCE_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_DETAIL
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
 WHERE 
 (CASE WHEN CAST(cdmTable.ADMITTED_FROM_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.ADMITTED_FROM_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.ADMITTED_FROM_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.ADMITTED_FROM_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_OCCURRENCE
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
 'VISIT_OCCURRENCE.CARE_SITE_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.CARE_SITE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.CARE_SITE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.CARE_SITE_ID) AS STRING),'.') != 0))
 AND cdmTable.CARE_SITE_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_OCCURRENCE
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
 WHERE 
 (CASE WHEN CAST(cdmTable.DISCHARGED_TO_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.DISCHARGED_TO_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.DISCHARGED_TO_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.DISCHARGED_TO_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_OCCURRENCE
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
 'VISIT_OCCURRENCE.PERSON_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PERSON_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PERSON_ID) AS STRING),'.') != 0))
 AND cdmTable.PERSON_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_OCCURRENCE
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
 'VISIT_OCCURRENCE.PRECEDING_VISIT_OCCURRENCE_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PRECEDING_VISIT_OCCURRENCE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PRECEDING_VISIT_OCCURRENCE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PRECEDING_VISIT_OCCURRENCE_ID) AS STRING),'.') != 0))
 AND cdmTable.PRECEDING_VISIT_OCCURRENCE_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_OCCURRENCE
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
 'VISIT_OCCURRENCE.PROVIDER_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.PROVIDER_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.PROVIDER_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.PROVIDER_ID) AS STRING),'.') != 0))
 AND cdmTable.PROVIDER_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_OCCURRENCE
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
 WHERE 
 (CASE WHEN CAST(cdmTable.VISIT_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.VISIT_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.VISIT_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.VISIT_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_OCCURRENCE
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
 'VISIT_OCCURRENCE.VISIT_OCCURRENCE_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.VISIT_OCCURRENCE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.VISIT_OCCURRENCE_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.VISIT_OCCURRENCE_ID) AS STRING),'.') != 0))
 AND cdmTable.VISIT_OCCURRENCE_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_OCCURRENCE
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
 'VISIT_OCCURRENCE.VISIT_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 WHERE 
 (CASE WHEN CAST(cdmTable.VISIT_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 0 
 OR (CASE WHEN CAST(cdmTable.VISIT_SOURCE_CONCEPT_ID AS DOUBLE) IS NOT NULL THEN 1 ELSE 0 END = 1 
 AND INSTR(CAST(ABS(cdmTable.VISIT_SOURCE_CONCEPT_ID) AS STRING),'.') != 0))
 AND cdmTable.VISIT_SOURCE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_OCCURRENCE
) denominator;
