SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CARE_SITE_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CARE_SITE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CARE_SITE_NAME) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CARE_SITE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CARE_SITE_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CARE_SITE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(LOCATION_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CARE_SITE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PLACE_OF_SERVICE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CARE_SITE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PLACE_OF_SERVICE_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CARE_SITE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CDM_ETL_REFERENCE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CDM_SOURCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CDM_HOLDER) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CDM_SOURCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CDM_RELEASE_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CDM_SOURCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CDM_SOURCE_ABBREVIATION) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CDM_SOURCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CDM_SOURCE_NAME) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CDM_SOURCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CDM_VERSION) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CDM_SOURCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CDM_VERSION_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CDM_SOURCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(SOURCE_DESCRIPTION) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CDM_SOURCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(SOURCE_DOCUMENTATION_REFERENCE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CDM_SOURCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(SOURCE_RELEASE_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CDM_SOURCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VOCABULARY_VERSION) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CDM_SOURCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(COHORT_DEFINITION_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM omop_dqd.COHORT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(COHORT_END_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM omop_dqd.COHORT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(COHORT_START_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM omop_dqd.COHORT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(SUBJECT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM omop_dqd.COHORT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(COHORT_DEFINITION_DESCRIPTION) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM omop_dqd.COHORT_DEFINITION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(COHORT_DEFINITION_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM omop_dqd.COHORT_DEFINITION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(COHORT_DEFINITION_NAME) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM omop_dqd.COHORT_DEFINITION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(COHORT_DEFINITION_SYNTAX) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM omop_dqd.COHORT_DEFINITION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(COHORT_INITIATION_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM omop_dqd.COHORT_DEFINITION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DEFINITION_TYPE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM omop_dqd.COHORT_DEFINITION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(SUBJECT_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM omop_dqd.COHORT_DEFINITION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CONDITION_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CONDITION_ERA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CONDITION_ERA_END_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CONDITION_ERA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CONDITION_ERA_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CONDITION_ERA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CONDITION_ERA_START_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CONDITION_ERA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CONDITION_OCCURRENCE_COUNT) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CONDITION_ERA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PERSON_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CONDITION_ERA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CONDITION_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CONDITION_END_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CONDITION_END_DATETIME) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CONDITION_OCCURRENCE_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CONDITION_SOURCE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CONDITION_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CONDITION_START_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CONDITION_START_DATETIME) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CONDITION_STATUS_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CONDITION_STATUS_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CONDITION_TYPE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PERSON_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PROVIDER_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(STOP_REASON) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_DETAIL_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_OCCURRENCE_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(AMOUNT_ALLOWED) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.COST cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(COST_DOMAIN_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.COST cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(COST_EVENT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.COST cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(COST_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.COST cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(COST_TYPE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.COST cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CURRENCY_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.COST cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DRG_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.COST cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DRG_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.COST cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PAID_BY_PATIENT) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.COST cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PAID_BY_PAYER) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.COST cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PAID_BY_PRIMARY) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.COST cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PAID_DISPENSING_FEE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.COST cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PAID_INGREDIENT_COST) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.COST cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PAID_PATIENT_COINSURANCE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.COST cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PAID_PATIENT_COPAY) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.COST cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PAID_PATIENT_DEDUCTIBLE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.COST cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PAYER_PLAN_PERIOD_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.COST cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(REVENUE_CODE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.COST cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(REVENUE_CODE_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.COST cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(TOTAL_CHARGE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.COST cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(TOTAL_COST) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.COST cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(TOTAL_PAID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.COST cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CAUSE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DEATH cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CAUSE_SOURCE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DEATH cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CAUSE_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DEATH cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DEATH_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DEATH cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DEATH_DATETIME) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DEATH cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DEATH_TYPE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DEATH cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PERSON_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DEATH cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DEVICE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DEVICE_EXPOSURE_END_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DEVICE_EXPOSURE_END_DATETIME) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DEVICE_EXPOSURE_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DEVICE_EXPOSURE_START_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DEVICE_EXPOSURE_START_DATETIME) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DEVICE_SOURCE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DEVICE_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DEVICE_TYPE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PERSON_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PRODUCTION_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PROVIDER_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(QUANTITY) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(UNIQUE_DEVICE_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(UNIT_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(UNIT_SOURCE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(UNIT_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_DETAIL_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_OCCURRENCE_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DOSE_ERA_END_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DOSE_ERA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DOSE_ERA_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DOSE_ERA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DOSE_ERA_START_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DOSE_ERA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DOSE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DOSE_ERA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DRUG_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DOSE_ERA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PERSON_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DOSE_ERA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(UNIT_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DOSE_ERA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DRUG_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_ERA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DRUG_ERA_END_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_ERA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DRUG_ERA_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_ERA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DRUG_ERA_START_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_ERA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DRUG_EXPOSURE_COUNT) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_ERA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(GAP_DAYS) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_ERA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PERSON_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_ERA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DAYS_SUPPLY) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DOSE_UNIT_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DRUG_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DRUG_EXPOSURE_END_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DRUG_EXPOSURE_END_DATETIME) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DRUG_EXPOSURE_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DRUG_EXPOSURE_START_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DRUG_EXPOSURE_START_DATETIME) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DRUG_SOURCE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DRUG_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DRUG_TYPE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(LOT_NUMBER) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PERSON_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PROVIDER_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(QUANTITY) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(REFILLS) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(ROUTE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(ROUTE_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(SIG) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(STOP_REASON) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VERBATIM_END_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_DETAIL_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_OCCURRENCE_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(AMOUNT_UNIT_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_STRENGTH cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(AMOUNT_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_STRENGTH cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(BOX_SIZE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_STRENGTH cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DENOMINATOR_UNIT_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_STRENGTH cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DENOMINATOR_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_STRENGTH cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DRUG_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_STRENGTH cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(INGREDIENT_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_STRENGTH cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(INVALID_REASON) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_STRENGTH cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(NUMERATOR_UNIT_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_STRENGTH cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(NUMERATOR_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_STRENGTH cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VALID_END_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_STRENGTH cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VALID_START_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_STRENGTH cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(EPISODE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.EPISODE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(EPISODE_END_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.EPISODE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(EPISODE_END_DATETIME) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.EPISODE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(EPISODE_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.EPISODE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(EPISODE_NUMBER) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.EPISODE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(EPISODE_OBJECT_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.EPISODE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(EPISODE_PARENT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.EPISODE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(EPISODE_SOURCE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.EPISODE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(EPISODE_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.EPISODE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(EPISODE_START_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.EPISODE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(EPISODE_START_DATETIME) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.EPISODE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(EPISODE_TYPE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.EPISODE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PERSON_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.EPISODE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(EPISODE_EVENT_FIELD_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.EPISODE_EVENT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(EPISODE_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.EPISODE_EVENT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(EVENT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.EPISODE_EVENT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DOMAIN_CONCEPT_ID_1) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.FACT_RELATIONSHIP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DOMAIN_CONCEPT_ID_2) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.FACT_RELATIONSHIP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(FACT_ID_1) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.FACT_RELATIONSHIP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(FACT_ID_2) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.FACT_RELATIONSHIP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(RELATIONSHIP_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.FACT_RELATIONSHIP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(ADDRESS_1) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.LOCATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(ADDRESS_2) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.LOCATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CITY) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.LOCATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(COUNTRY_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.LOCATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(COUNTRY_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.LOCATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(COUNTY) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.LOCATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(LATITUDE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.LOCATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(LOCATION_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.LOCATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(LOCATION_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.LOCATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(LONGITUDE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.LOCATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(STATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.LOCATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(ZIP) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.LOCATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(MEAS_EVENT_FIELD_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.MEASUREMENT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(MEASUREMENT_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.MEASUREMENT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(MEASUREMENT_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.MEASUREMENT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(MEASUREMENT_DATETIME) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.MEASUREMENT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(MEASUREMENT_EVENT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.MEASUREMENT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(MEASUREMENT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.MEASUREMENT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(MEASUREMENT_SOURCE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.MEASUREMENT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(MEASUREMENT_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.MEASUREMENT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(MEASUREMENT_TIME) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.MEASUREMENT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(MEASUREMENT_TYPE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.MEASUREMENT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(OPERATOR_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.MEASUREMENT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PERSON_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.MEASUREMENT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PROVIDER_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.MEASUREMENT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(RANGE_HIGH) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.MEASUREMENT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(RANGE_LOW) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.MEASUREMENT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(UNIT_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.MEASUREMENT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(UNIT_SOURCE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.MEASUREMENT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(UNIT_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.MEASUREMENT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VALUE_AS_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.MEASUREMENT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VALUE_AS_NUMBER) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.MEASUREMENT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VALUE_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.MEASUREMENT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_DETAIL_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.MEASUREMENT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_OCCURRENCE_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.MEASUREMENT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(METADATA_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.METADATA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(METADATA_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.METADATA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(METADATA_DATETIME) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.METADATA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(METADATA_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.METADATA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(METADATA_TYPE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.METADATA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(NAME) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.METADATA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VALUE_AS_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.METADATA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VALUE_AS_NUMBER) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.METADATA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VALUE_AS_STRING) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.METADATA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(ENCODING_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(LANGUAGE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(NOTE_CLASS_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(NOTE_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(NOTE_DATETIME) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(NOTE_EVENT_FIELD_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(NOTE_EVENT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(NOTE_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(NOTE_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(NOTE_TEXT) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(NOTE_TITLE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(NOTE_TYPE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PERSON_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PROVIDER_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_DETAIL_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_OCCURRENCE_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(LEXICAL_VARIANT) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE_NLP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(NLP_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE_NLP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(NLP_DATETIME) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE_NLP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(NLP_SYSTEM) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE_NLP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(NOTE_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE_NLP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(NOTE_NLP_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE_NLP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(NOTE_NLP_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE_NLP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(NOTE_NLP_SOURCE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE_NLP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(SECTION_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE_NLP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(SNIPPET) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE_NLP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(TERM_EXISTS) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE_NLP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(TERM_MODIFIERS) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE_NLP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(TERM_TEMPORAL) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE_NLP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(OBS_EVENT_FIELD_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.OBSERVATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(OBSERVATION_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.OBSERVATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(OBSERVATION_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.OBSERVATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(OBSERVATION_DATETIME) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.OBSERVATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(OBSERVATION_EVENT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.OBSERVATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(OBSERVATION_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.OBSERVATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(OBSERVATION_SOURCE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.OBSERVATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(OBSERVATION_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.OBSERVATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(OBSERVATION_TYPE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.OBSERVATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PERSON_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.OBSERVATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PROVIDER_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.OBSERVATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(QUALIFIER_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.OBSERVATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(QUALIFIER_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.OBSERVATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(UNIT_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.OBSERVATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(UNIT_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.OBSERVATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VALUE_AS_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.OBSERVATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VALUE_AS_NUMBER) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.OBSERVATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VALUE_AS_STRING) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.OBSERVATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VALUE_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.OBSERVATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_DETAIL_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.OBSERVATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_OCCURRENCE_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.OBSERVATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(OBSERVATION_PERIOD_END_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.OBSERVATION_PERIOD cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(OBSERVATION_PERIOD_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.OBSERVATION_PERIOD cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(OBSERVATION_PERIOD_START_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.OBSERVATION_PERIOD cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PERIOD_TYPE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.OBSERVATION_PERIOD cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PERSON_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.OBSERVATION_PERIOD cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(FAMILY_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PAYER_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PAYER_PLAN_PERIOD_END_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PAYER_PLAN_PERIOD_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PAYER_PLAN_PERIOD_START_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PAYER_SOURCE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PAYER_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PERSON_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PLAN_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PLAN_SOURCE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PLAN_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(SPONSOR_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(SPONSOR_SOURCE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(SPONSOR_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(STOP_REASON_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(STOP_REASON_SOURCE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(STOP_REASON_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(BIRTH_DATETIME) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PERSON cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CARE_SITE_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PERSON cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DAY_OF_BIRTH) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PERSON cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(ETHNICITY_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PERSON cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(ETHNICITY_SOURCE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PERSON cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(ETHNICITY_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PERSON cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(GENDER_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PERSON cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(GENDER_SOURCE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PERSON cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(GENDER_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PERSON cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(LOCATION_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PERSON cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(MONTH_OF_BIRTH) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PERSON cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PERSON_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PERSON cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PERSON_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PERSON cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PROVIDER_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PERSON cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(RACE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PERSON cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(RACE_SOURCE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PERSON cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(RACE_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PERSON cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(YEAR_OF_BIRTH) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PERSON cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(MODIFIER_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(MODIFIER_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PERSON_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PROCEDURE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PROCEDURE_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PROCEDURE_DATETIME) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PROCEDURE_END_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PROCEDURE_END_DATETIME) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PROCEDURE_OCCURRENCE_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PROCEDURE_SOURCE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PROCEDURE_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PROCEDURE_TYPE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PROVIDER_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(QUANTITY) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_DETAIL_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_OCCURRENCE_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CARE_SITE_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROVIDER cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DEA) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROVIDER cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(GENDER_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROVIDER cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(GENDER_SOURCE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROVIDER cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(GENDER_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROVIDER cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(NPI) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROVIDER cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PROVIDER_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROVIDER cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PROVIDER_NAME) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROVIDER cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PROVIDER_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROVIDER cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(SPECIALTY_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROVIDER cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(SPECIALTY_SOURCE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROVIDER cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(SPECIALTY_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROVIDER cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(YEAR_OF_BIRTH) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROVIDER cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(INVALID_REASON) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.SOURCE_TO_CONCEPT_MAP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(SOURCE_CODE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.SOURCE_TO_CONCEPT_MAP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(SOURCE_CODE_DESCRIPTION) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.SOURCE_TO_CONCEPT_MAP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(SOURCE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.SOURCE_TO_CONCEPT_MAP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(SOURCE_VOCABULARY_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.SOURCE_TO_CONCEPT_MAP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(TARGET_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.SOURCE_TO_CONCEPT_MAP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(TARGET_VOCABULARY_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.SOURCE_TO_CONCEPT_MAP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VALID_END_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.SOURCE_TO_CONCEPT_MAP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VALID_START_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.SOURCE_TO_CONCEPT_MAP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(ANATOMIC_SITE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.SPECIMEN cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(ANATOMIC_SITE_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.SPECIMEN cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DISEASE_STATUS_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.SPECIMEN cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DISEASE_STATUS_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.SPECIMEN cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PERSON_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.SPECIMEN cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(QUANTITY) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.SPECIMEN cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(SPECIMEN_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.SPECIMEN cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(SPECIMEN_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.SPECIMEN cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(SPECIMEN_DATETIME) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.SPECIMEN cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(SPECIMEN_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.SPECIMEN cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(SPECIMEN_SOURCE_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.SPECIMEN cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(SPECIMEN_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.SPECIMEN cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(SPECIMEN_TYPE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.SPECIMEN cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(UNIT_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.SPECIMEN cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(UNIT_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.SPECIMEN cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(ADMITTED_FROM_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(ADMITTED_FROM_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CARE_SITE_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DISCHARGED_TO_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DISCHARGED_TO_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PARENT_VISIT_DETAIL_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PERSON_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PRECEDING_VISIT_DETAIL_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PROVIDER_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_DETAIL_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_DETAIL_END_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_DETAIL_END_DATETIME) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_DETAIL_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_DETAIL_SOURCE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_DETAIL_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_DETAIL_START_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_DETAIL_START_DATETIME) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_DETAIL_TYPE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_OCCURRENCE_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(ADMITTED_FROM_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(ADMITTED_FROM_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(CARE_SITE_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DISCHARGED_TO_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(DISCHARGED_TO_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PERSON_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PRECEDING_VISIT_OCCURRENCE_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(PROVIDER_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_END_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_END_DATETIME) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_OCCURRENCE_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_SOURCE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_SOURCE_VALUE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_START_DATE) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_START_DATETIME) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT num_violated_rows FROM (
 SELECT
 CASE 
 WHEN COUNT(VISIT_TYPE_CONCEPT_ID) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
