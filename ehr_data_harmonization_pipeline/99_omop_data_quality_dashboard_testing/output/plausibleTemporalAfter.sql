SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 WHERE 
 IF(try_cast(cdmTable.SOURCE_RELEASE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.SOURCE_RELEASE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.SOURCE_RELEASE_DATE  AS DATE))
 > IF(try_cast(cdmTable.CDM_RELEASE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CDM_RELEASE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CDM_RELEASE_DATE  AS DATE))
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
 'CONDITION_ERA.CONDITION_ERA_END_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.CONDITION_ERA cdmTable
 WHERE 
 IF(try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE))
 > IF(try_cast(cdmTable.CONDITION_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_ERA_END_DATE  AS DATE))
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
 'CONDITION_ERA.CONDITION_ERA_START_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.CONDITION_ERA cdmTable
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE))
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
 'CONDITION_OCCURRENCE.CONDITION_END_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 WHERE 
 IF(try_cast(cdmTable.CONDITION_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATE  AS DATE))
 > IF(try_cast(cdmTable.CONDITION_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATE  AS DATE))
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
 'CONDITION_OCCURRENCE.CONDITION_END_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 WHERE 
 IF(try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE))
 > IF(try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE))
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
 'CONDITION_OCCURRENCE.CONDITION_START_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.CONDITION_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATE  AS DATE))
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
 'CONDITION_OCCURRENCE.CONDITION_START_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE))
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
 'DEATH.DEATH_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DEATH cdmTable
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.DEATH_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEATH_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEATH_DATE  AS DATE))
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
 'DEATH.DEATH_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DEATH cdmTable
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.DEATH_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEATH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEATH_DATETIME  AS DATE))
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
 'DEVICE_EXPOSURE.DEVICE_EXPOSURE_END_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 WHERE 
 IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE))
 > IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE))
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
 'DEVICE_EXPOSURE.DEVICE_EXPOSURE_END_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 WHERE 
 IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE))
 > IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE))
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
 'DEVICE_EXPOSURE.DEVICE_EXPOSURE_START_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE))
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
 'DEVICE_EXPOSURE.DEVICE_EXPOSURE_START_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE))
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
 'DOSE_ERA.DOSE_ERA_END_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DOSE_ERA cdmTable
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.DOSE_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DOSE_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DOSE_ERA_END_DATE  AS DATE))
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
 'DOSE_ERA.DOSE_ERA_START_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DOSE_ERA cdmTable
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DOSE_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE))
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
 'DRUG_ERA.DRUG_ERA_END_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_ERA cdmTable
 WHERE 
 IF(try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE))
 > IF(try_cast(cdmTable.DRUG_ERA_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_ERA_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_ERA_END_DATE  AS DATE))
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
 'DRUG_ERA.DRUG_ERA_START_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_ERA cdmTable
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE))
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
 'DRUG_EXPOSURE.DRUG_EXPOSURE_END_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE 
 IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE))
 > IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE))
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
 'DRUG_EXPOSURE.DRUG_EXPOSURE_END_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE 
 IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE))
 > IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE))
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
 'DRUG_EXPOSURE.DRUG_EXPOSURE_START_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE))
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
 'DRUG_EXPOSURE.DRUG_EXPOSURE_START_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE))
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
 'DRUG_EXPOSURE.VERBATIM_END_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE 
 IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE))
 > IF(try_cast(cdmTable.VERBATIM_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VERBATIM_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VERBATIM_END_DATE  AS DATE))
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
 'DRUG_STRENGTH.VALID_END_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_STRENGTH cdmTable
 WHERE 
 IF(try_cast(cdmTable.VALID_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VALID_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VALID_START_DATE  AS DATE))
 > IF(try_cast(cdmTable.VALID_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VALID_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VALID_END_DATE  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_STRENGTH cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 WHERE 
 IF(try_cast(cdmTable.EPISODE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATE  AS DATE))
 > IF(try_cast(cdmTable.EPISODE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATE  AS DATE))
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
 'EPISODE.EPISODE_END_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.EPISODE cdmTable
 WHERE 
 IF(try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE))
 > IF(try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE))
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
 'EPISODE.EPISODE_START_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.EPISODE cdmTable
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.EPISODE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATE  AS DATE))
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
 'EPISODE.EPISODE_START_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.EPISODE cdmTable
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE))
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
 'MEASUREMENT.MEASUREMENT_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.MEASUREMENT cdmTable
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.MEASUREMENT_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.MEASUREMENT_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.MEASUREMENT_DATE  AS DATE))
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
 'NOTE.NOTE_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.NOTE cdmTable
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.NOTE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.NOTE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.NOTE_DATE  AS DATE))
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
 'NOTE.NOTE_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.NOTE cdmTable
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.NOTE_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.NOTE_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.NOTE_DATETIME  AS DATE))
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
 'OBSERVATION.OBSERVATION_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.OBSERVATION cdmTable
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.OBSERVATION_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_DATE  AS DATE))
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
 'OBSERVATION.OBSERVATION_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.OBSERVATION cdmTable
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.OBSERVATION_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_DATETIME  AS DATE))
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
 'OBSERVATION_PERIOD.OBSERVATION_PERIOD_END_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.OBSERVATION_PERIOD cdmTable
 WHERE 
 IF(try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE))
 > IF(try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE))
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
 'OBSERVATION_PERIOD.OBSERVATION_PERIOD_START_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.OBSERVATION_PERIOD cdmTable
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE))
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
 'PAYER_PLAN_PERIOD.PAYER_PLAN_PERIOD_END_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 WHERE 
 IF(try_cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS DATE))
 > IF(try_cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PAYER_PLAN_PERIOD_END_DATE  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PAYER_PLAN_PERIOD_START_DATE  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.PROCEDURE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATE  AS DATE))
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
 'PROCEDURE_OCCURRENCE.PROCEDURE_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE))
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
 'PROCEDURE_OCCURRENCE.PROCEDURE_END_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 WHERE 
 IF(try_cast(cdmTable.PROCEDURE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATE  AS DATE))
 > IF(try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE))
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
 'PROCEDURE_OCCURRENCE.PROCEDURE_END_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 WHERE 
 IF(try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE))
 > IF(try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE))
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
 'SOURCE_TO_CONCEPT_MAP.VALID_END_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.SOURCE_TO_CONCEPT_MAP cdmTable
 WHERE 
 IF(try_cast(cdmTable.VALID_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VALID_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VALID_START_DATE  AS DATE))
 > IF(try_cast(cdmTable.VALID_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VALID_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VALID_END_DATE  AS DATE))
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
 'SPECIMEN.SPECIMEN_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.SPECIMEN cdmTable
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.SPECIMEN_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.SPECIMEN_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.SPECIMEN_DATE  AS DATE))
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
 'SPECIMEN.SPECIMEN_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.SPECIMEN cdmTable
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.SPECIMEN_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.SPECIMEN_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.SPECIMEN_DATETIME  AS DATE))
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
 'VISIT_DETAIL.VISIT_DETAIL_END_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_DETAIL cdmTable
 WHERE 
 IF(try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE))
 > IF(try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE))
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
 'VISIT_DETAIL.VISIT_DETAIL_END_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_DETAIL cdmTable
 WHERE 
 IF(try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE))
 > IF(try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE))
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
 'VISIT_DETAIL.VISIT_DETAIL_START_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_DETAIL cdmTable
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE))
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
 'VISIT_DETAIL.VISIT_DETAIL_START_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_DETAIL cdmTable
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE))
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
 'VISIT_OCCURRENCE.VISIT_END_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 WHERE 
 IF(try_cast(cdmTable.VISIT_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATE  AS DATE))
 > IF(try_cast(cdmTable.VISIT_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATE  AS DATE))
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
 'VISIT_OCCURRENCE.VISIT_END_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 WHERE 
 IF(try_cast(cdmTable.VISIT_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATETIME  AS DATE))
 > IF(try_cast(cdmTable.VISIT_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATETIME  AS DATE))
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
 'VISIT_OCCURRENCE.VISIT_START_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.VISIT_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATE  AS DATE))
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
 'VISIT_OCCURRENCE.VISIT_START_DATETIME' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 JOIN ehr_union.PERSON plausibleTable 
 ON cdmTable.person_id = plausibleTable.person_id
 WHERE 
 COALESCE(
 IF(try_cast(plausibleTable.BIRTH_DATETIME  AS DATE) IS NULL, to_date(cast(plausibleTable.BIRTH_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(plausibleTable.BIRTH_DATETIME  AS DATE)),
 IF(try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE) IS NULL, to_date(cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS STRING), 'yyyyMMdd'), try_cast(CONCAT(plausibleTable.year_of_birth,'0601')  AS DATE))
 ) 
 > IF(try_cast(cdmTable.VISIT_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATETIME  AS DATE))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
) denominator;
