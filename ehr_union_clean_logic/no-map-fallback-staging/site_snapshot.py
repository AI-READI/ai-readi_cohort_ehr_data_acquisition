"""
Site snapshot -- runs FIRST in step 03, before perform_standard_mapping().

Saves what the site sent, before any mapping, rescue or fallback changes it, to
<site>_ingestion.03_snapshot_<domain> (one table per domain, overwritten on each run).

Columns:
  data_partner_id         the site
  site_table              the table the site sent the row in (e.g. condition_occurrence)
  site_domain_id          the site's primary key for the row (e.g. condition_occurrence_id);
                          the same value step 04 writes as site_domain_id
  site_person_id          the site's person_id
  site_concept_id         <domain>_concept_id as sent
  site_source_concept_id  <domain>_source_concept_id as sent
  site_source_value       <domain>_source_value as sent (the site's source code)
  snapshot_ts             when the snapshot was taken

Link to later steps on (data_partner_id, site_table, site_domain_id). Step 04 keeps site_domain_id and writes
the site table, upper case, as source_domain; both are carried to 06_<domain>, which has the final <domain>_id.

The snapshot holds raw site codes. It stays in the site ingestion schema and is not delivered
(step 13 exports only ehr_union_clean). Do not commit its contents or counts to the repository.
-- Stephanie Hong, November 2026
"""

from pyspark.sql import functions as F

SNAPSHOT_PREFIX = "03_snapshot_"


def _col_or_null(df, name):
    """The column, matched case-insensitively (step 02 writes DATA_PARTNER_ID in upper case), else NULL."""
    cols = {c.lower(): c for c in df.columns}
    return F.col(cols[name.lower()]) if name.lower() in cols else F.lit(None)


def snapshot_columns(df, domain, concept_col):
    """The snapshot as a DataFrame (no write). Same row count as df."""
    prefix = concept_col.replace("_concept_id", "")          # condition, drug, visit, ...
    return df.select(
        _col_or_null(df, "data_partner_id").alias("data_partner_id"),
        F.lit(domain).alias("site_table"),
        _col_or_null(df, f"{domain}_id").alias("site_domain_id"),
        _col_or_null(df, "person_id").alias("site_person_id"),
        _col_or_null(df, concept_col).alias("site_concept_id"),
        _col_or_null(df, f"{prefix}_source_concept_id").alias("site_source_concept_id"),
        _col_or_null(df, f"{prefix}_source_value").alias("site_source_value"),
        F.current_timestamp().alias("snapshot_ts"),
    )


def write_site_snapshot(spark, df, dbname, domain, concept_col):
    """Write <dbname>.03_snapshot_<domain> from the 02 data, before any step 03 change. Returns the row count."""
    snap = snapshot_columns(df, domain, concept_col)
    (snap.write.format("delta")
         .mode("overwrite")
         .option("overwriteSchema", "true")
         .saveAsTable(f"{dbname}.{SNAPSHOT_PREFIX}{domain}"))
    n = spark.table(f"{dbname}.{SNAPSHOT_PREFIX}{domain}").count()
    if n != df.count():
        raise ValueError(f"Site snapshot of {domain} has {n} rows, expected {df.count()}")
    return n
