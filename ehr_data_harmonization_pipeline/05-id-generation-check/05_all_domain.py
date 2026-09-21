# Databricks notebook source
# MAGIC %md
# MAGIC - 51 bit was hashed from source_pkey column in step 4. 
# MAGIC - check and record if there is any 51 bit duplication. If there is duplicate source_pkey, the code will failed instead. 
# MAGIC

# COMMAND ----------

dbutils.widgets.removeAll()

dbutils.widgets.text("site", "", "Sites")

dbname=dbutils.widgets.get("site")+'_ingestion'
print(dbname)

# COMMAND ----------

# DBTITLE 1,Cell 3
from pyspark.sql import functions as F
from pyspark.sql.window import Window 
import sys
sys.path.append("/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
from myproject import timestamp_comment

def create_collision_lookup_table(spark, domain, pk_col, hash_col="hashed_id"):
    """
    Create collision lookup table for a domain by identifying hash collisions.
    
    Args:
        spark: SparkSession
        domain: Domain name (table name)
        pk_col: Primary key column (51-bit id)
        hash_col: Hash column to verify uniqueness, default "hashed_id"
    
    Returns:
        DataFrame: The collision lookup table
    """
    # Read domain data
    domain_df = spark.table(f"{dbname}.04_{domain}")
    
    # Check if hashed_id/source_pkey in step 4 is unique
    hash_count = domain_df.groupBy(hash_col).count().filter("count > 1").count()
    if hash_count > 0:
        raise ValueError(f"Validation failed: {hash_col} is not unique in {domain}")
    
    # Find duplicates of pk_col/<domain>_51_bit
    w = Window.partitionBy(pk_col)
    duplicates_df = domain_df.select('*', F.count(pk_col).over(w).alias('dupeCount')) \
        .where('dupeCount > 1') \
        .drop('dupeCount') \
        .select(pk_col, hash_col)
    
    # Target table name
    lookup_table_name = f"{dbname}.05_{domain}"
    
    # If no duplicates found, create empty table
    if duplicates_df.count() == 0:
        schema = f"struct<{pk_col}:long, {hash_col}:string, collision_bits:int>"
        empty_df = spark.createDataFrame([], schema=schema)
        empty_df.write.format("delta").mode("overwrite").saveAsTable(lookup_table_name)
        # log runtime on description
        timestamp_comment.comment(spark, dbname, f"05_{domain}")
       
    else:
        # Assign collision bits (starting at 0)
        w2 = Window.partitionBy(pk_col).orderBy(hash_col)
        result_df = duplicates_df.withColumn('collision_bits', F.row_number().over(w2) - 1)
        
        # Validate collision_bits is less than 4
        if result_df.filter("collision_bits >= 4").count() > 0:
            raise ValueError(f"Validation failed: More than 3 collisions found for some IDs in {domain}")
        
        # Write to Delta table
        result_df.write.format("delta").mode("overwrite").saveAsTable(lookup_table_name)
        # Log the runtime on description
        timestamp_comment.comment(spark, dbname, f"05_{domain}")


def process_all_collision_tables(spark):
    """
    Process collision detection for all domains
    """
    domains = [
        ("care_site", "care_site_id_51_bit"),
        # ("condition_era", "condition_era_id_51_bit"),
        ("condition_occurrence", "condition_occurrence_id_51_bit"),
        ("device_exposure", "device_exposure_id_51_bit"),
        # ("dose_era", "dose_era_id_51_bit"),
        # ("drug_era", "drug_era_id_51_bit"),
        ("drug_exposure", "drug_exposure_id_51_bit"),
        ("location", "location_id_51_bit"),
        ("measurement", "measurement_id_51_bit"),
        # ("note", "note_id_51_bit"),
        # ("note_nlp", "note_nlp_id_51_bit"),
        ("observation", "observation_id_51_bit"),
        # ("observation_period", "observation_period_id_51_bit"),
        ("person", "person_id_51_bit"),
        ("procedure_occurrence", "procedure_occurrence_id_51_bit"),
        ("provider", "provider_id_51_bit"),
        # ("visit_detail", "visit_detail_id_51_bit"),
        ("visit_occurrence", "visit_occurrence_id_51_bit"),
        # ("control_map", "control_map_id_51_bit"),
    ]
    
    
    #results = {}
    for domain, pk_col in domains:
        print(f"Processing {domain}...")
        try:
            result_df = create_collision_lookup_table(spark, domain, pk_col)
        except ValueError as e:
            print(f"WARNING: Skipping {domain} due to validation error: {e}")


# To run this in a Databricks notebook:
process_all_collision_tables(spark)

# COMMAND ----------


