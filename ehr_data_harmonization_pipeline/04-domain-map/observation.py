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
CREATE OR REPLACE TABLE {databaseName}.04_observation AS

    --obs2obs
    with observation as
    (
        SELECT
            observation_id as site_domain_id
            , 'OBSERVATION_ID:' || observation_id || '|TARGET_CONCEPT_ID:' || COALESCE(target_concept_id, '') as source_pkey
            , person_id as site_person_id
            , COALESCE( target_concept_id, 0) as observation_concept_id 
            , observation_date
            , observation_datetime
            , observation_type_concept_id
            , value_as_number
            , value_as_string
            , value_as_concept_id
            , qualifier_concept_id
            , unit_concept_id
            , provider_id as site_provider_id
            , visit_occurrence_id as site_visit_occurrence_id
            , visit_detail_id
            , observation_source_value
            , observation_source_concept_id
            , unit_source_value
            , qualifier_source_value
            ,'OBSERVATION' as source_domain
            , data_partner_id
            , payload
        FROM {databaseName}.03_observation o
        WHERE observation_id IS NOT NULL 
        and target_concept_id is not null
        AND (o.target_domain_id NOT IN ('Device', 'Condition', 'Measurement','Procedure','Drug','Visit') 
        or o.target_domain_id is null)
    ), 
    observation_unmap as(
        SELECT
            observation_id as site_domain_id
            , 'OBSERVATION_ID:' || observation_id || '|OBSERVATION_CONCEPT_ID:' || COALESCE(observation_concept_id, '') as source_pkey
            , person_id as site_person_id
            , observation_concept_id -- if the target_concept_id is null use what was submitted in this column
            , observation_date
            , observation_datetime
            , observation_type_concept_id
            , value_as_number
            , value_as_string
            , value_as_concept_id
            , qualifier_concept_id
            , unit_concept_id
            , provider_id as site_provider_id
            , visit_occurrence_id as site_visit_occurrence_id
            , visit_detail_id
            , observation_source_value
            , observation_source_concept_id
            , unit_source_value
            , qualifier_source_value
            ,'OBSERVATION' as source_domain
            , data_partner_id
            , payload
    FROM {databaseName}.03_observation o
    WHERE (observation_id IS NOT NULL 
    and target_concept_id is null) 
    ),

    --condition2obs
    condition as (
        select 
            condition_occurrence_id as site_domain_id
            , 'CONDITION_OCCURRENCE_ID:' || condition_occurrence_id || '|TARGET_CONCEPT_ID:' || COALESCE(target_concept_id, '') as source_pkey
            , person_id as site_person_id
            , COALESCE( target_concept_id, 0) as observation_concept_id
            , condition_start_date as observation_date
            , condition_start_datetime as observation_datetime
            , condition_type_concept_id as observation_type_concept_id
            , CAST(null as int ) as value_as_number
            , CAST(null as string ) as value_as_string
            , CAST(null as int ) as value_as_concept_id
            , CAST(null as int ) as qualifier_concept_id
            , CAST(null as int ) as unit_concept_id
            , provider_id as site_provider_id
            , visit_occurrence_id as site_visit_occurrence_id
            , visit_detail_id
            , condition_source_value as observation_source_value
            , condition_source_concept_id as observation_source_concept_id
            , CAST(null as string ) as unit_source_value
            , CAST(null as string ) as qualifier_source_value
            , 'CONDITION' as source_domain
            , data_partner_id
            , payload
        FROM {databaseName}.03_condition_occurrence c
        WHERE condition_occurrence_id IS NOT NULL
        And c.target_domain_id = 'Observation'

    ), 

    --procedures2observation
    procedures as (
        SELECT 
            procedure_occurrence_id as site_domain_id
            , 'PROCEDURE_OCCURRENCE_ID:' || procedure_occurrence_id || '|TARGET_CONCEPT_ID:' || COALESCE(target_concept_id, '') as source_pkey
            , person_id as site_person_id
            , COALESCE( target_concept_id, 0) as observation_concept_id
            , procedure_date as observation_date
            , procedure_datetime as observation_datetime
            , procedure_type_concept_id as observation_type_concept_id
            , CAST(null as float) AS value_as_number
            , CAST(null as string) AS value_as_string
            , CAST(null as int) AS value_as_concept_id
            , CAST(null as int) AS qualifier_concept_id
            , CAST(null as int) AS unit_concept_id
            , provider_id as site_provider_id
            , visit_occurrence_id as site_visit_occurrence_id
            , visit_detail_id
            , procedure_source_value as observation_source_value
            , procedure_source_concept_id as observation_source_concept_id
            , CAST( NULL AS string) as unit_source_value
            , CAST( NULL AS string) as qualifier_source_value
            , 'PROCEDURE' as source_domain
            , data_partner_id
            , payload
        FROM {databaseName}.03_procedure_occurrence p
        WHERE procedure_occurrence_id IS NOT NULL
        And p.target_domain_id = 'Observation'
    ),
    --from drug -- drug2obs
    drugexp as (
        SELECT 
            drug_exposure_id as site_domain_id
            , 'DRUG_EXPOSURE_ID:' || drug_exposure_id || '|TARGET_CONCEPT_ID:' || COALESCE(target_concept_id, '') as source_pkey
            , person_id as site_person_id
            , COALESCE( target_concept_id, 0) as observation_concept_id
            , drug_exposure_start_date as observation_date
            , drug_exposure_start_datetime as observation_datetime
            , drug_type_concept_id as observation_type_concept_id
            , CAST(null as float) AS value_as_number
            , CAST(null as string) AS value_as_string
            , CAST(null as int) AS value_as_concept_id
            , CAST(null as int) AS qualifier_concept_id
            , CAST(null as int) AS unit_concept_id
            , provider_id as site_provider_id
            , visit_occurrence_id as site_visit_occurrence_id
            , visit_detail_id
            , drug_source_value as observation_source_value
            , drug_source_concept_id as observation_source_concept_id
            , CAST( dose_unit_source_value AS string) as unit_source_value
            , CAST( NULL AS string) as qualifier_source_value
            , 'Drug' as source_domain
            , data_partner_id
            , payload
        FROM {databaseName}.03_drug_exposure dr
        WHERE drug_exposure_id IS NOT NULL
        And dr.target_domain_id = 'Observation'

    ),
    device as (
        SELECT
        device_exposure_id as site_domain_id
        , 'DEVICE_EXPOSURE_ID:' || device_exposure_id || '|TARGET_CONCEPT_ID:' || COALESCE(target_concept_id, '') as source_pkey
        , person_id as site_person_id
        , COALESCE(target_concept_id, 0) as observation_concept_id 
        , device_exposure_start_date as observation_date
        , device_exposure_start_datetime as observation_datetime
        , device_type_concept_id as observation_type_concept_id
        , CAST(null as float) AS value_as_number
        , CAST(null as string) AS value_as_string
        , CAST(null as int) ASvalue_as_concept_id
        , CAST(null as int) AS qualifier_concept_id
        , CAST(null as int) AS unit_concept_id
        , provider_id as site_provider_id
        , visit_occurrence_id as site_visit_occurrence_id
        , visit_detail_id
        , device_source_value as observation_source_value
        , device_source_concept_id as observation_source_concept_id
        , CAST( NULL AS string) as unit_source_value
        , CAST( NULL AS string) as qualifier_source_value
        ,'DEVICE' as source_domain
        , data_partner_id
        , payload
        from {databaseName}.03_device_exposure d
        where d.device_exposure_id is not null
        and d.target_domain_id = 'Observation'
    ),
    measurement as (
        SELECT
            measurement_id as site_domain_id
            , 'MEASUREMENT_ID:' || measurement_id || '|TARGET_CONCEPT_ID:' || COALESCE(target_concept_id, '') as source_pkey
            , person_id as site_person_id
            , COALESCE( target_concept_id, 0) as observation_concept_id 
            , measurement_date as observation_date
            , measurement_datetime as observation_datetime
            , measurement_type_concept_id as observation_type_concept_id
            , value_as_number as value_as_number
            , CAST(null as string) AS value_as_string
            , value_as_concept_id
            , CAST(null as int) AS qualifier_concept_id
            , unit_concept_id
            , provider_id as site_provider_id
            , visit_occurrence_id as site_visit_occurrence_id
            , visit_detail_id
            , measurement_source_value as observation_source_value
            , measurement_source_concept_id as observation_source_concept_id
            , unit_source_value
            , CAST( NULL AS string) as qualifier_source_value
            ,'MEASUREMENT' as source_domain
            , data_partner_id
            , payload
            from {databaseName}.03_measurement m
            where m.measurement_id is not NULL
            and m.target_domain_id = 'Observation'

    ),

    all_domain as (
        select distinct * from observation
        union
        select distinct * from observation_unmap
        union
        select distinct * from condition
        union 
        select distinct * from procedures
        UNION
        select distinct * from drugexp
        union 
        select distinct * from device
        union
        select distinct * from measurement

    ),

    final_table as (
        select
            *
            , md5( concat_ws( ';'
             , CAST(source_pkey as string)
             , COALESCE( CAST( observation_concept_id as string), ''  )
             , COALESCE( CAST( observation_source_concept_id as string), ''  )
            )) as hashed_id
        from all_domain 
    )

    SELECT 
          * 
        , cast(conv(substr(hashed_id, 1, 15), 16, 10) as bigint) & 2251799813685247 as observation_id_51_bit
    FROM (
        SELECT *
        FROM final_table
    )   
""")

# COMMAND ----------

import sys
sys.path.append("/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
from myproject import timestamp_comment
timestamp_comment.comment(spark,databaseName,'04_observation')
