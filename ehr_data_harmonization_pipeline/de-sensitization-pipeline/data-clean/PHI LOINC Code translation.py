# Databricks notebook source
## ai-readi ehr data ingestion and harmonzation
##-- Any PHI present in thE data must be removed.
##-- translate PHI LOINC codes to OMOP concept ids, 
##-- if the concept id is found in the respective domain then remove it from the data for the level 2 dataset
##-- used for data cleaning step 
spark.sql("""
    CREATE OR REPLACE TABLE omop_vocab_extra.phi_loinc_code_map AS 
    WITH source_concept_map AS (
    SELECT phi_loinc.source_value as source_code_value,
    'LOINC' AS source_code_type, 
    'LOINC' AS source_vocab_code,
    c.concept_code AS source_code, 
    COALESCE(c.concept_id, 0) AS source_concept_id, 
    c.concept_name AS source_concept_name,
    c.vocabulary_id AS source_vocabulary_id,
    c.domain_id AS source_domain_id,
    c.concept_class_id AS source_concept_class_id,
    c.standard_concept AS source_standard_concept,
    c.valid_start_date AS source_valid_start_date,
    c.valid_end_date AS source_valid_end_date,
    c.invalid_reason AS source_invalid_reason
    FROM  omop_vocab_extra.n3c_loinc_code_list_base phi_loinc
    LEFT JOIN omop_vocab.concept c 
        on phi_loinc.source_value = c.concept_code 
        AND upper(c.vocabulary_id) = 'LOINC' 
        AND c.concept_class_id !='ICD10PCS Hierarchy' --'ICD10PCS Hierarchy'
    WHERE phi_loinc.removal_reason = 'Yes' -- 252 rows
    ),
    -- TARGET concept mapping
    target_concept_map as (
        SELECT DISTINCT
            source_concept_map.*
            , COALESCE(c2.concept_id, 0)     AS target_concept_id
            , COALESCE(
                c2.concept_name,
                'No matching concept')       AS target_concept_name
            , c2.vocabulary_id               AS target_vocabulary_id
            , COALESCE(
                c2.domain_id,
                'Observation')               AS target_domain_id
            , c2.concept_class_id            AS target_concept_class_id
            , c2.valid_start_date            AS target_valid_start_date
            , c2.valid_end_date              AS target_valid_end_date
            , c2.invalid_reason              AS target_invalid_reason
        FROM source_concept_map
        LEFT JOIN omop_vocab.concept_relationship cr 
            ON source_concept_map.source_concept_id = cr.concept_id_1
            AND cr.invalid_reason IS NULL 
            AND lower(cr.relationship_id) = 'maps to'
        LEFT JOIN omop_vocab.concept c2
            ON cr.concept_id_2 = c2.concept_id
            AND c2.invalid_reason IS NULL -- invalid records will map to concept_id = 0
    )
    SELECT * FROM target_concept_map
    WHERE target_concept_id != 0
""")


# COMMAND ----------

# MAGIC %sql
# MAGIC -- 184 rows
# MAGIC SELECT DISTINCT * FROM omop_vocab_extra.phi_loinc_code_map 

# COMMAND ----------

# MAGIC %sql
# MAGIC create or replace table omop_vocab_extra.loinc_codes_to_remove_new as
# MAGIC SELECT 
# MAGIC target_domain_id as domains,
# MAGIC '_concept_id' as col_name,
# MAGIC target_concept_id as value,
# MAGIC target_concept_name as meaning,
# MAGIC 'PHI_LOINC_CONCEPT_ID' as removal_reason
# MAGIC FROM omop_vocab_extra.phi_loinc_code_map

# COMMAND ----------


