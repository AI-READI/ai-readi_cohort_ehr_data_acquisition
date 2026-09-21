# Databricks notebook source
# MAGIC %sql
# MAGIC -- This will drop the database and all its tables
# MAGIC DROP DATABASE IF EXISTS ehr_union CASCADE;
# MAGIC
# MAGIC -- Recreate the empty database
# MAGIC CREATE DATABASE ehr_union;

# COMMAND ----------

# DBTITLE 1,Cell 2
import sys
sys.path.append("/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
from myproject import final_schema
from pyspark.sql.functions import col, count
from pyspark.sql import functions as F, types as T
from myproject import timestamp_comment

def perform_union(spark, domain, **inputs):
    """Union multiple dataframes with proper schema enforcement"""
    # Get schema from final_schema module
    schema = final_schema.schema_dict[domain]
    
    # Enforce schema for each input dataframe
    dfs_to_union = []
    for site_name, df_site in inputs.items():
        try:
            # Select only columns that exist in the schema
            df_with_schema = df_site.selectExpr(*schema)
            dfs_to_union.append(df_with_schema)
            print(f"Successfully processed {site_name} for domain {domain}")
        except Exception as e:
            print(f"Error processing {site_name} for domain {domain}: {str(e)}")
            # Continue with other dataframes instead of failing completely
            continue
    
    # Check if we have any dataframes to union
    if not dfs_to_union:
        raise ValueError(f"No valid input dataframes found for domain {domain}")
    
    # Union all dataframes together
    unioned_df = dfs_to_union[0]
    for i, df in enumerate(dfs_to_union[1:], 1):
        try:
            unioned_df = unioned_df.unionByName(df, allowMissingColumns=True)
            
        except Exception as e:
            print(f"Error during union operation {i+1}: {str(e)}")
            raise
    
    # Ensure final column ordering matches schema
    unioned_df = unioned_df.selectExpr(*schema)
    
    return unioned_df


def get_inputs_databricks(spark, domain):
    inputs = {}
    #inputs["jhu"] = spark.table(f"jhu_staging.{domain}")
    inputs["uab"] = spark.table(f"uab_staging.{domain}")
    inputs["uw"] = spark.table(f"uw_staging.{domain}")
    inputs["ucsd"] = spark.table(f"ucsd_staging.{domain}")
    #print(f"union sites files: {list(inputs.keys())}")
    return inputs


def validate_primary_key(df, key_col):
    """Check if the primary key contains unique values"""
    count_all = df.count()
    count_distinct = df.select(key_col).distinct().count()
    if count_all != count_distinct:
        return False
    else:
        print(f"Column {key_col} is a valid primary key")
        return True


def my_compute_function(domain, key_col):
    """Transform function to union datasets together"""
    inputs = get_inputs_databricks(spark, domain)  # Added spark parameter
    
    df_out = perform_union(spark, domain, **inputs)  # Added spark parameter
    
    is_unique = validate_primary_key(df_out, key_col)
    
    output_table = f"EHR_union.{domain}"
    if is_unique:
        df_out.write.mode("overwrite").saveAsTable(output_table)
        # Add comment separately
        timestamp_comment.comment(spark,"EHR_union",domain)
        return df_out
    else:
        print(f"Column {key_col} is not a valid primary key, dropping duplicates and saving to ehr_union invalid")
        dup_ids = df_out.groupBy(key_col).count().filter("count > 1").select(key_col)
        df_invalid = df_out.join(dup_ids, key_col, "inner")
        df_valid = df_out.join(dup_ids, key_col, "left_anti")
        df_valid.write.mode("overwrite").saveAsTable(output_table)
        df_invalid.write.mode("overwrite").saveAsTable(f"ehr_union.invalid_{domain}")
        timestamp_comment.comment(spark,"EHR_union",domain)
        timestamp_comment.comment(spark,"ehr_union",f"invalid_{domain}")
        return df_valid


domains = [
    # domain, pkey, 
    ("care_site", "care_site_id"),
    # ("condition_era", "condition_era_id"),
    ("condition_occurrence", "condition_occurrence_id"),
    # ("control_map", 'control_map_id'),
    ("death", 'person_id'),
    ("device_exposure", "device_exposure_id"),
    # ("dose_era", "dose_era_id"),
    # ("drug_era", "drug_era_id"),
    ("drug_exposure", "drug_exposure_id"),
    ("location", "location_id"),
    ("measurement", "measurement_id"),
    # ("note", 'note_id'),  # Temporarily do not check the primary key - note_id
    # ("note_nlp",'note_nlp_id'),  # Temporarily do not check the primary key - note_nlp_id
    ("observation", "observation_id"),
    # ("observation_period", "observation_period_id"),
    ("person", "person_id"),
    ("procedure_occurrence", "procedure_occurrence_id"),
    ("provider", "provider_id"),
    # ("visit_detail", "visit_detail_id"),
    ("visit_occurrence", "visit_occurrence_id"),
]

for domain_tuple in domains:
    domain_name = domain_tuple[0]
    key_col = domain_tuple[1]
    try:
        my_compute_function(domain_name, key_col)
        print(f"Processed {domain_name}...")
    except ValueError as e:
        print(f"WARNING: Skipping {domain_name} due to validation error: {e}")

# COMMAND ----------

# union files for DQ dashboard
df= spark.sql("""select * from uab_ingestion.02_person_issue
              union all
              select * from uw_ingestion.02_person_issue
              union all
              select * from ucsd_ingestion.02_person_issue""")
df.write.format("delta").mode("overwrite").saveAsTable("ehr_dqp.person_id_remove")
timestamp_comment.comment(spark,'ehr_dqp','person_id_remove')

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT d.*
# MAGIC FROM uab_staging.death d
# MAGIC JOIN (
# MAGIC     SELECT person_id
# MAGIC     FROM uab_staging.death
# MAGIC     GROUP BY person_id
# MAGIC     HAVING COUNT(*) > 1
# MAGIC ) dup
# MAGIC ON d.person_id = dup.person_id
# MAGIC ORDER BY d.person_id;

# COMMAND ----------

spark.conf.set(
    "fs.azure.account.auth.type.fairhubproduction.dfs.core.windows.net", 
    "SAS"
)
spark.conf.set(
    "fs.azure.sas.token.provider.type.fairhubproduction.dfs.core.windows.net", 
    "org.apache.hadoop.fs.azurebfs.sas.FixedSASTokenProvider"
)
spark.conf.set(
    "fs.azure.sas.fixed.token.fairhubproduction.dfs.core.windows.net", 
    "sp=rawl&st=2026-02-10T21:15:26Z&se=2028-02-11T05:30:26Z&spr=https&sv=2024-11-04&sr=c&sig=2spnccLLWMNRtZEgTbyP5BS12Fno%2B0blmdtOaKnp9OE%3D"
)


# COMMAND ----------

# MAGIC %sql
# MAGIC CREATE OR REPLACE TABLE ehr_dqp.omop_data_comparison AS(
# MAGIC WITH all_sites AS (
# MAGIC   -- UAB
# MAGIC   SELECT 
# MAGIC     'UAB' as site,
# MAGIC     e.TABLE_NAME,
# MAGIC     e.ROW_COUNT as expected_count,
# MAGIC     a.actual_count
# MAGIC   FROM uab_ingestion.00_data_counts e
# MAGIC   JOIN (
# MAGIC     SELECT 'condition_occurrence' as domain, COUNT(*) as actual_count FROM uab_ingestion.01_condition_occurrence
# MAGIC     UNION ALL
# MAGIC     SELECT 'drug_exposure' as domain, COUNT(*) as actual_count FROM uab_ingestion.01_drug_exposure
# MAGIC     UNION ALL
# MAGIC     SELECT 'observation' as domain, COUNT(*) as actual_count FROM uab_ingestion.01_observation
# MAGIC     UNION ALL
# MAGIC     SELECT 'measurement' as domain, COUNT(*) as actual_count FROM uab_ingestion.01_measurement
# MAGIC     UNION ALL
# MAGIC     SELECT 'procedure_occurrence' as domain, COUNT(*) as actual_count FROM uab_ingestion.01_procedure_occurrence
# MAGIC     UNION ALL
# MAGIC     SELECT 'visit_occurrence' as domain, COUNT(*) as actual_count FROM uab_ingestion.01_visit_occurrence
# MAGIC     UNION ALL
# MAGIC     SELECT 'device_exposure' as domain, COUNT(*) as actual_count FROM uab_ingestion.01_device_exposure
# MAGIC     UNION ALL
# MAGIC     SELECT 'death' as domain, COUNT(*) as actual_count FROM uab_ingestion.01_death
# MAGIC     UNION ALL
# MAGIC     SELECT 'person' as domain, COUNT(*) as actual_count FROM uab_ingestion.01_person
# MAGIC     UNION ALL
# MAGIC     SELECT 'care_site' as domain, COUNT(*) as actual_count FROM uab_ingestion.01_care_site
# MAGIC     UNION ALL
# MAGIC     SELECT 'location' as domain, COUNT(*) as actual_count FROM uab_ingestion.01_location
# MAGIC     UNION ALL
# MAGIC     SELECT 'provider' as domain, COUNT(*) as actual_count FROM uab_ingestion.01_provider
# MAGIC   ) a ON UPPER(a.domain) = UPPER(e.TABLE_NAME)
# MAGIC
# MAGIC   UNION ALL
# MAGIC
# MAGIC   -- UW
# MAGIC   SELECT 
# MAGIC     'UW' as site,
# MAGIC     e.datafile as TABLE_NAME,
# MAGIC     e.count as expected_count,
# MAGIC     a.actual_count
# MAGIC   FROM uw_ingestion.00_data_counts e
# MAGIC   JOIN (
# MAGIC     SELECT 'condition_occurrence' as domain, COUNT(*) as actual_count FROM uw_ingestion.01_condition_occurrence
# MAGIC     UNION ALL
# MAGIC     SELECT 'drug_exposure' as domain, COUNT(*) as actual_count FROM uw_ingestion.01_drug_exposure
# MAGIC     UNION ALL
# MAGIC     SELECT 'observation' as domain, COUNT(*) as actual_count FROM uw_ingestion.01_observation
# MAGIC     UNION ALL
# MAGIC     SELECT 'measurement' as domain, COUNT(*) as actual_count FROM uw_ingestion.01_measurement
# MAGIC     UNION ALL
# MAGIC     SELECT 'procedure_occurrence' as domain, COUNT(*) as actual_count FROM uw_ingestion.01_procedure_occurrence
# MAGIC     UNION ALL
# MAGIC     SELECT 'visit_occurrence' as domain, COUNT(*) as actual_count FROM uw_ingestion.01_visit_occurrence
# MAGIC     UNION ALL
# MAGIC     SELECT 'device_exposure' as domain, COUNT(*) as actual_count FROM uw_ingestion.01_device_exposure
# MAGIC     UNION ALL
# MAGIC     SELECT 'death' as domain, COUNT(*) as actual_count FROM uw_ingestion.01_death
# MAGIC     UNION ALL
# MAGIC     SELECT 'person' as domain, COUNT(*) as actual_count FROM uw_ingestion.01_person
# MAGIC     UNION ALL
# MAGIC     SELECT 'care_site' as domain, COUNT(*) as actual_count FROM uw_ingestion.01_care_site
# MAGIC     UNION ALL
# MAGIC     SELECT 'location' as domain, COUNT(*) as actual_count FROM uw_ingestion.01_location
# MAGIC     UNION ALL
# MAGIC     SELECT 'provider' as domain, COUNT(*) as actual_count FROM uw_ingestion.01_provider
# MAGIC   ) a ON UPPER(a.domain) = UPPER(e.datafile)
# MAGIC
# MAGIC   UNION ALL
# MAGIC
# MAGIC   -- UCSD
# MAGIC   SELECT 
# MAGIC     'UCSD' as site,
# MAGIC     e.TABLE_NAME as TABLE_NAME,
# MAGIC     e.ROW_COUNT as expected_count,
# MAGIC     a.actual_count
# MAGIC   FROM ucsd_ingestion.00_data_counts e
# MAGIC   JOIN (
# MAGIC     SELECT 'condition_occurrence' as domain, COUNT(*) as actual_count FROM ucsd_ingestion.01_condition_occurrence
# MAGIC     UNION ALL
# MAGIC     SELECT 'drug_exposure' as domain, COUNT(*) as actual_count FROM ucsd_ingestion.01_drug_exposure
# MAGIC     UNION ALL
# MAGIC     SELECT 'observation' as domain, COUNT(*) as actual_count FROM ucsd_ingestion.01_observation
# MAGIC     UNION ALL
# MAGIC     SELECT 'measurement' as domain, COUNT(*) as actual_count FROM ucsd_ingestion.01_measurement
# MAGIC     UNION ALL
# MAGIC     SELECT 'procedure_occurrence' as domain, COUNT(*) as actual_count FROM ucsd_ingestion.01_procedure_occurrence
# MAGIC     UNION ALL
# MAGIC     SELECT 'visit_occurrence' as domain, COUNT(*) as actual_count FROM ucsd_ingestion.01_visit_occurrence
# MAGIC     UNION ALL
# MAGIC     SELECT 'device_exposure' as domain, COUNT(*) as actual_count FROM ucsd_ingestion.01_device_exposure
# MAGIC     UNION ALL
# MAGIC     SELECT 'death' as domain, COUNT(*) as actual_count FROM ucsd_ingestion.01_death
# MAGIC     UNION ALL
# MAGIC     SELECT 'person' as domain, COUNT(*) as actual_count FROM ucsd_ingestion.01_person
# MAGIC     UNION ALL
# MAGIC     SELECT 'care_site' as domain, COUNT(*) as actual_count FROM ucsd_ingestion.01_care_site
# MAGIC     UNION ALL
# MAGIC     SELECT 'location' as domain, COUNT(*) as actual_count FROM ucsd_ingestion.01_location
# MAGIC     UNION ALL
# MAGIC     SELECT 'provider' as domain, COUNT(*) as actual_count FROM ucsd_ingestion.01_provider
# MAGIC   ) a ON UPPER(a.domain) = UPPER(e.TABLE_NAME)
# MAGIC )
# MAGIC SELECT 
# MAGIC   site,
# MAGIC   LOWER(TABLE_NAME) as domain,  -- Normalize output to lowercase
# MAGIC   expected_count,
# MAGIC   actual_count,
# MAGIC   (actual_count - expected_count) as difference
# MAGIC FROM all_sites
# MAGIC --WHERE (actual_count - expected_count) != 0 
# MAGIC ORDER BY LOWER(TABLE_NAME), site
# MAGIC )
