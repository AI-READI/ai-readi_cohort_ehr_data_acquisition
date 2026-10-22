-- Databricks notebook source
DROP SCHEMA IF EXISTS ehr_union_clean CASCADE;

-- COMMAND ----------

CREATE DATABASE IF NOT EXISTS ehr_union_clean

-- COMMAND ----------

CREATE OR REPLACE TABLE ehr_union_clean.death DEEP CLONE ehr_union.death;

-- COMMAND ----------

CREATE OR REPLACE TABLE ehr_union_clean.condition_occurrence DEEP CLONE ehr_union.condition_occurrence;


-- COMMAND ----------

CREATE OR REPLACE TABLE ehr_union_clean.drug_exposure DEEP CLONE ehr_union.drug_exposure;


-- COMMAND ----------

CREATE OR REPLACE TABLE ehr_union_clean.procedure_occurrence DEEP CLONE ehr_union.procedure_occurrence;


-- COMMAND ----------

CREATE OR REPLACE TABLE ehr_union_clean.device_exposure DEEP CLONE ehr_union.device_exposure;


-- COMMAND ----------

CREATE OR REPLACE TABLE ehr_union_clean.measurement DEEP CLONE ehr_union.measurement;


-- COMMAND ----------

CREATE OR REPLACE TABLE ehr_union_clean.observation DEEP CLONE ehr_union.observation;


-- COMMAND ----------

CREATE OR REPLACE TABLE ehr_union_clean.location DEEP CLONE ehr_union.location;


-- COMMAND ----------

CREATE OR REPLACE TABLE ehr_union_clean.care_site DEEP CLONE ehr_union.care_site;


-- COMMAND ----------

CREATE OR REPLACE TABLE ehr_union_clean.provider DEEP CLONE ehr_union.provider;


-- COMMAND ----------


