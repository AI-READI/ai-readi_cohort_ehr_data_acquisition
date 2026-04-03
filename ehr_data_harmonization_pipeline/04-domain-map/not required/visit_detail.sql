-- Databricks notebook source
-- MAGIC %python
-- MAGIC dbutils.widgets.removeAll()
-- MAGIC dbutils.widgets.text("databaseName", "", "Database name")
-- MAGIC
-- MAGIC dbname=dbutils.widgets.get("databaseName")

-- COMMAND ----------

CREATE TABLE IDENTIFIER(:databaseName ||'.04_visit_detail') AS
    with visit_detail_domain as (
        SELECT DISTINCT
              vd.visit_detail_id as site_visit_detail_id
            , vd.person_id as site_person_id
            , vd.visit_detail_concept_id
            , vd.visit_detail_start_date
            , vd.visit_detail_start_datetime
            , vd.visit_detail_end_date
            , vd.visit_detail_end_datetime
            , vd.visit_detail_type_concept_id
            , vd.provider_id as site_provider_id
            , vd.care_site_id as site_care_site_id
            , vd.visit_detail_source_value
            , vd.visit_detail_source_concept_id
            , vd.admitting_source_value
            , vd.admitting_source_concept_id
            , vd.discharge_to_source_value
            , vd.discharge_to_concept_id
            , vd.preceding_visit_detail_id as site_preceding_visit_detail_id
            , vd.visit_detail_parent_id
            , vd.visit_occurrence_id as site_visit_occurrence_id
            , vd.data_partner_id
            , vd.payload
        FROM IDENTIFIER(:databaseName ||'.03_visit_detail') vd
        join IDENTIFIER(:databaseName ||'.03_visit_occurrence') v
         on vd.visit_occurrence_id = v.visit_occurrence_id
        join IDENTIFIER(:databaseName ||'.03_person') p
        on vd.person_id = p.person_id
        WHERE visit_detail_id IS NOT NULL
    ),
    final_table as (
        select *, 
         md5(concat_ws(';'
                , COALESCE(CAST(site_visit_detail_id as string), '')
                , COALESCE(cast(visit_detail_concept_id as string), '')
            )) as hashed_id
        from visit_detail_domain
    )

    SELECT 
          * 
        , cast(conv(substr(hashed_id, 1, 15), 16, 10) as bigint) & 2251799813685247 as visit_detail_id_51_bit
    FROM final_table

-- COMMAND ----------

-- MAGIC %python
-- MAGIC import sys
-- MAGIC sys.path.append("/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
-- MAGIC from myproject import timestamp_comment
-- MAGIC timestamp_comment.comment(spark,dbname,'04_visit_detail')
-- MAGIC
