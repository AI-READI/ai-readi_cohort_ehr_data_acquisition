# Databricks notebook source
# MAGIC %md
# MAGIC - Harmonize the OMOP file by joining with up to date omop tables
# MAGIC - Use concept relationship table and relationship_id = ‘Maps to’ to find any mapping concepts. 
# MAGIC - Mapped conceptes information is stored at target_concept_columns
# MAGIC - Target concepts columns are used in the next steps

# COMMAND ----------

dbutils.widgets.removeAll()

dbutils.widgets.text("site", "", "Sites")

dbname=dbutils.widgets.get("site")+'_ingestion'
print(dbname)

# COMMAND ----------

import sys
sys.path.append("/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
from myproject.standard_mapping import perform_standard_mapping
from pyspark.sql import functions as F, types as T
from myproject import timestamp_comment

def make_transform(domain,concept_col):
    processed_df=spark.sql(f"select * from {dbname}.02_{domain}") 

    concept_df=spark.sql("select * from omop_vocab.concept") 
    concept_relationship_df = spark.sql("select * from omop_vocab.concept_relationship") 


    if concept_col:
        processed_df = perform_standard_mapping(processed_df, concept_df, concept_relationship_df, concept_col, domain)


    
    processed_df.write \
        .format("delta") \
        .option("mergeSchema", "true") \
        .mode("overwrite") \
        .saveAsTable(f"{dbname}.03_{domain}")
        
    print(f"{dbname}.03_{domain} created")


    # Add comment separately
    timestamp_comment.comment(spark,dbname,'03_'+domain)

domains = [
    ("care_site", None),
    # ("condition_era", "condition_concept_id"),
    ("condition_occurrence", "condition_concept_id"),
    # ("control_map", None),
    ("death", None),
    ("device_exposure", "device_concept_id"),
    # ("dose_era", "drug_concept_id"),
    # ("drug_era", "drug_concept_id"),
    ("drug_exposure", "drug_concept_id"),
    ("location", None),
    ("measurement", "measurement_concept_id"),
    # ("note", None), 
    # ("note_nlp", "note_nlp_concept_id"),  # note_nlp_concept_id
    ("observation", "observation_concept_id"),
    # ("observation_period", None),
    ("person", None),
    ("procedure_occurrence", "procedure_concept_id"),
    ("provider", None),
    # ("visit_detail", "visit_detail_id"),
    ("visit_occurrence", "visit_concept_id")
]

_ = [make_transform(*domain) for domain in domains]


# COMMAND ----------


