SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 WHERE cdmTable.CARE_SITE_ID IN ( 
 SELECT 
 CARE_SITE_ID 
 FROM ehr_union.CARE_SITE
 GROUP BY CARE_SITE_ID
 HAVING COUNT(*) > 1 
 )
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
 'CONDITION_ERA.CONDITION_ERA_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.CONDITION_ERA cdmTable
 WHERE cdmTable.CONDITION_ERA_ID IN ( 
 SELECT 
 CONDITION_ERA_ID 
 FROM ehr_union.CONDITION_ERA
 GROUP BY CONDITION_ERA_ID
 HAVING COUNT(*) > 1 
 )
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
 'CONDITION_OCCURRENCE.CONDITION_OCCURRENCE_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 WHERE cdmTable.CONDITION_OCCURRENCE_ID IN ( 
 SELECT 
 CONDITION_OCCURRENCE_ID 
 FROM ehr_union.CONDITION_OCCURRENCE
 GROUP BY CONDITION_OCCURRENCE_ID
 HAVING COUNT(*) > 1 
 )
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
 'COST.COST_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.COST cdmTable
 WHERE cdmTable.COST_ID IN ( 
 SELECT 
 COST_ID 
 FROM ehr_union.COST
 GROUP BY COST_ID
 HAVING COUNT(*) > 1 
 )
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
 'DEVICE_EXPOSURE.DEVICE_EXPOSURE_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 WHERE cdmTable.DEVICE_EXPOSURE_ID IN ( 
 SELECT 
 DEVICE_EXPOSURE_ID 
 FROM ehr_union.DEVICE_EXPOSURE
 GROUP BY DEVICE_EXPOSURE_ID
 HAVING COUNT(*) > 1 
 )
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
 'DOSE_ERA.DOSE_ERA_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DOSE_ERA cdmTable
 WHERE cdmTable.DOSE_ERA_ID IN ( 
 SELECT 
 DOSE_ERA_ID 
 FROM ehr_union.DOSE_ERA
 GROUP BY DOSE_ERA_ID
 HAVING COUNT(*) > 1 
 )
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
 'DRUG_ERA.DRUG_ERA_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DRUG_ERA cdmTable
 WHERE cdmTable.DRUG_ERA_ID IN ( 
 SELECT 
 DRUG_ERA_ID 
 FROM ehr_union.DRUG_ERA
 GROUP BY DRUG_ERA_ID
 HAVING COUNT(*) > 1 
 )
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
 'DRUG_EXPOSURE.DRUG_EXPOSURE_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE cdmTable.DRUG_EXPOSURE_ID IN ( 
 SELECT 
 DRUG_EXPOSURE_ID 
 FROM ehr_union.DRUG_EXPOSURE
 GROUP BY DRUG_EXPOSURE_ID
 HAVING COUNT(*) > 1 
 )
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
 'EPISODE.EPISODE_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.EPISODE cdmTable
 WHERE cdmTable.EPISODE_ID IN ( 
 SELECT 
 EPISODE_ID 
 FROM ehr_union.EPISODE
 GROUP BY EPISODE_ID
 HAVING COUNT(*) > 1 
 )
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
 'LOCATION.LOCATION_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.LOCATION cdmTable
 WHERE cdmTable.LOCATION_ID IN ( 
 SELECT 
 LOCATION_ID 
 FROM ehr_union.LOCATION
 GROUP BY LOCATION_ID
 HAVING COUNT(*) > 1 
 )
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
 'MEASUREMENT.MEASUREMENT_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.MEASUREMENT cdmTable
 WHERE cdmTable.MEASUREMENT_ID IN ( 
 SELECT 
 MEASUREMENT_ID 
 FROM ehr_union.MEASUREMENT
 GROUP BY MEASUREMENT_ID
 HAVING COUNT(*) > 1 
 )
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
 'METADATA.METADATA_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.METADATA cdmTable
 WHERE cdmTable.METADATA_ID IN ( 
 SELECT 
 METADATA_ID 
 FROM ehr_union.METADATA
 GROUP BY METADATA_ID
 HAVING COUNT(*) > 1 
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.METADATA cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
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
 WHERE cdmTable.NOTE_ID IN ( 
 SELECT 
 NOTE_ID 
 FROM ehr_union.NOTE
 GROUP BY NOTE_ID
 HAVING COUNT(*) > 1 
 )
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
 'NOTE_NLP.NOTE_NLP_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.NOTE_NLP cdmTable
 WHERE cdmTable.NOTE_NLP_ID IN ( 
 SELECT 
 NOTE_NLP_ID 
 FROM ehr_union.NOTE_NLP
 GROUP BY NOTE_NLP_ID
 HAVING COUNT(*) > 1 
 )
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
 'OBSERVATION.OBSERVATION_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.OBSERVATION cdmTable
 WHERE cdmTable.OBSERVATION_ID IN ( 
 SELECT 
 OBSERVATION_ID 
 FROM ehr_union.OBSERVATION
 GROUP BY OBSERVATION_ID
 HAVING COUNT(*) > 1 
 )
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
 'OBSERVATION_PERIOD.OBSERVATION_PERIOD_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.OBSERVATION_PERIOD cdmTable
 WHERE cdmTable.OBSERVATION_PERIOD_ID IN ( 
 SELECT 
 OBSERVATION_PERIOD_ID 
 FROM ehr_union.OBSERVATION_PERIOD
 GROUP BY OBSERVATION_PERIOD_ID
 HAVING COUNT(*) > 1 
 )
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
 'PAYER_PLAN_PERIOD.PAYER_PLAN_PERIOD_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 WHERE cdmTable.PAYER_PLAN_PERIOD_ID IN ( 
 SELECT 
 PAYER_PLAN_PERIOD_ID 
 FROM ehr_union.PAYER_PLAN_PERIOD
 GROUP BY PAYER_PLAN_PERIOD_ID
 HAVING COUNT(*) > 1 
 )
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
 'PERSON.PERSON_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PERSON cdmTable
 WHERE cdmTable.PERSON_ID IN ( 
 SELECT 
 PERSON_ID 
 FROM ehr_union.PERSON
 GROUP BY PERSON_ID
 HAVING COUNT(*) > 1 
 )
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
 'PROCEDURE_OCCURRENCE.PROCEDURE_OCCURRENCE_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 WHERE cdmTable.PROCEDURE_OCCURRENCE_ID IN ( 
 SELECT 
 PROCEDURE_OCCURRENCE_ID 
 FROM ehr_union.PROCEDURE_OCCURRENCE
 GROUP BY PROCEDURE_OCCURRENCE_ID
 HAVING COUNT(*) > 1 
 )
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
 'PROVIDER.PROVIDER_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.PROVIDER cdmTable
 WHERE cdmTable.PROVIDER_ID IN ( 
 SELECT 
 PROVIDER_ID 
 FROM ehr_union.PROVIDER
 GROUP BY PROVIDER_ID
 HAVING COUNT(*) > 1 
 )
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
 'SPECIMEN.SPECIMEN_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.SPECIMEN cdmTable
 WHERE cdmTable.SPECIMEN_ID IN ( 
 SELECT 
 SPECIMEN_ID 
 FROM ehr_union.SPECIMEN
 GROUP BY SPECIMEN_ID
 HAVING COUNT(*) > 1 
 )
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
 'VISIT_DETAIL.VISIT_DETAIL_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.VISIT_DETAIL cdmTable
 WHERE cdmTable.VISIT_DETAIL_ID IN ( 
 SELECT 
 VISIT_DETAIL_ID 
 FROM ehr_union.VISIT_DETAIL
 GROUP BY VISIT_DETAIL_ID
 HAVING COUNT(*) > 1 
 )
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
 'VISIT_OCCURRENCE.VISIT_OCCURRENCE_ID' AS violating_field, 
 cdmTable.* 
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 WHERE cdmTable.VISIT_OCCURRENCE_ID IN ( 
 SELECT 
 VISIT_OCCURRENCE_ID 
 FROM ehr_union.VISIT_OCCURRENCE
 GROUP BY VISIT_OCCURRENCE_ID
 HAVING COUNT(*) > 1 
 )
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
) denominator;
