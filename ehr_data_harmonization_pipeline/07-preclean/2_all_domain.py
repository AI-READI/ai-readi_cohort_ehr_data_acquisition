# Databricks notebook source
# MAGIC %md 
# MAGIC - remove rows fit the condition: ahrq_code, loinc_code_to_remove, tribal_zip_code
# MAGIC - note: we are missing the full tribal_zip_code file

# COMMAND ----------

dbutils.widgets.removeAll()

dbutils.widgets.text("site", "", "Sites")

dbname=dbutils.widgets.get("site")+'_ingestion'
print(dbname)

# COMMAND ----------


import sys
sys.path.append("/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
from myproject import pre_clean
from pyspark.sql import functions as F 
from myproject import timestamp_comment

ahrq_xwalk = spark.table('omop_vocab_extra.ahrq_code_xwalk')
# N3C version:
#loincs_to_remove = spark.table('omop_vocab_extra.loinc_codes_to_remove')

# Generate the files on the databricks:
loincs_to_remove = spark.table('omop_vocab_extra.loinc_codes_to_remove_new')
# palantir used array type but databricks has it as string
loincs_to_remove = loincs_to_remove.withColumn(
    "domains", 
    F.split(F.trim(F.col("domains")), ",")
)
tribal_zips = spark.table('omop_vocab_extra.tribal_zip_codes')
removed_person_ids = spark.table(f"{dbname}.07_pre_clean_removed_person_ids")

def table_exists(spark, table_name):
    try:
        spark.table(table_name)
        return True
    except:
        return False
    
def clean_function(domain, ahrq_xwalk, tribal_zips, loincs_to_remove,spark):
    print(f"Processing domain: {domain} ")
    
    # Define table names
    processed = f"{dbname}.07_{domain}_processed"
    nulled_rows = f"{dbname}.07_{domain}_nulled"
    removed_rows = f"{dbname}.07_{domain}_removed"
    
    # Load input data
    try:
        input_table = f"{dbname}.06_{domain}"
        print(f"Loading data from {input_table}")
        foundry_df = spark.table(input_table)
    except Exception as e:
        print(f"Error loading table {input_table}: {str(e)}")
        print(f"Skipping domain {domain}")
        return False
    
    # Process the domain
    try:
        print(f"Starting pre_clean for {domain}")
        pre_clean.do_pre_clean(
            domain,
            processed, nulled_rows, removed_rows,
            foundry_df, removed_person_ids,
            ahrq_xwalk, tribal_zips, loincs_to_remove, spark
        )
        print(f"Completed pre_clean for {domain}")


        # Add timestamp comments only for tables that exist
        timestamp_comment.comment(spark, dbname, '07_'+domain+'_processed')
        
        if table_exists(spark, f"{dbname}.07_{domain}_nulled"):
            timestamp_comment.comment(spark, dbname, '07_'+domain+'_nulled')
        else:
            print(f"Skipping comment for 07_{domain}_nulled - table not created")
            
        if table_exists(spark, f"{dbname}.07_{domain}_removed"):
            timestamp_comment.comment(spark, dbname, '07_'+domain+'_removed')
        else:
            print(f"Skipping comment for 07_{domain}_removed - table not created")

        return True
    except Exception as e:
        import traceback
        print(f"Error processing domain {domain}: {str(e)}")
        print(traceback.format_exc())
        return False

# Define domains to process
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
    # "payer_plan_period" is commented out as in your original code
    "person",
    "procedure_occurrence",
    "provider",
    # "visit_detail",
    "visit_occurrence",
]

# Process each domain
results = {}
for domain in domains:
    try:
        results[domain] = clean_function(domain, ahrq_xwalk, tribal_zips, loincs_to_remove,spark)
    except Exception as e:
        print(f"Unexpected error processing {domain}: {str(e)}")
        results[domain] = False

# Print summary
print("\n===== Processing Summary =====")
for domain, success in results.items():
    status = "Success" if success else "Failed"
    print(f"{domain}: {status}")

# COMMAND ----------


