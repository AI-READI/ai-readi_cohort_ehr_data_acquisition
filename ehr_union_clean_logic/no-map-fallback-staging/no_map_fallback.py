"""
No 'Maps to' fallback -- runs last in step 03, after perform_standard_mapping() (and after rescue_meas_value() once integrated).

OMOP CDM convention: a source concept with no standard mapping is stored with concept_id = 0, in the table
of its source concept's domain, with the site's concept kept in *_source_concept_id.

Before this step, rows whose concept had no valid 'Maps to' kept target_concept_id = NULL. Step 04 then kept
them in the table the site sent them in (the *_unmap CTEs) with the site's NON-STANDARD concept still in the
main *_concept_id column. Example: ICD10CM Y92.x 'place of occurrence' codes (Observation domain) sent in
CONDITION_OCCURRENCE stayed in CONDITION_OCCURRENCE with a non-standard concept.

For rows with no 'Maps to' whose source concept IS in the vocabulary, this function sets:
  * target_concept_id   = 0
  * target_domain_id    = source_domain_id when it is a domain step 04 routes
                          (Condition, Procedure, Measurement, Observation, Drug, Device);
                          otherwise NULL, so the row stays in the table it was sent in
  * <domain>_source_concept_id = the site's concept, when the site left it empty
Step 04 then routes the row like any mapped row (target_concept_id IS NOT NULL) and writes concept 0.

Left unchanged (step 04 keeps them exactly as today):
  * concept 0 / NULL                         -- nothing to map
  * concept IDs not in the vocabulary        -- source_domain_id is NULL; pending the vocabulary-version check
  * visit_occurrence and tables without a concept column

DEVICE_EXPOSURE is not included yet. One partner's device concepts came from a name lookup (OSM, LOINC,
NDF-RT concepts that share a device's name); those rows are corrected after the union
(ehr_union_clean_logic/ehr_osm_device_name_fix_drop_osm_copies_fromDevice*.sql) and the remaining unmapped
device rows are under review. When enabled, unmapped device rows stay in DEVICE_EXPOSURE with concept 0
(KEEP_IN_TABLE), whatever the domain of their concept.

Audit column added to the 03 table: no_map_fallback (1 = changed by this step, else NULL).
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
    # "device_exposure":    "device_source_concept_id",   # enable after the unmapped device rows are reviewed
    "condition_occurrence": "condition_source_concept_id",
    "procedure_occurrence": "procedure_source_concept_id",
    "measurement":          "measurement_source_concept_id",
    "observation":          "observation_source_concept_id",
    "drug_exposure":        "drug_source_concept_id",
}


def apply_no_map_fallback(df, domain):
    """Concept 0 + source-concept domain for rows with no 'Maps to'. Other rows are returned unchanged."""
    needed = {"source_concept_id", "source_domain_id", "target_concept_id", "target_domain_id"}
    if domain not in SOURCE_CONCEPT_COL or not needed.issubset(df.columns):
        return df

    src_col = SOURCE_CONCEPT_COL[domain]
    tgt_type = df.schema["target_concept_id"].dataType

    no_map = (F.col("target_concept_id").isNull()
              & F.col("source_concept_id").isNotNull()
              & (F.col("source_concept_id") != 0)
              & F.col("source_domain_id").isNotNull())          # source concept is in the vocabulary

    # flag first: target_concept_id is overwritten last
    df = df.withColumn("no_map_fallback", F.when(no_map, F.lit(1)))
    hit = F.col("no_map_fallback") == 1

    if src_col in df.columns:
        df = df.withColumn(
            src_col,
            F.when(hit & (F.col(src_col).isNull() | (F.col(src_col) == 0)),
                   F.col("source_concept_id").cast(df.schema[src_col].dataType))
             .otherwise(F.col(src_col)))

    if domain in KEEP_IN_TABLE:
        new_domain = F.lit(KEEP_IN_TABLE[domain])
    else:
        new_domain = F.when(F.col("source_domain_id").isin(ROUTABLE_DOMAINS), F.col("source_domain_id"))

    df = (df
          .withColumn("target_domain_id", F.when(hit, new_domain).otherwise(F.col("target_domain_id")))
          .withColumn("target_concept_name",
                      F.when(hit, F.lit("No matching concept")).otherwise(F.col("target_concept_name")))
          .withColumn("target_concept_id",
                      F.when(hit, F.lit(0).cast(tgt_type)).otherwise(F.col("target_concept_id"))))
    return df


def fallback_summary(df):
    """Rows changed by the fallback, by source domain and resulting target domain. Run on a 03 table."""
    return (df.filter(F.col("no_map_fallback") == 1)
              .groupBy("source_domain_id", "source_vocabulary_id", "target_domain_id")
              .agg(F.count("*").alias("n_rows"), F.countDistinct("source_concept_id").alias("n_concepts"))
              .orderBy(F.desc("n_rows")))
