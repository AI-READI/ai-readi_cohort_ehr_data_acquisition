-- Databricks notebook source
-- Unit inference, Part 0: the AI-READI REDCap list, loaded for the EHR data.
--
-- Run first, before A. Reads three files from AI-READI/DataElementMaps
-- (main) on GitHub and writes five tables in
-- hive_metastore.ehr_union_clean_metrics; nothing else is read or changed
-- apart from omop_vocab.concept (read). Part D uses the result to flag
-- implausible values (value_plausibility) and E reviews it.
--   redcap_value_set_mapping  _ai_readi_redcap_value_set_mapping_common.csv
--   redcap_unit_lookup        scripts/unit_concept_lookup_extended.csv
--   redcap_value_limits       section U8 of scripts/09_validate_units_and_value_ranges.sql
--   redcap_sources            what was fetched, when, and its sha256
--   redcap_list_tests         the three joined: one row per OMOP concept
-- The files are written for the survey data and keyed by REDCap field
-- name; the EHR data is keyed by concept, so 0b joins them on field and
-- keeps the concept. Review 0d shows the result.

-- COMMAND ----------

-- MAGIC %python
-- MAGIC # 0a. Load the files from DataElementMaps (main) on every run, so they are
-- MAGIC #     never a stale copy. Needs the cluster to reach raw.githubusercontent.com.
-- MAGIC #     The CSVs are stored as they are, every column a string, with column
-- MAGIC #     names lowercased (FIELD_ID -> field_id). 09's limits are read out of
-- MAGIC #     the script's VALUES list, in the list's unit, per REDCap field; the
-- MAGIC #     cell fails if that layout changes.
-- MAGIC import csv, hashlib, io, re, urllib.request
-- MAGIC from datetime import datetime, timezone
-- MAGIC
-- MAGIC BASE = 'https://raw.githubusercontent.com/AI-READI/DataElementMaps/main/redCapDataDictionaryWithExtension/value-set-mapping-common/'
-- MAGIC SCHEMA = 'hive_metastore.ehr_union_clean_metrics'
-- MAGIC fetched_at = datetime.now(timezone.utc).isoformat(timespec='seconds')
-- MAGIC sources = []
-- MAGIC
-- MAGIC def fetch(path):
-- MAGIC     text = urllib.request.urlopen(BASE + path, timeout=60).read().decode('utf-8-sig')
-- MAGIC     sources.append((path, BASE + path, fetched_at, hashlib.sha256(text.encode()).hexdigest()))
-- MAGIC     return text
-- MAGIC
-- MAGIC def save(name, schema, rows):
-- MAGIC     (spark.createDataFrame(rows, schema).write.mode('overwrite')
-- MAGIC      .option('overwriteSchema', 'true').saveAsTable(f'{SCHEMA}.{name}'))
-- MAGIC
-- MAGIC def save_csv(name, path):
-- MAGIC     reader = csv.reader(io.StringIO(fetch(path)))
-- MAGIC     cols = [re.sub(r'\W', '_', c.strip()).lower() for c in next(reader)]
-- MAGIC     rows = [[(v.strip() or None) for v in (r + [''] * len(cols))[:len(cols)]]
-- MAGIC             for r in reader if any(v.strip() for v in r)]
-- MAGIC     save(name, ', '.join(f'`{c}` string' for c in cols), rows)
-- MAGIC
-- MAGIC save_csv('redcap_value_set_mapping', '_ai_readi_redcap_value_set_mapping_common.csv')
-- MAGIC save_csv('redcap_unit_lookup', 'scripts/unit_concept_lookup_extended.csv')
-- MAGIC
-- MAGIC script = fetch('scripts/09_validate_units_and_value_ranges.sql')
-- MAGIC block = re.search(r'VIEW ranges AS(.*?)AS r\(field, imp_lo, imp_hi, ext_lo, ext_hi\)', script, re.S)
-- MAGIC num = r'\s*(-?[0-9.]+)\s*'
-- MAGIC row = r"\(\s*'([^']+)'\s*," + ','.join([num] * 4) + r'\)'
-- MAGIC limits = [(f, *map(float, v)) for f, *v in re.findall(row, block.group(1))] if block else []
-- MAGIC if len(limits) < 50 or len({l[0] for l in limits}) != len(limits):
-- MAGIC     raise ValueError(f'09 U8 limits not read as expected ({len(limits)} rows): check the script layout')
-- MAGIC save('redcap_value_limits', 'field string, imp_lo double, imp_hi double, ext_lo double, ext_hi double', limits)
-- MAGIC
-- MAGIC save('redcap_sources', 'file string, url string, fetched_at string, sha256 string', sources)
-- MAGIC display(spark.sql(f'''
-- MAGIC   SELECT 'redcap_value_set_mapping' AS tbl, COUNT(*) AS n FROM {SCHEMA}.redcap_value_set_mapping
-- MAGIC   UNION ALL SELECT 'redcap_unit_lookup', COUNT(*) FROM {SCHEMA}.redcap_unit_lookup
-- MAGIC   UNION ALL SELECT 'redcap_value_limits', COUNT(*) FROM {SCHEMA}.redcap_value_limits'''))

-- COMMAND ----------

-- Check: 0c, in E_gate_checks.sql.
-- Review: 0d, in E_review_outputs.sql.

-- 0b. The list per OMOP concept: one row for every standard concept the
--     mapping puts in the Measurement domain (the AI-READI custom concepts,
--     2005200xxx, aren't in omop_vocab and never appear in EHR data). The
--     REDCap files are keyed by field name; this joins them on it:
--       mapped_fields  the mapping's FIELD_ID for the concept (empty for the
--                      lab_results items)
--       list_unit_*    the lookup's unit for the concept's fields
--       imp_*, ext_*   09's limits for those fields, in the list's unit.
--                      imp: outside = implausible (almost certainly an
--                      error); ext: outside = clinically extreme (counted
--                      only; EHR patients are sicker than survey ones).
--     The list's unit only matters for converting the limits; canonical
--     units stay UCUM (mmol/L, not the list's mEq/L).
CREATE OR REPLACE TABLE hive_metastore.ehr_union_clean_metrics.redcap_list_tests AS
WITH listed AS (
  SELECT try_cast(target_concept_id AS BIGINT) AS concept_id,
         array_join(sort_array(collect_set(field_id)), ', ') AS mapped_fields
  FROM hive_metastore.ehr_union_clean_metrics.redcap_value_set_mapping
  WHERE target_domain_id = 'Measurement'
  GROUP BY 1
),
lookup AS (
  SELECT try_cast(target_concept_id AS BIGINT) AS concept_id,
         array_join(sort_array(collect_set(lookup_key)), ', ') AS lookup_fields,
         COUNT(DISTINCT unit_concept_id) AS n_units,
         max(try_cast(unit_concept_id AS BIGINT)) AS list_unit_concept_id
  FROM hive_metastore.ehr_union_clean_metrics.redcap_unit_lookup
  GROUP BY 1
),
lim AS (
  SELECT try_cast(u.target_concept_id AS BIGINT) AS concept_id,
         array_join(sort_array(collect_set(r.field)), ', ') AS limit_fields,
         COUNT(DISTINCT r.imp_lo, r.imp_hi, r.ext_lo, r.ext_hi) AS n_limit_sets,
         min(r.imp_lo) AS imp_lo, max(r.imp_hi) AS imp_hi,
         min(r.ext_lo) AS ext_lo, max(r.ext_hi) AS ext_hi
  FROM hive_metastore.ehr_union_clean_metrics.redcap_value_limits r
  JOIN hive_metastore.ehr_union_clean_metrics.redcap_unit_lookup u ON u.lookup_key = r.field
  GROUP BY 1
)
SELECT l.concept_id, c.concept_name, l.mapped_fields, k.lookup_fields,
       k.list_unit_concept_id, uc.concept_code AS list_unit_code, uc.vocabulary_id AS list_unit_vocabulary,
       k.n_units, m.limit_fields, m.n_limit_sets,
       m.imp_lo, m.imp_hi, m.ext_lo, m.ext_hi
FROM listed l
JOIN omop_vocab.concept c ON c.concept_id = l.concept_id
LEFT JOIN lookup k ON k.concept_id = l.concept_id
LEFT JOIN lim m    ON m.concept_id = l.concept_id
LEFT JOIN omop_vocab.concept uc ON uc.concept_id = k.list_unit_concept_id;
