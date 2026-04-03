SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PERSON cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.OBSERVATION_PERIOD cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.MEASUREMENT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.OBSERVATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DEATH cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.NOTE_NLP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.SPECIMEN cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.FACT_RELATIONSHIP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.LOCATION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CARE_SITE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PROVIDER cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.COST cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_ERA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DOSE_ERA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CONDITION_ERA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.EPISODE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.EPISODE_EVENT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.METADATA cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.CDM_SOURCE cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.SOURCE_TO_CONCEPT_MAP cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM ehr_union.DRUG_STRENGTH cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM omop_dqd.COHORT cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 num_violated_rows 
 FROM
 (
 SELECT
 CASE 
 WHEN COUNT(*) = 0 THEN 0
 ELSE 0
 END AS num_violated_rows
 FROM omop_dqd.COHORT_DEFINITION cdmTable
 ) violated_rows
) violated_row_count cross join (SELECT 1 AS num_rows
) denominator;
