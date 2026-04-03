SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'CDM_SOURCE.CDM_RELEASE_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.CDM_SOURCE cdmTable
 WHERE IF(try_cast(cdmTable.CDM_RELEASE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CDM_RELEASE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CDM_RELEASE_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CDM_SOURCE cdmTable
 WHERE CDM_RELEASE_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'CDM_SOURCE.SOURCE_RELEASE_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.CDM_SOURCE cdmTable
 WHERE IF(try_cast(cdmTable.SOURCE_RELEASE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.SOURCE_RELEASE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.SOURCE_RELEASE_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CDM_SOURCE cdmTable
 WHERE SOURCE_RELEASE_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'COHORT.COHORT_END_DATE' AS violating_field, 
 cdmTable.*
 FROM omop_dqd.COHORT cdmTable
 WHERE IF(try_cast(cdmTable.COHORT_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.COHORT_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.COHORT_END_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM omop_dqd.COHORT cdmTable
 WHERE COHORT_END_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'COHORT.COHORT_START_DATE' AS violating_field, 
 cdmTable.*
 FROM omop_dqd.COHORT cdmTable
 WHERE IF(try_cast(cdmTable.COHORT_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.COHORT_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.COHORT_START_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM omop_dqd.COHORT cdmTable
 WHERE COHORT_START_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'CONDITION_ERA.CONDITION_ERA_END_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.CONDITION_ERA cdmTable
 WHERE IF(try_cast(cdmTable.CONDITION_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_ERA_END_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_ERA cdmTable
 WHERE CONDITION_ERA_END_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'CONDITION_ERA.CONDITION_ERA_START_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.CONDITION_ERA cdmTable
 WHERE IF(try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_ERA cdmTable
 WHERE CONDITION_ERA_START_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'CONDITION_OCCURRENCE.CONDITION_END_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 WHERE IF(try_cast(cdmTable.CONDITION_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 WHERE CONDITION_END_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'CONDITION_OCCURRENCE.CONDITION_END_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 WHERE IF(try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 WHERE CONDITION_END_DATETIME IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'CONDITION_OCCURRENCE.CONDITION_START_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 WHERE IF(try_cast(cdmTable.CONDITION_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 WHERE CONDITION_START_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'CONDITION_OCCURRENCE.CONDITION_START_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 WHERE IF(try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 WHERE CONDITION_START_DATETIME IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DEATH.DEATH_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DEATH cdmTable
 WHERE IF(try_cast(cdmTable.DEATH_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEATH_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEATH_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DEATH cdmTable
 WHERE DEATH_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DEATH.DEATH_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DEATH cdmTable
 WHERE IF(try_cast(cdmTable.DEATH_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEATH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEATH_DATETIME  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DEATH cdmTable
 WHERE DEATH_DATETIME IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DEVICE_EXPOSURE.DEVICE_EXPOSURE_END_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 WHERE IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 WHERE DEVICE_EXPOSURE_END_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DEVICE_EXPOSURE.DEVICE_EXPOSURE_END_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 WHERE IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 WHERE DEVICE_EXPOSURE_END_DATETIME IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DEVICE_EXPOSURE.DEVICE_EXPOSURE_START_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 WHERE IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 WHERE DEVICE_EXPOSURE_START_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DEVICE_EXPOSURE.DEVICE_EXPOSURE_START_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 WHERE IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 WHERE DEVICE_EXPOSURE_START_DATETIME IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DOSE_ERA.DOSE_ERA_END_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DOSE_ERA cdmTable
 WHERE IF(try_cast(cdmTable.DOSE_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DOSE_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DOSE_ERA_END_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DOSE_ERA cdmTable
 WHERE DOSE_ERA_END_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DOSE_ERA.DOSE_ERA_START_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DOSE_ERA cdmTable
 WHERE IF(try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DOSE_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DOSE_ERA cdmTable
 WHERE DOSE_ERA_START_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_ERA.DRUG_ERA_END_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_ERA cdmTable
 WHERE IF(try_cast(cdmTable.DRUG_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_ERA_END_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_ERA cdmTable
 WHERE DRUG_ERA_END_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_ERA.DRUG_ERA_START_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_ERA cdmTable
 WHERE IF(try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_ERA cdmTable
 WHERE DRUG_ERA_START_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 WHERE cdmTable.DAYS_SUPPLY > 365
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE DAYS_SUPPLY IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_EXPOSURE.DRUG_EXPOSURE_END_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE DRUG_EXPOSURE_END_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_EXPOSURE.DRUG_EXPOSURE_END_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE DRUG_EXPOSURE_END_DATETIME IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_EXPOSURE.DRUG_EXPOSURE_START_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE DRUG_EXPOSURE_START_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_EXPOSURE.DRUG_EXPOSURE_START_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE DRUG_EXPOSURE_START_DATETIME IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_EXPOSURE.QUANTITY' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE cdmTable.QUANTITY > 1095
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE QUANTITY IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 WHERE cdmTable.REFILLS > 24
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE REFILLS IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_EXPOSURE.VERBATIM_END_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE IF(try_cast(cdmTable.VERBATIM_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VERBATIM_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VERBATIM_END_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE VERBATIM_END_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'EPISODE.EPISODE_END_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.EPISODE cdmTable
 WHERE IF(try_cast(cdmTable.EPISODE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.EPISODE cdmTable
 WHERE EPISODE_END_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'EPISODE.EPISODE_END_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.EPISODE cdmTable
 WHERE IF(try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.EPISODE cdmTable
 WHERE EPISODE_END_DATETIME IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'EPISODE.EPISODE_START_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.EPISODE cdmTable
 WHERE IF(try_cast(cdmTable.EPISODE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.EPISODE cdmTable
 WHERE EPISODE_START_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'EPISODE.EPISODE_START_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.EPISODE cdmTable
 WHERE IF(try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.EPISODE cdmTable
 WHERE EPISODE_START_DATETIME IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'MEASUREMENT.MEASUREMENT_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.MEASUREMENT cdmTable
 WHERE IF(try_cast(cdmTable.MEASUREMENT_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.MEASUREMENT_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.MEASUREMENT_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT cdmTable
 WHERE MEASUREMENT_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'MEASUREMENT.MEASUREMENT_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.MEASUREMENT cdmTable
 WHERE IF(try_cast(cdmTable.MEASUREMENT_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.MEASUREMENT_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.MEASUREMENT_DATETIME  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT cdmTable
 WHERE MEASUREMENT_DATETIME IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'NOTE.NOTE_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.NOTE cdmTable
 WHERE IF(try_cast(cdmTable.NOTE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.NOTE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.NOTE_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.NOTE cdmTable
 WHERE NOTE_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'NOTE.NOTE_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.NOTE cdmTable
 WHERE IF(try_cast(cdmTable.NOTE_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.NOTE_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.NOTE_DATETIME  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.NOTE cdmTable
 WHERE NOTE_DATETIME IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'NOTE_NLP.NLP_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.NOTE_NLP cdmTable
 WHERE IF(try_cast(cdmTable.NLP_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.NLP_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.NLP_DATETIME  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.NOTE_NLP cdmTable
 WHERE NLP_DATETIME IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'OBSERVATION.OBSERVATION_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.OBSERVATION cdmTable
 WHERE IF(try_cast(cdmTable.OBSERVATION_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.OBSERVATION cdmTable
 WHERE OBSERVATION_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'OBSERVATION.OBSERVATION_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.OBSERVATION cdmTable
 WHERE IF(try_cast(cdmTable.OBSERVATION_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_DATETIME  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.OBSERVATION cdmTable
 WHERE OBSERVATION_DATETIME IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'OBSERVATION_PERIOD.OBSERVATION_PERIOD_END_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.OBSERVATION_PERIOD cdmTable
 WHERE IF(try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.OBSERVATION_PERIOD cdmTable
 WHERE OBSERVATION_PERIOD_END_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'OBSERVATION_PERIOD.OBSERVATION_PERIOD_START_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.OBSERVATION_PERIOD cdmTable
 WHERE IF(try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.OBSERVATION_PERIOD cdmTable
 WHERE OBSERVATION_PERIOD_START_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'PAYER_PLAN_PERIOD.PAYER_PLAN_PERIOD_END_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 WHERE IF(try_cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 WHERE PAYER_PLAN_PERIOD_END_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'PAYER_PLAN_PERIOD.PAYER_PLAN_PERIOD_START_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 WHERE IF(try_cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 WHERE PAYER_PLAN_PERIOD_START_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'PERSON.BIRTH_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PERSON cdmTable
 WHERE IF(try_cast(cdmTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.BIRTH_DATETIME  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PERSON cdmTable
 WHERE BIRTH_DATETIME IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 WHERE cdmTable.DAY_OF_BIRTH > 31
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PERSON cdmTable
 WHERE DAY_OF_BIRTH IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 WHERE cdmTable.MONTH_OF_BIRTH > 12
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PERSON cdmTable
 WHERE MONTH_OF_BIRTH IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 WHERE cdmTable.YEAR_OF_BIRTH > YEAR(CURRENT_DATE)+1
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PERSON cdmTable
 WHERE YEAR_OF_BIRTH IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'PROCEDURE_OCCURRENCE.PROCEDURE_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 WHERE IF(try_cast(cdmTable.PROCEDURE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 WHERE PROCEDURE_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'PROCEDURE_OCCURRENCE.PROCEDURE_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 WHERE IF(try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 WHERE PROCEDURE_DATETIME IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'PROCEDURE_OCCURRENCE.PROCEDURE_END_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 WHERE IF(try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 WHERE PROCEDURE_END_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'PROCEDURE_OCCURRENCE.PROCEDURE_END_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 WHERE IF(try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 WHERE PROCEDURE_END_DATETIME IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'SPECIMEN.SPECIMEN_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.SPECIMEN cdmTable
 WHERE IF(try_cast(cdmTable.SPECIMEN_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.SPECIMEN_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.SPECIMEN_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.SPECIMEN cdmTable
 WHERE SPECIMEN_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'SPECIMEN.SPECIMEN_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.SPECIMEN cdmTable
 WHERE IF(try_cast(cdmTable.SPECIMEN_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.SPECIMEN_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.SPECIMEN_DATETIME  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.SPECIMEN cdmTable
 WHERE SPECIMEN_DATETIME IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_DETAIL.VISIT_DETAIL_END_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_DETAIL cdmTable
 WHERE IF(try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 WHERE VISIT_DETAIL_END_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_DETAIL.VISIT_DETAIL_END_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_DETAIL cdmTable
 WHERE IF(try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 WHERE VISIT_DETAIL_END_DATETIME IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_DETAIL.VISIT_DETAIL_START_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_DETAIL cdmTable
 WHERE IF(try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 WHERE VISIT_DETAIL_START_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_DETAIL.VISIT_DETAIL_START_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_DETAIL cdmTable
 WHERE IF(try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 WHERE VISIT_DETAIL_START_DATETIME IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_OCCURRENCE.VISIT_END_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 WHERE IF(try_cast(cdmTable.VISIT_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 WHERE VISIT_END_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_OCCURRENCE.VISIT_END_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 WHERE IF(try_cast(cdmTable.VISIT_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATETIME  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 WHERE VISIT_END_DATETIME IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_OCCURRENCE.VISIT_START_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 WHERE IF(try_cast(cdmTable.VISIT_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATE  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 WHERE VISIT_START_DATE IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.violating_field) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_OCCURRENCE.VISIT_START_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 WHERE IF(try_cast(cdmTable.VISIT_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATETIME  AS DATE)) > IF(try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE) IS NULL, to_date(cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS STRING), 'yyyyMMdd'), try_cast(CAST(DATEADD(day,1,CURRENT_DATE) AS DATE)  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 WHERE VISIT_START_DATETIME IS NOT NULL
) denominator;
