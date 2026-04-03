SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.person_id) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 cdmTable.* 
 FROM ehr_union.person cdmTable
 LEFT JOIN ehr_union.OBSERVATION_PERIOD cdmTable2 
 ON cdmTable.person_id = cdmTable2.person_id
 WHERE cdmTable2.person_id IS NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.person cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.person_id) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 cdmTable.* 
 FROM ehr_union.person cdmTable
 LEFT JOIN ehr_union.VISIT_OCCURRENCE cdmTable2 
 ON cdmTable.person_id = cdmTable2.person_id
 WHERE cdmTable2.person_id IS NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.person cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.person_id) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 cdmTable.* 
 FROM ehr_union.person cdmTable
 LEFT JOIN ehr_union.VISIT_DETAIL cdmTable2 
 ON cdmTable.person_id = cdmTable2.person_id
 WHERE cdmTable2.person_id IS NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.person cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.person_id) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 cdmTable.* 
 FROM ehr_union.person cdmTable
 LEFT JOIN ehr_union.CONDITION_OCCURRENCE cdmTable2 
 ON cdmTable.person_id = cdmTable2.person_id
 WHERE cdmTable2.person_id IS NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.person cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.person_id) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 cdmTable.* 
 FROM ehr_union.person cdmTable
 LEFT JOIN ehr_union.DRUG_EXPOSURE cdmTable2 
 ON cdmTable.person_id = cdmTable2.person_id
 WHERE cdmTable2.person_id IS NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.person cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.person_id) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 cdmTable.* 
 FROM ehr_union.person cdmTable
 LEFT JOIN ehr_union.PROCEDURE_OCCURRENCE cdmTable2 
 ON cdmTable.person_id = cdmTable2.person_id
 WHERE cdmTable2.person_id IS NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.person cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.person_id) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 cdmTable.* 
 FROM ehr_union.person cdmTable
 LEFT JOIN ehr_union.DEVICE_EXPOSURE cdmTable2 
 ON cdmTable.person_id = cdmTable2.person_id
 WHERE cdmTable2.person_id IS NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.person cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.person_id) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 cdmTable.* 
 FROM ehr_union.person cdmTable
 LEFT JOIN ehr_union.MEASUREMENT cdmTable2 
 ON cdmTable.person_id = cdmTable2.person_id
 WHERE cdmTable2.person_id IS NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.person cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.person_id) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 cdmTable.* 
 FROM ehr_union.person cdmTable
 LEFT JOIN ehr_union.OBSERVATION cdmTable2 
 ON cdmTable.person_id = cdmTable2.person_id
 WHERE cdmTable2.person_id IS NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.person cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.person_id) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 cdmTable.* 
 FROM ehr_union.person cdmTable
 LEFT JOIN ehr_union.DEATH cdmTable2 
 ON cdmTable.person_id = cdmTable2.person_id
 WHERE cdmTable2.person_id IS NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.person cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.person_id) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 cdmTable.* 
 FROM ehr_union.person cdmTable
 LEFT JOIN ehr_union.NOTE cdmTable2 
 ON cdmTable.person_id = cdmTable2.person_id
 WHERE cdmTable2.person_id IS NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.person cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.person_id) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 cdmTable.* 
 FROM ehr_union.person cdmTable
 LEFT JOIN ehr_union.SPECIMEN cdmTable2 
 ON cdmTable.person_id = cdmTable2.person_id
 WHERE cdmTable2.person_id IS NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.person cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.person_id) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 cdmTable.* 
 FROM ehr_union.person cdmTable
 LEFT JOIN ehr_union.PAYER_PLAN_PERIOD cdmTable2 
 ON cdmTable.person_id = cdmTable2.person_id
 WHERE cdmTable2.person_id IS NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.person cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.person_id) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 cdmTable.* 
 FROM ehr_union.person cdmTable
 LEFT JOIN ehr_union.DRUG_ERA cdmTable2 
 ON cdmTable.person_id = cdmTable2.person_id
 WHERE cdmTable2.person_id IS NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.person cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.person_id) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 cdmTable.* 
 FROM ehr_union.person cdmTable
 LEFT JOIN ehr_union.DOSE_ERA cdmTable2 
 ON cdmTable.person_id = cdmTable2.person_id
 WHERE cdmTable2.person_id IS NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.person cdmTable
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(violated_rows.person_id) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 cdmTable.* 
 FROM ehr_union.person cdmTable
 LEFT JOIN ehr_union.CONDITION_ERA cdmTable2 
 ON cdmTable.person_id = cdmTable2.person_id
 WHERE cdmTable2.person_id IS NULL
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.person cdmTable
) denominator;
