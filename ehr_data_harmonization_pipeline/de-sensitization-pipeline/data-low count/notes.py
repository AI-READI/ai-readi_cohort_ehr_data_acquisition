# Databricks notebook source
# Aggregate 
# referece database: ucsd_staging for now. It will be ehr_union after UAB submit the new file.
# if the count is less than 5, remove the records. <- Handle the rare condition

# We may also have to do the following: 
# any race value with  American Indian (AI) or Alaska Native (AN) in the EMR have had their race changed to "OTHER" 
# and  we should replace race_source_value with "Other" and race_source_concept_id with 0. 
 
# # if zip ( first 3 zip codes are in ) in restricted zip codes then overwrite with 000 
# restricted_zips = ["036", "059", "102", "203", "556", "692", "821", "823", "878", "879", "884", "893", "205", "369"] 
 
 
