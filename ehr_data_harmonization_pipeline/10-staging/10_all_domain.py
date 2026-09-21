# Databricks notebook source
dbutils.widgets.text("site", "", "Sites")
dbname=dbutils.widgets.get("site")+'_ingestion'
staging_folder=dbutils.widgets.get("site")+ '_staging'

print(dbname)


# COMMAND ----------

# create database 
spark.sql(f"DROP database {staging_folder} CASCADE")
# if drop command failed, line 4 would report error
spark.sql(f"CREATE DATABASE {staging_folder}")


# COMMAND ----------

import sys
sys.path.append("/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
from myproject import final_schema
from myproject import timestamp_comment

def filter_table(spark, domain):
    df = spark.sql(f"select * from {dbname}.09_{domain}")
    schema_dict = final_schema.schema_dict[domain]

    # Create a mapping of lowercase column names to actual column names in df
    df_col_mapping = {col.lower(): col for col in df.columns}
    
    
    # Get list of columns that exist in both the dataframe and the schema
    df_columns = [col.lower() for col in df.columns]  # Convert to lowercase for comparison
    schema_columns = [col.lower() for col in schema_dict]  # Convert to lowercase
    
    # Find columns that exist in both
    columns_to_keep = [col for col in df_columns if col in schema_columns]
    
    # Select only the columns we want to keep
    filtered_df = df.select(*columns_to_keep)
    
    # Write the filtered dataframe to a new table
    output_table = f"{staging_folder}.{domain}"
    filtered_df.write.mode("overwrite").saveAsTable(output_table)
    
    # Add timestamp comment
    timestamp_comment.comment(spark, staging_folder, domain)
    print(f"Moved {domain} to staging folder and keep the OMOP cols only")
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
    filter_table(spark,domain)

# COMMAND ----------


