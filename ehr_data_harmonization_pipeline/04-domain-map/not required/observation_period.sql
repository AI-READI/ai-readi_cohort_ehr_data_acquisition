-- Databricks notebook source
-- MAGIC %python
-- MAGIC dbutils.widgets.removeAll()
-- MAGIC dbutils.widgets.text("databaseName", "", "Database name")
-- MAGIC
-- MAGIC dbname=dbutils.widgets.get("databaseName")

-- COMMAND ----------

CREATE TABLE IDENTIFIER(:databaseName ||'.04_observation_period') AS

    SELECT 
          * 
        , cast(conv(substr(hashed_id, 1, 15), 16, 10) as bigint) & 2251799813685247 as observation_period_id_51_bit
    FROM (
        SELECT
              observation_period_id as site_observation_period_id
            , md5(CAST(observation_period_id as string)) as hashed_id
            , person_id as site_person_id
            , observation_period_start_date
            , observation_period_end_date
            , period_type_concept_id
            , data_partner_id
            , payload
        FROM IDENTIFIER(:databaseName ||'.03_observation_period')
        WHERE observation_period_id IS NOT NULL
    )   


-- COMMAND ----------

-- MAGIC %python
-- MAGIC import sys
-- MAGIC sys.path.append("/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
-- MAGIC from myproject import timestamp_comment
-- MAGIC timestamp_comment.comment(spark,dbname,'04_observation_period')
-- MAGIC
