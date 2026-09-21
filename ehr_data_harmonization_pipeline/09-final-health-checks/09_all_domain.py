# Databricks notebook source
dbutils.widgets.removeAll()

dbutils.widgets.text("site", "", "Sites")

dbname=dbutils.widgets.get("site")+'_ingestion'
print(dbname)

# COMMAND ----------

import sys
sys.path.append("/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
from pyspark.sql import functions as F, types as T
from myproject import schema
from myproject import timestamp_comment

def make_validator(domain, pkey):
    """
    Create a function that validates an OMOP domain table against its schema
    
    Args:
        domain (str): The OMOP domain (e.g., "person", "condition_occurrence")
        pkey (str): The primary key column (e.g., "person_id")
        
    Returns:
        function: A function that validates the specified domain
    """
    
    # Get complete schema for this OMOP domain
    complete_schema = schema.omop_complete[domain]
    
    # Convert column names to lowercase
    complete_schema = {k.lower(): v for k, v in complete_schema.items()}
    
    # Get required non-null columns for this OMOP domain
    required_schema = schema.omop_required[domain]
    required_cols = [col.lower() for col in required_schema.keys()]
    
    def validate_domain(spark, dbname):
        """
        Validate the OMOP domain table and write the results to database tables
        
        Args:
            spark: SparkSession
            dbname (str): Database name from widget
            
        Returns:
            DataFrame: The validated DataFrame
        """
        # Construct input table name with naming convention
        input_table = f"{dbname}.08_{domain}"
        print(f"Validating {domain} from {input_table}...")
        
        # Read the input table
        df = spark.table(input_table)
        
        # Create a validation results DataFrame
        validation_results = []
        
        # Check 1: Schema validation - CONTAINS logic like Palantir E.schema().contains()
        # Only check that required columns exist with correct types, ignore extra columns
        missing_cols = []
        type_mismatch_cols = []
        
        for col_name, expected_type in complete_schema.items():
            if col_name not in df.columns:
                missing_cols.append(col_name)
            else:
                # Get the column from the DataFrame
                col = df.schema[col_name]
                
                # TO DO: make it simplier 
                # Compare data types with expected type
                if type(expected_type) == T.LongType and type(col.dataType) != T.LongType:
                    type_mismatch_cols.append(f"{col_name} (expected: LongType, got: {col.dataType})")
                elif type(expected_type) == T.IntegerType and type(col.dataType) != T.IntegerType:
                    type_mismatch_cols.append(f"{col_name} (expected: IntegerType, got: {col.dataType})")
                elif type(expected_type) == T.DateType and type(col.dataType) != T.DateType:
                    type_mismatch_cols.append(f"{col_name} (expected: DateType, got: {col.dataType})")
                elif type(expected_type) == T.TimestampType and type(col.dataType) != T.TimestampType:
                    type_mismatch_cols.append(f"{col_name} (expected: TimestampType, got: {col.dataType})")
                elif type(expected_type) == T.StringType and type(col.dataType) != T.StringType:
                    type_mismatch_cols.append(f"{col_name} (expected: StringType, got: {col.dataType})")
                elif type(expected_type) == T.FloatType and type(col.dataType) != T.FloatType:
                    type_mismatch_cols.append(f"{col_name} (expected: FloatType, got: {col.dataType})")
                elif type(expected_type) == T.DoubleType and type(col.dataType) != T.DoubleType:
                    type_mismatch_cols.append(f"{col_name} (expected: DoubleType, got: {col.dataType})")
                elif type(expected_type) == T.BooleanType and type(col.dataType) != T.BooleanType:
                    type_mismatch_cols.append(f"{col_name} (expected: BooleanType, got: {col.dataType})")
        
        # Report extra columns for information but DON'T fail because of them (like Palantir contains())
        expected_cols = set(complete_schema.keys())
        actual_cols = set([col.lower() for col in df.columns])
        extra_cols = actual_cols - expected_cols
        
        schema_check_passed = len(missing_cols) == 0 and len(type_mismatch_cols) == 0
        validation_results.append({
            "check_name": "Dataset includes expected OMOP columns with proper types",
            "passed": schema_check_passed,
            "details": f"Missing columns: {missing_cols}, Type mismatches: {type_mismatch_cols}" if not schema_check_passed else f"All required columns present with correct types. Extra columns (allowed): {sorted(extra_cols) if extra_cols else 'none'}"
        })
        
        # Check 2: Primary key validation (if applicable)
        if pkey:
            # Count total rows
            total_rows = df.count()
            
            # Count distinct values in primary key
            distinct_pkey_count = df.select(pkey).distinct().count()
            
            pkey_check_passed = total_rows == distinct_pkey_count
            validation_results.append({
                "check_name": f"Valid global id primary key",
                "passed": pkey_check_passed,
                "details": f"Total rows: {total_rows}, Distinct {pkey} values: {distinct_pkey_count}" if not pkey_check_passed else "Primary key is valid"
            })
        
        # Check 3: Non-null checks for required columns
        null_rows_union = None
        for col_name in required_cols:
            if col_name in df.columns:
                null_rows = df.filter(F.col(col_name).isNull())
                null_count = null_rows.count()
                col_check_passed = null_count == 0
                validation_results.append({
                    "check_name": f"{col_name} column must be non-null",
                    "passed": col_check_passed,
                    "details": f"Found {null_count} null values" if not col_check_passed else "No null values found"
                })
                # Collect all rows with nulls in any required column
                if null_count > 0:
                    if null_rows_union is None:
                        null_rows_union = null_rows
                    else:
                        null_rows_union = null_rows_union.union(null_rows)
            else:
                validation_results.append({
                    "check_name": f"{col_name} column must be non-null",
                    "passed": False,
                    "details": f"Column {col_name} does not exist in the dataset"
                })
        
        # Save rows with nulls in required columns to a separate table
        if null_rows_union is not None:
            null_table = f"{dbname}.09_{domain}_nulls"
            print(f"Saving rows with nulls in required columns to {null_table}")
            null_rows_union.write.format("delta").mode("overwrite").saveAsTable(null_table)
        
        # Drop rows with nulls in required columns from the main DataFrame
        for col_name in required_cols:
            if col_name in df.columns:
                df = df.filter(F.col(col_name).isNotNull())
        
        # Print validation summary
        print(f"Validation summary for {domain}:")
        for result in validation_results:
            status = "PASSED" if result["passed"] else "FAILED"
            print(f"  {status}: {result['check_name']}")
            if not result["passed"]:
                print(f"    Details: {result['details']}")
        
        # Check if any validations failed
        any_failures = any(not result["passed"] for result in validation_results)
        if any_failures:
            print(f"ERROR: Validation failures detected in {domain}.")
            failed_checks = [result["check_name"] for result in validation_results if not result["passed"]]
            failure_details = [f"{result['check_name']}: {result['details']}" for result in validation_results if not result["passed"]]
            error_message = f"Validation failed for {domain}.\nFailed checks: {', '.join(failed_checks)}\nDetails:\n" + "\n".join(failure_details)
            raise ValueError(error_message)
        
        # Only write the output data if all validations passed
        # Keep ALL columns (including extra ones) like Palantir's passthrough behavior
        output_table = f"{dbname}.09_{domain}"
        print(f"All validations passed. Writing validated data to {output_table}")
        df.write.format("delta").mode("overwrite").saveAsTable(output_table)
        timestamp_comment.comment(spark,dbname,f"09_{domain}")
        return df
    
    return validate_domain

def run_all_validations(spark, dbname):
    """
    Run validations for all OMOP domains
    
    Args:
        spark: SparkSession
        dbname: Database name
    """

    domains = [
        ("care_site", "care_site_id"),
        # ("condition_era", "condition_era_id"),
        ("condition_occurrence", "condition_occurrence_id"),
        # ("control_map", None), # want to ignore control_map checks
        ("death", None),  # Deaths do not have primary keys
        ("device_exposure", "device_exposure_id"),
        # ("dose_era", "dose_era_id"),
        # ("drug_era", "drug_era_id"),
        ("drug_exposure", "drug_exposure_id"),
        ("location", "location_id"),
        ("measurement", "measurement_id"),
        # ("note", "note_id"),
        # ("note_nlp", "note_nlp_id"),
        ("observation", "observation_id"),
        # ("observation_period", "observation_period_id"),
        ("person", "person_id"),
        ("procedure_occurrence", "procedure_occurrence_id"),
        ("provider", "provider_id"),
        # ("visit_detail", "visit_detail_id"),
        ("visit_occurrence", "visit_occurrence_id")
    ]
    
    # Track validation results across all domains
    success_count = 0
    failed_domains = []
    
    for domain, pkey in domains:
        try:
            validator = make_validator(domain, pkey)
            validator(spark, dbname)
            success_count += 1
            print(f"{domain} validated successfully")
        except Exception as e:
            print(f"{domain} validation failed: {str(e)}")
            failed_domains.append(domain)
    
    # Final summary
    print(f"\n===== VALIDATION SUMMARY =====")
    print(f"Total domains: {len(domains)}")
    print(f"Successful validations: {success_count}")
    print(f"Failed validations: {len(failed_domains)}")
    
    if failed_domains:
        print(f"Failed domains: {', '.join(failed_domains)}")
        raise ValueError(f"Validation failed for the following domains: {', '.join(failed_domains)}")

# Usage
run_all_validations(spark, dbname)

# COMMAND ----------

# import sys
# sys.path.append("/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
# from pyspark.sql import functions as F, types as T
# from myproject import schema
# from myproject import timestamp_comment

# def make_validator(domain, pkey):
#     """
#     Create a function that validates an OMOP domain table against its schema
    
#     Args:
#         domain (str): The OMOP domain (e.g., "person", "condition_occurrence")
#         pkey (str): The primary key column (e.g., "person_id")
        
#     Returns:
#         function: A function that validates the specified domain
#     """
    
#     # Get complete schema for this OMOP domain
#     complete_schema = schema.omop_complete[domain]
    
#     # Convert column names to lowercase
#     complete_schema = {k.lower(): v for k, v in complete_schema.items()}
    
#     # Get required non-null columns for this OMOP domain
#     required_schema = schema.omop_required[domain]
#     required_cols = [col.lower() for col in required_schema.keys()]
    
#     def validate_domain(spark, dbname):
#         """
#         Validate the OMOP domain table and write the results to database tables
        
#         Args:
#             spark: SparkSession
#             dbname (str): Database name from widget
            
#         Returns:
#             DataFrame: The validated DataFrame
#         """
#         # Construct input table name with naming convention
#         input_table = f"{dbname}.08_{domain}"
#         print(f"Validating {domain} from {input_table}...")
        
#         # Read the input table
#         df = spark.table(input_table)
        
#         # Create a validation results DataFrame
#         validation_results = []
        
#         # Check 1: Schema validation - CONTAINS logic like Palantir E.schema().contains()
#         # Only check that required columns exist with correct types, ignore extra columns
#         missing_cols = []
#         type_mismatch_cols = []
        
#         for col_name, expected_type in complete_schema.items():
#             if col_name not in df.columns:
#                 missing_cols.append(col_name)
#             else:
#                 # Get the column from the DataFrame
#                 col = df.schema[col_name]
                
#                 # TO DO: make it simplier 
#                 # Compare data types with expected type
#                 if type(expected_type) == T.LongType and type(col.dataType) != T.LongType:
#                     type_mismatch_cols.append(f"{col_name} (expected: LongType, got: {col.dataType})")
#                 elif type(expected_type) == T.IntegerType and type(col.dataType) != T.IntegerType:
#                     type_mismatch_cols.append(f"{col_name} (expected: IntegerType, got: {col.dataType})")
#                 elif type(expected_type) == T.DateType and type(col.dataType) != T.DateType:
#                     type_mismatch_cols.append(f"{col_name} (expected: DateType, got: {col.dataType})")
#                 elif type(expected_type) == T.TimestampType and type(col.dataType) != T.TimestampType:
#                     type_mismatch_cols.append(f"{col_name} (expected: TimestampType, got: {col.dataType})")
#                 elif type(expected_type) == T.StringType and type(col.dataType) != T.StringType:
#                     type_mismatch_cols.append(f"{col_name} (expected: StringType, got: {col.dataType})")
#                 elif type(expected_type) == T.FloatType and type(col.dataType) != T.FloatType:
#                     type_mismatch_cols.append(f"{col_name} (expected: FloatType, got: {col.dataType})")
#                 elif type(expected_type) == T.DoubleType and type(col.dataType) != T.DoubleType:
#                     type_mismatch_cols.append(f"{col_name} (expected: DoubleType, got: {col.dataType})")
#                 elif type(expected_type) == T.BooleanType and type(col.dataType) != T.BooleanType:
#                     type_mismatch_cols.append(f"{col_name} (expected: BooleanType, got: {col.dataType})")
        
#         # Report extra columns for information but DON'T fail because of them (like Palantir contains())
#         expected_cols = set(complete_schema.keys())
#         actual_cols = set([col.lower() for col in df.columns])
#         extra_cols = actual_cols - expected_cols
        

        
#         schema_check_passed = len(missing_cols) == 0 and len(type_mismatch_cols) == 0
#         validation_results.append({
#             "check_name": "Dataset includes expected OMOP columns with proper types",
#             "passed": schema_check_passed,
#             "details": f"Missing columns: {missing_cols}, Type mismatches: {type_mismatch_cols}" if not schema_check_passed else f"All required columns present with correct types. Extra columns (allowed): {sorted(extra_cols) if extra_cols else 'none'}"
#         })
        
#         # Check 2: Primary key validation (if applicable)
#         if pkey:
#             # Count total rows
#             total_rows = df.count()
            
#             # Count distinct values in primary key
#             distinct_pkey_count = df.select(pkey).distinct().count()
            
#             pkey_check_passed = total_rows == distinct_pkey_count
#             validation_results.append({
#                 "check_name": f"Valid global id primary key",
#                 "passed": pkey_check_passed,
#                 "details": f"Total rows: {total_rows}, Distinct {pkey} values: {distinct_pkey_count}" if not pkey_check_passed else "Primary key is valid"
#             })
        
#         # Check 3: Non-null checks for required columns
#         for col_name in required_cols:
#             if col_name in df.columns:
#                 null_count = df.filter(F.col(col_name).isNull()).count()
#                 col_check_passed = null_count == 0
#                 validation_results.append({
#                     "check_name": f"{col_name} column must be non-null",
#                     "passed": col_check_passed,
#                     "details": f"Found {null_count} null values" if not col_check_passed else "No null values found"
#                 })
#             else:
#                 validation_results.append({
#                     "check_name": f"{col_name} column must be non-null",
#                     "passed": False,
#                     "details": f"Column {col_name} does not exist in the dataset"
#                 })
        
#         # Print validation summary
#         print(f"Validation summary for {domain}:")
#         for result in validation_results:
#             status = "PASSED" if result["passed"] else "FAILED"
#             print(f"  {status}: {result['check_name']}")
#             if not result["passed"]:
#                 print(f"    Details: {result['details']}")
        
#         # Check if any validations failed
#         any_failures = any(not result["passed"] for result in validation_results)
#         if any_failures:
#             print(f"ERROR: Validation failures detected in {domain}.")
#             failed_checks = [result["check_name"] for result in validation_results if not result["passed"]]
#             failure_details = [f"{result['check_name']}: {result['details']}" for result in validation_results if not result["passed"]]
#             error_message = f"Validation failed for {domain}.\nFailed checks: {', '.join(failed_checks)}\nDetails:\n" + "\n".join(failure_details)
#             raise ValueError(error_message)
        
#         # Only write the output data if all validations passed
#         # Keep ALL columns (including extra ones) like Palantir's passthrough behavior
#         output_table = f"{dbname}.09_{domain}"
#         print(f"All validations passed. Writing validated data to {output_table}")
#         df.write.format("delta").mode("overwrite").saveAsTable(output_table)
#         timestamp_comment.comment(spark,dbname,f"09_{domain}")
#         return df
    
#     return validate_domain

# def run_all_validations(spark, dbname):
#     """
#     Run validations for all OMOP domains
    
#     Args:
#         spark: SparkSession
#         dbname: Database name
#     """

#     domains = [
#         ("care_site", "care_site_id"),
#         # ("condition_era", "condition_era_id"),
#         ("condition_occurrence", "condition_occurrence_id"),
#         # ("control_map", None), # want to ignore control_map checks
#         ("death", None),  # Deaths do not have primary keys
#         ("device_exposure", "device_exposure_id"),
#         # ("dose_era", "dose_era_id"),
#         # ("drug_era", "drug_era_id"),
#         ("drug_exposure", "drug_exposure_id"),
#         ("location", "location_id"),
#         ("measurement", "measurement_id"),
#         # ("note", "note_id"),
#         # ("note_nlp", "note_nlp_id"),
#         ("observation", "observation_id"),
#         # ("observation_period", "observation_period_id"),
#         ("person", "person_id"),
#         ("procedure_occurrence", "procedure_occurrence_id"),
#         ("provider", "provider_id"),
#         # ("visit_detail", "visit_detail_id"),
#         ("visit_occurrence", "visit_occurrence_id")
#     ]
    
#     # Track validation results across all domains
#     success_count = 0
#     failed_domains = []
    
#     for domain, pkey in domains:
#         try:
#             validator = make_validator(domain, pkey)
#             validator(spark, dbname)
#             success_count += 1
#             print(f"{domain} validated successfully")
#         except Exception as e:
#             print(f"{domain} validation failed: {str(e)}")
#             failed_domains.append(domain)
    
#     # Final summary
#     print(f"\n===== VALIDATION SUMMARY =====")
#     print(f"Total domains: {len(domains)}")
#     print(f"Successful validations: {success_count}")
#     print(f"Failed validations: {len(failed_domains)}")
    
#     if failed_domains:
#         print(f"Failed domains: {', '.join(failed_domains)}")
#         raise ValueError(f"Validation failed for the following domains: {', '.join(failed_domains)}")

# # Usage
# run_all_validations(spark, dbname)

# COMMAND ----------

# %sql
# CREATE OR REPLACE TABLE uab_ingestion.09_visit_occurrence AS
# SELECT *
# FROM uab_ingestion.09_visit_occurrence
# WHERE visit_start_date IS NOT NULL;

# COMMAND ----------

# %sql
# -- only create rows without null dates

# CREATE or REPLACE TABLE uab_ingestion.09_condition_occurrence AS
# SELECT *
# FROM uab_ingestion.08_condition_occurrence
# WHERE condition_start_date IS NOT NULL;

# COMMAND ----------

# %sql
# -- only create rows without null dates
# CREATE OR REPLACE TABLE uab_ingestion.09_device_exposure AS
# SELECT *
# FROM uab_ingestion.08_device_exposure
# WHERE device_exposure_start_date IS NOT NULL;


# COMMAND ----------

# %sql
# -- only create rows without null dates
# CREATE OR REPLACE TABLE uab_ingestion.09_measurement AS
# SELECT *
# FROM uab_ingestion.08_measurement
# WHERE measurement_date IS NOT NULL;

# COMMAND ----------

# %sql
# -- only create rows without null dates
# CREATE OR REPLACE TABLE uab_ingestion.09_procedure_occurrence AS
# SELECT *
# FROM uab_ingestion.08_procedure_occurrence
# WHERE procedure_date IS NOT NULL;


# COMMAND ----------

# %sql
# -- only create rows without null dates
# CREATE OR REPLACE TABLE uab_ingestion.09_observation AS
# SELECT *
# FROM uab_ingestion.08_observation
# WHERE observation_date IS NOT NULL;
