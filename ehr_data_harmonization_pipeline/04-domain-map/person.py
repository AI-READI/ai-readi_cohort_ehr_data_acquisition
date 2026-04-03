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
CREATE OR REPLACE TABLE {databaseName}.04_person AS

    SELECT
        *
        -- Convert hashed id to 51 bit Long
        , cast(conv(substr(hashed_id, 1, 15), 16, 10) as bigint) & 2251799813685247 as person_id_51_bit
    FROM (
        SELECT 
              person_id as site_person_id
            , md5(CAST(person_id AS STRING)) as hashed_id
            , gender_concept_id
            , year_of_birth
            , month_of_birth
            , day_of_birth
            , birth_datetime
            , race_concept_id
            , ethnicity_concept_id
            , location_id as site_location_id
            , provider_id as site_provider_id
            , care_site_id as site_care_site_id
            , person_source_value
            , gender_source_value
            , gender_source_concept_id
            , race_source_value
            , race_source_concept_id
            , ethnicity_source_value
            , ethnicity_source_concept_id
            , data_partner_id
            , payload
        FROM {databaseName}.03_person   
        WHERE person_id IS NOT NULL
    )
""")

# COMMAND ----------

import sys
sys.path.append("/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
from myproject import timestamp_comment
timestamp_comment.comment(spark,databaseName,'04_person')
