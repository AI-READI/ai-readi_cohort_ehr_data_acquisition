# Databricks notebook source
# MAGIC %md
# MAGIC Remove the records that fit the condition below:
# MAGIC - Records have person id that does not exist in the person table
# MAGIC - Multiple person associated with a single visit_occurrence
# MAGIC

# COMMAND ----------

dbutils.widgets.removeAll()

dbutils.widgets.text("site", "", "Sites")

dbname=dbutils.widgets.get("site")+'_ingestion'
print(dbname)

# COMMAND ----------


from pyspark.sql import SparkSession
import sys
sys.path.append("/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
from myproject import person_ids 
from datetime import datetime
from myproject import timestamp_comment

# Define the domains with person_id column
domains_with_person_id_column = [
    # "condition_era",
    "condition_occurrence",
    "death",
    # "drug_era",
    "drug_exposure",
    "device_exposure",
    "measurement",
    # "note",
    "observation",
    # "observation_period",
    # "payer_plan_period",
    "person",
    "procedure_occurrence",
    # "visit_detail",
    "visit_occurrence"
]


input_tables = {}
for domain in domains_with_person_id_column:
    input_tables[domain] = f"{dbname}.06_{domain}"


def compute_function():

    person = spark.table(input_tables["person"])
    
    # Load all input tables into a dictionary
    input_dfs = {}
    for domain in domains_with_person_id_column:
        if domain != "person":
            input_dfs[domain] = spark.table(input_tables[domain])
    
    result = person_ids.person_id_pre_clean(None, person, **input_dfs)
    
 
    result.write.mode("overwrite").saveAsTable(f"{dbname}.07_pre_clean_removed_person_ids")

    # create timestamp 

    timestamp_comment.comment(spark,dbname,'07_pre_clean_removed_person_ids')
    return result


if __name__ == "__main__":
    compute_function()

# COMMAND ----------

# DBTITLE 1,Cell 4
# MAGIC %sql
# MAGIC SELECT * FROM `${site}_ingestion`.`07_pre_clean_removed_person_ids`

# COMMAND ----------


