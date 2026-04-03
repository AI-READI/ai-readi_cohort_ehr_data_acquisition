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
    CREATE OR REPLACE TABLE {databaseName}.06_location AS

    WITH join_conflict_id AS (
        SELECT 
            d.*
            , COALESCE(lookup.collision_bits, 0) as collision_index
        FROM {databaseName}.04_location d
        LEFT JOIN {databaseName}.05_location lookup
        ON d.location_id_51_bit = lookup.location_id_51_bit
        AND d.hashed_id = lookup.hashed_id
    ),

    global_id AS (
    SELECT
        *
        -- Final 10 bits reserved for the site id
        , shiftleft(local_id, 10) + data_partner_id as location_id 
        FROM (
            SELECT
                *
                -- Take conflict index and append it as 2 bits (assumes no more than 3 conflicts)
                , shiftleft(location_id_51_bit, 2) + collision_index as local_id
            FROM join_conflict_id
        )
    )

    SELECT * FROM global_id
""")

# COMMAND ----------


import sys
sys.path.append("/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
from myproject import timestamp_comment
timestamp_comment.comment(spark,databaseName,'06_location')


