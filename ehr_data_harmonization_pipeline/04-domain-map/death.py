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
CREATE OR REPLACE TABLE {databaseName}.04_death AS

    SELECT 
            * 
    FROM (
        SELECT
            person_id as site_person_id
            , death_date	
            , death_datetime	
            , death_type_concept_id	
            , cause_concept_id	
            , cause_source_value	
            , cause_source_concept_id	
            , data_partner_id
            , payload
        FROM {databaseName}.03_death
    ) 
""")


# COMMAND ----------

import sys
sys.path.append("/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
from myproject import timestamp_comment
timestamp_comment.comment(spark,databaseName,'04_death')
