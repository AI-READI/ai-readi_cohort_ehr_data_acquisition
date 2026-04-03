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

# Create 
spark.sql(f"""
    CREATE OR REPLACE TABLE {databaseName}.03_5_visit_occurrence AS          
      SELECT  
        visit_occurrence_id
        ,person_id
        ,visit_concept_id
        , visit_type_concept_id
        , care_site_id 
        , visit_source_value
        , visit_source_concept_id
        , admitting_source_concept_id
        , admitting_source_value
        , discharge_to_concept_id
        , discharge_to_source_value
        , preceding_visit_occurrence_id 
        , data_partner_id
        , payload
        , target_concept_id
        , target_domain_id
        , max(provider_id) as provider_id
        , min(visit_start_date) as visit_start_date
        , min(visit_start_datetime) as visit_start_datetime
        , min(visit_end_date) as visit_end_date
        , min(visit_end_datetime) as visit_end_datetime
        , count(*) as dup_visit_count  
        , array_agg(provider_id) as all_provider_ids
        , array_agg(visit_start_datetime) as all_start_datetime
        , array_agg(visit_end_datetime) as all_end_datetime
      FROM (select * from {databaseName}.03_visit_occurrence order by provider_id, visit_start_datetime, visit_end_datetime) t
      GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
""")

# COMMAND ----------

spark.sql(f"""
CREATE OR REPLACE TABLE {databaseName}.04_visit_occurrence AS
      
    with visit as (
        SELECT
            visit_occurrence_id as site_visit_occurrence_id
            ,'VISIT_OCCURRENCE_ID:' || CAST(visit_occurrence_id AS STRING) || 
             'PROVIDER_ID:' || COALESCE(CAST(provider_id AS STRING), '') || 
             'VISIT_START_DATETIME' || COALESCE(CAST(visit_start_datetime AS STRING), '') || 
             'VISIT_END_DATETIME' || COALESCE(CAST(visit_end_datetime AS STRING), '') as source_pkey
            , person_id as site_person_id
            , COALESCE(target_concept_id, 0 ) as visit_concept_id
            , visit_start_date
            , visit_start_datetime
            , visit_end_date
            , visit_end_datetime
            , visit_type_concept_id
            , provider_id as site_provider_id
            , care_site_id as site_care_site_id
            , visit_source_value
            , visit_source_concept_id
            , admitting_source_concept_id
            , admitting_source_value
            , discharge_to_concept_id
            , discharge_to_source_value
            , preceding_visit_occurrence_id as site_preceding_visit_occurrence_id
            , data_partner_id
            , payload
            ,'Visit' as source_domain
            , dup_visit_count
            , all_provider_ids
            , all_start_datetime
            , all_end_datetime
        FROM {databaseName}.03_5_visit_occurrence
        WHERE visit_occurrence_id IS NOT NULL
        and target_concept_id is not null
        -- Retain all records from the source table, unless we're already mapping them to another domain
        -- ie: If there are rows with domain_id == ('Observation'), do not include them in this table, condition contained target domain id in ( condition, observation, null )
        AND target_domain_id NOT IN ('Device', 'Observation', 'Measurement','Procedure','Drug','Condition') 
    ), visit_null as (
        -- keep the unmapp concepts
        SELECT
            visit_occurrence_id as site_visit_occurrence_id
            ,'VISIT_OCCURRENCE_ID:' || CAST(visit_occurrence_id AS STRING) || 
             'PROVIDER_ID:' || COALESCE(CAST(provider_id AS STRING), '') || 
             'VISIT_START_DATETIME' || COALESCE(CAST(visit_start_datetime AS STRING), '') || 
             'VISIT_END_DATETIME' || COALESCE(CAST(visit_end_datetime AS STRING), '') as source_pkey
            , person_id as site_person_id
            , visit_concept_id
            , visit_start_date
            , visit_start_datetime
            , visit_end_date
            , visit_end_datetime
            , visit_type_concept_id
            , provider_id as site_provider_id
            , care_site_id as site_care_site_id
            , visit_source_value
            , visit_source_concept_id
            , admitting_source_concept_id
            , admitting_source_value
            , discharge_to_concept_id
            , discharge_to_source_value
            , preceding_visit_occurrence_id as site_preceding_visit_occurrence_id
            , data_partner_id
            , payload
            ,'Visit' as source_domain
            , null as dup_visit_count
            , null as all_provider_ids
            , null as all_start_datetime
            , null as all_end_datetime            
        FROM {databaseName}.03_visit_occurrence
        WHERE visit_occurrence_id IS NOT NULL
        and target_concept_id is null


    ), procedure as (
        SELECT
            procedure_occurrence_id as site_visit_occurrence_id
            , 'PROCEDURE_OCCURRENCE_ID:' || CAST(procedure_occurrence_id AS STRING) || 
              'TARGET_CONCEPT_ID:' || COALESCE(CAST(target_concept_id AS STRING), '') || 
              'PROVIDER_ID:' || COALESCE(CAST(provider_id AS STRING), '') || 
              'VISIT_START_DATETIME' || COALESCE(CAST(procedure_datetime AS STRING), '') || 
              'VISIT_END_DATETIME' || COALESCE(CAST(procedure_datetime AS STRING), '') as source_pkey
            , person_id as site_person_id
            , COALESCE(target_concept_id, 0) as visit_concept_id
            , procedure_date as visit_start_date
            , procedure_datetime as visit_start_datetime
            , procedure_date as visit_end_date
            , procedure_datetime as visit_end_datetime
            , procedure_type_concept_id as visit_type_concept_id
            , provider_id as site_provider_id
            ,cast ( null as long) as site_care_site_id
            , procedure_source_value as visit_source_value
            , procedure_source_concept_id as visit_source_concept_id
            , cast( null as int) as admitting_source_concept_id
            , cast( null as string) as admitting_source_value
            , cast( null as int) as discharge_to_concept_id
            , cast( null as string) as discharge_to_source_value
            ,cast(null as long) as site_preceding_visit_occurrence_id
            , data_partner_id
            , payload
            , 'PROCEDURE' as source_domain
            , null as dup_visit_count
            , null as all_provider_ids
            , null as all_start_datetime
            , null as all_end_datetime                   
        FROM {databaseName}.03_procedure_occurrence p
        WHERE procedure_occurrence_id IS NOT NULL
        and p.target_domain_id = 'Visit' and p.target_standard_concept = 'S'

    ),
    observation as (
        SELECT
              observation_id as site_visit_occurrence_id
            , 'OBSERVATION_ID:' || CAST(observation_id AS STRING) || 
              'TARGET_CONCEPT_ID:' || COALESCE(CAST(target_concept_id AS STRING), '') || 
              'PROVIDER_ID:' || COALESCE(CAST(provider_id AS STRING), '') || 
              'VISIT_START_DATETIME' || COALESCE(CAST(observation_datetime AS STRING), '') || 
              'VISIT_END_DATETIME' || COALESCE(CAST(observation_datetime AS STRING), '') as source_pkey
            , person_id as site_person_id
            , COALESCE(target_concept_id, 0) as visit_concept_id
            , observation_date as visit_start_date
            , observation_datetime as visit_start_datetime
            , observation_date as visit_end_date
            , observation_datetime as visit_end_datetime
            , observation_type_concept_id as visit_type_concept_id
            , provider_id as site_provider_id
            ,cast ( null as long) as site_care_site_id
            , observation_source_value as visit_source_value
            , observation_source_concept_id as visit_source_concept_id
            , cast( null as int) as admitting_source_concept_id
            , cast( null as string) as admitting_source_value
            , cast( null as int) as discharge_to_concept_id
            , cast( null as string) as discharge_to_source_value
            ,cast(null as long) as site_preceding_visit_occurrence_id
            , data_partner_id
            , payload
            , 'OBSERVATION' as source_domain
            , null as dup_visit_count
            , null as all_provider_ids
            , null as all_start_datetime
            , null as all_end_datetime       
        FROM {databaseName}.03_observation o
        WHERE observation_id IS NOT NULL
        and o.target_domain_id = 'Visit' and o.target_standard_concept = 'S'
    ),

    drug as (
        SELECT
             drug_exposure_id as site_visit_occurrence_id
            , 'DRUG_EXPOSURE_ID:' || CAST(drug_exposure_id AS STRING) || 
              'TARGET_CONCEPT_ID:' || COALESCE(CAST(target_concept_id AS STRING), '') || 
              'PROVIDER_ID:' || COALESCE(CAST(provider_id AS STRING), '') || 
              'VISIT_START_DATETIME' || COALESCE(CAST(drug_exposure_start_datetime AS STRING), '') || 
              'VISIT_END_DATETIME' || COALESCE(CAST(drug_exposure_end_datetime AS STRING), '') as source_pkey
            , person_id as site_person_id
            , COALESCE(target_concept_id, 0) as visit_concept_id
            , drug_exposure_start_date as visit_start_date
            , drug_exposure_start_datetime as visit_start_datetime
            , drug_exposure_end_date as visit_end_date
            , drug_exposure_end_datetime as visit_end_datetime
            , drug_type_concept_id as visit_type_concept_id
            , provider_id as site_provider_id
            ,cast ( null as long) as site_care_site_id
            , drug_source_value as visit_source_value
            , drug_source_concept_id as visit_source_concept_id
            , cast( null as int) as admitting_source_concept_id
            , cast( null as string) as admitting_source_value
            , cast( null as int) as discharge_to_concept_id
            , cast( null as string) as discharge_to_source_value
            ,cast(null as long) as site_preceding_visit_occurrence_id
            , data_partner_id
            , payload
            , 'DRUG' as source_domain
            , null as dup_visit_count
            , null as all_provider_ids
            , null as all_start_datetime
            , null as all_end_datetime       
        FROM {databaseName}.03_drug_exposure d
        WHERE drug_exposure_id IS NOT NULL
        and d.target_domain_id = 'Visit' and d.target_standard_concept = 'S'
    ),
    visit_combine as (
        select * from visit union ALL
        select * from visit_null
    ),
    all_domain as (
        select *,md5(CAST(source_pkey as string)) as hashed_id from visit_combine
        union all 
        select *
         , md5(
             concat_ws( ';'
            , CAST(source_pkey as string)
             , COALESCE( CAST( visit_concept_id as string), ''  )
             , COALESCE( CAST( visit_source_concept_id as string), ''  )
             , COALESCE( source_domain, ''  )
         )) as hashed_id
         from (
             select * from procedure
             union all 
             select * from observation
             union all
             select * from drug
             
  
         )
    )

    SELECT 
          * 
        , cast(conv(substr(hashed_id, 1, 15), 16, 10) as bigint) & 2251799813685247 as visit_occurrence_id_51_bit
    FROM (
        all_domain
    )   
""")

# COMMAND ----------

# MAGIC %md
# MAGIC Clean table for:
# MAGIC 1. Same person, provider, date, visit_occurrence_id but different admitting source value
# MAGIC 2. Same person, provider, date, visit_occurrence_id but different admitting source value and visit end date -> this make joining with other tables impossible

# COMMAND ----------

if databaseName == 'UAB_ingestion':
    print("Create dropped table")
    spark.sql(f"""
    CREATE OR REPLACE TABLE {databaseName}.04_5_visit_occurrence_dropped AS          
    WITH a AS (
        SELECT
            person_id,
            visit_start_date,
            visit_end_date,
            visit_type_concept_id,
            visit_source_value,
            visit_source_concept_id,
            visit_end_datetime,
            visit_start_datetime,
            visit_concept_id,
            visit_occurrence_id,
            'same date different admitting source' as removal_reason
        FROM
            uab_ingestion.`01_visit_occurrence`
        GROUP BY
            person_id,
            visit_start_date,
            visit_end_date,
            visit_type_concept_id,
            visit_source_value,
            visit_source_concept_id,
            visit_end_datetime,
            visit_start_datetime,
            visit_concept_id,
            visit_occurrence_id
        HAVING
            -- This ensures we only keep groups where admitting_source_value is NOT the same
            COUNT(DISTINCT admitting_source_value) > 1
    ), b AS (
        SELECT         
            person_id,
            visit_start_date,
            visit_end_date,
            visit_type_concept_id,
            visit_source_value,
            visit_source_concept_id,
            visit_end_datetime,
            visit_start_datetime,
            visit_concept_id,
            visit_occurrence_id,
            'different end date and admitting source' as removal_reason
            from uab_ingestion.`01_visit_occurrence` where VISIT_OCCURRENCE_ID in (
        SELECT
            visit_occurrence_id
            FROM
                uab_ingestion.`01_visit_occurrence`
            GROUP BY
                person_id,
                visit_start_date,
                visit_type_concept_id,
                visit_source_value,
                visit_source_concept_id,
                visit_start_datetime,
                visit_concept_id,
                visit_occurrence_id,
                'different end date and admitting source'
            HAVING
                -- This ensures we only keep groups where admitting_source_value is NOT the same
                COUNT(DISTINCT admitting_source_value) > 1
        )
    )

    SELECT * FROM a 
    UNION ALL
    SELECT * FROM b
    """)

    print("Manually drop the rows")
    spark.sql(f"""
    CREATE OR REPLACE TABLE {databaseName}.04_visit_occurrence AS
    SELECT * 
    FROM {databaseName}.04_visit_occurrence
    WHERE site_visit_occurrence_id NOT IN (
        SELECT visit_occurrence_id FROM {databaseName}.04_5_visit_occurrence_dropped
        )"""
    )


# COMMAND ----------

import sys
sys.path.append("/Workspace/Shared/ai-readi-ehr-omop-pipeline/logic/")
from myproject import timestamp_comment
timestamp_comment.comment(spark,databaseName,'04_visit_occurrence')

# COMMAND ----------



# COMMAND ----------


