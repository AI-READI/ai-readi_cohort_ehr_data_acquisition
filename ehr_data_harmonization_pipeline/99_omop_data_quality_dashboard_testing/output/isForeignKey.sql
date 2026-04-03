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
 'CARE_SITE.LOCATION_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.CARE_SITE cdmTable
 LEFT JOIN 
 ehr_union.LOCATION fkTable 
 ON cdmTable.LOCATION_ID = fkTable.LOCATION_ID
 WHERE fkTable.LOCATION_ID IS NULL 
 AND cdmTable.LOCATION_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'CARE_SITE.PLACE_OF_SERVICE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.CARE_SITE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.PLACE_OF_SERVICE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.PLACE_OF_SERVICE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'CDM_SOURCE.CDM_VERSION_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.CDM_SOURCE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.CDM_VERSION_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.CDM_VERSION_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'COHORT_DEFINITION.COHORT_DEFINITION_ID' AS violating_field, 
 cdmTable.*
 FROM omop_dqd.COHORT_DEFINITION cdmTable
 LEFT JOIN 
 omop_dqd.COHORT fkTable
 ON cdmTable.COHORT_DEFINITION_ID = fkTable.COHORT_DEFINITION_ID
 WHERE fkTable.COHORT_DEFINITION_ID IS NULL 
 AND cdmTable.COHORT_DEFINITION_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'COHORT_DEFINITION.DEFINITION_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM omop_dqd.COHORT_DEFINITION cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.DEFINITION_TYPE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.DEFINITION_TYPE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'COHORT_DEFINITION.SUBJECT_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM omop_dqd.COHORT_DEFINITION cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.SUBJECT_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.SUBJECT_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'CONDITION_ERA.CONDITION_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.CONDITION_ERA cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.CONDITION_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.CONDITION_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'CONDITION_ERA.PERSON_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.CONDITION_ERA cdmTable
 LEFT JOIN 
 ehr_union.PERSON fkTable 
 ON cdmTable.PERSON_ID = fkTable.PERSON_ID
 WHERE fkTable.PERSON_ID IS NULL 
 AND cdmTable.PERSON_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'CONDITION_OCCURRENCE.CONDITION_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.CONDITION_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.CONDITION_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'CONDITION_OCCURRENCE.CONDITION_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.CONDITION_SOURCE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.CONDITION_SOURCE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'CONDITION_OCCURRENCE.CONDITION_STATUS_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.CONDITION_STATUS_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.CONDITION_STATUS_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'CONDITION_OCCURRENCE.CONDITION_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.CONDITION_TYPE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.CONDITION_TYPE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'CONDITION_OCCURRENCE.PERSON_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 LEFT JOIN 
 ehr_union.PERSON fkTable 
 ON cdmTable.PERSON_ID = fkTable.PERSON_ID
 WHERE fkTable.PERSON_ID IS NULL 
 AND cdmTable.PERSON_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'CONDITION_OCCURRENCE.PROVIDER_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 LEFT JOIN 
 ehr_union.PROVIDER fkTable 
 ON cdmTable.PROVIDER_ID = fkTable.PROVIDER_ID
 WHERE fkTable.PROVIDER_ID IS NULL 
 AND cdmTable.PROVIDER_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'CONDITION_OCCURRENCE.VISIT_DETAIL_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 LEFT JOIN 
 ehr_union.VISIT_DETAIL fkTable 
 ON cdmTable.VISIT_DETAIL_ID = fkTable.VISIT_DETAIL_ID
 WHERE fkTable.VISIT_DETAIL_ID IS NULL 
 AND cdmTable.VISIT_DETAIL_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'CONDITION_OCCURRENCE.VISIT_OCCURRENCE_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 LEFT JOIN 
 ehr_union.VISIT_OCCURRENCE fkTable 
 ON cdmTable.VISIT_OCCURRENCE_ID = fkTable.VISIT_OCCURRENCE_ID
 WHERE fkTable.VISIT_OCCURRENCE_ID IS NULL 
 AND cdmTable.VISIT_OCCURRENCE_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'COST.COST_DOMAIN_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.COST cdmTable
 LEFT JOIN 
 ehr_union.DOMAIN fkTable
 ON cdmTable.COST_DOMAIN_ID = fkTable.DOMAIN_ID
 WHERE fkTable.DOMAIN_ID IS NULL 
 AND cdmTable.COST_DOMAIN_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'COST.COST_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.COST cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.COST_TYPE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.COST_TYPE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'COST.CURRENCY_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.COST cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.CURRENCY_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.CURRENCY_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'COST.DRG_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.COST cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.DRG_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.DRG_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'COST.REVENUE_CODE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.COST cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.REVENUE_CODE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.REVENUE_CODE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DEATH.CAUSE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DEATH cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.CAUSE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.CAUSE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DEATH.CAUSE_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DEATH cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.CAUSE_SOURCE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.CAUSE_SOURCE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DEATH.DEATH_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DEATH cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.DEATH_TYPE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.DEATH_TYPE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DEATH.PERSON_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DEATH cdmTable
 LEFT JOIN 
 ehr_union.PERSON fkTable 
 ON cdmTable.PERSON_ID = fkTable.PERSON_ID
 WHERE fkTable.PERSON_ID IS NULL 
 AND cdmTable.PERSON_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DEVICE_EXPOSURE.DEVICE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.DEVICE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.DEVICE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DEVICE_EXPOSURE.DEVICE_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.DEVICE_SOURCE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.DEVICE_SOURCE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DEVICE_EXPOSURE.DEVICE_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.DEVICE_TYPE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.DEVICE_TYPE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DEVICE_EXPOSURE.PERSON_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 LEFT JOIN 
 ehr_union.PERSON fkTable 
 ON cdmTable.PERSON_ID = fkTable.PERSON_ID
 WHERE fkTable.PERSON_ID IS NULL 
 AND cdmTable.PERSON_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DEVICE_EXPOSURE.PROVIDER_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 LEFT JOIN 
 ehr_union.PROVIDER fkTable 
 ON cdmTable.PROVIDER_ID = fkTable.PROVIDER_ID
 WHERE fkTable.PROVIDER_ID IS NULL 
 AND cdmTable.PROVIDER_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DEVICE_EXPOSURE.UNIT_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.UNIT_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.UNIT_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DEVICE_EXPOSURE.UNIT_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.UNIT_SOURCE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.UNIT_SOURCE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DEVICE_EXPOSURE.VISIT_DETAIL_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 LEFT JOIN 
 ehr_union.VISIT_DETAIL fkTable 
 ON cdmTable.VISIT_DETAIL_ID = fkTable.VISIT_DETAIL_ID
 WHERE fkTable.VISIT_DETAIL_ID IS NULL 
 AND cdmTable.VISIT_DETAIL_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DEVICE_EXPOSURE.VISIT_OCCURRENCE_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 LEFT JOIN 
 ehr_union.VISIT_OCCURRENCE fkTable 
 ON cdmTable.VISIT_OCCURRENCE_ID = fkTable.VISIT_OCCURRENCE_ID
 WHERE fkTable.VISIT_OCCURRENCE_ID IS NULL 
 AND cdmTable.VISIT_OCCURRENCE_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DOSE_ERA.DRUG_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DOSE_ERA cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.DRUG_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.DRUG_CONCEPT_ID IS NOT NULL
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
 'DOSE_ERA.PERSON_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DOSE_ERA cdmTable
 LEFT JOIN 
 ehr_union.PERSON fkTable 
 ON cdmTable.PERSON_ID = fkTable.PERSON_ID
 WHERE fkTable.PERSON_ID IS NULL 
 AND cdmTable.PERSON_ID IS NOT NULL
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
 'DOSE_ERA.UNIT_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DOSE_ERA cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.UNIT_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.UNIT_CONCEPT_ID IS NOT NULL
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
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.DRUG_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.DRUG_CONCEPT_ID IS NOT NULL
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
 'DRUG_ERA.PERSON_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_ERA cdmTable
 LEFT JOIN 
 ehr_union.PERSON fkTable 
 ON cdmTable.PERSON_ID = fkTable.PERSON_ID
 WHERE fkTable.PERSON_ID IS NULL 
 AND cdmTable.PERSON_ID IS NOT NULL
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
 'DRUG_EXPOSURE.DRUG_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.DRUG_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.DRUG_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_EXPOSURE.DRUG_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.DRUG_SOURCE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.DRUG_SOURCE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_EXPOSURE.DRUG_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.DRUG_TYPE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.DRUG_TYPE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_EXPOSURE.PERSON_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 LEFT JOIN 
 ehr_union.PERSON fkTable 
 ON cdmTable.PERSON_ID = fkTable.PERSON_ID
 WHERE fkTable.PERSON_ID IS NULL 
 AND cdmTable.PERSON_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_EXPOSURE.PROVIDER_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 LEFT JOIN 
 ehr_union.PROVIDER fkTable 
 ON cdmTable.PROVIDER_ID = fkTable.PROVIDER_ID
 WHERE fkTable.PROVIDER_ID IS NULL 
 AND cdmTable.PROVIDER_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_EXPOSURE.ROUTE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.ROUTE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.ROUTE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_EXPOSURE.VISIT_DETAIL_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 LEFT JOIN 
 ehr_union.VISIT_DETAIL fkTable 
 ON cdmTable.VISIT_DETAIL_ID = fkTable.VISIT_DETAIL_ID
 WHERE fkTable.VISIT_DETAIL_ID IS NULL 
 AND cdmTable.VISIT_DETAIL_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_EXPOSURE.VISIT_OCCURRENCE_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 LEFT JOIN 
 ehr_union.VISIT_OCCURRENCE fkTable 
 ON cdmTable.VISIT_OCCURRENCE_ID = fkTable.VISIT_OCCURRENCE_ID
 WHERE fkTable.VISIT_OCCURRENCE_ID IS NULL 
 AND cdmTable.VISIT_OCCURRENCE_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_STRENGTH.AMOUNT_UNIT_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_STRENGTH cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.AMOUNT_UNIT_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.AMOUNT_UNIT_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_STRENGTH.DENOMINATOR_UNIT_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_STRENGTH cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.DENOMINATOR_UNIT_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.DENOMINATOR_UNIT_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_STRENGTH.DRUG_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_STRENGTH cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.DRUG_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.DRUG_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_STRENGTH.INGREDIENT_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_STRENGTH cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.INGREDIENT_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.INGREDIENT_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'DRUG_STRENGTH.NUMERATOR_UNIT_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_STRENGTH cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.NUMERATOR_UNIT_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.NUMERATOR_UNIT_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'EPISODE.EPISODE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.EPISODE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.EPISODE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.EPISODE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'EPISODE.EPISODE_OBJECT_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.EPISODE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.EPISODE_OBJECT_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.EPISODE_OBJECT_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'EPISODE.EPISODE_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.EPISODE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.EPISODE_SOURCE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.EPISODE_SOURCE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'EPISODE.EPISODE_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.EPISODE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.EPISODE_TYPE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.EPISODE_TYPE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'EPISODE.PERSON_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.EPISODE cdmTable
 LEFT JOIN 
 ehr_union.PERSON fkTable 
 ON cdmTable.PERSON_ID = fkTable.PERSON_ID
 WHERE fkTable.PERSON_ID IS NULL 
 AND cdmTable.PERSON_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'EPISODE_EVENT.EPISODE_EVENT_FIELD_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.EPISODE_EVENT cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.EPISODE_EVENT_FIELD_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.EPISODE_EVENT_FIELD_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'EPISODE_EVENT.EPISODE_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.EPISODE_EVENT cdmTable
 LEFT JOIN 
 ehr_union.EPISODE fkTable 
 ON cdmTable.EPISODE_ID = fkTable.EPISODE_ID
 WHERE fkTable.EPISODE_ID IS NULL 
 AND cdmTable.EPISODE_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'FACT_RELATIONSHIP.DOMAIN_CONCEPT_ID_1' AS violating_field, 
 cdmTable.*
 FROM ehr_union.FACT_RELATIONSHIP cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.DOMAIN_CONCEPT_ID_1 = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.DOMAIN_CONCEPT_ID_1 IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.FACT_RELATIONSHIP cdmTable
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
 'FACT_RELATIONSHIP.DOMAIN_CONCEPT_ID_2' AS violating_field, 
 cdmTable.*
 FROM ehr_union.FACT_RELATIONSHIP cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.DOMAIN_CONCEPT_ID_2 = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.DOMAIN_CONCEPT_ID_2 IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.FACT_RELATIONSHIP cdmTable
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
 'FACT_RELATIONSHIP.RELATIONSHIP_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.FACT_RELATIONSHIP cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.RELATIONSHIP_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.RELATIONSHIP_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.FACT_RELATIONSHIP cdmTable
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
 'LOCATION.COUNTRY_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.LOCATION cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.COUNTRY_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.COUNTRY_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'MEASUREMENT.MEAS_EVENT_FIELD_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.MEASUREMENT cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.MEAS_EVENT_FIELD_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.MEAS_EVENT_FIELD_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'MEASUREMENT.MEASUREMENT_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.MEASUREMENT cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.MEASUREMENT_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.MEASUREMENT_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'MEASUREMENT.MEASUREMENT_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.MEASUREMENT cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.MEASUREMENT_SOURCE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.MEASUREMENT_SOURCE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'MEASUREMENT.MEASUREMENT_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.MEASUREMENT cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.MEASUREMENT_TYPE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.MEASUREMENT_TYPE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'MEASUREMENT.OPERATOR_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.MEASUREMENT cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.OPERATOR_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.OPERATOR_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'MEASUREMENT.PERSON_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.MEASUREMENT cdmTable
 LEFT JOIN 
 ehr_union.PERSON fkTable 
 ON cdmTable.PERSON_ID = fkTable.PERSON_ID
 WHERE fkTable.PERSON_ID IS NULL 
 AND cdmTable.PERSON_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'MEASUREMENT.PROVIDER_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.MEASUREMENT cdmTable
 LEFT JOIN 
 ehr_union.PROVIDER fkTable 
 ON cdmTable.PROVIDER_ID = fkTable.PROVIDER_ID
 WHERE fkTable.PROVIDER_ID IS NULL 
 AND cdmTable.PROVIDER_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'MEASUREMENT.UNIT_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.MEASUREMENT cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.UNIT_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.UNIT_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'MEASUREMENT.UNIT_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.MEASUREMENT cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.UNIT_SOURCE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.UNIT_SOURCE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'MEASUREMENT.VALUE_AS_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.MEASUREMENT cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.VALUE_AS_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.VALUE_AS_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'MEASUREMENT.VISIT_DETAIL_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.MEASUREMENT cdmTable
 LEFT JOIN 
 ehr_union.VISIT_DETAIL fkTable 
 ON cdmTable.VISIT_DETAIL_ID = fkTable.VISIT_DETAIL_ID
 WHERE fkTable.VISIT_DETAIL_ID IS NULL 
 AND cdmTable.VISIT_DETAIL_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'MEASUREMENT.VISIT_OCCURRENCE_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.MEASUREMENT cdmTable
 LEFT JOIN 
 ehr_union.VISIT_OCCURRENCE fkTable 
 ON cdmTable.VISIT_OCCURRENCE_ID = fkTable.VISIT_OCCURRENCE_ID
 WHERE fkTable.VISIT_OCCURRENCE_ID IS NULL 
 AND cdmTable.VISIT_OCCURRENCE_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'METADATA.METADATA_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.METADATA cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.METADATA_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.METADATA_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'METADATA.METADATA_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.METADATA cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.METADATA_TYPE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.METADATA_TYPE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'METADATA.VALUE_AS_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.METADATA cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.VALUE_AS_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.VALUE_AS_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'NOTE.ENCODING_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.NOTE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.ENCODING_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.ENCODING_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'NOTE.LANGUAGE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.NOTE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.LANGUAGE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.LANGUAGE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'NOTE.NOTE_CLASS_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.NOTE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.NOTE_CLASS_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.NOTE_CLASS_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'NOTE.NOTE_EVENT_FIELD_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.NOTE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.NOTE_EVENT_FIELD_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.NOTE_EVENT_FIELD_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'NOTE.NOTE_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.NOTE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.NOTE_TYPE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.NOTE_TYPE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'NOTE.PERSON_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.NOTE cdmTable
 LEFT JOIN 
 ehr_union.PERSON fkTable 
 ON cdmTable.PERSON_ID = fkTable.PERSON_ID
 WHERE fkTable.PERSON_ID IS NULL 
 AND cdmTable.PERSON_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'NOTE.PROVIDER_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.NOTE cdmTable
 LEFT JOIN 
 ehr_union.PROVIDER fkTable 
 ON cdmTable.PROVIDER_ID = fkTable.PROVIDER_ID
 WHERE fkTable.PROVIDER_ID IS NULL 
 AND cdmTable.PROVIDER_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'NOTE.VISIT_DETAIL_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.NOTE cdmTable
 LEFT JOIN 
 ehr_union.VISIT_DETAIL fkTable 
 ON cdmTable.VISIT_DETAIL_ID = fkTable.VISIT_DETAIL_ID
 WHERE fkTable.VISIT_DETAIL_ID IS NULL 
 AND cdmTable.VISIT_DETAIL_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'NOTE.VISIT_OCCURRENCE_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.NOTE cdmTable
 LEFT JOIN 
 ehr_union.VISIT_OCCURRENCE fkTable 
 ON cdmTable.VISIT_OCCURRENCE_ID = fkTable.VISIT_OCCURRENCE_ID
 WHERE fkTable.VISIT_OCCURRENCE_ID IS NULL 
 AND cdmTable.VISIT_OCCURRENCE_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'NOTE_NLP.NOTE_NLP_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.NOTE_NLP cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.NOTE_NLP_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.NOTE_NLP_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'NOTE_NLP.NOTE_NLP_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.NOTE_NLP cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.NOTE_NLP_SOURCE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.NOTE_NLP_SOURCE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'NOTE_NLP.SECTION_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.NOTE_NLP cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.SECTION_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.SECTION_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'OBSERVATION.OBS_EVENT_FIELD_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.OBSERVATION cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.OBS_EVENT_FIELD_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.OBS_EVENT_FIELD_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'OBSERVATION.OBSERVATION_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.OBSERVATION cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.OBSERVATION_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.OBSERVATION_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'OBSERVATION.OBSERVATION_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.OBSERVATION cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.OBSERVATION_SOURCE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.OBSERVATION_SOURCE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'OBSERVATION.OBSERVATION_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.OBSERVATION cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.OBSERVATION_TYPE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.OBSERVATION_TYPE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'OBSERVATION.PERSON_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.OBSERVATION cdmTable
 LEFT JOIN 
 ehr_union.PERSON fkTable 
 ON cdmTable.PERSON_ID = fkTable.PERSON_ID
 WHERE fkTable.PERSON_ID IS NULL 
 AND cdmTable.PERSON_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'OBSERVATION.PROVIDER_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.OBSERVATION cdmTable
 LEFT JOIN 
 ehr_union.PROVIDER fkTable 
 ON cdmTable.PROVIDER_ID = fkTable.PROVIDER_ID
 WHERE fkTable.PROVIDER_ID IS NULL 
 AND cdmTable.PROVIDER_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'OBSERVATION.QUALIFIER_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.OBSERVATION cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.QUALIFIER_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.QUALIFIER_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'OBSERVATION.UNIT_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.OBSERVATION cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.UNIT_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.UNIT_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'OBSERVATION.VALUE_AS_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.OBSERVATION cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.VALUE_AS_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.VALUE_AS_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'OBSERVATION.VISIT_DETAIL_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.OBSERVATION cdmTable
 LEFT JOIN 
 ehr_union.VISIT_DETAIL fkTable 
 ON cdmTable.VISIT_DETAIL_ID = fkTable.VISIT_DETAIL_ID
 WHERE fkTable.VISIT_DETAIL_ID IS NULL 
 AND cdmTable.VISIT_DETAIL_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'OBSERVATION.VISIT_OCCURRENCE_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.OBSERVATION cdmTable
 LEFT JOIN 
 ehr_union.VISIT_OCCURRENCE fkTable 
 ON cdmTable.VISIT_OCCURRENCE_ID = fkTable.VISIT_OCCURRENCE_ID
 WHERE fkTable.VISIT_OCCURRENCE_ID IS NULL 
 AND cdmTable.VISIT_OCCURRENCE_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'OBSERVATION_PERIOD.PERIOD_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.OBSERVATION_PERIOD cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.PERIOD_TYPE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.PERIOD_TYPE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'OBSERVATION_PERIOD.PERSON_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.OBSERVATION_PERIOD cdmTable
 LEFT JOIN 
 ehr_union.PERSON fkTable 
 ON cdmTable.PERSON_ID = fkTable.PERSON_ID
 WHERE fkTable.PERSON_ID IS NULL 
 AND cdmTable.PERSON_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PAYER_PLAN_PERIOD.PAYER_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.PAYER_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.PAYER_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PAYER_PLAN_PERIOD.PAYER_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.PAYER_SOURCE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.PAYER_SOURCE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PAYER_PLAN_PERIOD.PERSON_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 LEFT JOIN 
 ehr_union.PERSON fkTable 
 ON cdmTable.PERSON_ID = fkTable.PERSON_ID
 WHERE fkTable.PERSON_ID IS NULL 
 AND cdmTable.PERSON_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PAYER_PLAN_PERIOD.PLAN_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.PLAN_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.PLAN_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PAYER_PLAN_PERIOD.PLAN_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.PLAN_SOURCE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.PLAN_SOURCE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PAYER_PLAN_PERIOD.SPONSOR_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.SPONSOR_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.SPONSOR_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PAYER_PLAN_PERIOD.SPONSOR_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.SPONSOR_SOURCE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.SPONSOR_SOURCE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PAYER_PLAN_PERIOD.STOP_REASON_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.STOP_REASON_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.STOP_REASON_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PAYER_PLAN_PERIOD.STOP_REASON_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.STOP_REASON_SOURCE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.STOP_REASON_SOURCE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PERSON.CARE_SITE_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PERSON cdmTable
 LEFT JOIN 
 ehr_union.CARE_SITE fkTable 
 ON cdmTable.CARE_SITE_ID = fkTable.CARE_SITE_ID
 WHERE fkTable.CARE_SITE_ID IS NULL 
 AND cdmTable.CARE_SITE_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PERSON.ETHNICITY_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PERSON cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.ETHNICITY_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.ETHNICITY_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PERSON.ETHNICITY_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PERSON cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.ETHNICITY_SOURCE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.ETHNICITY_SOURCE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PERSON.GENDER_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PERSON cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.GENDER_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.GENDER_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PERSON.GENDER_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PERSON cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.GENDER_SOURCE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.GENDER_SOURCE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PERSON.LOCATION_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PERSON cdmTable
 LEFT JOIN 
 ehr_union.LOCATION fkTable 
 ON cdmTable.LOCATION_ID = fkTable.LOCATION_ID
 WHERE fkTable.LOCATION_ID IS NULL 
 AND cdmTable.LOCATION_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PERSON.PROVIDER_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PERSON cdmTable
 LEFT JOIN 
 ehr_union.PROVIDER fkTable 
 ON cdmTable.PROVIDER_ID = fkTable.PROVIDER_ID
 WHERE fkTable.PROVIDER_ID IS NULL 
 AND cdmTable.PROVIDER_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PERSON.RACE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PERSON cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.RACE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.RACE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PERSON.RACE_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PERSON cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.RACE_SOURCE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.RACE_SOURCE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PROCEDURE_OCCURRENCE.MODIFIER_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.MODIFIER_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.MODIFIER_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PROCEDURE_OCCURRENCE.PERSON_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 LEFT JOIN 
 ehr_union.PERSON fkTable 
 ON cdmTable.PERSON_ID = fkTable.PERSON_ID
 WHERE fkTable.PERSON_ID IS NULL 
 AND cdmTable.PERSON_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PROCEDURE_OCCURRENCE.PROCEDURE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.PROCEDURE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.PROCEDURE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PROCEDURE_OCCURRENCE.PROCEDURE_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.PROCEDURE_SOURCE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.PROCEDURE_SOURCE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PROCEDURE_OCCURRENCE.PROCEDURE_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.PROCEDURE_TYPE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.PROCEDURE_TYPE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PROCEDURE_OCCURRENCE.PROVIDER_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 LEFT JOIN 
 ehr_union.PROVIDER fkTable 
 ON cdmTable.PROVIDER_ID = fkTable.PROVIDER_ID
 WHERE fkTable.PROVIDER_ID IS NULL 
 AND cdmTable.PROVIDER_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PROCEDURE_OCCURRENCE.VISIT_DETAIL_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 LEFT JOIN 
 ehr_union.VISIT_DETAIL fkTable 
 ON cdmTable.VISIT_DETAIL_ID = fkTable.VISIT_DETAIL_ID
 WHERE fkTable.VISIT_DETAIL_ID IS NULL 
 AND cdmTable.VISIT_DETAIL_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PROCEDURE_OCCURRENCE.VISIT_OCCURRENCE_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 LEFT JOIN 
 ehr_union.VISIT_OCCURRENCE fkTable 
 ON cdmTable.VISIT_OCCURRENCE_ID = fkTable.VISIT_OCCURRENCE_ID
 WHERE fkTable.VISIT_OCCURRENCE_ID IS NULL 
 AND cdmTable.VISIT_OCCURRENCE_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PROVIDER.CARE_SITE_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PROVIDER cdmTable
 LEFT JOIN 
 ehr_union.CARE_SITE fkTable 
 ON cdmTable.CARE_SITE_ID = fkTable.CARE_SITE_ID
 WHERE fkTable.CARE_SITE_ID IS NULL 
 AND cdmTable.CARE_SITE_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PROVIDER.GENDER_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PROVIDER cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.GENDER_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.GENDER_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PROVIDER.GENDER_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PROVIDER cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.GENDER_SOURCE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.GENDER_SOURCE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PROVIDER.SPECIALTY_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PROVIDER cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.SPECIALTY_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.SPECIALTY_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'PROVIDER.SPECIALTY_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PROVIDER cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.SPECIALTY_SOURCE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.SPECIALTY_SOURCE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'SOURCE_TO_CONCEPT_MAP.SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.SOURCE_TO_CONCEPT_MAP cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.SOURCE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.SOURCE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'SOURCE_TO_CONCEPT_MAP.TARGET_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.SOURCE_TO_CONCEPT_MAP cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.TARGET_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.TARGET_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'SOURCE_TO_CONCEPT_MAP.TARGET_VOCABULARY_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.SOURCE_TO_CONCEPT_MAP cdmTable
 LEFT JOIN 
 ehr_union.VOCABULARY fkTable
 ON cdmTable.TARGET_VOCABULARY_ID = fkTable.VOCABULARY_ID
 WHERE fkTable.VOCABULARY_ID IS NULL 
 AND cdmTable.TARGET_VOCABULARY_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'SPECIMEN.ANATOMIC_SITE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.SPECIMEN cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.ANATOMIC_SITE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.ANATOMIC_SITE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'SPECIMEN.DISEASE_STATUS_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.SPECIMEN cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.DISEASE_STATUS_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.DISEASE_STATUS_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'SPECIMEN.PERSON_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.SPECIMEN cdmTable
 LEFT JOIN 
 ehr_union.PERSON fkTable 
 ON cdmTable.PERSON_ID = fkTable.PERSON_ID
 WHERE fkTable.PERSON_ID IS NULL 
 AND cdmTable.PERSON_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'SPECIMEN.SPECIMEN_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.SPECIMEN cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.SPECIMEN_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.SPECIMEN_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'SPECIMEN.SPECIMEN_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.SPECIMEN cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.SPECIMEN_TYPE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.SPECIMEN_TYPE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'SPECIMEN.UNIT_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.SPECIMEN cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.UNIT_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.UNIT_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_DETAIL.ADMITTED_FROM_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_DETAIL cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.ADMITTED_FROM_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.ADMITTED_FROM_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_DETAIL.CARE_SITE_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_DETAIL cdmTable
 LEFT JOIN 
 ehr_union.CARE_SITE fkTable 
 ON cdmTable.CARE_SITE_ID = fkTable.CARE_SITE_ID
 WHERE fkTable.CARE_SITE_ID IS NULL 
 AND cdmTable.CARE_SITE_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_DETAIL.DISCHARGED_TO_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_DETAIL cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.DISCHARGED_TO_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.DISCHARGED_TO_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_DETAIL.PARENT_VISIT_DETAIL_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_DETAIL cdmTable
 LEFT JOIN 
 ehr_union.VISIT_DETAIL fkTable 
 ON cdmTable.PARENT_VISIT_DETAIL_ID = fkTable.VISIT_DETAIL_ID
 WHERE fkTable.VISIT_DETAIL_ID IS NULL 
 AND cdmTable.PARENT_VISIT_DETAIL_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_DETAIL.PERSON_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_DETAIL cdmTable
 LEFT JOIN 
 ehr_union.PERSON fkTable 
 ON cdmTable.PERSON_ID = fkTable.PERSON_ID
 WHERE fkTable.PERSON_ID IS NULL 
 AND cdmTable.PERSON_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_DETAIL.PRECEDING_VISIT_DETAIL_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_DETAIL cdmTable
 LEFT JOIN 
 ehr_union.VISIT_DETAIL fkTable 
 ON cdmTable.PRECEDING_VISIT_DETAIL_ID = fkTable.VISIT_DETAIL_ID
 WHERE fkTable.VISIT_DETAIL_ID IS NULL 
 AND cdmTable.PRECEDING_VISIT_DETAIL_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_DETAIL.PROVIDER_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_DETAIL cdmTable
 LEFT JOIN 
 ehr_union.PROVIDER fkTable 
 ON cdmTable.PROVIDER_ID = fkTable.PROVIDER_ID
 WHERE fkTable.PROVIDER_ID IS NULL 
 AND cdmTable.PROVIDER_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_DETAIL.VISIT_DETAIL_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_DETAIL cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.VISIT_DETAIL_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.VISIT_DETAIL_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_DETAIL.VISIT_DETAIL_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_DETAIL cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.VISIT_DETAIL_SOURCE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.VISIT_DETAIL_SOURCE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_DETAIL.VISIT_DETAIL_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_DETAIL cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.VISIT_DETAIL_TYPE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.VISIT_DETAIL_TYPE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_DETAIL.VISIT_OCCURRENCE_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_DETAIL cdmTable
 LEFT JOIN 
 ehr_union.VISIT_OCCURRENCE fkTable 
 ON cdmTable.VISIT_OCCURRENCE_ID = fkTable.VISIT_OCCURRENCE_ID
 WHERE fkTable.VISIT_OCCURRENCE_ID IS NULL 
 AND cdmTable.VISIT_OCCURRENCE_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_OCCURRENCE.ADMITTED_FROM_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.ADMITTED_FROM_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.ADMITTED_FROM_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_OCCURRENCE.CARE_SITE_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 LEFT JOIN 
 ehr_union.CARE_SITE fkTable 
 ON cdmTable.CARE_SITE_ID = fkTable.CARE_SITE_ID
 WHERE fkTable.CARE_SITE_ID IS NULL 
 AND cdmTable.CARE_SITE_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_OCCURRENCE.DISCHARGED_TO_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.DISCHARGED_TO_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.DISCHARGED_TO_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_OCCURRENCE.PERSON_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 LEFT JOIN 
 ehr_union.PERSON fkTable 
 ON cdmTable.PERSON_ID = fkTable.PERSON_ID
 WHERE fkTable.PERSON_ID IS NULL 
 AND cdmTable.PERSON_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_OCCURRENCE.PRECEDING_VISIT_OCCURRENCE_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 LEFT JOIN 
 ehr_union.VISIT_OCCURRENCE fkTable 
 ON cdmTable.PRECEDING_VISIT_OCCURRENCE_ID = fkTable.VISIT_OCCURRENCE_ID
 WHERE fkTable.VISIT_OCCURRENCE_ID IS NULL 
 AND cdmTable.PRECEDING_VISIT_OCCURRENCE_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_OCCURRENCE.PROVIDER_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 LEFT JOIN 
 ehr_union.PROVIDER fkTable 
 ON cdmTable.PROVIDER_ID = fkTable.PROVIDER_ID
 WHERE fkTable.PROVIDER_ID IS NULL 
 AND cdmTable.PROVIDER_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_OCCURRENCE.VISIT_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.VISIT_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.VISIT_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_OCCURRENCE.VISIT_SOURCE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.VISIT_SOURCE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.VISIT_SOURCE_CONCEPT_ID IS NOT NULL
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
 FROM (
 /*violatedRowsBegin*/
 SELECT 
 'VISIT_OCCURRENCE.VISIT_TYPE_CONCEPT_ID' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 LEFT JOIN 
 ehr_union.CONCEPT fkTable
 ON cdmTable.VISIT_TYPE_CONCEPT_ID = fkTable.CONCEPT_ID
 WHERE fkTable.CONCEPT_ID IS NULL 
 AND cdmTable.VISIT_TYPE_CONCEPT_ID IS NOT NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
) denominator;
