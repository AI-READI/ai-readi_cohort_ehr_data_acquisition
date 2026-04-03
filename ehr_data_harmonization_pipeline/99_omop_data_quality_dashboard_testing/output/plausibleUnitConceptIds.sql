SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3006315
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8784,8848,8961,9444) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3006315
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3004410
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8554,8737,9225,9579) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3004410
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 40487382
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8784,8848,8961,9444) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 40487382
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3013721
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8645,8923) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3013721
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3019198
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8784,8848,8961,9444) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3019198
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3034426
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8555) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3034426
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3043688
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8713) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3043688
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3046485
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8523,8554,8596,-1) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3046485
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4216098
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8784,8848,8961,9444) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4216098
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4245152
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8736,8753,9557) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4245152
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 43055141
 AND COALESCE (m.unit_concept_id, -1) NOT IN (-1) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 43055141
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3006923
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8645,8923) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3006923
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3021044
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8837) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3021044
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3024171
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8483,8541) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3024171
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3027114
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8840) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3027114
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 40762499
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8554,-1) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 40762499
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3000963
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8636,8713) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3000963
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3001604
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8848,8961,9444) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3001604
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3019069
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8554) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3019069
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3022509
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8765) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3022509
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3028288
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8840,9028) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3028288
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4148615
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8784,8848,8961,8848,9444) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4148615
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 44806420
 AND COALESCE (m.unit_concept_id, -1) NOT IN (720870,8795) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 44806420
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3028437
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8840,9028) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3028437
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3016991
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8837) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3016991
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3026925
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8820,8845) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3026925
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3028615
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8784,8816,8848,8961,9436,9444) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3028615
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3051205
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8786) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3051205
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4098046
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8554) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4098046
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3005131
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8840,9028) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3005131
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3011163
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8523,8529,8554,8596,8606,-1) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3011163
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3044491
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8576,8840,9028) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3044491
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4017361
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8753,8840) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4017361
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3006504
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8554) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3006504
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3000483
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8840) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3000483
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3033543
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8523,-1) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3033543
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3045716
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8753,9557) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3045716
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4101713
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8636,8736,8753,8840) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4101713
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4103762
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8753,9557) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4103762
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3001008
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8765,8786,8889) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3001008
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3009744
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8564,8636,8713) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3009744
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3013115
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8848,8961,9444) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3013115
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3019550
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8753,9557) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3019550
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3020416
 AND COALESCE (m.unit_concept_id, -1) NOT IN (44777575,8734,8815) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3020416
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3035583
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8786,8889) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3035583
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3035995
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8645,8923) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3035995
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3038553
 AND COALESCE (m.unit_concept_id, -1) NOT IN (9531) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3038553
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 35610320
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8876) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 35610320
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3001490
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8784,8848,8961,9444) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3001490
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4195214
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8523,8554,8596,-1) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4195214
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 36306178
 AND COALESCE (m.unit_concept_id, -1) NOT IN (720870,8795) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 36306178
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 37393850
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8636,8713,8554,8753) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 37393850
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3004501
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8840,8753) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3004501
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3008598
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8817) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3008598
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3018010
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8554,-1) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3018010
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3022192
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8840,8753) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3022192
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4151768
 AND COALESCE (m.unit_concept_id, -1) NOT IN (9448,-1) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4151768
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4197602
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8719,9040,9093,44777578,8750,8923,44777583) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4197602
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 46236952
 AND COALESCE (m.unit_concept_id, -1) NOT IN (720870,8795) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 46236952
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3006906
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8840) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3006906
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3007070
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8840) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3007070
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3020460
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8751,8840) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3020460
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3023314
 AND COALESCE (m.unit_concept_id, -1) NOT IN (44777604,8554) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3023314
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3035941
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8564,9655) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3035941
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3037072
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8840) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3037072
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4151358
 AND COALESCE (m.unit_concept_id, -1) NOT IN (44777604,8554,8523) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4151358
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4194332
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8784,8848,8961,9444) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4194332
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3001123
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8583) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3001123
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3012888
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8876) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3012888
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3013707
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8752) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3013707
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3037511
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8554) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3037511
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3040168
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8848,8961,9444) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3040168
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4097430
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8753,9557) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4097430
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3005424
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8617) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3005424
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3013603
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8748,8842) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3013603
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3020509
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8523,8554,8596,-1) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3020509
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3036277
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8582,9327,9330,9546) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3036277
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4301868
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8483,8541,8581) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4301868
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 40762636
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8554) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 40762636
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 40765040
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8842,8845) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 40765040
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3024386
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8583) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3024386
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3009201
 AND COALESCE (m.unit_concept_id, -1) NOT IN (44777578,8719,9040,9093,8860) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3009201
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3024731
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8583) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3024731
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3050479
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8554,-1) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3050479
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4012479
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8636,8753,8840) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4012479
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4152194
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8876) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4152194
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 37393840
 AND COALESCE (m.unit_concept_id, -1) NOT IN (44777604,8523,8554,-1) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 37393840
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3000593
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8845) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3000593
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3002888
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8583) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3002888
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3010910
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8647,8785,8815,8931) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3010910
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3013290
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8876) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3013290
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3027970
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8636,8713,8950) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3027970
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4239408
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8483,8541,8581) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4239408
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3010813
 AND COALESCE (m.unit_concept_id, -1) NOT IN (44777588,8848,8961,9444,8647) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3010813
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3023103
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8753,9557) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3023103
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4030871
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8734,8815,8931,9444,9445) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4030871
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4154790
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8876) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4154790
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4217013
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8876) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4217013
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3001318
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8554,8596,-1) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3001318
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3004249
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8876) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3004249
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3009596
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8576,8840) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3009596
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3025315
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8739,9346,9373,9529) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3025315
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3053283
 AND COALESCE (m.unit_concept_id, -1) NOT IN (720870,8795) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3053283
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4008265
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8736,8753,8840) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4008265
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 36303797
 AND COALESCE (m.unit_concept_id, -1) NOT IN (720870,8795) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 36303797
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 37398460
 AND COALESCE (m.unit_concept_id, -1) NOT IN (32995,8645,8923) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 37398460
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3013682
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8840) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3013682
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3026361
 AND COALESCE (m.unit_concept_id, -1) NOT IN (32706,8785,8815,8931) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3026361
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3027018
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8483,8541,-1) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3027018
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4013965
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8554) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4013965
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3013429
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8784,8816,8848,8961,9436,9444) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3013429
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3023599
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8583) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3023599
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3036588
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8525,-1) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3036588
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4298431
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8848,8961,9444) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4298431
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3017732
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8848,8961,9444) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3017732
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3024561
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8636,8713) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3024561
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3034639
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8713,8840,9579,8923) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3034639
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3013650
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8784,8848,8961,9444) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3013650
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3021886
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8636,8713,8950) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3021886
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4254663
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8848,9444) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4254663
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3001420
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8840) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3001420
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3007461
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8848,8961,9444,32706) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3007461
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3012030
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8564) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3012030
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 40764999
 AND COALESCE (m.unit_concept_id, -1) NOT IN (720870,8795) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 40764999
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3008893
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8817) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3008893
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3016723
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8840,8749) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3016723
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3026910
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8645,8923) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3026910
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3033575
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8784,8816,8848,8961,9436,9444) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3033575
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3041084
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8848,8961,9444) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3041084
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4184637
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8554,8632,8737,9579) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4184637
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4313591
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8483,8541) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4313591
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 37393851
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8583) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 37393851
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 1619025
 AND COALESCE (m.unit_concept_id, -1) NOT IN (720870,8795) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 1619025
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3013869
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8554) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3013869
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3035472
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8554,-1) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3035472
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3039000
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8753,9557) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3039000
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3000905
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8816,8848,8961,9436,9444) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3000905
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3015632
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8753,9557) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3015632
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3032710
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8554,-1) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3032710
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4197971
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8554,8632,8737) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4197971
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 42869452
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8554,-1) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 42869452
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3002109
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8523,8596,8606,-1) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3002109
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3004327
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8784,8816,8848,8961,9436,9444) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3004327
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3006322
 AND COALESCE (m.unit_concept_id, -1) NOT IN (586323) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3006322
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3008342
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8554) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3008342
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3020630
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8636,8713) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3020630
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3001122
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8748,8842) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3001122
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3009542
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8554) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3009542
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3010189
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8765,8786) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3010189
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3010457
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8554) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3010457
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4192368
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8583) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4192368
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3014576
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8753,9557) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3014576
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3024128
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8840,8749) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3024128
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3018311
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8523,8554,8596,-1) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3018311
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3020891
 AND COALESCE (m.unit_concept_id, -1) NOT IN (586323,9289) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3020891
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3037556
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8840,8923) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3037556
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 37399332
 AND COALESCE (m.unit_concept_id, -1) NOT IN (44777578,9040) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 37399332
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3011904
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8840) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3011904
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3019897
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8554,-1) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3019897
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3025255
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8786) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3025255
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4076704
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8753,8840) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4076704
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4172647
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8848,8961,9444) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4172647
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 37393531
 AND COALESCE (m.unit_concept_id, -1) NOT IN (32995,8645,8923) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 37393531
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 40771529
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8554,-1) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 40771529
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3000034
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8576,8723,8751,8840,8859,8636) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3000034
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3035124
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8786,8889) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3035124
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3002030
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8554,8848) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3002030
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3019170
 AND COALESCE (m.unit_concept_id, -1) NOT IN (44777578,8719,8860,9040,9093,9550) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3019170
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3020149
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8842) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3020149
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3022174
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8647,8784,8785,8848,8961) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3022174
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3024929
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8816,8848,8961,9436,9444) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3024929
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3049187
 AND COALESCE (m.unit_concept_id, -1) NOT IN (720870,8795) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3049187
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 37398676
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8848) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 37398676
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4112223
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8523,8596,-1) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4112223
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3017250
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8576,8840) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3017250
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4191837
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8840,8753) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 4191837
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3022096
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8554) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3022096
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3034485
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8523,8723,8838,9017,9072) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3034485
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 44790183
 AND COALESCE (m.unit_concept_id, -1) NOT IN (720870,8795) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 44790183
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3002400
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8749,8837) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3002400
 AND value_as_number IS NOT NULL
) denominator;
SELECT num_violated_rows, 
 CASE 
 WHEN denominator.num_rows = 0 THEN 0 
 ELSE 1.0*num_violated_rows/denominator.num_rows 
 END AS pct_violated_rows, 
 denominator.num_rows AS num_denominator_rows
 FROM (SELECT 
 COUNT(*) AS num_violated_rows
 FROM
 (
 /*violatedRowsBegin*/
 SELECT 
 m.* 
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3003338
 AND COALESCE (m.unit_concept_id, -1) NOT IN (8713,8753) -- '-1' stands for the cases when unit_concept_id is null
 AND m.value_as_number IS NOT NULL 
 /*violatedRowsEnd*/
 ) violated_rows
) violated_row_count cross join (SELECT 
 COUNT(*) AS num_rows
 FROM ehr_union.MEASUREMENT m
 WHERE m.MEASUREMENT_CONCEPT_ID = 3003338
 AND value_as_number IS NOT NULL
) denominator;
