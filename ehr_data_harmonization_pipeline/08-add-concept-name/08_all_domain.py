# Databricks notebook source
dbutils.widgets.removeAll()

dbutils.widgets.text("site", "", "Sites")

dbname=dbutils.widgets.get("site")+'_ingestion'
print(dbname)

# COMMAND ----------

import sys
sys.path.append("/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
from myproject import clean
from pyspark.sql import functions as F, types as T
from myproject import timestamp_comment


def add_concept_name(domain):
    df = spark.sql(f"""select * from {dbname}.07_{domain}_processed""")
    concept = spark.sql("select * from omop_vocab.concept")
    df_out = clean.conceptualize(domain, df, concept)
    
    # Cast provider_id to BIGINT to handle large values
    if "provider_id" in df_out.columns:
        df_out = df_out.withColumn("provider_id", F.col("provider_id").cast("bigint"))
    
    df_out.write.format("delta").mode("overwrite").saveAsTable(f"{dbname}.08_{domain}")
    timestamp_comment.comment(spark,dbname,'08_'+domain)
    
domains = [
    "care_site",
    # "condition_era",
    "condition_occurrence",
    # "control_map",
    "death",
    "device_exposure",
    # "dose_era",
    # "drug_era",
    "drug_exposure",
    "location",
    "measurement",
    # "note",
    # "note_nlp",
    "observation",
    # "observation_period",
    # # payer_plan_period
    "person",
    "procedure_occurrence",
    "provider",
    # "visit_detail",
    "visit_occurrence",
]
for domain in domains:
    add_concept_name(domain)
    print(f"Processed {domain}")

# COMMAND ----------


site = dbutils.widgets.get("site")

if site == "UAB":
    spark.sql("""
        CREATE OR REPLACE TABLE uab_ingestion.08_visit_occurrence AS 
        SELECT * FROM uab_ingestion.08_visit_occurrence 
        WHERE visit_start_date IS NOT NULL
    """)
    print("UAB: Filtered visit_occurrence to exclude NULL visit_start_date rows.")
else:
    print(f"Site is '{site}', not UAB — skipping visit_occurrence filter.")

# COMMAND ----------


