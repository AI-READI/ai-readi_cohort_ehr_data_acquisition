# Databricks notebook source
dbutils.widgets.removeAll()
dbutils.widgets.text("database", "", "Config")
databaseName = dbutils.widgets.get("database")
print(databaseName)
spark.sql(f"USE {databaseName}")

rare_threshold = 5
output_table = "rare_concepts_review"

# COMMAND ----------

# table counts by concept only

from pyspark.sql import SparkSession
from pyspark.sql.functions import (
    col, countDistinct, collect_list, concat_ws, 
    lit, when, isnotnull, desc, asc, sum as spark_sum,
    count as spark_count
)
from pyspark.sql.types import StringType
from pyspark.sql import DataFrame
from functools import reduce
import pyspark.sql.functions as F

# Table configurations
columns_to_check = [
    ('condition_occurrence', 'condition_concept_id', 'condition_concept_name'),
    ('death', 'cause_concept_id', 'cause_concept_name'),
    ('device_exposure', 'device_concept_id', 'device_concept_name'),
    ('drug_exposure', 'drug_concept_id', 'drug_concept_name'),
    ('measurement', 'measurement_concept_id', 'measurement_concept_name'),
    ('observation', 'observation_concept_id', 'observation_concept_name'),
    ('procedure_occurrence', 'procedure_concept_id', 'procedure_concept_name'),
]

def table_cnts(table_name, concept_id_col, concept_name_col):
    """
    Get row and person counts for each concept in a single domain table
    """
    table_df = spark.table(table_name)
    table_rows = table_df.count()
    print(f"Processing table: {table_name} with {table_rows:,} rows")
    
    # Read the table
    df = spark.sql(f"""
        WITH concept_counts AS (
            SELECT  
                '{table_name}' AS table_name,
                {concept_id_col} AS concept_id,
                {concept_name_col} AS concept_name,
                COUNT(*) AS row_count,
                COUNT(DISTINCT person_id) AS person_cnt
            FROM {table_name}
            GROUP BY {concept_id_col}, {concept_name_col}
        )
        SELECT  table_name, 
                CASE WHEN person_cnt < {rare_threshold} THEN TRUE ELSE FALSE END AS rare_concept, 
                concept_id, concept_name,
                row_count AS concept_row_count, 
                person_cnt AS concept_person_count
        FROM concept_counts
        ORDER BY 1, 2, 5, 4
    """)
    df.show(5, truncate=False)
    
    return df

# List to store all review datasets
all_table_cnts_df = []

print("Starting OMOP CDM Rare Concepts Review Process...")

# Process each table
for table_name, concept_id_col, concept_name_col in columns_to_check:
    try:
        table_result = table_cnts(table_name, concept_id_col, concept_name_col)
        all_table_cnts_df.append(table_result)           
    except Exception as e:
        print(f"Error processing table {table_name}: {str(e)}")
        continue

# Combine all review datasets
print(f"\nCombining results from {len(columns_to_check)} tables...")

# Union all review datasets
all_table_cnts = reduce(DataFrame.unionAll, all_table_cnts_df)
total_count = all_table_cnts.count()

# Sort the combined results
all_table_cnts = all_table_cnts.orderBy(
    asc("table_name"),
    asc(when(col("rare_concept") == True, 0).otherwise(1)),  # 0 for true, 1 for false
    asc("concept_id"),
    asc("concept_name")
)

# Show sample of the final data
print(f"\nSample of final results (first 10 rows):")
all_table_cnts.show(10, truncate=False)

# Save the results
print(f"\nSaving results to table: {output_table}")

all_table_cnts.write \
    .mode("overwrite") \
    .option("overwriteSchema", "true") \
    .saveAsTable(output_table)

print(f"Successfully saved {total_count:,} records to {output_table}")
# Pass statement for Databricks debug mode
pass

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT * FROM ehr_union.rare_concepts_review

# COMMAND ----------



# COMMAND ----------

# MAGIC %sql
# MAGIC DROP TABLE IF EXISTS ehr_union.rare_concepts_summary;
# MAGIC     
# MAGIC CREATE TABLE ehr_union.rare_concepts_summary AS
# MAGIC -- Summary by table_name only
# MAGIC   SELECT 
# MAGIC     table_name,
# MAGIC     COUNT(DISTINCT CASE WHEN rare_concept = true THEN concept_id END) AS rare_concept_count,
# MAGIC     COUNT(DISTINCT concept_id) AS all_concept_count,
# MAGIC     ROUND(
# MAGIC       COUNT(DISTINCT CASE WHEN rare_concept = true THEN concept_id END) * 100.0 / 
# MAGIC       COUNT(DISTINCT concept_id), 2
# MAGIC     ) AS pct_concepts_rare,
# MAGIC     SUM(CASE WHEN rare_concept = true THEN concept_row_count ELSE 0 END) AS rare_concept_row_count,
# MAGIC     SUM(concept_row_count) AS total_row_count,
# MAGIC     ROUND(
# MAGIC       SUM(CASE WHEN rare_concept = true THEN concept_row_count ELSE 0 END) * 100.0 / 
# MAGIC       SUM(concept_row_count), 2
# MAGIC     ) AS pct_rows_rare
# MAGIC   FROM ehr_union.rare_concepts_review
# MAGIC   GROUP BY table_name
# MAGIC   ORDER BY table_name
# MAGIC ;
# MAGIC SELECT * FROM ehr_union.rare_concepts_summary

# COMMAND ----------

# MAGIC %sql
# MAGIC   -- same as above but for all tables
# MAGIC   SELECT 
# MAGIC     COUNT(DISTINCT CASE WHEN rare_concept = true THEN concept_id END) AS rare_concept_count,
# MAGIC     COUNT(DISTINCT concept_id) AS all_concept_count,
# MAGIC     ROUND(
# MAGIC       COUNT(DISTINCT CASE WHEN rare_concept = true THEN concept_id END) * 100.0 / 
# MAGIC       COUNT(DISTINCT concept_id), 2
# MAGIC     ) AS pct_concepts_rare,
# MAGIC     SUM(CASE WHEN rare_concept = true THEN concept_row_count ELSE 0 END) AS rare_concept_row_count,
# MAGIC     SUM(concept_row_count) AS total_row_count,
# MAGIC     ROUND(
# MAGIC       SUM(CASE WHEN rare_concept = true THEN concept_row_count ELSE 0 END) * 100.0 / 
# MAGIC       SUM(concept_row_count), 2
# MAGIC     ) AS pct_rows_rare
# MAGIC   FROM ehr_union.rare_concepts_review

# COMMAND ----------

# table counts by both concept and data partner

from pyspark.sql import SparkSession
from pyspark.sql.functions import (
    col, countDistinct, collect_list, concat_ws, 
    lit, when, isnotnull, desc, asc, sum as spark_sum,
    count as spark_count
)
from pyspark.sql.types import StringType
from pyspark.sql import DataFrame
from functools import reduce
import pyspark.sql.functions as F

# Table configurations
columns_to_check = [
    ('condition_occurrence', 'condition_concept_id', 'condition_concept_name'),
    ('death', 'cause_concept_id', 'cause_concept_name'),
    ('device_exposure', 'device_concept_id', 'device_concept_name'),
    ('drug_exposure', 'drug_concept_id', 'drug_concept_name'),
    ('measurement', 'measurement_concept_id', 'measurement_concept_name'),
    ('observation', 'observation_concept_id', 'observation_concept_name'),
    ('procedure_occurrence', 'procedure_concept_id', 'procedure_concept_name'),
]

def table_cnts(table_name, concept_id_col, concept_name_col):
    """
    Get counts for a single table
    """
    table_df = spark.table(table_name)
    table_rows = table_df.count()
    print(f"Processing table: {table_name} with {table_rows:,} rows")
    
    # Read the table
    df = spark.sql(f"""
          WITH concept_totals AS (
            SELECT 
                {concept_id_col},
                COUNT(*) AS concept_row_count,
                COUNT(DISTINCT person_id) AS concept_person_count
            FROM {table_name}
            GROUP BY {concept_id_col}
          ),
          partner_stats AS (
            SELECT  
                '{table_name}' AS table_name,
                {concept_id_col} AS concept_id,
                {concept_name_col} AS concept_name,
                CAST(data_partner_id AS string) AS data_partner_id,
                COUNT(*) AS row_count,
                COUNT(DISTINCT person_id) AS person_cnt
            FROM {table_name}
            GROUP BY {concept_id_col}, {concept_name_col}, data_partner_id
          )
          SELECT 
              ps.table_name,
              ps.concept_id,
              ps.concept_name,
              ps.data_partner_id,
              ps.row_count,
              ps.person_cnt,
              ct.concept_row_count,
              ct.concept_person_count
          FROM partner_stats ps
          JOIN concept_totals ct ON ps.concept_id = ct.{concept_id_col}
          ORDER BY 1, 2, 3, 4
          """)
    df.show()
    
    return df

# List to store all review datasets
all_table_cnts_df = []

print("Starting OMOP CDM Rare Concepts Review Process...")

# Process each table
for table_name, concept_id_col, concept_name_col in columns_to_check:
    try:
        table_result = table_cnts(table_name, concept_id_col, concept_name_col)
        all_table_cnts_df.append(table_result)           
    except Exception as e:
        print(f"Error processing table {table_name}: {str(e)}")
        continue

# Combine all review datasets
print(f"\nCombining results from {len(columns_to_check)} tables...")

# Union all review datasets
all_table_cnts = reduce(DataFrame.unionAll, all_table_cnts_df)

all_table_cnts = all_table_cnts.withColumn('rare_concept', (col('concept_person_count') < rare_threshold))

# Sort the combined results
all_table_cnts = all_table_cnts.orderBy(
    asc("table_name"),
    asc(when(col("rare_concept") == True, 0).otherwise(1)),  # 0 for true, 1 for false
    asc("concept_id"),
    asc("concept_name"),
    asc("data_partner_id")
)

# Show summary statistics
total_count = all_table_cnts.count()
print(f"\nSummary:")
print(f"Total rare concept entries across all tables: {total_count:,}")

# Show sample of the final data
print(f"\nSample of final results (first 10 rows):")
all_table_cnts.show(10, truncate=False)

# Save the results
print(f"\nSaving results to table: {output_table}")

all_table_cnts.write \
    .mode("overwrite") \
    .option("overwriteSchema", "true") \
    .saveAsTable(output_table)

print(f"Successfully saved {total_count:,} records to {output_table}")

# Show data partner breakdown
print("\nRare concepts by data partner:")

# Pass statement for Databricks debug mode
pass

# COMMAND ----------

# MAGIC %sql
# MAGIC DROP TABLE IF EXISTS ehr_union.rare_concepts_summary;
# MAGIC     
# MAGIC CREATE TABLE ehr_union.rare_concepts_summary AS
# MAGIC -- Summary by table_name only
# MAGIC WITH table_summary AS (
# MAGIC   SELECT 
# MAGIC     table_name,
# MAGIC     COUNT(DISTINCT CASE WHEN rare_concept = true THEN concept_id END) AS rare_concept_count,
# MAGIC     COUNT(DISTINCT concept_id) AS all_concept_count,
# MAGIC     ROUND(
# MAGIC       COUNT(DISTINCT CASE WHEN rare_concept = true THEN concept_id END) * 100.0 / 
# MAGIC       COUNT(DISTINCT concept_id), 2
# MAGIC     ) AS pct_concepts_rare,
# MAGIC     SUM(CASE WHEN rare_concept = true THEN row_count ELSE 0 END) AS rare_concept_row_count,
# MAGIC     SUM(row_count) AS total_row_count,
# MAGIC     ROUND(
# MAGIC       SUM(CASE WHEN rare_concept = true THEN row_count ELSE 0 END) * 100.0 / 
# MAGIC       SUM(row_count), 2
# MAGIC     ) AS pct_rows_rare
# MAGIC   FROM ehr_union.rare_concepts_review
# MAGIC   GROUP BY table_name
# MAGIC ),
# MAGIC
# MAGIC -- Summary by data_partner_id only
# MAGIC partner_summary AS (
# MAGIC   SELECT 
# MAGIC     data_partner_id,
# MAGIC     COUNT(DISTINCT CASE WHEN rare_concept = true THEN concept_id END) AS rare_concept_count,
# MAGIC     COUNT(DISTINCT concept_id) AS all_concept_count,
# MAGIC     ROUND(
# MAGIC       COUNT(DISTINCT CASE WHEN rare_concept = true THEN concept_id END) * 100.0 / 
# MAGIC       COUNT(DISTINCT concept_id), 2
# MAGIC     ) AS pct_concepts_rare,
# MAGIC     SUM(CASE WHEN rare_concept = true THEN row_count ELSE 0 END) AS rare_concept_row_count,
# MAGIC     SUM(row_count) AS total_row_count,
# MAGIC     ROUND(
# MAGIC       SUM(CASE WHEN rare_concept = true THEN row_count ELSE 0 END) * 100.0 / 
# MAGIC       SUM(row_count), 2
# MAGIC     ) AS pct_rows_rare
# MAGIC   FROM ehr_union.rare_concepts_review
# MAGIC   GROUP BY data_partner_id
# MAGIC ),
# MAGIC
# MAGIC -- Summary by table_name and data_partner_id
# MAGIC table_partner_summary AS (
# MAGIC   SELECT 
# MAGIC     table_name,
# MAGIC     data_partner_id,
# MAGIC     COUNT(DISTINCT CASE WHEN rare_concept = true THEN concept_id END) AS rare_concept_count,
# MAGIC     COUNT(DISTINCT concept_id) AS all_concept_count,
# MAGIC     ROUND(
# MAGIC       COUNT(DISTINCT CASE WHEN rare_concept = true THEN concept_id END) * 100.0 / 
# MAGIC       COUNT(DISTINCT concept_id), 2
# MAGIC     ) AS pct_concepts_rare,
# MAGIC     SUM(CASE WHEN rare_concept = true THEN row_count ELSE 0 END) AS rare_concept_row_count,
# MAGIC     SUM(row_count) AS total_row_count,
# MAGIC     ROUND(
# MAGIC       SUM(CASE WHEN rare_concept = true THEN row_count ELSE 0 END) * 100.0 / 
# MAGIC       SUM(row_count), 2
# MAGIC     ) AS pct_rows_rare
# MAGIC   FROM ehr_union.rare_concepts_review
# MAGIC   GROUP BY table_name, data_partner_id
# MAGIC )
# MAGIC
# MAGIC -- Display table-level summary
# MAGIC SELECT 
# MAGIC   'TABLE' as summary_type,
# MAGIC   table_name,
# MAGIC   CAST(NULL AS STRING) as data_partner_id,
# MAGIC   rare_concept_count,
# MAGIC   all_concept_count,
# MAGIC   pct_concepts_rare,
# MAGIC   rare_concept_row_count,
# MAGIC   total_row_count,
# MAGIC   pct_rows_rare
# MAGIC FROM table_summary
# MAGIC
# MAGIC UNION ALL
# MAGIC
# MAGIC -- Display partner-level summary
# MAGIC SELECT 
# MAGIC   'PARTNER' as summary_type,
# MAGIC   CAST(NULL AS STRING) as table_name,
# MAGIC   CAST(data_partner_id AS STRING) as data_partner_id,
# MAGIC   rare_concept_count,
# MAGIC   all_concept_count,
# MAGIC   pct_concepts_rare,
# MAGIC   rare_concept_row_count,
# MAGIC   total_row_count,
# MAGIC   pct_rows_rare
# MAGIC FROM partner_summary
# MAGIC
# MAGIC UNION ALL
# MAGIC
# MAGIC -- Display table + partner level summary
# MAGIC SELECT 
# MAGIC   'TABLE_PARTNER' as summary_type,
# MAGIC   table_name,
# MAGIC   CAST(data_partner_id AS STRING) as data_partner_id,
# MAGIC   rare_concept_count,
# MAGIC   all_concept_count,
# MAGIC   pct_concepts_rare,
# MAGIC   rare_concept_row_count,
# MAGIC   total_row_count,
# MAGIC   pct_rows_rare
# MAGIC FROM table_partner_summary
# MAGIC
# MAGIC ORDER BY 
# MAGIC   CASE summary_type 
# MAGIC     WHEN 'TABLE' THEN 1 
# MAGIC     WHEN 'PARTNER' THEN 2 
# MAGIC     WHEN 'TABLE_PARTNER' THEN 3 
# MAGIC   END,
# MAGIC   table_name, 
# MAGIC   data_partner_id;
