SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_ERA_START_DATE  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_ERA cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.CONDITION_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATE  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_END_DATETIME  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.CONDITION_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATE  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.CONDITION_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.CONDITION_START_DATETIME  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATE  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_END_DATETIME  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATE  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DEVICE_EXPOSURE_START_DATETIME  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DOSE_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DOSE_ERA_START_DATE  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DOSE_ERA cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_ERA_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_ERA_START_DATE  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_ERA cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATE  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_END_DATETIME  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATE  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.DRUG_EXPOSURE_START_DATETIME  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.VERBATIM_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VERBATIM_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VERBATIM_END_DATE  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.EPISODE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATE  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.EPISODE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_END_DATETIME  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.EPISODE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.EPISODE_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATE  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.EPISODE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.EPISODE_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.EPISODE_START_DATETIME  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.EPISODE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_END_DATE  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.OBSERVATION_PERIOD cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.OBSERVATION_PERIOD_START_DATE  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.OBSERVATION_PERIOD cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.PROCEDURE_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATE  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_DATETIME  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATE  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.PROCEDURE_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.PROCEDURE_END_DATETIME  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATE  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_END_DATETIME  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATE  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_DETAIL_START_DATETIME  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.VISIT_END_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATE  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.VISIT_END_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_END_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_END_DATETIME  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.VISIT_START_DATE  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATE  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATE  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 JOIN ehr_union.death de 
 ON cdmTable.person_id = de.person_id
 WHERE IF(try_cast(cdmTable.VISIT_START_DATETIME  AS DATE) IS NULL, to_date(cast(cdmTable.VISIT_START_DATETIME  AS STRING), 'yyyyMMdd'), try_cast(cdmTable.VISIT_START_DATETIME  AS DATE)) > DATEADD(day, 60, IF(try_cast(de.death_date  AS DATE) IS NULL, to_date(cast(de.death_date  AS STRING), 'yyyyMMdd'), try_cast(de.death_date  AS DATE)))
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 WHERE person_id IN
 (SELECT 
 person_id 
 FROM ehr_union.death)
) denominator;
