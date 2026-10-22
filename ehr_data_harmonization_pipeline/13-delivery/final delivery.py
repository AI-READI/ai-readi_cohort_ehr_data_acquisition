# Databricks notebook source
# refresh database
spark.sql("DROP DATABASE IF EXISTS ehr_union_release CASCADE")

# COMMAND ----------

# Replicate all tables from ehr_union_clean database into ehr_union_release database
spark.sql("CREATE DATABASE IF NOT EXISTS ehr_union_release")

tables = spark.sql("SHOW TABLES IN ehr_union_clean").collect()

for table in tables:
    table_name = table.tableName
    print(f"Replicating table: {table_name}")
    spark.sql(f"CREATE OR REPLACE TABLE ehr_union_release.{table_name} AS SELECT * FROM ehr_union_clean.{table_name}")
    print(f"  Done: {table_name}")

print("\nAll tables replicated successfully.")

# COMMAND ----------

# MAGIC %sql
# MAGIC -- OMOP CDM v5.3 - CDM_SOURCE Table
# MAGIC
# MAGIC CREATE or replace TABLE ehr_union_release.cdm_source (
# MAGIC     cdm_source_name                 VARCHAR(255)    NOT NULL,
# MAGIC     cdm_source_abbreviation         VARCHAR(25),
# MAGIC     cdm_holder                      VARCHAR(255),
# MAGIC     source_description              VARCHAR(255),
# MAGIC     source_documentation_reference  VARCHAR(255),
# MAGIC     cdm_etl_reference               VARCHAR(255),
# MAGIC     source_release_date             DATE,
# MAGIC     cdm_release_date                DATE,
# MAGIC     cdm_version                     VARCHAR(10),
# MAGIC     vocabulary_version              VARCHAR(20)
# MAGIC );
# MAGIC
# MAGIC -- Insert with dynamically pulled vocabulary_version
# MAGIC INSERT INTO ehr_union_release.cdm_source (
# MAGIC     cdm_source_name,
# MAGIC     cdm_source_abbreviation,
# MAGIC     cdm_holder,
# MAGIC     source_description,
# MAGIC     source_documentation_reference,
# MAGIC     cdm_etl_reference,
# MAGIC     source_release_date,
# MAGIC     cdm_release_date,
# MAGIC     cdm_version,
# MAGIC     vocabulary_version
# MAGIC )
# MAGIC SELECT
# MAGIC     'AI-READI participant longitudinal EHR dataset', --cdm_source_name
# MAGIC     'AI-READI EHR', --cdm_source_abbreviation
# MAGIC     'Bridge2ai-AI-READI', --cdm_holder
# MAGIC     'AI-READI participants electronic health record data from the BRIDGE2AI-AI-READI participating sites', --source_description
# MAGIC     'https://docs.aireadi.org/docs/3/about', --source_documentation_reference
# MAGIC     'https://github.com/AI-READI/ai-readi_cohort_ehr_data_acquisition', --cdm_etl_reference
# MAGIC     '2026-10-21', --source_release_date
# MAGIC     '2026-10-21', --cdm_release_date
# MAGIC     '5.3.1', --cdm_version
# MAGIC     (SELECT vocabulary_version FROM omop_vocab.vocabulary WHERE vocabulary_id = 'None'); --vocabulary_version

# COMMAND ----------

# Set up the configuration for accessing the second Azure Data Lake Storage container
spark.conf.set(
##### hashing for security reason
)
spark.conf.set(
##### hashing for security reason
)
spark.conf.set(
##### hashing for security reason
)

# COMMAND ----------

from pyspark.sql.functions import col, lit
import re

output_base_path = "abfss://stage-one@fairhubproduction.dfs.core.windows.net/AI-READI/omop-pipeline/EHR/deliverable/"

tables = spark.sql("SHOW TABLES IN ehr_union_release").collect()
# Added this filter line
tables = [t for t in tables if not t.isTemporary and not t.tableName.startswith("_")]

print(f"Total tables to export: {len(tables)}")
print("="*50)

for table in tables:
    table_name = table.tableName
    print(f"\nExporting table: {table_name}")

    df = spark.table(f"ehr_union_release.{table_name}")

    # Handle void columns (HIPAA nulled columns)
    select_exprs = []
    for f in df.schema.fields:
        if f.dataType.typeName() == "void":
            #print(f"  -> Void column (HIPAA nulled): {f.name}")
            select_exprs.append(lit(None).cast("string").alias(f.name))
        else:
            select_exprs.append(col(f.name).cast("string").alias(f.name))

    df = df.select(select_exprs)

    # Temp path and final path
    temp_path = f"{output_base_path}_temp_{table_name}"
    final_path = f"{output_base_path}{table_name}.csv"

    df.coalesce(1) \
      .write \
      .format("csv") \
      .option("header", "true") \
      .option("delimiter", ",") \
      .mode("overwrite") \
      .save(temp_path)

    # Find part file and rename
    files = dbutils.fs.ls(temp_path)
    part_file = [f.path for f in files if re.search(r'part-.*\.csv', f.path)][0]

    dbutils.fs.cp(part_file, final_path)
    #dbutils.fs.rm(temp_path, recurse=True)

    #print(f"  -> Saved to: {final_path}")

print("\n" + "="*50)
print("All tables exported successfully!")

# COMMAND ----------


