# Databricks notebook source
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
CREATE OR REPLACE TABLE {databaseName}.04_provider AS

    SELECT 
          * 
        , cast(conv(substr(hashed_id, 1, 15), 16, 10) as bigint) & 2251799813685247 as provider_id_51_bit
    FROM (
        SELECT
              provider_id as site_provider_id
            , md5(CAST(provider_id as string)) as hashed_id
            , provider_name
            , npi
            , dea
            , specialty_concept_id
            , care_site_id as site_care_site_id
            , year_of_birth
            , gender_concept_id
            , provider_source_value
            , specialty_source_value
            , specialty_source_concept_id
            , gender_source_value
            , gender_source_concept_id
            , data_partner_id
            , payload
        FROM {databaseName}.03_provider
        WHERE provider_id IS NOT NULL
    ) 
""")  

# COMMAND ----------

import sys
sys.path.append("/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
from myproject import timestamp_comment
timestamp_comment.comment(spark,databaseName,'04_provider')
