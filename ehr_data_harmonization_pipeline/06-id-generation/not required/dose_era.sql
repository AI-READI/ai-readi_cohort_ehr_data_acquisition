-- Databricks notebook source
-- MAGIC %python 
-- MAGIC dbutils.widgets.removeAll()
-- MAGIC dbutils.widgets.text("databaseName", "", "Database name")
-- MAGIC dbname=dbutils.widgets.get("databaseName")

-- COMMAND ----------

CREATE TABLE IDENTIFIER(:databaseName ||'.06_dose_era') AS

WITH join_conflict_id AS (
    SELECT 
        d.*
        , COALESCE(lookup.collision_bits, 0) as collision_index
    FROM IDENTIFIER(:databaseName ||'.04_dose_era') d
    LEFT JOIN IDENTIFIER(:databaseName ||'.05_dose_era') lookup
    ON d.dose_era_id_51_bit = lookup.dose_era_id_51_bit
    AND d.hashed_id = lookup.hashed_id
),

global_id AS (
SELECT
      *
    -- Final 10 bits reserved for the site id
    , shiftleft(local_id, 10) + data_partner_id as dose_era_id 
    FROM (
        SELECT
            *
            -- Take conflict index and append it as 2 bits (assumes no more than 3 conflicts)
            , shiftleft(dose_era_id_51_bit, 2) + collision_index as local_id
        FROM join_conflict_id
    )
)

SELECT
      global_id.*
    -- Join in the final person and visit ids from the final OMOP domains after collision resolutions
    , p.person_id
FROM global_id
LEFT JOIN IDENTIFIER(:databaseName ||'.06_person') p
ON global_id.site_person_id = p.site_person_id


-- COMMAND ----------

-- MAGIC %python
-- MAGIC import sys
-- MAGIC sys.path.append("/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
-- MAGIC from myproject import timestamp_comment
-- MAGIC timestamp_comment.comment(spark,dbname,'06_dose_era')
-- MAGIC
-- MAGIC
