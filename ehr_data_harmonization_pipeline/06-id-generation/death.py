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
    CREATE TABLE {databaseName}.06_death AS

    SELECT 
        d.*
        -- Join in the final person and visit ids from the final OMOP domains after collision resolutions
        , p.person_id
    FROM {databaseName}.04_death d
    LEFT JOIN {databaseName}.06_person p
    ON d.site_person_id = p.site_person_id 
""")


# COMMAND ----------


import sys
sys.path.append("/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
from myproject import timestamp_comment
timestamp_comment.comment(spark,databaseName,'06_death')


