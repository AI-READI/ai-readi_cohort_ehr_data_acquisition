-- Databricks notebook source
-- MAGIC %python
-- MAGIC dbutils.widgets.removeAll()
-- MAGIC dbutils.widgets.text("databaseName", "", "Database name")
-- MAGIC
-- MAGIC dbname=dbutils.widgets.get("databaseName")

-- COMMAND ----------

CREATE TABLE IDENTIFIER(:databaseName ||'.04_control_map') AS
    SELECT 
        * 
        , CAST(conv(substr(hashed_id, 1, 15), 16, 10) as bigint) & 2251799813685247 as control_map_id_51_bit
    FROM (
        SELECT
            control_map_id as site_control_map_id
            , md5(CAST(control_map_id AS STRING)) as hashed_id
            , case_person_id as site_case_person_id
            , buddy_num
            , control_person_id as site_control_person_id   
            , CAST(NULL as INTEGER) as case_age	
            , CAST(NULL as STRING) as case_sex	
            , CAST(NULL as STRING) as case_race	
            , CAST(NULL as STRING) as case_ethn	
            , CAST(NULL as INTEGER) as control_age	
            , CAST(NULL as STRING) as control_sex	
            , CAST(NULL as STRING) as control_race	
            , CAST(NULL as STRING) as control_ethn
            , data_partner_id
            , payload
        FROM ( 
            SELECT
            CAST( (case_person_id || buddy_num || control_person_id) AS STRING) as control_map_id ,
            case_person_id,
            buddy_num, 
            control_person_id, 
            data_partner_id,
            payload
            FROM (
                select distinct case_person_id, buddy_num, control_person_id, data_partner_id, payload
                from 
                IDENTIFIER(:databaseName ||'.03_control_map')
                WHERE case_person_id IS NOT NULL and buddy_num is not null and control_person_id is not null 
            ) 
        )
    )

-- COMMAND ----------

-- MAGIC %python
-- MAGIC import sys
-- MAGIC sys.path.append("/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
-- MAGIC from myproject import timestamp_comment
-- MAGIC timestamp_comment.comment(spark,dbname,'04_control_map')
-- MAGIC
