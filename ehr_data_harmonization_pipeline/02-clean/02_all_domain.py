# Databricks notebook source
# MAGIC %md
# MAGIC - Change tables format to OMOP schema
# MAGIC - Check if the primary key is unique
# MAGIC

# COMMAND ----------

#dbutils.widgets.removeAll()
#dbutils.widgets.text("databaseName", "", "Database name")
dbutils.widgets.text("site", "", "Sites")

#dbname=dbutils.widgets.get("databaseName")
dbname=dbutils.widgets.get("site")+'_ingestion'
print(dbname)

# COMMAND ----------

import sys
sys.path.append("/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
from myproject import schema
from myproject import local_schemas
from pyspark.sql.functions import col, count
from typing import List
from pyspark.sql import functions as F, types as T
from myproject import timestamp_comment
# Set the legacy time parser policy
spark.conf.set("spark.sql.legacy.timeParserPolicy", "LEGACY")

def validate_schema(df, schema_strings, domain, pkey=None):
    """
    Validates a DataFrame against required schema and primary key constraints
    
    Args:
        df: Spark DataFrame to validate
        schema_strings: List of required column names
        domain: Name of the domain/table for error messages
        pkey: Optional primary key column name
    
    Returns:
        bool: True if all validations pass, False otherwise
    """
    # Check schema
    existing_columns = [col.upper() for col in df.columns]
    missing_columns = [col for col in schema_strings if col not in existing_columns]

    if missing_columns:
        print(f"Validation failed: {domain} schema must contain required columns: {', '.join(missing_columns)}")
        return False
    
    # Check primary key if specified
    if pkey:
        # Count total rows
        total_rows = df.count()
        
        # Count distinct values in primary key column
        distinct_keys = df.select(pkey).distinct().count()
        
        if total_rows != distinct_keys:
            print(f"Validation failed: {pkey} must be a valid primary key - duplicate values found")
            return False
    
    return True


def transform_omop(domain, pkey):
    schema_dict = local_schemas.complete_domain_schema_dict[domain]
    schema_dict["DATA_PARTNER_ID"] = T.IntegerType()
    schema_dict["PAYLOAD"] = T.StringType()
    # add comment
    required_dict = local_schemas.required_domain_schema_dict[domain]
    # add comment
    schema_strings = schema.schema_dict_all_string_type(required_dict, add_payload=False)

    
    df = spark.sql(f"""select * from {dbname}.01_{domain}""")



    # check input schema
    if dbname == 'UAB_ingestion':
        print('UAB files have duplications. Bypass the check')
    elif not validate_schema(df, schema_strings, domain,pkey): # UAB will not pass the primary key check. Bypass for now.:
        print(f"Input validation failed for {domain}. Skipping this domain.")
        return False

    
    def compute_function(df, schema_dict):
        try:
            # Process with schema - schema.py now handles preserving data_partner_id and payload
            processed_df = schema.apply_schema(df, schema_dict, include_payload=False)  # Set to True to keep payload

            # output schema check
            if validate_schema(processed_df, schema_strings, domain) or dbname == 'UAB_ingestion': # UAB will not pass the primary key check. Bypass for now.
                processed_df.write.format("delta").option("mergeSchema", "true").mode("overwrite").saveAsTable(f"{dbname}.02_{domain}")
                # log timestamp
                timestamp_comment.comment(spark, dbname, '02_'+domain)
                print(f"{dbname}.02_{domain} created successfully.")
                return True
            else:
                print(f"Output validation failed for {domain}. Table not written.")
                return False
                
        except Exception as e:
            print(f"Error processing {domain}: {str(e)}")
            return False

    return compute_function(df, schema_dict)


domains = [
    # domain, pkey
    ("care_site", "care_site_id"),
    # ("condition_era", "condition_era_id"),
    ("condition_occurrence", "condition_occurrence_id"),
    # ("control_map", None),
    ("death", None),
    ("device_exposure", "device_exposure_id"),
    # ("dose_era", "dose_era_id"),
    # ("drug_era", "drug_era_id"),
    ("drug_exposure", "drug_exposure_id"),
    ("location", "location_id"),
    ("measurement", "measurement_id"),
    # ("note", None),  # Temporarily do not check the primary key - note_id
    # ("note_nlp", None),  # Temporarily do not check the primary key - note_nlp_id
    ("observation", "observation_id"),
    # ("observation_period", "observation_period_id"),
    ("person", "person_id"),
    ("procedure_occurrence", "procedure_occurrence_id"),
    ("provider", "provider_id"),
    #("visit_detail", "visit_detail_id"),
    ("visit_occurrence", "visit_occurrence_id"),
]

results = {}
for domain in domains:
    success = transform_omop(*domain)
    

# COMMAND ----------


