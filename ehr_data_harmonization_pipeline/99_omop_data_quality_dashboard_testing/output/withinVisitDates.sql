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
 'CONDITION_OCCURRENCE.CONDITION_START_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 JOIN ehr_union.visit_occurrence vo
 ON cdmTable.visit_occurrence_id = vo.visit_occurrence_id
 WHERE cdmTable.CONDITION_START_DATE < DATEADD(DAY, -7, vo.visit_start_date)
 OR cdmTable.CONDITION_START_DATE > DATEADD(DAY, 7, vo.visit_end_date)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.CONDITION_OCCURRENCE cdmTable
 JOIN ehr_union.visit_occurrence vo
 ON cdmTable.visit_occurrence_id = vo.visit_occurrence_id
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
 'DEVICE_EXPOSURE.DEVICE_EXPOSURE_START_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 JOIN ehr_union.visit_occurrence vo
 ON cdmTable.visit_occurrence_id = vo.visit_occurrence_id
 WHERE cdmTable.DEVICE_EXPOSURE_START_DATE < DATEADD(DAY, -7, vo.visit_start_date)
 OR cdmTable.DEVICE_EXPOSURE_START_DATE > DATEADD(DAY, 7, vo.visit_end_date)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DEVICE_EXPOSURE cdmTable
 JOIN ehr_union.visit_occurrence vo
 ON cdmTable.visit_occurrence_id = vo.visit_occurrence_id
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
 'DRUG_EXPOSURE.DRUG_EXPOSURE_START_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 JOIN ehr_union.visit_occurrence vo
 ON cdmTable.visit_occurrence_id = vo.visit_occurrence_id
 WHERE cdmTable.DRUG_EXPOSURE_START_DATE < DATEADD(DAY, -7, vo.visit_start_date)
 OR cdmTable.DRUG_EXPOSURE_START_DATE > DATEADD(DAY, 7, vo.visit_end_date)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.DRUG_EXPOSURE cdmTable
 JOIN ehr_union.visit_occurrence vo
 ON cdmTable.visit_occurrence_id = vo.visit_occurrence_id
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
 'MEASUREMENT.MEASUREMENT_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.MEASUREMENT cdmTable
 JOIN ehr_union.visit_occurrence vo
 ON cdmTable.visit_occurrence_id = vo.visit_occurrence_id
 WHERE cdmTable.MEASUREMENT_DATE < DATEADD(DAY, -7, vo.visit_start_date)
 OR cdmTable.MEASUREMENT_DATE > DATEADD(DAY, 7, vo.visit_end_date)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT cdmTable
 JOIN ehr_union.visit_occurrence vo
 ON cdmTable.visit_occurrence_id = vo.visit_occurrence_id
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
 'NOTE.NOTE_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.NOTE cdmTable
 JOIN ehr_union.visit_occurrence vo
 ON cdmTable.visit_occurrence_id = vo.visit_occurrence_id
 WHERE cdmTable.NOTE_DATE < DATEADD(DAY, -7, vo.visit_start_date)
 OR cdmTable.NOTE_DATE > DATEADD(DAY, 7, vo.visit_end_date)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.NOTE cdmTable
 JOIN ehr_union.visit_occurrence vo
 ON cdmTable.visit_occurrence_id = vo.visit_occurrence_id
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
 'OBSERVATION.OBSERVATION_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.OBSERVATION cdmTable
 JOIN ehr_union.visit_occurrence vo
 ON cdmTable.visit_occurrence_id = vo.visit_occurrence_id
 WHERE cdmTable.OBSERVATION_DATE < DATEADD(DAY, -7, vo.visit_start_date)
 OR cdmTable.OBSERVATION_DATE > DATEADD(DAY, 7, vo.visit_end_date)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.OBSERVATION cdmTable
 JOIN ehr_union.visit_occurrence vo
 ON cdmTable.visit_occurrence_id = vo.visit_occurrence_id
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
 'PROCEDURE_OCCURRENCE.PROCEDURE_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 JOIN ehr_union.visit_occurrence vo
 ON cdmTable.visit_occurrence_id = vo.visit_occurrence_id
 WHERE cdmTable.PROCEDURE_DATE < DATEADD(DAY, -7, vo.visit_start_date)
 OR cdmTable.PROCEDURE_DATE > DATEADD(DAY, 7, vo.visit_end_date)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.PROCEDURE_OCCURRENCE cdmTable
 JOIN ehr_union.visit_occurrence vo
 ON cdmTable.visit_occurrence_id = vo.visit_occurrence_id
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
 'VISIT_DETAIL.VISIT_DETAIL_END_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_DETAIL cdmTable
 JOIN ehr_union.visit_occurrence vo
 ON cdmTable.visit_occurrence_id = vo.visit_occurrence_id
 WHERE cdmTable.VISIT_DETAIL_END_DATE < DATEADD(DAY, -7, vo.visit_start_date)
 OR cdmTable.VISIT_DETAIL_END_DATE > DATEADD(DAY, 7, vo.visit_end_date)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 JOIN ehr_union.visit_occurrence vo
 ON cdmTable.visit_occurrence_id = vo.visit_occurrence_id
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
 'VISIT_DETAIL.VISIT_DETAIL_START_DATE' AS violating_field, 
 cdmTable.*
 FROM ehr_union.VISIT_DETAIL cdmTable
 JOIN ehr_union.visit_occurrence vo
 ON cdmTable.visit_occurrence_id = vo.visit_occurrence_id
 WHERE cdmTable.VISIT_DETAIL_START_DATE < DATEADD(DAY, -7, vo.visit_start_date)
 OR cdmTable.VISIT_DETAIL_START_DATE > DATEADD(DAY, 7, vo.visit_end_date)
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.VISIT_DETAIL cdmTable
 JOIN ehr_union.visit_occurrence vo
 ON cdmTable.visit_occurrence_id = vo.visit_occurrence_id
) denominator;
