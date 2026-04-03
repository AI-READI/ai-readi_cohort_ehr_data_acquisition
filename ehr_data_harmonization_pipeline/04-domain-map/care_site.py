# Databricks notebook source
# MAGIC
# MAGIC %md
# MAGIC - Use the target_domain_id field from step 3 to ensure all records are going to appropriate domains. 
# MAGIC - source_pkey column is used to create unique combination to generate global ID in the downstream pipeline

# COMMAND ----------

dbutils.widgets.removeAll()
dbutils.widgets.text("site", "", "Sites")
databaseName = dbutils.widgets.get("site") + '_ingestion'
print(databaseName)


# COMMAND ----------

spark.sql(f"""
CREATE OR REPLACE TABLE {databaseName}.04_care_site AS

    SELECT 
          * 
        , cast(conv(substr(hashed_id, 1, 15), 16, 10) as bigint) & 2251799813685247 as care_site_id_51_bit
    FROM (
        SELECT
              care_site_id as site_care_site_id
            , md5(CAST(care_site_id as string)) as hashed_id
            , care_site_name
            , place_of_service_concept_id
            , location_id as site_location_id
            , care_site_source_value
            , place_of_service_source_value
            , data_partner_id
            , payload
        FROM {databaseName}.03_care_site
        WHERE care_site_id IS NOT NULL
    )   
""")

# COMMAND ----------

import sys
sys.path.append("/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
from myproject import timestamp_comment
timestamp_comment.comment(spark,databaseName,'04_care_site')
