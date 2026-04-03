# Databricks notebook source
# MAGIC %md
# MAGIC - If there is any duplication of 51 bit, meaning there are records in 05 collision table. The code use collision index to generate an unique global ID.
# MAGIC - If no duplication found, then creat the ID from step 4 51 bit directly

# COMMAND ----------

dbutils.widgets.removeAll()
dbutils.widgets.text("site", "", "Sites")
databaseName = dbutils.widgets.get("site") + '_ingestion'
print(databaseName)


# COMMAND ----------

spark.sql(f"""
    CREATE OR REPLACE TABLE {databaseName}.06_visit_occurrence AS

    WITH join_conflict_id AS (
        SELECT 
            d.*
            , COALESCE(lookup.collision_bits, 0) as collision_index
        FROM {databaseName}.04_visit_occurrence d
        LEFT JOIN {databaseName}.05_visit_occurrence lookup
        ON d.visit_occurrence_id_51_bit = lookup.visit_occurrence_id_51_bit
        AND d.hashed_id = lookup.hashed_id
    ),

    global_id AS (
    SELECT
        *
        -- Final 10 bits reserved for the site id
        , shiftleft(local_id, 10) + data_partner_id as visit_occurrence_id 
        FROM (
            SELECT
                *
                -- Take conflict index and append it as 2 bits (assumes no more than 3 conflicts)
                , shiftleft(visit_occurrence_id_51_bit, 2) + collision_index as local_id
            FROM join_conflict_id
        )
    ), 

    global_visit as (

        SELECT
            global_id.*
            -- Join in the final person and visit ids from the final OMOP domains after collision resolutions
            , p.person_id
            , care.care_site_id
            , prov.provider_id
        FROM global_id
        LEFT JOIN {databaseName}.06_person p
        ON global_id.site_person_id = p.site_person_id
        LEFT JOIN {databaseName}.06_care_site care
        ON global_id.site_care_site_id = care.site_care_site_id
        LEFT JOIN {databaseName}.06_provider prov
        ON global_id.site_provider_id = prov.site_provider_id

    )

    SELECT gv.*
        ,preceding.visit_occurrence_id as preceding_visit_occurrence_id
    FROM global_visit gv
    LEFT JOIN global_visit preceding 
    ON gv.site_preceding_visit_occurrence_id = preceding.site_visit_occurrence_id
""")

  

# COMMAND ----------

import sys
sys.path.append("/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
from myproject import timestamp_comment
timestamp_comment.comment(spark,databaseName,'06_visit_occurrence')
