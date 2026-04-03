# Databricks notebook source
dbutils.widgets.removeAll()
# dbutils.widgets.text("databaseName", "", "Database name")
# dbutils.widgets.text("folder", "", "Files folder")
dbutils.widgets.text("site", "", "Sites")


# dbname=dbutils.widgets.get("databaseName")
# folder=dbutils.widgets.get("folder")
site=dbutils.widgets.get("site")

site_folders='abfss://ehr-export@fairhubproduction.dfs.core.windows.net/'
ingestion_folder='/dbfs/mnt/ai-readi/AI-READI/omop-pipeline/EHR/'+site+'/'


# COMMAND ----------

# Set up the configuration for accessing the Azure Data Lake Storage
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
    "sp=racwl&st=2025-06-16T18:37:29Z&se=2027-06-17T02:37:29Z&spr=https&sv=2024-11-04&sr=c&sig=DtIz7wTNfypExGEhBw9gK2JprG3OLfUb%2FcXhdchzD0A%3D"
)

# Test connection
dbutils.fs.ls(site_folders+'/'+site)

# COMMAND ----------

# List files in the Azure Data Lake Storage
files = dbutils.fs.ls("abfss://ehr-export@fairhubproduction.dfs.core.windows.net/" + site)

# Sort files by modification time (most recent first)
sorted_files = sorted(files, key=lambda file: file.modificationTime, reverse=True)

# Print the most recent file
if sorted_files:
    latest_file = sorted_files[0]
    latest_file_name=latest_file.name
    print(f"Latest file: {latest_file_name}, Size: {latest_file.size}, Modification Time: {latest_file.modificationTime}")
else:
    print("No files found.")

# COMMAND ----------

import zipfile
import io
import os

# Define the latest file path
unzip_folder_name = os.path.splitext(latest_file_name)[0]
latest_file_path = site_folders + site + '/' + latest_file_name
print(latest_file_path)
# Define the extraction folder
ingestion_folder = os.path.join(ingestion_folder, unzip_folder_name)
print(ingestion_folder)

os.makedirs(ingestion_folder, exist_ok=True)
# Read the zip file directly from Azure Data Lake Storage
binary_data = spark.read.format("binaryFile").load(latest_file_path).select("content").collect()[0][0]

# Unzip the file
with zipfile.ZipFile(io.BytesIO(binary_data), 'r') as zip_ref:
    zip_ref.extractall(ingestion_folder)

# COMMAND ----------

import os

def get_last_two_segments(path):
    # Remove trailing slash if present
    path = path.rstrip('/')
    # Get a list of all the segments/layers/folders
    parts = path.split('/')
    if len(parts) >= 2:
        return '/'.join(parts[-2:])
    return path

def list_all_files_short(path):
    all_files = []

    items = dbutils.fs.ls(path)
    for item in items:
        if item.isDir():
            all_files.extend(list_all_files_short(item.path))
        else:
            short_path = get_last_two_segments(item.path)
            all_files.append(short_path)
    return all_files


files = list_all_files_short('/mnt/ai-readi/AI-READI/omop-pipeline/EHR/'+site+'/'+unzip_folder_name)
for file in files:
    print(file)

# COMMAND ----------

# Add payload columns
import pandas as pd
df = pd.read_csv(ingestion_folder+'/MANIFEST.txt', sep='|')
df['PAYLOAD']=unzip_folder_name
df.to_csv(ingestion_folder+'/MANIFEST.txt',sep='|',index=False)

