# Databricks notebook source
# MAGIC %sql
# MAGIC SELECT 
# MAGIC array(target_domain_id) as domains,
# MAGIC '_concept_id' as col_name,
# MAGIC target_concept_id as value,
# MAGIC target_concept_name as meaning,
# MAGIC 'PHI_LOINC_CONCEPT_ID' as removal_reason
# MAGIC FROM ehr_union.phi_loinc_code_map
