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
CREATE OR REPLACE TABLE {databaseName}.04_device_exposure AS

    ---drug2device4
    with drug as (
         SELECT
              drug_exposure_id as site_domain_id
            , 'DRUG_EXPOSURE_ID:' || drug_exposure_id || '|TARGET_CONCEPT_ID:' ||
                COALESCE(target_concept_id, '')  as source_pkey
            , person_id as site_person_id
            , COALESCE(target_concept_id, 0 ) as device_concept_id
            , drug_exposure_start_date as device_exposure_start_date
            , drug_exposure_start_datetime as device_exposure_start_datetime
            , drug_exposure_end_date as device_exposure_end_date
            , drug_exposure_end_datetime as device_exposure_end_datetime
            , coalesce(drug_type_concept_id, 32817) as device_type_concept_id
            , CAST(null as string) unique_device_id     
            , CAST(NULL AS INT ) as quantity 
            , provider_id as site_provider_id
            , visit_occurrence_id as site_visit_occurrence_id
            , visit_detail_id
            , drug_source_value as device_source_value
            , drug_source_concept_id as device_source_concept_id
            , 'DRUG' as source_domain
            , data_partner_id
            , payload
    FROM {databaseName}.03_drug_exposure d
    WHERE drug_exposure_id IS NOT NULL
    AND (d.target_domain_id = 'Device' )
    ),
    -- if concept is not mappable (or standard already)
    device_unmap as (
    -- if cooncept is mappable based on 02_porepared_01 extended columns
       SELECT d.device_exposure_id as site_domain_id
            , 'DEVICE_EXPOSURE_ID:' || device_exposure_id || '|DEVICE_CONCEPT_ID:' || 
                COALESCE(d.device_concept_id, '') as source_pkey
            , d.person_id as site_person_id
            , device_concept_id
            , d.device_exposure_start_date
            , d.device_exposure_start_datetime
            , d.device_exposure_end_date
            , d.device_exposure_end_datetime
            , coalesce(d.device_type_concept_id, 32817 ) as device_type_concept_id
            , d.unique_device_id     
            , d.quantity 
            , d.provider_id as site_provider_id
            , d.visit_occurrence_id as site_visit_occurrence_id
            , d.visit_detail_id as site_visit_detail_id
            , d.device_source_value
            , d.device_source_concept_id
            , 'DEVICE' as source_domain
            , data_partner_id
            , payload
        FROM {databaseName}.03_device_exposure d
        WHERE ( d.device_exposure_id IS NOT NULL 
        AND d.target_concept_id is null ) OR (d.target_domain_id = 'Visit')
    ),

    --procedure2device
    procedure as (
        SELECT
            procedure_occurrence_id as site_domain_id
            , 'PROCEDURE_OCCURRENCE_ID:' || procedure_occurrence_id || '|TARGET_CONCEPT_ID:' || 
                COALESCE(target_concept_id, '') as source_pkey
            , person_id as site_person_id
            , COALESCE(target_concept_id, 0 ) as device_concept_id
            , procedure_date as device_exposure_start_date
            , procedure_datetime as device_exposure_start_datetime
            , procedure_date as device_exposure_end_date
            , procedure_datetime as device_exposure_end_datetime
            , coalesce(procedure_type_concept_id, 32817 ) as device_type_concept_id
            , CAST(null as string) as unique_device_id     
            , CAST(NULL AS INT ) as quantity 
            , provider_id as site_provider_id
            , visit_occurrence_id as site_visit_occurrence_id
            , visit_detail_id
            , procedure_source_value as device_source_value
            , procedure_source_concept_id as device_source_concept_id
            , 'PROCEDURE' as source_domain
            , data_partner_id
            , payload
        FROM {databaseName}.03_procedure_occurrence p
        WHERE procedure_occurrence_id IS NOT NULL 
        AND p.target_domain_id = 'Device'
    ),

    --device2device 
    device as (
        SELECT d.device_exposure_id as site_domain_id
            , 'DEVICE_EXPOSURE_ID:' || device_exposure_id || '|TARGET_CONCEPT_ID:' || 
                COALESCE(d.target_concept_id, '') as source_pkey
            , d.person_id as site_person_id
            , COALESCE(target_concept_id, 0 ) as device_concept_id
            , d.device_exposure_start_date
            , d.device_exposure_start_datetime
            , d.device_exposure_end_date
            , d.device_exposure_end_datetime
            , coalesce(d.device_type_concept_id, 32817 ) as device_type_concept_id
            , d.unique_device_id     
            , d.quantity 
            , d.provider_id as site_provider_id
            , d.visit_occurrence_id as site_visit_occurrence_id
            , d.visit_detail_id as site_visit_detail_id
            , d.device_source_value
            , d.device_source_concept_id
            , 'DEVICE' as source_domain
            , data_partner_id
            , payload
        FROM {databaseName}.03_device_exposure d
        WHERE d.device_exposure_id IS NOT NULL 
        and target_concept_id is not null
       AND (d.target_domain_id NOT IN ('Condition', 'Observation', 'Measurement','Procedure','Drug','Visit') or d.target_domain_id is null)
    ),
    condition as (
        SELECT 
            condition_occurrence_id as site_domain_id
            , 'CONDITION_OCCURRENCE_ID:' || condition_occurrence_id || '|TARGET_CONCEPT_ID:' || COALESCE(target_concept_id, '') as source_pkey
            , person_id as site_person_id
            , COALESCE(target_concept_id, 0 ) as device_concept_id
            , condition_start_date as device_exposure_start_date
            , condition_start_datetime as device_exposure_start_datetime
            , condition_end_date as device_exposure_end_date
            , condition_end_datetime as device_exposure_end_datetime
            , coalesce(condition_type_concept_id, 32817)  as device_type_concept_id
            , CAST(null as string) as unique_device_id     
            , CAST(NULL AS INT ) as quantity 
            , provider_id as site_provider_id
            , visit_occurrence_id as site_visit_occurrence_id
            , visit_detail_id as site_visit_detail_id
            , condition_source_value as device_source_value
            , condition_source_concept_id as device_source_concept_id
            , 'CONDITION' as source_domain
            , data_partner_id
            , payload
            from {databaseName}.03_condition_occurrence c
            where condition_occurrence_id is not NULL
            and c.target_domain_id = 'Device'
    ),
    observation as (
        SELECT 
            observation_id as site_domain_id
            , 'OBSERVATION_ID:' || observation_id || '|TARGET_CONCEPT_ID:' || 
                COALESCE(target_concept_id, '') as source_pkey
            , person_id as site_person_id
            , COALESCE(target_concept_id, 0 ) as device_concept_id
            , observation_date as device_exposure_start_date
            , observation_datetime as device_exposure_start_datetime
            , cast(null as date) as device_exposure_end_date
            , cast(Null as timestamp) as device_exposure_end_datetime
            , coalesce(observation_type_concept_id, 32817 ) as device_type_concept_id
            , CAST(null as string) as unique_device_id     
            , CAST(NULL AS INT ) as quantity 
            , provider_id as site_provider_id
            , visit_occurrence_id as site_visit_occurrence_id
            , visit_detail_id as site_visit_detail_id
            , observation_source_value as device_source_value
            , observation_source_concept_id as device_source_concept_id
            , 'OBSERVATION' as source_domain
            , data_partner_id
            , payload
            from {databaseName}.03_observation o
            where o.observation_id is not null
            and o.target_domain_id = 'Device'
    ),
    measurement as (
        SELECT 
            measurement_id as site_domain_id
            , 'MEASUREMENT_ID:' || measurement_id || '|TARGET_CONCEPT_ID:' || COALESCE(target_concept_id, '') as source_pkey
            , person_id as site_person_id
            , COALESCE(target_concept_id, 0 ) as device_concept_id
            , measurement_date as device_exposure_start_date
            , measurement_datetime as device_exposure_start_datetime
            , cast(null as date) as device_exposure_end_date
            , cast(Null as timestamp) as device_exposure_end_datetime
            , coalesce(measurement_type_concept_id, 32817 ) as device_type_concept_id
            , CAST(null as string) as unique_device_id     
            , CAST(NULL AS INT ) as quantity 
            , provider_id as site_provider_id
            , visit_occurrence_id as site_visit_occurrence_id
            , visit_detail_id as site_visit_detail_id
            , measurement_source_value as device_source_value
            , measurement_source_concept_id as device_source_concept_id
            , 'MEASUREMENT' as source_domain
            , data_partner_id
            , payload
            from {databaseName}.03_measurement m
            where m.measurement_id is not null
            and m.target_domain_id = 'Device'

    ),

    all_domain as (
        select *
         , md5(CAST(source_pkey as string)) as hashed_id
         from (
             select * from drug
             union
             select * from procedure
             union
             select * from device
             UNION
             select * from device_unmap
             UNION
             select * from condition
             union
             select * from observation
             union
             select * from measurement
         )
    )

    SELECT 
          * 
        , cast(conv(substr(hashed_id, 1, 15), 16, 10) as bigint) & 2251799813685247 as device_exposure_id_51_bit
    FROM (
        SELECT * from all_domain
    )  
""") 

# COMMAND ----------


import sys
sys.path.append("/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
from myproject import timestamp_comment
timestamp_comment.comment(spark,databaseName,'04_device_exposure')

