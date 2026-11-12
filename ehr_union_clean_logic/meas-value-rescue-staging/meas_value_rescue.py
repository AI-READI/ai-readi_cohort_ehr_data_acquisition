"""
Meas Value target rescue -- runs in step 03 right after perform_standard_mapping().

perform_standard_mapping() sets target_concept_id / target_domain_id from the 'Maps to' relationship.
Some site concepts map (to themselves) into the Meas Value domain. Meas Value concepts are answers, not
events, so step 04 has no table to route them to and they fail the domain conformance check.

For rows whose target_domain_id = 'Meas Value', this module looks the target up in the Meas Value
rescue crosswalk (meas_value_rescue_crosswalk.csv) and overwrites the target_* columns:
  * crosswalk target <> 0 -> target_concept_id = that concept, target_domain_id = its vocabulary domain;
                              step 04 then routes the row (e.g. observation -> measurement)
  * crosswalk target = 0    -> target_concept_id = 0, target_domain_id = NULL;
                              step 04 keeps the row in the table the site sent it to, with concept 0
  * no crosswalk entry      -> row unchanged (listed by unmatched_meas_value); e.g. Lens / Lead / Graft
                              device copies are left for ehr_union_clean_logic/ehr_osm_device_name_fix_*
It also applies the crosswalk's value and unit fixes (parse value_as_string into value_as_number,
set unit_concept_id / unit_source_value) and keeps the original concept in the *_source_concept_id column.

Audit columns added to the 03 table: meas_value_xwalk_id, meas_value_original_target_concept_id.
See 03-prepared/meas_value_rescue_README.md.
-- Stephanie Hong, November 2026
"""

from pyspark.sql import functions as F, types as T

CROSSWALK_SCHEMA = T.StructType([
    T.StructField("xwalk_id", T.IntegerType()),
    T.StructField("source_table", T.StringType()),
    T.StructField("source_concept_id", T.LongType()),
    T.StructField("source_concept_name", T.StringType()),
    T.StructField("value_regex", T.StringType()),
    T.StructField("target_concept_id", T.LongType()),
    T.StructField("target_concept_name", T.StringType()),
    T.StructField("resolved_target_domain_id", T.StringType()),
    T.StructField("target_unit_concept_id", T.LongType()),
    T.StructField("target_unit_source_value", T.StringType()),
    T.StructField("parse_number_regex", T.StringType()),
    T.StructField("expected_rows", T.IntegerType()),
    T.StructField("note", T.StringType()),
])

# per table: the column holding the site's source concept, and whether it has value/unit columns
TABLE_COLUMNS = {
    "observation":          {"source_concept_col": "observation_source_concept_id", "has_value": True},
    "measurement":          {"source_concept_col": "measurement_source_concept_id", "has_value": True},
    "device_exposure":      {"source_concept_col": "device_source_concept_id",      "has_value": False},
    "condition_occurrence": {"source_concept_col": "condition_source_concept_id",   "has_value": False},
    "procedure_occurrence": {"source_concept_col": "procedure_source_concept_id",   "has_value": False},
    "drug_exposure":        {"source_concept_col": "drug_source_concept_id",        "has_value": False},
}

TARGET_INFO_COLS = ["target_concept_name", "target_domain_id", "target_vocabulary_id",
                    "target_concept_class_id", "target_standard_concept"]


def load_crosswalk(spark, csv_path):
    """Read the crosswalk CSV (a workspace file) into a Spark DataFrame; empty strings become NULL."""
    import pandas as pd
    pdf = pd.read_csv(csv_path, dtype=str, keep_default_na=False)
    rows = []
    for r in pdf.to_dict("records"):
        out = {}
        for f in CROSSWALK_SCHEMA.fields:
            v = (r.get(f.name) or "").strip()
            if v == "":
                out[f.name] = None
            elif isinstance(f.dataType, (T.IntegerType, T.LongType)):
                out[f.name] = int(v)
            else:
                out[f.name] = v
        rows.append(out)
    return spark.createDataFrame(rows, schema=CROSSWALK_SCHEMA)


def rescue_meas_value(df, concept_df, crosswalk_df, domain):
    """Overwrite target_* on rows whose target_domain_id = 'Meas Value'. Other rows are returned unchanged."""
    if "target_domain_id" not in df.columns or domain not in TABLE_COLUMNS:
        return df

    cfg = TABLE_COLUMNS[domain]
    original_cols = df.columns
    has_value = cfg["has_value"] and "value_as_string" in original_cols
    src_col = cfg["source_concept_col"]

    x = (crosswalk_df.filter(F.col("source_table") == domain)
         .select(F.col("xwalk_id").alias("_x_id"),
                 F.col("source_concept_id").alias("_x_src"),
                 F.col("value_regex").alias("_x_regex"),
                 F.col("target_concept_id").alias("_x_tgt"),
                 F.col("target_unit_concept_id").alias("_x_unit"),
                 F.col("target_unit_source_value").alias("_x_unit_src"),
                 F.col("parse_number_regex").alias("_x_parse")))

    is_mv = F.col("target_domain_id") == F.lit("Meas Value")
    cond = is_mv & (F.col("target_concept_id") == F.col("_x_src"))
    if has_value:
        cond = cond & (F.col("_x_regex").isNull() | F.expr("value_as_string RLIKE _x_regex"))
    else:
        cond = cond & F.col("_x_regex").isNull()

    j = df.join(F.broadcast(x), on=cond, how="left")

    # vocabulary info for the new target
    tc = concept_df.select(F.col("concept_id").alias("_t_id"),
                           F.col("concept_name").alias("_t_name"),
                           F.col("domain_id").alias("_t_domain"),
                           F.col("vocabulary_id").alias("_t_vocab"),
                           F.col("concept_class_id").alias("_t_class"),
                           F.col("standard_concept").alias("_t_std"))
    j = j.join(tc, on=(F.col("_x_tgt") == F.col("_t_id")) & (F.col("_x_tgt") != 0), how="left")

    # flag rows first: target_domain_id / target_concept_id are overwritten below.
    # Only rows that match a crosswalk entry are changed; other Meas Value rows pass through unchanged
    # (reported by unmatched_meas_value) so later fixes that key on the site concept still see them.
    j = j.withColumn("_hit", is_mv & F.col("_x_id").isNotNull())
    hit = F.col("_hit")
    new_tgt = F.col("_x_tgt").cast(df.schema["target_concept_id"].dataType)
    j = (j
         .withColumn("meas_value_xwalk_id", F.when(hit, F.col("_x_id")))
         .withColumn("meas_value_original_target_concept_id", F.when(hit, F.col("target_concept_id")))
         # keep the site's concept as the source concept when the site left it empty
         .withColumn(src_col, F.when(hit & (F.col(src_col).isNull() | (F.col(src_col) == 0)),
                                     F.col("target_concept_id").cast(df.schema[src_col].dataType))
                               .otherwise(F.col(src_col)))
         .withColumn("target_concept_name", F.when(hit, F.coalesce(F.col("_t_name"), F.lit("No matching concept")))
                                             .otherwise(F.col("target_concept_name")))
         .withColumn("target_vocabulary_id", F.when(hit, F.col("_t_vocab")).otherwise(F.col("target_vocabulary_id")))
         .withColumn("target_concept_class_id", F.when(hit, F.col("_t_class")).otherwise(F.col("target_concept_class_id")))
         .withColumn("target_standard_concept", F.when(hit, F.col("_t_std")).otherwise(F.col("target_standard_concept")))
         # NULL domain for concept 0 => step 04 keeps the row in its own table
         .withColumn("target_domain_id", F.when(hit, F.col("_t_domain")).otherwise(F.col("target_domain_id")))
         .withColumn("target_concept_id", F.when(hit, new_tgt).otherwise(F.col("target_concept_id"))))

    if has_value:
        parsed = F.expr("CAST(regexp_extract(value_as_string, _x_parse, 1) AS DOUBLE)")
        j = (j
             .withColumn("value_as_number",
                         F.when(hit & F.col("_x_parse").isNotNull() & F.col("value_as_number").isNull(),
                                parsed.cast(df.schema["value_as_number"].dataType))
                          .otherwise(F.col("value_as_number")))
             .withColumn("unit_concept_id",
                         F.when(hit & F.col("_x_unit").isNotNull(),
                                F.col("_x_unit").cast(df.schema["unit_concept_id"].dataType))
                          .otherwise(F.col("unit_concept_id")))
             .withColumn("unit_source_value",
                         F.when(hit & F.col("_x_unit_src").isNotNull(), F.col("_x_unit_src"))
                          .otherwise(F.col("unit_source_value"))))

    return j.select(*original_cols, "meas_value_xwalk_id", "meas_value_original_target_concept_id")


def rescue_summary(df):
    """Rows rescued, by crosswalk entry and resulting target. Run after rescue_meas_value()."""
    return (df.filter(F.col("meas_value_original_target_concept_id").isNotNull())
              .groupBy("meas_value_xwalk_id", "meas_value_original_target_concept_id",
                       "target_concept_id", "target_concept_name", "target_domain_id")
              .count()
              .orderBy("meas_value_xwalk_id"))


def unmatched_meas_value(df):
    """Meas Value targets with no crosswalk entry (left unchanged). Add entries or confirm they are handled elsewhere."""
    return (df.filter((F.col("target_domain_id") == "Meas Value") & F.col("meas_value_xwalk_id").isNull())
              .groupBy("target_concept_id", "target_concept_name").count()
              .orderBy(F.desc("count")))
