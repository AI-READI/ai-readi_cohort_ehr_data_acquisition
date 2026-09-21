-- Databricks notebook source
---------------------------
---- macro visit, if the visit starts within a visit of the previous visit, they are collapsed into one macro visit
---- need to build a mapping table of macro-visit groups
-- my notes on the logic - 
-- visits are partitioned by data_partner_id, person_id
-- ordered by visit_start_date, visit_end_date, visit_occurrence_id
-- a new group starts only when visit_start_date > prev_running_end_date
-- therefore overlapping visits, contained visits, and boundary-touching visits stay in the same group
-- For example, the macro visit will collaps all following visits into one macro visit - 
-- Visit A: Jan 1–Jan 5
-- Visit B: Jan 4–Jan 6
-- Visit C: Jan 6–Jan 8
-- Stephanie Hong -documentation for March 20th, 2026 data quality report
---------------------------------------------------------

create or replace table ehr_union_clean.visit_occurrence_macrovisit as 
WITH base AS (
    SELECT
        vo.data_partner_id,
        vo.person_id,
        vo.visit_occurrence_id,
        vo.visit_concept_id,
        vo.visit_start_date,
        COALESCE(vo.visit_end_date, vo.visit_start_date) AS visit_end_date
    FROM ehr_union_clean.visit_occurrence vo
),

ordered AS (
    SELECT
        b.data_partner_id,
        b.person_id,
        b.visit_occurrence_id,
        b.visit_concept_id,
        b.visit_start_date,
        b.visit_end_date,
        MAX(b.visit_end_date) OVER (
            PARTITION BY b.data_partner_id, b.person_id
            ORDER BY b.visit_start_date, b.visit_end_date, b.visit_occurrence_id
            ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
        ) AS prev_running_end_date
    FROM base b
),

flagged AS (
    SELECT
        o.data_partner_id,
        o.person_id,
        o.visit_occurrence_id,
        o.visit_concept_id,
        o.visit_start_date,
        o.visit_end_date,
        o.prev_running_end_date,
        CASE
            WHEN o.prev_running_end_date IS NULL THEN 1
            WHEN o.visit_start_date > o.prev_running_end_date THEN 1
            ELSE 0
        END AS new_visit_group
    FROM ordered o
),

grouped AS (
    SELECT
        f.data_partner_id,
        f.person_id,
        f.visit_occurrence_id,
        f.visit_concept_id,
        f.visit_start_date,
        f.visit_end_date,
        f.prev_running_end_date,
        f.new_visit_group,
        SUM(f.new_visit_group) OVER (
            PARTITION BY f.data_partner_id, f.person_id
            ORDER BY f.visit_start_date, f.visit_end_date, f.visit_occurrence_id
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS collapsed_visit_group
    FROM flagged f
),

map_visit as (
  SELECT
      m.data_partner_id,
      m.person_id,
      m.collapsed_visit_group,
      MIN(m.visit_start_date) AS collapsed_visit_start_date,
      MAX(m.visit_end_date) AS collapsed_visit_end_date,
      COUNT(*) AS source_visit_count
  FROM grouped m
  GROUP BY
      m.data_partner_id,
      m.person_id,
      m.collapsed_visit_group
)
select 
v.*, g.collapsed_visit_group as macrovisit_id ,g.collapsed_visit_group ||'|'|| v.person_id as macrovisit_id_unique, m.collapsed_visit_start_date as macrovisit_start_date, m.collapsed_visit_end_date as macrovisit_end_date
from ehr_union_clean.visit_occurrence v
left join grouped g on g.visit_occurrence_id = v.visit_occurrence_id
left join map_visit m on g.collapsed_visit_group = m.collapsed_visit_group and g.person_id=m.person_id and g.data_partner_id=m.data_partner_id








-- COMMAND ----------

select count(*) from ehr_union_clean.visit_occurrence_macrovisit

-- COMMAND ----------


