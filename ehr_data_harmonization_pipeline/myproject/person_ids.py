# Databricks version of person_ids.py
from pyspark.sql import functions as F, Window as W
from pyspark.sql.types import LongType, IntegerType, StringType, StructType, StructField

def person_id_pre_clean(ctx, person, **input_dfs):
    pairs_to_union = []
    persons_to_union = []

    for (alias, df) in input_dfs.items():
        # Get person_ids for the missing persons check - ensure consistent types
        person_data = df.select("person_id", "data_partner_id") \
            .withColumn("person_id", F.col("person_id").cast(LongType())) \
            .withColumn("data_partner_id", F.col("data_partner_id").cast(IntegerType()))
        persons_to_union.append(person_data)

        # If the domain has a person_id and visit_occurrence_id column
        if alias in domains_to_filter_multiple_persons_per_visit:
            # Get person_id + visit_occurrence_id pairs - ensure consistent types
            pair_data = df.select("person_id", "visit_occurrence_id", "data_partner_id") \
                .withColumn("person_id", F.col("person_id").cast(LongType())) \
                .withColumn("visit_occurrence_id", F.col("visit_occurrence_id").cast(LongType())) \
                .withColumn("data_partner_id", F.col("data_partner_id").cast(IntegerType()))
            pairs_to_union.append(pair_data)

    # Replace Palantir's union_many with our custom function
    distinct_pairs = union_dataframes(pairs_to_union).distinct()
    all_persons = union_dataframes(persons_to_union).distinct()

    # DETERMINE ROWS TO REMOVE + CREATE UNIFORM SCHEMA
    # Rows with multiple persons per visit
    multiple_persons_df = get_rows_with_multiple_persons_per_visit(distinct_pairs) \
        .select("person_id",
                "visit_occurrence_id",
                "data_partner_id",
                "removal_reason")
    
    # Rows with person_ids not found in the person table
    missing_persons_df = get_rows_with_missing_persons(all_persons, person) \
        .select("person_id",
                "data_partner_id",
                "removal_reason") \
        .withColumn("visit_occurrence_id", F.lit(None).cast(LongType()))

    # Create explicit schema to ensure identical structure
    target_schema = StructType([
        StructField("person_id", LongType(), True),
        StructField("visit_occurrence_id", LongType(), True),
        StructField("data_partner_id", IntegerType(), True),
        StructField("removal_reason", StringType(), False)
    ])
    
    # Create new DataFrames with explicit schema to ensure identical column order and types
    from pyspark.sql import SparkSession
    spark = SparkSession.getActiveSession()
    
    multiple_persons_rdd = multiple_persons_df.rdd.map(lambda row: (
        row.person_id if row.person_id is not None else None,
        row.visit_occurrence_id if row.visit_occurrence_id is not None else None,
        row.data_partner_id if row.data_partner_id is not None else None,
        row.removal_reason
    ))
    
    missing_persons_rdd = missing_persons_df.rdd.map(lambda row: (
        row.person_id if row.person_id is not None else None,
        row.visit_occurrence_id if row.visit_occurrence_id is not None else None,
        row.data_partner_id if row.data_partner_id is not None else None,
        row.removal_reason
    ))
    
    multiple_persons_clean = spark.createDataFrame(multiple_persons_rdd, target_schema)
    missing_persons_clean = spark.createDataFrame(missing_persons_rdd, target_schema)
    
    # Union with guaranteed identical schemas
    bad_person_ids = multiple_persons_clean.unionByName(missing_persons_clean)

    return bad_person_ids

# Custom function to replace Palantir's union_many
def union_dataframes(dataframes):
    """
    Union a list of dataframes with consistent types
    """
    if not dataframes:
        return None
    
    # Start with the first dataframe
    result = dataframes[0]
    
    # Union with the rest - keep allowMissingColumns for schema flexibility
    for df in dataframes[1:]:
        result = result.unionByName(df, allowMissingColumns=True)
    
    return result

domains_to_filter_multiple_persons_per_visit = [
    "condition_occurrence",
    "procedure_occurrence",
    "measurement",
    "observation",
    "visit_occurrence",
    "drug_exposure",
    "device_exposure"
]

# Return rows that have a visit_occurrence_id associated with more than 1 person_id
def get_rows_with_multiple_persons_per_visit(domain_df):
    w = W.partitionBy("visit_occurrence_id")
    # collect all rows that have a visit_occurrence_id associated with more than 1 person_id
    bad_rows_df = domain_df.filter(F.col('visit_occurrence_id').isNotNull()) \
        .withColumn('distinct_person_count', F.size(F.collect_set("person_id").over(w)))
    bad_rows_df = bad_rows_df \
        .filter(bad_rows_df.distinct_person_count > 1) \
        .drop('distinct_person_count') \
        .withColumn('removal_reason', F.lit('MULTIPLE_PERSONS_PER_VISIT_OCCURRENCE'))

    return bad_rows_df

# Return rows that have a person_id not found in the person domain
def get_rows_with_missing_persons(all_persons_df, person_domain_df):
    bad_rows_df = all_persons_df.join(person_domain_df, on='person_id', how='left_anti')

    return bad_rows_df.withColumn('removal_reason', F.lit('PERSON_ID_NOT_IN_PERSON_DOMAIN'))