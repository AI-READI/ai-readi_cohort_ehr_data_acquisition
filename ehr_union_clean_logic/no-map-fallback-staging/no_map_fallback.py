"""
No 'Maps to' fallback -- runs last in step 03, after perform_standard_mapping(), rescue_meas_value() and
apply_concept_replacements(); write_site_snapshot() runs first and keeps what the site sent.

OMOP CDM convention:
  * target side (concept_relationship): a concept with no valid 'Maps to' gets <domain>_concept_id = 0.
  * source side (concept): <domain>_source_concept_id holds an OMOP concept_id.
  * a non-standard concept is never stored in the main <domain>_concept_id column.

1. TARGET SIDE -- every row whose target_concept_id is still NULL after 'Maps to':
     target_concept_id = 0, target_concept_name = 'No matching concept'
     target_domain_id  = source_domain_id when the site's concept is in the vocabulary and its domain is one
                         step 04 routes (Condition, Procedure, Measurement, Observation, Drug, Device);
                         otherwise NULL, so the row stays in the table it was sent in.
                         This covers concept 0/NULL and concept IDs not in the vocabulary.
     <domain>_source_concept_id = the site's concept when the site left it empty or 0 and that concept is
                         in the vocabulary.
   Step 04 then routes the row like any mapped row (target_concept_id IS NOT NULL) and writes concept 0.

2. SOURCE SIDE (fail-safe) -- every row with a <domain>_source_concept_id that is not 0/NULL:
     a. it is an OMOP concept_id in the concept table          -> kept
     b. otherwise, it matches a concept_code in one of the domain's source vocabularies (SOURCE_CODE_VOCABS,
        e.g. a SNOMED CT code such as 404684003 in condition_source_concept_id)
                                                               -> replaced by that concept's concept_id
        (several vocabularies: the first in the list wins, so the join never adds rows)
     c. otherwise                                              -> 0 when ZERO_UNRESOLVED_SOURCE is True,
                                                                  else kept
   The site's value is always kept in <domain>_source_concept_id_original, and the outcome in
   source_concept_resolution ('concept_id', 'code:<vocabulary>', 'not found').
   An integer column cannot hold ICD-10 codes with a dot; string columns are matched as text (trimmed).

DEVICE_EXPOSURE is not included: one partner's device concepts came from a name lookup and the duplicate
device rows are not yet confirmed (ehr_union_clean_logic/ehr_osm_device_name_fix_drop_osm_copies_fromDevice*.sql).

Audit columns added to the 03 table:
  no_map_fallback                       1 = target set to 0 by rule 1
  <domain>_source_concept_id_original   the site's value before rule 2
  source_concept_resolution             'concept_id' | 'code:<vocabulary>' | 'not found' (NULL when 0/NULL)
See 03-prepared/no_map_fallback_README.md.
-- Stephanie Hong, November 2026
"""

from pyspark.sql import functions as F, Window

# Domains step 04 routes rows to (see the target_domain_id filters in 04-domain-map/*.py)
ROUTABLE_DOMAINS = ["Condition", "Procedure", "Measurement", "Observation", "Drug", "Device"]

# Tables whose unmapped rows stay in place (concept 0) instead of moving to the source concept's domain
# (used once device_exposure is enabled in SOURCE_CONCEPT_COL)
KEEP_IN_TABLE = {"device_exposure": "Device"}

# Rule 1: concepts that stay in the table the site sent them in (concept 0), whatever their vocabulary domain.
# 4237085 Nitrogen dioxide: one partner's observation rows (value 3, no source value) are not drug exposures.
KEEP_IN_PLACE_CONCEPTS = [4237085]

# Tables this step applies to, with the column that holds the site's source concept.
SOURCE_CONCEPT_COL = {
    # "device_exposure":    "device_source_concept_id",   # enable after the duplicate device rows are confirmed
    "condition_occurrence": "condition_source_concept_id",
    "procedure_occurrence": "procedure_source_concept_id",
    "measurement":          "measurement_source_concept_id",
    "observation":          "observation_source_concept_id",
    "drug_exposure":        "drug_source_concept_id",
}

# Rule 2b: vocabularies whose codes a site may put in <domain>_source_concept_id, in priority order
SOURCE_CODE_VOCABS = {
    "condition_occurrence": ["SNOMED", "ICD10CM", "ICD10", "ICD9CM"],
    "procedure_occurrence": ["SNOMED", "CPT4", "HCPCS", "ICD10PCS", "ICD9Proc"],
    "measurement":          ["LOINC", "SNOMED"],
    "observation":          ["SNOMED", "LOINC", "ICD10CM"],
    "drug_exposure":        ["RxNorm", "RxNorm Extension", "NDC"],
}

# Rule 2c: set a source concept that is neither a concept_id nor a known code to 0.
# The site's value is kept in <domain>_source_concept_id_original either way.
ZERO_UNRESOLVED_SOURCE = True


def _resolve_source_concepts(df, concept_df, domain, src_col):
    """One row per distinct site value: resolved concept_id and how it was resolved (no fan-out)."""
    vals = (df.select(F.col(src_col).alias("_v"))
              .filter(F.col("_v").isNotNull() & (F.trim(F.col("_v").cast("string")) != "0"))
              .distinct()
              .withColumn("_v_str", F.trim(F.col("_v").cast("string"))))

    # a. the value is an OMOP concept_id
    ids = concept_df.select(F.col("concept_id").cast("string").alias("_id_str")).distinct()
    by_id = (vals.join(ids, vals._v_str == ids._id_str, "inner")
                 .select("_v", F.col("_v_str").cast("long").alias("_resolved_id"),
                         F.lit("concept_id").alias("_resolution"), F.lit(0).alias("_prio")))

    # b. the value is a concept_code in one of the domain's source vocabularies (first vocabulary wins)
    vocabs = SOURCE_CODE_VOCABS.get(domain, [])
    prio = F.lit(len(vocabs) + 1)
    for i, v in enumerate(vocabs, start=1):
        prio = F.when(F.col("vocabulary_id") == v, F.lit(i)).otherwise(prio)
    codes = (concept_df.filter(F.col("vocabulary_id").isin(vocabs))
                       .select(F.col("concept_code").alias("_code"), F.col("concept_id").cast("long").alias("_code_id"),
                               F.col("vocabulary_id").alias("_code_vocab"), prio.alias("_prio")))
    by_code = (vals.join(by_id.select("_v"), "_v", "left_anti")
                   .join(codes, vals._v_str == codes._code, "inner")
                   .select("_v", F.col("_code_id").alias("_resolved_id"),
                           F.concat(F.lit("code:"), F.col("_code_vocab")).alias("_resolution"), "_prio"))

    w = Window.partitionBy("_v").orderBy("_prio", "_resolved_id")
    resolved = (by_id.unionByName(by_code)
                     .withColumn("_rn", F.row_number().over(w))
                     .filter("_rn = 1").drop("_rn", "_prio"))
    return resolved


def apply_no_map_fallback(df, concept_df, domain):
    """Rule 1 (target 0 when no 'Maps to') and rule 2 (fail-safe source concept). Row count is unchanged."""
    needed = {"source_concept_id", "source_domain_id", "target_concept_id", "target_domain_id"}
    if domain not in SOURCE_CONCEPT_COL or not needed.issubset(df.columns):
        return df

    src_col = SOURCE_CONCEPT_COL[domain]
    tgt_type = df.schema["target_concept_id"].dataType

    in_vocab = F.col("source_domain_id").isNotNull()          # site's <domain>_concept_id is in concept
    no_map = F.col("target_concept_id").isNull()              # no valid 'Maps to'

    # flag first: target_concept_id is overwritten below
    df = df.withColumn("no_map_fallback", F.when(no_map, F.lit(1)))
    hit = F.col("no_map_fallback") == 1

    if src_col in df.columns:
        src_type = df.schema[src_col].dataType
        orig_col = f"{src_col}_original"
        df = df.withColumn(orig_col, F.col(src_col))

        # rule 2: resolve the site's value (concept_id, else a code in the domain's vocabularies)
        resolved = _resolve_source_concepts(df, concept_df, domain, src_col)
        df = df.join(resolved, F.col(src_col) == F.col("_v"), "left").drop("_v")

        src_given = F.col(orig_col).isNotNull() & (F.trim(F.col(orig_col).cast("string")) != "0")
        df = df.withColumn("source_concept_resolution",
                           F.when(~src_given, F.lit(None).cast("string"))
                            .when(F.col("_resolution").isNotNull(), F.col("_resolution"))
                            .otherwise(F.lit("not found")))
        unresolved = src_given & F.col("_resolution").isNull()
        df = df.withColumn(
            src_col,
            F.when(src_given & F.col("_resolution").isNotNull(), F.col("_resolved_id").cast(src_type))
             .when(unresolved & F.lit(ZERO_UNRESOLVED_SOURCE), F.lit(0).cast(src_type))
             # rule 1: fill an empty source concept from the site's concept when that concept is in the vocabulary
             .when(hit & ~src_given & in_vocab, F.col("source_concept_id").cast(src_type))
             .otherwise(F.col(src_col)))
        df = df.drop("_resolved_id", "_resolution")

    if domain in KEEP_IN_TABLE:
        new_domain = F.lit(KEEP_IN_TABLE[domain])
    else:
        new_domain = F.when(in_vocab & F.col("source_domain_id").isin(ROUTABLE_DOMAINS)
                            & ~F.col("source_concept_id").isin(KEEP_IN_PLACE_CONCEPTS),
                            F.col("source_domain_id"))

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


def source_concept_summary(df, domain):
    """Rule 2 outcome: rows by resolution ('concept_id', 'code:<vocabulary>', 'not found'). Run on a 03 table."""
    if "source_concept_resolution" not in df.columns:
        return None
    orig_col = f"{SOURCE_CONCEPT_COL[domain]}_original"
    return (df.filter(F.col("source_concept_resolution").isNotNull())
              .groupBy("source_concept_resolution")
              .agg(F.count("*").alias("n_rows"), F.countDistinct(orig_col).alias("n_distinct_values"))
              .orderBy(F.desc("n_rows")))


def unresolved_source_values(df, domain, n=25):
    """Most frequent site values that rule 2 could not resolve (to review or report to the site)."""
    if "source_concept_resolution" not in df.columns:
        return None
    orig_col = f"{SOURCE_CONCEPT_COL[domain]}_original"
    value_col = SOURCE_CONCEPT_COL[domain].replace("_concept_id", "_value")
    cols = [orig_col] + ([value_col] if value_col in df.columns else [])
    return (df.filter(F.col("source_concept_resolution") == "not found")
              .groupBy(*cols).count().orderBy(F.desc("count")).limit(n))
