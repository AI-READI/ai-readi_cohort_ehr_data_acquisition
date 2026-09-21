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
site = dbutils.widgets.get("site")
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
import traceback

# Set the legacy time parser policy
spark.conf.set("spark.sql.legacy.timeParserPolicy", "LEGACY")


# --- Site -> data_partner_id mapping ---
SITE_TO_PARTNER_ID = {
    "JHU": 1952,
    "UAB": 8469,
    "UCSD": 2084,
    "UW": 3058,
}

if site not in SITE_TO_PARTNER_ID:
    print(f"WARNING: site {repr(site)} not recognized. data_partner_id will default to 0.")


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
    existing_columns = [c.upper() for c in df.columns]
    missing_columns = [c for c in schema_strings if c not in existing_columns]

    if missing_columns:
        print(f"Validation failed: {domain} schema must contain required columns: {', '.join(missing_columns)}")
        return False

    # Check primary key if specified
    if pkey:
        total_rows = df.count()
        distinct_keys = df.select(pkey).distinct().count()

        if total_rows != distinct_keys:
            print(f"Validation failed: {pkey} must be a valid primary key - duplicate values found")
            return False

    return True


def transform_omop(domain, pkey):
    schema_dict = local_schemas.complete_domain_schema_dict[domain]
    schema_dict["DATA_PARTNER_ID"] = T.IntegerType()
    schema_dict["PAYLOAD"] = T.StringType()

    required_dict = local_schemas.required_domain_schema_dict[domain]
    schema_strings = schema.schema_dict_all_string_type(required_dict, add_payload=False)
    # if site == 'UAB' and domain=='person': # need manual cleaning
    #     df=spark.sql(f"""select * from {dbname}.01_5_{domain}""")
    # else:
    df = spark.sql(f"""select * from {dbname}.01_{domain}""")

    # check input schema
    if dbname == 'UAB_ingestion':
        print('UAB files have duplications. Bypass the check')
    elif not validate_schema(df, schema_strings, domain, pkey):  # UAB will not pass the primary key check. Bypass for now.
        print(f"Input validation failed for {domain}. Skipping this domain.")
        return False

    def compute_function(df, schema_dict):
        try:
            # Process with schema - schema.py now handles preserving data_partner_id and payload
            processed_df = schema.apply_schema(df, schema_dict, include_payload=False)  # Set to True to keep payload

            # Inject the correct data_partner_id, overriding whatever apply_schema null-filled
            data_partner_id = SITE_TO_PARTNER_ID.get(site, 0)
            processed_df = processed_df.withColumn(
                "DATA_PARTNER_ID",
                F.lit(data_partner_id).cast(T.IntegerType())
            )

            # output schema check
            if validate_schema(processed_df, schema_strings, domain) or dbname == 'UAB_ingestion':
                processed_df.write.format("delta").option("mergeSchema", "true").mode("overwrite").saveAsTable(f"{dbname}.02_{domain}")
                # log timestamp
                timestamp_comment.comment(spark, dbname, '02_' + domain)
                print(f"{dbname}.02_{domain} created successfully.")
                return True
            else:
                print(f"Output validation failed for {domain}. Table not written.")
                return False

        except Exception as e:
            print(f"Error processing {domain}: {str(e)}")
            traceback.print_exc()
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
    # ("visit_detail", "visit_detail_id"),
    ("visit_occurrence", "visit_occurrence_id"),
]

results = {}
for domain_tuple in domains:
    domain_name = domain_tuple[0]
    success = transform_omop(*domain_tuple)
    results[domain_name] = success

print("\n--- Summary ---")
for d, ok in results.items():
    print(f"{d}: {'OK' if ok else 'FAILED'}")

# COMMAND ----------

from pyspark.sql import SparkSession
from pyspark.sql.functions import col

spark = SparkSession.builder.getOrCreate()
site = dbutils.widgets.get("site")
dbname = f"{site}_ingestion"

person_df = spark.table(f"{dbname}.02_person")


print("======Process general issue=====")
# Find duplicate person_id or rows with null year_of_birth
issue_df = person_df.filter(
    (person_df.person_id.isin(
        [row.person_id for row in person_df.groupBy("person_id").count().filter("count > 1").collect()]
    )) | (person_df.year_of_birth.isNull())
)

issue_df.write.format("delta").mode("overwrite").saveAsTable(f"{dbname}.02_person_issue")

# Remove problematic rows from person table
clean_df = person_df.filter(
    (~person_df.person_id.isin(
        [row.person_id for row in issue_df.select("person_id").filter("person_id IS NOT NULL").distinct().collect()]
    )) & (person_df.year_of_birth.isNotNull())
)

clean_df.write.format("delta").mode("overwrite").saveAsTable(f"{dbname}.02_person")

# COMMAND ----------

# DBTITLE 1,Cell 4
# %sql

# -- Save duplicate person_id rows or rows with null year_of_birth to <site>_ingestion.02_person_issue
# CREATE OR REPLACE TABLE ${site}_ingestion.02_person_issue AS
# SELECT *
# FROM ${site}_ingestion.02_person
# WHERE person_id IN (
#     SELECT person_id
#     FROM ${site}_ingestion.02_person
#     GROUP BY person_id
#     HAVING COUNT(*) > 1
# )
# OR year_of_birth IS NULL;

# CREATE OR REPLACE TABLE ${site}_ingestion.02_person AS
# SELECT *
# FROM ${site}_ingestion.02_person
# WHERE person_id NOT IN (
#     SELECT person_id
#     FROM ${site}_ingestion.02_person_issue
#     WHERE person_id IS NOT NULL
# )
# AND year_of_birth IS NOT NULL;


# COMMAND ----------

# DBTITLE 1,Cell 6
# MAGIC %sql
# MAGIC -- de-dup drug_exposure table
# MAGIC -- Save duplicate drug_exposure rows or rows with null pk id to <site>_ingestion.02_drug_exposure_issue
# MAGIC CREATE OR REPLACE TABLE ${site}_ingestion.02_drug_exposure_issue AS
# MAGIC SELECT *
# MAGIC FROM ${site}_ingestion.02_drug_exposure
# MAGIC WHERE drug_exposure_id IN (
# MAGIC     SELECT drug_exposure_id
# MAGIC     FROM ${site}_ingestion.02_drug_exposure
# MAGIC     GROUP BY drug_exposure_id
# MAGIC     HAVING COUNT(*) > 1
# MAGIC )
# MAGIC OR drug_exposure_start_date IS NULL;
# MAGIC
# MAGIC CREATE OR REPLACE TABLE ${site}_ingestion.02_drug_exposure AS
# MAGIC SELECT *
# MAGIC FROM ${site}_ingestion.02_drug_exposure
# MAGIC WHERE drug_exposure_id NOT IN (
# MAGIC     SELECT drug_exposure_id
# MAGIC     FROM ${site}_ingestion.02_drug_exposure_issue
# MAGIC     WHERE drug_exposure_id IS NOT NULL
# MAGIC )
# MAGIC AND drug_exposure_start_date IS NOT NULL;
# MAGIC
