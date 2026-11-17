"""
No 'Maps to' fallback -- runs last in step 03, after perform_standard_mapping() (and after rescue_meas_value() once integrated).

OMOP CDM convention:
  * target side (concept_relationship): a concept with no valid 'Maps to' gets <domain>_concept_id = 0.
  * source side (concept): a <domain>_source_concept_id that is not in the concept table is stored as 0.
  * a non-standard concept is never stored in the main <domain>_concept_id column.
What the site sent is kept in <domain>_source_value, and (once added) in the step 03 site snapshot.

1. TARGET SIDE -- every row whose target_concept_id is still NULL after 'Maps to':
     target_concept_id = 0, target_concept_name = 'No matching concept'
     target_domain_id  = source_domain_id when the site's concept is in the vocabulary and its domain is one
                         step 04 routes (Condition, Procedure, Measurement, Observation, Drug, Device);
                         otherwise NULL, so the row stays in the table it was sent in.
                         This covers concept 0/NULL and concept IDs not in the vocabulary.
     <domain>_source_concept_id = the site's concept when the site left it empty or 0 and that concept is
                         in the vocabulary.
   Step 04 then routes the row like any mapped row (target_concept_id IS NOT NULL) and writes concept 0, so
   the *_unmap CTEs receive no rows from these tables.

2. SOURCE SIDE -- every row (mapped or not): a <domain>_source_concept_id that is not 0/NULL and is not in
   the concept table becomes 0. The site's value is still in the site snapshot.

DEVICE_EXPOSURE is not included: one partner's device concepts came from a name lookup and the duplicate
device rows are not yet confirmed (ehr_union_clean_logic/ehr_osm_device_name_fix_drop_osm_copies_fromDevice*.sql).
Device rows keep today's behaviour, including *_unmap in step 04.

Audit columns added to the 03 table:
  no_map_fallback            1 = target set to 0 by rule 1
  source_concept_not_in_vocab 1 = <domain>_source_concept_id set to 0 by rule 2
See 03-prepared/no_map_fallback_README.md.
-- Stephanie Hong, November 2026
"""

from pyspark.sql import functions as F

# Domains step 04 routes rows to (see the target_domain_id filters in 04-domain-map/*.py)
ROUTABLE_DOMAINS = ["Condition", "Procedure", "Measurement", "Observation", "Drug", "Device"]

# Tables whose unmapped rows stay in place (concept 0) instead of moving to the source concept's domain
# (used once device_exposure is enabled in SOURCE_CONCEPT_COL)
KEEP_IN_TABLE = {"device_exposure": "Device"}

# Tables this step applies to, with the column that holds the site's source concept.
SOURCE_CONCEPT_COL = {
    # "device_exposure":    "device_source_concept_id",   # enable after the duplicate device rows are confirmed
    "condition_occurrence": "condition_source_concept_id",
    "procedure_occurrence": "procedure_source_concept_id",
    "measurement":          "measurement_source_concept_id",
    "observation":          "observation_source_concept_id",
    "drug_exposure":        "drug_source_concept_id",
}


def apply_no_map_fallback(df, concept_df, domain):
    """Rule 1 (target 0 when no 'Maps to') and rule 2 (source 0 when not in concept). Row count is unchanged."""
    needed = {"source_concept_id", "source_domain_id", "target_concept_id", "target_domain_id"}
    if domain not in SOURCE_CONCEPT_COL or not needed.issubset(df.columns):
        return df

    src_col = SOURCE_CONCEPT_COL[domain]
    src_type = df.schema[src_col].dataType if src_col in df.columns else None
    tgt_type = df.schema["target_concept_id"].dataType

    in_vocab = F.col("source_domain_id").isNotNull()          # site's <domain>_concept_id is in concept
    no_map = F.col("target_concept_id").isNull()              # no valid 'Maps to'

    # flags first: target_concept_id and src_col are overwritten below
    df = df.withColumn("no_map_fallback", F.when(no_map, F.lit(1)))
    hit = F.col("no_map_fallback") == 1

    if src_col in df.columns:
        # rule 2: is the site's <domain>_source_concept_id in the concept table? (distinct ids, no fan-out)
        vocab_ids = concept_df.select(F.col("concept_id").alias("_src_in_vocab")).distinct()
        df = df.join(vocab_ids, F.col(src_col) == F.col("_src_in_vocab"), "left")
        src_given = F.col(src_col).isNotNull() & (F.col(src_col) != 0)
        not_found = src_given & F.col("_src_in_vocab").isNull()
        df = df.withColumn("source_concept_not_in_vocab", F.when(not_found, F.lit(1)))
        df = df.withColumn(
            src_col,
            F.when(not_found, F.lit(0).cast(src_type))
             # rule 1: fill an empty source concept from the site's concept when that concept is in the vocabulary
             .when(hit & ~src_given & in_vocab, F.col("source_concept_id").cast(src_type))
             .otherwise(F.col(src_col)))
        df = df.drop("_src_in_vocab")

    if domain in KEEP_IN_TABLE:
        new_domain = F.lit(KEEP_IN_TABLE[domain])
    else:
        new_domain = F.when(in_vocab & F.col("source_domain_id").isin(ROUTABLE_DOMAINS), F.col("source_domain_id"))

    df = (df
          .withColumn("target_domain_id", F.when(hit, new_domain).otherwise(F.col("target_domain_id")))
          .withColumn("target_concept_name",
                      F.when(hit, F.lit("No matching concept")).otherwise(F.col("target_concept_name")))
          .withColumn("target_concept_id",
                      F.when(hit, F.lit(0).cast(tgt_type)).otherwise(F.col("target_concept_id"))))
    return df


def fallback_summary(df):
    """Rows changed by rule 1, by why there was no target and where step 04 will put them. Run on a 03 table."""
    reason = (F.when(F.col("source_concept_id").isNull() | (F.col("source_concept_id") == 0), F.lit("concept 0/NULL"))
               .when(F.col("source_domain_id").isNull(), F.lit("not in vocab"))
               .otherwise(F.lit("in vocab, no Maps to")))
    return (df.filter(F.col("no_map_fallback") == 1)
              .withColumn("reason", reason)
              .groupBy("reason", "source_domain_id", "source_vocabulary_id", "target_domain_id")
              .agg(F.count("*").alias("n_rows"), F.countDistinct("source_concept_id").alias("n_concepts"))
              .orderBy(F.desc("n_rows")))


def source_concept_summary(df):
    """Rows whose <domain>_source_concept_id was set to 0 by rule 2. Run on a 03 table."""
    if "source_concept_not_in_vocab" not in df.columns:
        return None
    return (df.filter(F.col("source_concept_not_in_vocab") == 1)
              .groupBy("target_domain_id").agg(F.count("*").alias("n_rows"))
              .orderBy(F.desc("n_rows")))
