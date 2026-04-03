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
CREATE OR REPLACE TABLE {databaseName}.04_condition_occurrence AS
    
    --condition2condition
    with condition as (
        -- if cooncept is mappable 
        SELECT
            condition_occurrence_id as site_domain_id
            ----SSH Note: if we are joining relationship table to grab the the full target concepts columns, 
            --- then there may be instances where the non-standard code can be mapped to multiple target_concept_id
            ----for those instances, we would need to create unique set of source_pkey. And use the source_pkey to generate the hashed_id
            , 'CONDITION_OCCURRENCE_ID:' || condition_occurrence_id || '|TARGET_CONCEPT_ID:' || COALESCE(cast(c.target_concept_id as string), '') as source_pkey
            -----, 'CONDITION_OCCURRENCE_ID:' || condition_occurrence_id as source_pkey
            , person_id as site_person_id
            , COALESCE(target_concept_id, 0 ) as condition_concept_id
            , condition_start_date
            , condition_start_datetime
            , condition_end_date
            , condition_end_datetime
            , condition_type_concept_id
            , condition_status_concept_id
            , stop_reason
            , provider_id as site_provider_id
            , visit_occurrence_id as site_visit_occurrence_id
            , visit_detail_id as visit_detail_id
            , condition_source_value
            , condition_source_concept_id
            , condition_status_source_value
            , 'CONDITION' as source_domain
            , data_partner_id
            , payload
        -- pull the data from the prepared step where we have extended the dataset to include the target columns using the newest OMOP vocab tables
        FROM  {databaseName}.03_condition_occurrence c
        --domain id can be in Condition NULL or Observation
        WHERE c.condition_occurrence_id IS NOT NULL
        and c.target_concept_id is not null
        -- Retain all records from the source table, unless we're already mapping them to another domain
        -- ie: If there are rows with domain_id == ('Observation'), do not include them in this table, condition contained target domain id in ( condition, observation, null )
        AND (target_domain_id NOT IN ('Device', 'Observation', 'Measurement','Procedure','Drug','Visit') or target_domain_id is null)
    ), 
    condition_unmap as (
            --condition. If the conditions are unmappable (or standard already). Use origial data
            SELECT
            condition_occurrence_id as site_domain_id
            , 'CONDITION_OCCURRENCE_ID:' || condition_occurrence_id || '|CONDITION_CONCEPT_ID:' || 
                COALESCE(cast(c.condition_concept_id as string), '') as source_pkey
            , person_id as site_person_id
            , condition_concept_id
            , condition_start_date
            , condition_start_datetime
            , condition_end_date
            , condition_end_datetime
            , condition_type_concept_id
            , condition_status_concept_id
            , stop_reason
            , provider_id as site_provider_id
            , visit_occurrence_id as site_visit_occurrence_id
            , visit_detail_id as visit_detail_id
            , condition_source_value
            , condition_source_concept_id
            , condition_status_source_value
            , 'CONDITION' as source_domain
            , data_partner_id
            , payload
        FROM {databaseName}.03_condition_occurrence c
        --domain id can be in Condition NULL or Observation
        WHERE (c.condition_occurrence_id IS NOT NULL
        and c.target_concept_id is null) --or (c.target_domain_id = 'Visit')

    ), 
    --observation2condition
    observation as (
        select
            observation_id as site_domain_id
             , 'OBSERVATION_ID:' || observation_id || '|TARGET_CONCEPT_ID:' || COALESCE(cast(o.target_concept_id as string), '') as source_pkey
             , person_id as site_person_id
             , COALESCE(target_concept_id, 0 ) as condition_concept_id
             , observation_date as condition_start_date
             , observation_datetime as condition_start_datetime
             , cast(NULL as date) as condition_end_date
             , cast(Null as timestamp) as condition_end_datetime
             , observation_type_concept_id as condition_type_concept_id
             , cast( null as int) as condition_status_concept_id
             , cast( null as string ) as stop_reason
             , provider_id as site_provider_id
             , visit_occurrence_id as site_visit_occurrence_id
             , visit_detail_id as visit_detail_id
             , observation_source_value as condition_source_value
             , observation_source_concept_id as condition_source_concept_id
             , cast( null as string ) as condition_status_source_value
             , 'OBSERVATION' as source_domain
             , data_partner_id
             , payload
        FROM {databaseName}.03_observation o
        WHERE o.observation_id IS NOT NULL
        AND target_domain_id  = 'Condition' 
    ),

    device as (
        select
            device_exposure_id as site_domain_id
            , 'DEVICE_EXPOSURE_ID:' || device_exposure_id || '|TARGET_CONCEPT_ID:' || 
                COALESCE(cast(d.target_concept_id as string), '') as source_pkey
            , person_id as site_person_id
            , COALESCE(target_concept_id, 0 ) as condition_concept_id
            , device_exposure_start_date as condition_start_date
            , device_exposure_start_datetime as condition_start_datetime
            , cast(NULL as date) as condition_end_date
            , cast(Null as timestamp) as condition_end_datetime
            , device_type_concept_id as condition_type_concept_id
            , cast( null as int) as condition_status_concept_id
            , cast( null as string ) as stop_reason
            , provider_id as site_provider_id
            , visit_occurrence_id as site_visit_occurrence_id
            , visit_detail_id as visit_detail_id
            , device_source_value as condition_source_value
            , device_source_concept_id as condition_source_concept_id
            , cast( null as string ) as condition_status_source_value
            , 'DEVICE' as source_domain
            , data_partner_id
            , payload
        from {databaseName}.03_device_exposure  d
        where d.device_exposure_id is not null 
        and target_domain_id  = 'Condition'

    ),
    measurement as (
        SELECT
            measurement_id as site_domain_id
            , 'MEASUREMENTE_ID:' || measurement_id || '|TARGET_CONCEPT_ID:' || 
                COALESCE(cast(m.target_concept_id as string), '') as source_pkey
            , person_id as site_person_id
            , COALESCE(target_concept_id, 0 )as condition_concept_id
            , measurement_date as condition_start_date
            , measurement_datetime as condition_start_datetime
            , cast(NULL as date) as condition_end_date
            , cast(Null as timestamp) as condition_end_datetime
            , measurement_type_concept_id as condition_type_concept_id
            , cast( null as int) as condition_status_concept_id
            , cast( null as string ) as stop_reason
            , provider_id as site_provider_id
            , visit_occurrence_id as site_visit_occurrence_id
            , visit_detail_id as visit_detail_id
            , measurement_source_value as condition_source_value
            , measurement_source_concept_id as condition_source_concept_id
            , cast( null as string ) as condition_status_source_value
            , 'MEASUREMENT' as source_domain
            , data_partner_id
            , payload
            from {databaseName}.03_measurement m
            where m.measurement_id is not NULL
            and target_domain_id  = 'Condition'
    ),
    procedure as (
        SELECT
            procedure_occurrence_id as site_domain_id
            , 'PROCEDURE_OCCURRENCE_ID:' || procedure_occurrence_id || '|TARGET_CONCEPT_ID:' || 
                COALESCE(cast(p.target_concept_id as string), '') as source_pkey
            , person_id as site_person_id
            , COALESCE(target_concept_id, 0 ) as condition_concept_id
            , procedure_date as condition_start_date
            , procedure_datetime as condition_start_datetime
            , cast(NULL as date) as condition_end_date
            , cast(Null as timestamp) as condition_end_datetime
            , procedure_type_concept_id as condition_type_concept_id
            , cast( null as int) as condition_status_concept_id
            , cast( null as string ) as stop_reason
            , provider_id as site_provider_id
            , visit_occurrence_id as site_visit_occurrence_id
            , visit_detail_id as visit_detail_id
            , procedure_source_value as condition_source_value
            , procedure_source_concept_id as condition_source_concept_id
            , cast( null as string ) as condition_status_source_value
            , 'PROCEDURE' as source_domain
            , data_partner_id
            , payload
        from {databaseName}.03_procedure_occurrence p
        where p.procedure_occurrence_id is not null
        and target_domain_id  = 'Condition'
    ),
    drug as (
        SELECT
            drug_exposure_id as site_domain_id
            , 'DRUG_EXPOSURE_ID:' || drug_exposure_id || '|TARGET_CONCEPT_ID:' || 
                COALESCE(cast(dr.target_concept_id as string), '') as source_pkey
            , person_id as site_person_id
            , COALESCE(target_concept_id, 0 ) as condition_concept_id
            , drug_exposure_start_date as condition_start_date
            , drug_exposure_start_datetime as condition_start_datetime
            , drug_exposure_end_date as condition_end_date
            , drug_exposure_end_datetime as condition_end_datetime
            , drug_type_concept_id as condition_type_concept_id
            , cast( null as int) as condition_status_concept_id
            , stop_reason
            , provider_id as site_provider_id
            , visit_occurrence_id as site_visit_occurrence_id
            , visit_detail_id as visit_detail_id
            , drug_source_value as condition_source_value
            , drug_source_concept_id as condition_source_concept_id
            , cast( null as string ) as condition_status_source_value
            , 'DRUG' as source_domain
            , data_partner_id
            , payload
        from  {databaseName}.03_drug_exposure dr
        where dr.drug_exposure_id is not null
        and target_domain_id  = 'Condition'

    ),
    all_domain as (
        select 
        *, 
        md5(CAST(source_pkey as string )) as hashed_id
        from (
            select * from condition
            union 
            select * from condition_unmap
            union
            select * from observation
            union 
            select * from device
            union
            select * from measurement
            union
            select * from procedure
            UNION
            select * from drug
        )
    )

    SELECT 
          * 
        , cast(conv(substr(hashed_id, 1, 15), 16, 10) as bigint) & 2251799813685247 as condition_occurrence_id_51_bit
    FROM  all_domain 
""")


# COMMAND ----------


import sys
sys.path.append("/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
from myproject import timestamp_comment
timestamp_comment.comment(spark,databaseName,'04_condition_occurrence')


# COMMAND ----------


