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
    CREATE OR REPLACE TABLE {databaseName}.06_person AS


    WITH join_conflict_id AS (
        SELECT 
            d.*
            , COALESCE(lookup.collision_bits, 0) as id_index
        FROM {databaseName}.04_person d
        LEFT JOIN {databaseName}.05_person lookup
        ON d.person_id_51_bit = lookup.person_id_51_bit
        AND d.hashed_id = lookup.hashed_id
    ),

    global_id AS (
    SELECT
        *
        -- Final 10 bits reserved for the site id
        , shiftleft(local_id, 10) + data_partner_id as person_id 
        FROM (
            SELECT
                *
                -- Take collision index and append it as 2 bits (assumes no more than 3 conflicts)
                , shiftleft(person_id_51_bit, 2) + id_index as local_id
            FROM join_conflict_id
        )
    )

    SELECT
        global_id.*
        -- Join in the final person and visit ids from the final OMOP domains after collision resolutions
        , loc.location_id
        , prov.provider_id
        , care.care_site_id
    FROM global_id
    LEFT JOIN {databaseName}.06_location loc
    ON global_id.site_location_id = loc.site_location_id
    LEFT JOIN {databaseName}.06_provider prov
    ON global_id.site_provider_id = prov.site_provider_id
    LEFT JOIN {databaseName}.06_care_site care
    ON global_id.site_care_site_id = care.site_care_site_id
""")

# COMMAND ----------


import sys
sys.path.append("/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
from myproject import timestamp_comment
timestamp_comment.comment(spark,databaseName,'06_person')


