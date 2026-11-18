"""
Reviewed concept replacements -- runs in step 03 after perform_standard_mapping() (and the Meas Value rescue),
just BEFORE apply_no_map_fallback().

Some site concepts are deprecated and have neither a valid 'Maps to' nor a 'Concept replaced by' relationship,
so step 03 finds no target for them and the fallback would set them to 0. For a short list of these, a current
standard concept with an identical name was found and reviewed by hand. They are listed in
concept_replacement_crosswalk.csv (one row per site concept).

For rows whose target_concept_id is still NULL and whose site concept (source_concept_id) is in the crosswalk:
  target_concept_id   = replacement_concept_id
  target_* columns    = the replacement's name, domain, vocabulary, class and standard flag (from concept)
  <domain>_source_concept_id = the site's concept, when the site left it empty or 0
Step 04 then routes the row on target_domain_id like any mapped row.

Rows with a valid 'Maps to' are never changed: a vocabulary mapping always wins over the crosswalk.
Applies to the same tables as the no-map fallback (DEVICE_EXPOSURE excluded).

load_replacements() fails the run if a replacement is not a valid standard concept, or if its name no longer
matches the site concept's name. Re-check the file after each vocabulary refresh.

Audit column added to the 03 table: concept_replacement (1 = target set from the crosswalk).
-- Stephanie Hong, November 2026
"""

from pyspark.sql import functions as F, types as T

from myproject.no_map_fallback import SOURCE_CONCEPT_COL

REPLACEMENT_SCHEMA = T.StructType([
    T.StructField("site_concept_id", T.LongType()),
    T.StructField("site_concept_name", T.StringType()),
    T.StructField("site_vocabulary_id", T.StringType()),
    T.StructField("site_concept_class_id", T.StringType()),
    T.StructField("replacement_concept_id", T.LongType()),
    T.StructField("replacement_concept_name", T.StringType()),
    T.StructField("replacement_vocabulary_id", T.StringType()),
    T.StructField("replacement_concept_class_id", T.StringType()),
    T.StructField("reason", T.StringType()),
    T.StructField("reviewed_by", T.StringType()),
    T.StructField("reviewed_date", T.StringType()),
])


def load_replacements(spark, csv_path, concept_df):
    """Read the crosswalk CSV (a workspace file) and validate it against the vocabulary. Raises on any problem."""
    import pandas as pd
    pdf = pd.read_csv(csv_path, dtype=str, keep_default_na=False)
    rows = []
    for r in pdf.to_dict("records"):
        out = {}
        for f in REPLACEMENT_SCHEMA.fields:
            v = (r.get(f.name) or "").strip()
            out[f.name] = None if v == "" else (int(v) if isinstance(f.dataType, T.LongType) else v)
        rows.append(out)
    x = spark.createDataFrame(rows, schema=REPLACEMENT_SCHEMA)

    dup = x.groupBy("site_concept_id").count().filter("count > 1").count()
    if dup:
        raise ValueError(f"concept_replacement_crosswalk.csv: {dup} site_concept_id values listed more than once")

    c = concept_df.select("concept_id", "concept_name", "standard_concept", "invalid_reason")
    rep = c.select(F.col("concept_id").alias("r_id"), F.col("concept_name").alias("r_name"),
                   F.col("standard_concept").alias("r_std"), F.col("invalid_reason").alias("r_inv"))
    site = c.select(F.col("concept_id").alias("s_id"), F.col("concept_name").alias("s_name"))
    bad = (x.join(rep, x.replacement_concept_id == F.col("r_id"), "left")
            .join(site, x.site_concept_id == F.col("s_id"), "left")
            .filter(F.col("r_id").isNull()
                    | (F.coalesce(F.col("r_std"), F.lit("")) != "S")
                    | F.col("r_inv").isNotNull()
                    | F.col("s_id").isNull()
                    | (F.lower(F.col("r_name")) != F.lower(F.col("s_name"))))
            .select("site_concept_id", "replacement_concept_id", "s_name", "r_name", "r_std", "r_inv"))
    if bad.count():
        bad.show(truncate=False)
        raise ValueError("concept_replacement_crosswalk.csv: replacement not a valid standard concept, "
                         "site concept missing, or names no longer match (see rows above)")
    return x


def apply_concept_replacements(df, concept_df, replacement_df, domain):
    """Set the target from the reviewed crosswalk for rows with no 'Maps to'. Row count is unchanged."""
    needed = {"source_concept_id", "target_concept_id", "target_domain_id"}
    if domain not in SOURCE_CONCEPT_COL or not needed.issubset(df.columns):
        return df

    src_col = SOURCE_CONCEPT_COL[domain]
    original_cols = df.columns
    tgt_type = df.schema["target_concept_id"].dataType

    x = replacement_df.select(F.col("site_concept_id").alias("_x_site"),
                              F.col("replacement_concept_id").alias("_x_rep"))
    tc = concept_df.select(F.col("concept_id").alias("_t_id"), F.col("concept_name").alias("_t_name"),
                           F.col("domain_id").alias("_t_domain"), F.col("vocabulary_id").alias("_t_vocab"),
                           F.col("concept_class_id").alias("_t_class"), F.col("standard_concept").alias("_t_std"))

    j = (df.join(F.broadcast(x), (F.col("target_concept_id").isNull()) & (F.col("source_concept_id") == F.col("_x_site")), "left")
           .join(tc, F.col("_x_rep") == F.col("_t_id"), "left"))
    j = j.withColumn("concept_replacement", F.when(F.col("_x_rep").isNotNull(), F.lit(1)))
    hit = F.col("concept_replacement") == 1

    def upd(col, new):
        return F.when(hit, new).otherwise(F.col(col)) if col in original_cols else None

    for col, new in [("target_concept_name", F.col("_t_name")), ("target_domain_id", F.col("_t_domain")),
                     ("target_vocabulary_id", F.col("_t_vocab")), ("target_concept_class_id", F.col("_t_class")),
                     ("target_standard_concept", F.col("_t_std"))]:
        if col in original_cols:
            j = j.withColumn(col, upd(col, new))
    if src_col in original_cols:
        j = j.withColumn(src_col, F.when(hit & (F.col(src_col).isNull() | (F.col(src_col) == 0)),
                                         F.col("source_concept_id").cast(df.schema[src_col].dataType))
                                    .otherwise(F.col(src_col)))
    j = j.withColumn("target_concept_id", F.when(hit, F.col("_x_rep").cast(tgt_type)).otherwise(F.col("target_concept_id")))

    keep = [c for c in original_cols if c != "concept_replacement"]
    return j.select(*keep, "concept_replacement")


def replacement_summary(df):
    """Rows whose target came from the crosswalk, by site concept and replacement. Run on a 03 table."""
    if "concept_replacement" not in df.columns:
        return None
    return (df.filter(F.col("concept_replacement") == 1)
              .groupBy("source_concept_id", "target_concept_id", "target_concept_name", "target_domain_id")
              .count().orderBy(F.desc("count")))
