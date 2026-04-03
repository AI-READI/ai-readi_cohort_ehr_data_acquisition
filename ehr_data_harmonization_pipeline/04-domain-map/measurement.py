# Databricks notebook source
# MAGIC %md
# MAGIC - Use the target_domain_id field from step 3 to ensure all records are going to appropriate domains. 
# MAGIC - source_pkey column is used to create unique combination to generate global ID in the downstream pipeline

# COMMAND ----------

dbutils.widgets.removeAll()
dbutils.widgets.text("site", "", "Sites")
databaseName = dbutils.widgets.get("site") + '_ingestion'
print(databaseName)

# COMMAND ----------

spark.sql(f"""
CREATE OR REPLACE TABLE {databaseName}.04_measurement AS

    --measurement2measurement
    with measurement as (
         SELECT
              measurement_id as site_domain_id
            , 'MEASUREMENT_ID:' || measurement_id || '|TARGET_CONCEPT_ID:' || COALESCE(target_concept_id, '') as source_pkey
            , person_id as site_person_id
            , COALESCE( target_concept_id, 0) as measurement_concept_id
            , measurement_date
            , measurement_datetime
            , measurement_time
            , measurement_type_concept_id
            , operator_concept_id
            , value_as_number
            , value_as_concept_id
            , unit_concept_id
            , range_low
            , range_high
            , provider_id as site_provider_id
            , visit_occurrence_id as site_visit_occurrence_id
            , visit_detail_id
            , measurement_source_value
            , measurement_source_concept_id
            , unit_source_value
            , value_source_value
            , 'MEASUREMENT' as source_domain
            , data_partner_id
            , payload
        FROM {databaseName}.03_measurement m
        WHERE measurement_id IS NOT NULL
        and target_concept_id is not null
        -- Retain all records from the source table, unless we're already mapping them to another domain
        -- ie: If there are rows with domain_id == ('Procedure'), do not include them in this table
        -- target_domain_id of measurement are Measurement,  null, procedure, provider, condition
        AND (m.target_domain_id NOT IN ('Device', 'Observation', 'Condition','Procedure','Drug','Visit') or m.target_domain_id is null)
        
    ), 
    measurement_unmap as (
        SELECT
            measurement_id as site_domain_id
            , 'MEASUREMENT_ID:' || measurement_id || '|MEASUREMENT_CONCEPT_ID:' || COALESCE(measurement_concept_id, '') as source_pkey
            , person_id as site_person_id
            , measurement_concept_id
            , measurement_date
            , measurement_datetime
            , measurement_time
            , measurement_type_concept_id
            , operator_concept_id
            , value_as_number
            , value_as_concept_id
            , unit_concept_id
            , range_low
            , range_high
            , provider_id as site_provider_id
            , visit_occurrence_id as site_visit_occurrence_id
            , visit_detail_id
            , measurement_source_value
            , measurement_source_concept_id
            , unit_source_value
            , value_source_value
            , 'MEASUREMENT' as source_domain
            , data_partner_id
            , payload
        FROM {databaseName}.03_measurement m
        WHERE (measurement_id IS NOT NULL
        and target_concept_id is null) or (m.target_domain_id = 'Visit')
    ),

    --procedures2measurement
    procedures as (
        SELECT
            procedure_occurrence_id as site_domain_id
            , 'PROCEDURE_OCCURRENCE_ID:' || procedure_occurrence_id || '|TARGET_CONCEPT_ID:' || COALESCE(target_concept_id, '') as source_pkey
            , person_id as site_person_id
            , COALESCE( target_concept_id, 0) as measurement_concept_id
            , procedure_date as measurement_date
            , CAST(procedure_datetime as timestamp) as measurement_datetime 
            , CAST( NULL AS string ) as measurement_time
            , 32817 as measurement_type_concept_id
            , modifier_concept_id as operator_concept_id
            , CAST( NULL as float ) as value_as_number
            , CAST( NULL as int ) as value_as_concept_id
            , CAST( NULL as int ) as unit_concept_id
            , CAST( NULL as float ) as range_low
            , CAST( NULL as float ) as range_high
            , provider_id as site_provider_id
            , visit_occurrence_id as site_visit_occurrence_id
            , visit_detail_id
            , procedure_source_value as measurement_source_value
            , procedure_source_concept_id as measurement_source_concept_id
            , modifier_source_value as unit_source_value
            , procedure_source_value as value_source_value
            , 'PROCEDURE' as source_domain
            , data_partner_id
            , payload
        FROM {databaseName}.03_procedure_occurrence p
        WHERE procedure_occurrence_id IS NOT NULL
        AND p.target_domain_id = 'Measurement'
    ),
    
    --observation2measurement
    observation as (
        SELECT
            observation_id as site_domain_id
            , 'OBSERVATION_ID:' || observation_id || '|TARGET_CONCEPT_ID:' || COALESCE(target_concept_id, '') as source_pkey
            , person_id as site_person_id
            , COALESCE( target_concept_id, 0) as measurement_concept_id
            , o.observation_date as measurement_date
            , CAST(o.observation_datetime as timestamp) as measurement_datetime
            , CAST(null as string) AS measurement_time
            , observation_type_concept_id as measurement_type_concept_id
            , cast(null as int) as operator_concept_id
            , value_as_number
            , value_as_concept_id
            , unit_concept_id
            , CAST( NULL as float ) as range_low
            , CAST( NULL as float ) as range_high
            , provider_id as site_provider_id
            , visit_occurrence_id as site_visit_occurrence_id
            , visit_detail_id
            , observation_source_value as measurement_source_value
            , observation_source_concept_id as measurement_source_concept_id
            , unit_source_value
            , CAST(null as string) as value_source_value
            , 'OBSERVATION' as source_domain
            , data_partner_id
            , payload
        FROM {databaseName}.03_observation o
        WHERE observation_id IS NOT NULL
        AND o.target_domain_id = 'Measurement'
    ),

    condition as (
        SELECT
              condition_occurrence_id as site_domain_id
            , 'CONDITION_OCCURRENCE_ID:' || condition_occurrence_id || '|TARGET_CONCEPT_ID:' || COALESCE(target_concept_id, '') as source_pkey
            , person_id as site_person_id
            , COALESCE( target_concept_id, 0) as measurement_concept_id
            , condition_start_date as measurement_date
            , condition_start_datetime as measurement_datetime
            , CAST(null as string) AS measurement_time
            , condition_type_concept_id as measurement_type_concept_id
            , cast(null as int) as operator_concept_id
            , CAST( NULL as float ) as value_as_number
            , CAST( NULL as int ) as value_as_concept_id
            , CAST( NULL as int ) as unit_concept_id
            , CAST( NULL as float ) as range_low
            , CAST( NULL as float ) as range_high
            , provider_id as site_provider_id
            , visit_occurrence_id as site_visit_occurrence_id
            , visit_detail_id
            , condition_source_value as measurement_source_value
            , condition_source_concept_id as measurement_source_concept_id
            , cast( NULL as string) as unit_source_value
            , cast( NULL as string) as value_source_value
            , 'CONDITION' as source_domain
            , data_partner_id
            , payload
            from {databaseName}.03_condition_occurrence c
            where c.condition_occurrence_id is not null
            and c.target_domain_id = 'Measurement'
        
    ),
    device as (
        SELECT
            device_exposure_id as site_domain_id
            , 'DEVICE_EXPOSURE_ID:' || device_exposure_id || '|TARGET_CONCEPT_ID:' || COALESCE(target_concept_id, '') as source_pkey
            , person_id as site_person_id
            , COALESCE( target_concept_id, 0) as measurement_concept_id
            , device_exposure_start_date as measurement_date
            , device_exposure_start_datetime as measurement_datetime
            , CAST( NULL AS string ) as measurement_time
            , device_type_concept_id as measurement_type_concept_id
            , cast(null as int) as operator_concept_id
            , CAST( NULL as float ) as value_as_number
            , CAST( NULL as int ) as value_as_concept_id
            , CAST( NULL as int ) as unit_concept_id
            , CAST( NULL as float ) as range_low
            , CAST( NULL as float ) as range_high
            , provider_id as site_provider_id
            , visit_occurrence_id as site_visit_occurrence_id
            , visit_detail_id
            , device_source_value as measurement_source_value
            , device_source_concept_id as measurement_source_concept_id
            , cast( NULL as string) as unit_source_value
            , cast( NULL as string) as value_source_value
            , 'DEVICE' as source_domain
            , data_partner_id
            , payload
            from {databaseName}.03_device_exposure d
            where d.device_exposure_id is not null
            and d.target_domain_id = 'Measurement'
    ),
    drug as (
        SELECT
        drug_exposure_id as site_domain_id
        , 'DRUG_EXPOSURE_ID:' || drug_exposure_id || '|TARGET_CONCEPT_ID:' || COALESCE(target_concept_id, '') as source_pkey
        , person_id as site_person_id
        , COALESCE( target_concept_id, 0) as measurement_concept_id
        , drug_exposure_start_date as measurement_date
        , drug_exposure_start_datetime as measurement_datetime
        , CAST( NULL AS string ) asmeasurement_time
        , drug_type_concept_id as measurement_type_concept_id
        , cast(null as int) as operator_concept_id
        , CAST( NULL as float ) as value_as_number
        , CAST( NULL as int ) as value_as_concept_id
        , CAST( NULL as int ) as unit_concept_id
        , CAST( NULL as float ) as range_low
        , CAST( NULL as float ) as range_high
        , provider_id as site_provider_id
        , visit_occurrence_id as site_visit_occurrence_id
        , visit_detail_id
        , drug_source_value as measurement_source_value
        , drug_source_concept_id as measurement_source_concept_id
        , dose_unit_source_value as unit_source_value
        , cast( NULL as string) as value_source_value
        , 'DRUG' as source_domain
        , data_partner_id
        , payload
        from {databaseName}.03_drug_exposure dr
        where dr.drug_exposure_id is not null
        and dr.target_domain_id = 'Measurement'

    ),


    all_domain as ( 
        select
            *,
            md5(CAST(source_pkey as string)) AS hashed_id 
        from (
            select * from measurement 
            UNION
            select * from measurement_unmap
            union 
            select * from procedures
            union
            select * from observation
            union 
            select * from condition
            union
            select * from device
            UNION
            select * from drug
        )
    ) 

    SELECT 
            * 
            , cast(conv(substr(hashed_id, 1, 15), 16, 10) as bigint) & 2251799813685247 as measurement_id_51_bit
    FROM (
        select * from all_domain
         )   
""")

# COMMAND ----------

import sys
sys.path.append("/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
from myproject import timestamp_comment
timestamp_comment.comment(spark,databaseName,'04_measurement')
