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
 SELECT DISTINCT 
 'CONDITION_OCCURRENCE.CONDITION_SOURCE_VALUE' AS violating_field, 
 cdmTable.CONDITION_SOURCE_VALUE
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 WHERE cdmTable.CONDITION_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.CONDITION_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.CONDITION_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'CONDITION_OCCURRENCE.CONDITION_STATUS_SOURCE_VALUE' AS violating_field, 
 cdmTable.CONDITION_STATUS_SOURCE_VALUE
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 WHERE cdmTable.CONDITION_STATUS_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.CONDITION_STATUS_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.CONDITION_STATUS_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'DEATH.CAUSE_SOURCE_VALUE' AS violating_field, 
 cdmTable.CAUSE_SOURCE_VALUE
 FROM ehr_union.DEATH cdmTable
 WHERE cdmTable.CAUSE_SOURCE_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.CAUSE_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.CAUSE_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'DEVICE_EXPOSURE.DEVICE_SOURCE_VALUE' AS violating_field, 
 cdmTable.DEVICE_SOURCE_VALUE
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 WHERE cdmTable.DEVICE_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.DEVICE_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.DEVICE_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'DEVICE_EXPOSURE.UNIT_SOURCE_VALUE' AS violating_field, 
 cdmTable.UNIT_SOURCE_VALUE
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 WHERE cdmTable.UNIT_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.UNIT_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.UNIT_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'DRUG_EXPOSURE.DRUG_SOURCE_VALUE' AS violating_field, 
 cdmTable.DRUG_SOURCE_VALUE
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE cdmTable.DRUG_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.DRUG_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.DRUG_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'DRUG_EXPOSURE.ROUTE_SOURCE_VALUE' AS violating_field, 
 cdmTable.ROUTE_SOURCE_VALUE
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 WHERE cdmTable.ROUTE_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.ROUTE_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.ROUTE_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'MEASUREMENT.MEASUREMENT_SOURCE_VALUE' AS violating_field, 
 cdmTable.MEASUREMENT_SOURCE_VALUE
 FROM ehr_union.MEASUREMENT cdmTable
 WHERE cdmTable.MEASUREMENT_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.MEASUREMENT_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.MEASUREMENT_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'MEASUREMENT.UNIT_SOURCE_VALUE' AS violating_field, 
 cdmTable.UNIT_SOURCE_VALUE
 FROM ehr_union.MEASUREMENT cdmTable
 WHERE cdmTable.UNIT_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.UNIT_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.UNIT_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'OBSERVATION.OBSERVATION_SOURCE_VALUE' AS violating_field, 
 cdmTable.OBSERVATION_SOURCE_VALUE
 FROM ehr_union.OBSERVATION cdmTable
 WHERE cdmTable.OBSERVATION_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.OBSERVATION_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.OBSERVATION_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'OBSERVATION.QUALIFIER_SOURCE_VALUE' AS violating_field, 
 cdmTable.QUALIFIER_SOURCE_VALUE
 FROM ehr_union.OBSERVATION cdmTable
 WHERE cdmTable.QUALIFIER_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.QUALIFIER_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.QUALIFIER_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'OBSERVATION.UNIT_SOURCE_VALUE' AS violating_field, 
 cdmTable.UNIT_SOURCE_VALUE
 FROM ehr_union.OBSERVATION cdmTable
 WHERE cdmTable.UNIT_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.UNIT_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.UNIT_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'PAYER_PLAN_PERIOD.PAYER_SOURCE_VALUE' AS violating_field, 
 cdmTable.PAYER_SOURCE_VALUE
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 WHERE cdmTable.PAYER_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.PAYER_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.PAYER_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'PAYER_PLAN_PERIOD.PLAN_SOURCE_VALUE' AS violating_field, 
 cdmTable.PLAN_SOURCE_VALUE
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 WHERE cdmTable.PLAN_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.PLAN_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.PLAN_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'PAYER_PLAN_PERIOD.SPONSOR_SOURCE_VALUE' AS violating_field, 
 cdmTable.SPONSOR_SOURCE_VALUE
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 WHERE cdmTable.SPONSOR_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.SPONSOR_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.SPONSOR_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'PAYER_PLAN_PERIOD.STOP_REASON_SOURCE_VALUE' AS violating_field, 
 cdmTable.STOP_REASON_SOURCE_VALUE
 FROM ehr_union.PAYER_PLAN_PERIOD cdmTable
 WHERE cdmTable.STOP_REASON_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.STOP_REASON_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.STOP_REASON_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'PERSON.ETHNICITY_SOURCE_VALUE' AS violating_field, 
 cdmTable.ETHNICITY_SOURCE_VALUE
 FROM ehr_union.PERSON cdmTable
 WHERE cdmTable.ETHNICITY_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.ETHNICITY_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.ETHNICITY_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'PERSON.GENDER_SOURCE_VALUE' AS violating_field, 
 cdmTable.GENDER_SOURCE_VALUE
 FROM ehr_union.PERSON cdmTable
 WHERE cdmTable.GENDER_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.GENDER_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.GENDER_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'PERSON.RACE_SOURCE_VALUE' AS violating_field, 
 cdmTable.RACE_SOURCE_VALUE
 FROM ehr_union.PERSON cdmTable
 WHERE cdmTable.RACE_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.RACE_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.RACE_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'PROCEDURE_OCCURRENCE.MODIFIER_SOURCE_VALUE' AS violating_field, 
 cdmTable.MODIFIER_SOURCE_VALUE
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 WHERE cdmTable.MODIFIER_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.MODIFIER_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.MODIFIER_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'PROCEDURE_OCCURRENCE.PROCEDURE_SOURCE_VALUE' AS violating_field, 
 cdmTable.PROCEDURE_SOURCE_VALUE
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 WHERE cdmTable.PROCEDURE_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.PROCEDURE_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.PROCEDURE_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'PROVIDER.GENDER_SOURCE_VALUE' AS violating_field, 
 cdmTable.GENDER_SOURCE_VALUE
 FROM ehr_union.PROVIDER cdmTable
 WHERE cdmTable.GENDER_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.GENDER_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.GENDER_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'PROVIDER.SPECIALTY_SOURCE_VALUE' AS violating_field, 
 cdmTable.SPECIALTY_SOURCE_VALUE
 FROM ehr_union.PROVIDER cdmTable
 WHERE cdmTable.SPECIALTY_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.SPECIALTY_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.SPECIALTY_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'SPECIMEN.ANATOMIC_SITE_SOURCE_VALUE' AS violating_field, 
 cdmTable.ANATOMIC_SITE_SOURCE_VALUE
 FROM ehr_union.SPECIMEN cdmTable
 WHERE cdmTable.ANATOMIC_SITE_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.ANATOMIC_SITE_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.ANATOMIC_SITE_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'SPECIMEN.DISEASE_STATUS_SOURCE_VALUE' AS violating_field, 
 cdmTable.DISEASE_STATUS_SOURCE_VALUE
 FROM ehr_union.SPECIMEN cdmTable
 WHERE cdmTable.DISEASE_STATUS_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.DISEASE_STATUS_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.DISEASE_STATUS_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'SPECIMEN.SPECIMEN_SOURCE_VALUE' AS violating_field, 
 cdmTable.SPECIMEN_SOURCE_VALUE
 FROM ehr_union.SPECIMEN cdmTable
 WHERE cdmTable.SPECIMEN_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.SPECIMEN_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.SPECIMEN_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'SPECIMEN.UNIT_SOURCE_VALUE' AS violating_field, 
 cdmTable.UNIT_SOURCE_VALUE
 FROM ehr_union.SPECIMEN cdmTable
 WHERE cdmTable.UNIT_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.UNIT_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.UNIT_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'VISIT_DETAIL.ADMITTED_FROM_SOURCE_VALUE' AS violating_field, 
 cdmTable.ADMITTED_FROM_SOURCE_VALUE
 FROM ehr_union.VISIT_DETAIL cdmTable
 WHERE cdmTable.ADMITTED_FROM_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.ADMITTED_FROM_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.ADMITTED_FROM_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'VISIT_DETAIL.DISCHARGED_TO_SOURCE_VALUE' AS violating_field, 
 cdmTable.DISCHARGED_TO_SOURCE_VALUE
 FROM ehr_union.VISIT_DETAIL cdmTable
 WHERE cdmTable.DISCHARGED_TO_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.DISCHARGED_TO_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.DISCHARGED_TO_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'VISIT_OCCURRENCE.ADMITTED_FROM_SOURCE_VALUE' AS violating_field, 
 cdmTable.ADMITTED_FROM_SOURCE_VALUE
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 WHERE cdmTable.ADMITTED_FROM_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.ADMITTED_FROM_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.ADMITTED_FROM_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'VISIT_OCCURRENCE.DISCHARGED_TO_SOURCE_VALUE' AS violating_field, 
 cdmTable.DISCHARGED_TO_SOURCE_VALUE
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 WHERE cdmTable.DISCHARGED_TO_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.DISCHARGED_TO_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.DISCHARGED_TO_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
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
 SELECT DISTINCT 
 'VISIT_OCCURRENCE.VISIT_SOURCE_VALUE' AS violating_field, 
 cdmTable.VISIT_SOURCE_VALUE
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
 WHERE cdmTable.VISIT_CONCEPT_ID = 0
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(DISTINCT cdmTable.VISIT_SOURCE_VALUE) + COUNT(DISTINCT CASE WHEN cdmTable.VISIT_SOURCE_VALUE IS NULL THEN 1 END) AS num_rows
 FROM ehr_union.VISIT_OCCURRENCE cdmTable
) denominator;
