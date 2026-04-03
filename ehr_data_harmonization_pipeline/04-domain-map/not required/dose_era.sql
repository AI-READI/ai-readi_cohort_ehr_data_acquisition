-- Databricks notebook source
-- MAGIC %python
-- MAGIC dbutils.widgets.removeAll()
-- MAGIC dbutils.widgets.text("databaseName", "", "Database name")
-- MAGIC
-- MAGIC dbname=dbutils.widgets.get("databaseName")

-- COMMAND ----------

CREATE TABLE IDENTIFIER(:databaseName ||'.04_dose_era') AS

    SELECT 
          * 
        , cast(conv(substr(hashed_id, 1, 15), 16, 10) as bigint) & 2251799813685247 as dose_era_id_51_bit
    FROM (
        SELECT
              dose_era_id as site_dose_era_id
            , md5(CAST(dose_era_id as string)) as hashed_id
            , person_id	as site_person_id
            , COALESCE(target_concept_id, drug_concept_id) as drug_concept_id	
            , unit_concept_id	
            , dose_value	
            , dose_era_start_date	
            , dose_era_end_date	
            , data_partner_id
            , payload
        FROM IDENTIFIER(:databaseName ||'.03_dose_era')
        WHERE dose_era_id IS NOT NULL
    )   


-- COMMAND ----------

-- MAGIC %python
-- MAGIC import sys
-- MAGIC sys.path.append("/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
-- MAGIC from myproject import timestamp_comment
-- MAGIC timestamp_comment.comment(spark,dbname,'04_dose_era')
-- MAGIC
