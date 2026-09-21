-- Databricks notebook source
create or replace table ehr_union_clean.visit_occurrence as 
WITH all_other AS (
    SELECT visit_occurrence_id FROM ehr_union.condition_occurrence WHERE visit_occurrence_id IS NOT NULL
    UNION ALL
    SELECT visit_occurrence_id FROM ehr_union.device_exposure WHERE visit_occurrence_id IS NOT NULL
    UNION ALL
    SELECT visit_occurrence_id FROM ehr_union.drug_exposure WHERE visit_occurrence_id IS NOT NULL
    UNION ALL
    SELECT visit_occurrence_id FROM ehr_union.measurement WHERE visit_occurrence_id IS NOT NULL
    UNION ALL
    SELECT visit_occurrence_id FROM ehr_union.observation WHERE visit_occurrence_id IS NOT NULL
    UNION ALL
    SELECT visit_occurrence_id FROM ehr_union.procedure_occurrence WHERE visit_occurrence_id IS NOT NULL
)

select v.* from ehr_union.visit_occurrence v
-- left join ehr_dqp.site_id on v.data_partner_id = site_id.data_partner_id
where visit_occurrence_id  in (select distinct visit_occurrence_id from all_other)


-- COMMAND ----------

select count(*) from ehr_union_clean.visit_occurrence

-- COMMAND ----------

select count(*) from ehr_union.visit_occurrence

-- COMMAND ----------

create or replace table ehr_union_clean.person as
WITH all_other AS (
    SELECT person_id FROM ehr_union.condition_occurrence 
    UNION ALL
    SELECT person_id FROM ehr_union.device_exposure 
    UNION ALL
    SELECT person_id FROM ehr_union.drug_exposure 
    UNION ALL
    SELECT person_id FROM ehr_union.measurement 
    UNION ALL
    SELECT person_id FROM ehr_union.observation 
    UNION ALL
    SELECT person_id FROM ehr_union.procedure_occurrence 
    UNION ALL
    SELECT person_id FROM ehr_union.visit_occurrence
)
select * from ehr_union.person where person_id in (select distinct person_id from all_other)

-- COMMAND ----------

SELECT *
FROM ehr_union_clean.person
WHERE year_of_birth IS NOT NULL
  AND (YEAR(CURRENT_DATE()) - year_of_birth) > 90

-- COMMAND ----------

-- If person is over 90, cap birth year so that age is at most 90
UPDATE ehr_union_clean.person
SET year_of_birth = year(current_date()) - 90
WHERE year_of_birth IS NOT NULL
  AND (year(current_date()) - year_of_birth) > 90;


-- COMMAND ----------

SELECT *
FROM ehr_union_clean.person
WHERE year_of_birth IS NOT NULL
  AND (YEAR(CURRENT_DATE()) - year_of_birth) = 90

-- COMMAND ----------

-- Null out HIPAA sensitive columns per OMOP CDM format and list all columns explicitly

create or replace table ehr_union_clean.condition_occurrence as
select
  condition_occurrence_id,
  person_id,
  -- Null out sensitive columns
  provider_id,
  visit_occurrence_id,
  condition_concept_id,
  condition_start_date,
  condition_start_datetime,
  condition_end_date,
  condition_end_datetime,
  condition_type_concept_id,
  stop_reason,
  visit_detail_id,
  condition_status_concept_id,
  condition_status_source_value,
  condition_source_value,
  condition_source_concept_id,
  data_partner_id
from ehr_union.condition_occurrence
where person_id in (select person_id from ehr_union_clean.person);

create or replace table ehr_union_clean.device_exposure as
select
  device_exposure_id,
  person_id,
  provider_id,
  visit_occurrence_id,
  device_concept_id,
  device_exposure_start_date,
  device_exposure_start_datetime,
  device_exposure_end_date,
  device_exposure_end_datetime,
  device_type_concept_id,
  device_source_value,
  device_source_concept_id,
  unique_device_id,
  quantity,
  visit_detail_id,
  data_partner_id
from ehr_union.device_exposure
where person_id in (select person_id from ehr_union_clean.person);

create or replace table ehr_union_clean.drug_exposure as
select
  drug_exposure_id,
  person_id,
  provider_id,
  visit_occurrence_id,
  drug_concept_id,
  drug_exposure_start_date,
  drug_exposure_start_datetime,
  drug_exposure_end_date,
  drug_exposure_end_datetime,
  verbatim_end_date,
  drug_type_concept_id,
  stop_reason,
  refills,
  quantity,
  days_supply,
  sig,
  route_concept_id,
  route_source_value,
  dose_unit_source_value,
  visit_detail_id,
  drug_source_value,
  drug_source_concept_id,
  data_partner_id
from ehr_union.drug_exposure
where person_id in (select person_id from ehr_union_clean.person);

create or replace table ehr_union_clean.measurement as
select
  measurement_id,
  person_id,
  provider_id,
  visit_occurrence_id,
  measurement_concept_id,
  measurement_date,
  measurement_datetime,
  measurement_time,
  measurement_type_concept_id,
  operator_concept_id,
  value_as_number,
  value_as_concept_id,
  unit_concept_id,
  range_low,
  range_high,
  visit_detail_id,
  measurement_source_value,
  measurement_source_concept_id,
  unit_source_value,
  data_partner_id
from ehr_union.measurement
where person_id in (select person_id from ehr_union_clean.person);

create or replace table ehr_union_clean.observation as
select
  observation_id,
  person_id,
  provider_id,
  visit_occurrence_id,
  observation_concept_id,
  observation_date,
  observation_datetime,
  observation_type_concept_id,
  value_as_number,
  value_as_string,
  value_as_concept_id,
  qualifier_concept_id,
  unit_concept_id,
  visit_detail_id,
  observation_source_value,
  observation_source_concept_id,
  unit_source_value,
  qualifier_source_value,
  data_partner_id
from ehr_union.observation
where person_id in (select person_id from ehr_union_clean.person);

create or replace table ehr_union_clean.procedure_occurrence as
select
  procedure_occurrence_id,
  person_id,
  provider_id,
  visit_occurrence_id,
  procedure_concept_id,
  procedure_date,
  procedure_datetime,
  procedure_type_concept_id,
  modifier_concept_id,
  quantity,
  visit_detail_id,
  procedure_source_value,
  procedure_source_concept_id,
  modifier_source_value,
  data_partner_id
from ehr_union.procedure_occurrence
where person_id in (select person_id from ehr_union_clean.person);

create or replace table ehr_union_clean.visit_occurrence as
select
  visit_occurrence_id,
  person_id,
  provider_id,
  visit_start_date,
  visit_start_datetime,
  visit_end_date,
  visit_end_datetime,
  visit_concept_id,
  visit_type_concept_id,
  visit_source_value,
  visit_source_concept_id,
  admitting_source_concept_id,
  admitting_source_value,
  discharge_to_concept_id,
  discharge_to_source_value,
  preceding_visit_occurrence_id,
  data_partner_id
from ehr_union.visit_occurrence
where person_id in (select person_id from ehr_union_clean.person);

-- COMMAND ----------

-- Null out HIPAA sensitive columns per OMOP CDM format and list all columns explicitly
-- Non-clinical table: person

create or replace table ehr_union_clean.person as
select
  person_id,
  -- Null out sensitive columns
  year_of_birth,
  null as month_of_birth,
  null as day_of_birth,
  null as birth_datetime,
  gender_concept_id,
  gender_source_value,
  gender_source_concept_id,
  race_concept_id,
  race_source_value,
  race_source_concept_id,
  ethnicity_concept_id,
  ethnicity_source_value,
  ethnicity_source_concept_id,
  location_id,
  care_site_id,
  provider_id,
  data_partner_id
from ehr_union_clean.person
where person_id in (select person_id from ehr_union_clean.person);

-- Non-clinical table: death

create or replace table ehr_union_clean.death as
select
  person_id,
  null as death_date,
  null as death_datetime,
  death_type_concept_id,
  cause_concept_id,
  cause_source_value,
  cause_source_concept_id,
  data_partner_id
from ehr_union.death
where person_id in (select person_id from ehr_union_clean.person);

-- Non-clinical table: payer_plan_period

-- Non-clinical table: care_site

create or replace table ehr_union_clean.care_site as
select
  care_site_id,
  care_site_name,
  care_site_source_value,
  place_of_service_concept_id,
  place_of_service_source_value,
  data_partner_id
from ehr_union.care_site;

-- Non-clinical table: provider

create or replace table ehr_union_clean.provider as
select
  provider_id,
  null as provider_name,
  null as npi,
  null as dea,
  null as provider_source_value,
  null as specialty_source_value,
  specialty_concept_id,
  specialty_source_concept_id,
  care_site_id,
  null as year_of_birth,
  null as gender_concept_id,
  data_partner_id
from ehr_union.provider;
