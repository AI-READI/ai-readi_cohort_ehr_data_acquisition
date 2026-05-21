# SQL Quality Control Checks for OMOP CDM.
Useful code blocks that can be used to check for data quality.

This page example SQL queries that may be useful for validating OMOP CDM ETL results, identifying orphan records, assessing data completeness, and evaluating fitness-for-use for Type 2 diabetes research.

---

# 1. Basic Linkage and Orphan Checks

## Orphan PERSON References from Fact Tables

Example for `condition_occurrence` (repeat for other domain tables):

```sql
SELECT DISTINCT
    co.person_id AS co_person_id,
    p.person_id AS p_person_id
FROM condition_occurrence co
LEFT JOIN person p
    ON co.person_id = p.person_id
WHERE p.person_id IS NULL;
```

## Orphan VISIT References from Fact Tables

```sql
SELECT DISTINCT
    co.visit_occurrence_id
FROM condition_occurrence co
LEFT JOIN visit_occurrence v
    ON co.visit_occurrence_id = v.visit_occurrence_id
WHERE co.visit_occurrence_id IS NOT NULL
  AND v.visit_occurrence_id IS NULL;
```

## Orphan PERSON Records

Persons with no clinical records.

```sql
SELECT p.person_id
FROM person p
LEFT JOIN (
    SELECT person_id FROM visit_occurrence
    UNION
    SELECT person_id FROM condition_occurrence
    UNION
    SELECT person_id FROM procedure_occurrence
    UNION
    SELECT person_id FROM drug_exposure
    UNION
    SELECT person_id FROM measurement
    UNION
    SELECT person_id FROM observation
) c
    ON p.person_id = c.person_id
WHERE c.person_id IS NULL;
```

## Orphan VISIT Records

Visits with no references from clinical domains.

```sql
SELECT v.visit_occurrence_id
FROM visit_occurrence v
LEFT JOIN (
    SELECT visit_occurrence_id
    FROM condition_occurrence
    WHERE visit_occurrence_id IS NOT NULL

    UNION

    SELECT visit_occurrence_id
    FROM procedure_occurrence
    WHERE visit_occurrence_id IS NOT NULL

    UNION

    SELECT visit_occurrence_id
    FROM drug_exposure
    WHERE visit_occurrence_id IS NOT NULL

    UNION

    SELECT visit_occurrence_id
    FROM measurement
    WHERE visit_occurrence_id IS NOT NULL

    UNION

    SELECT visit_occurrence_id
    FROM observation
    WHERE visit_occurrence_id IS NOT NULL
) d
    ON v.visit_occurrence_id = d.visit_occurrence_id
WHERE d.visit_occurrence_id IS NULL;
```

---

# 2. Presence Checks for Diabetes Cohort Signals

## Count Patients with Type 2 Diabetes Diagnoses

Replace concept IDs with your validated Type 2 diabetes concept set.

```sql
SELECT COUNT(DISTINCT person_id) AS n_patients_t2d
FROM condition_occurrence
WHERE condition_concept_id IN (
    201820,
    40484648,
    201254
);
```

## Count Patients with Diabetes Medication Exposure

```sql
SELECT COUNT(DISTINCT person_id) AS n_on_diabetes_drugs
FROM drug_exposure
WHERE drug_concept_id IN (
    1503297,   -- Metformin
    1583251,   -- Insulin
    19022611,  -- Empagliflozin
    19022619,  -- Dapagliflozin
    19122183   -- Liraglutide
);
```

## Count Patients with HbA1c Measurements

```sql
SELECT COUNT(DISTINCT person_id) AS n_with_hba1c
FROM measurement
WHERE measurement_concept_id IN (
    3004410,
    3004249
);
```

## Count Patients with Glucose Measurements

```sql
SELECT COUNT(DISTINCT person_id) AS n_with_glucose
FROM measurement
WHERE measurement_concept_id IN (
    3003692,
    3014618
);
```

---

# 3. Plausibility and Value Range Checks

## HbA1c Plausibility Check

Review missing or implausible HbA1c values.

```sql
SELECT
    measurement_id,
    person_id,
    measurement_date,
    value_as_number,
    unit_concept_id
FROM measurement
WHERE measurement_concept_id IN (
    3004410,
    3004249
)
AND (
    value_as_number IS NULL
    OR value_as_number < 2
    OR value_as_number > 25
);
```

## Glucose Plausibility Check

```sql
SELECT
    measurement_id,
    person_id,
    measurement_date,
    value_as_number,
    unit_concept_id
FROM measurement
WHERE measurement_concept_id IN (
    3003692,
    3014618
)
AND (
    value_as_number IS NULL
    OR value_as_number < 20
    OR value_as_number > 2000
);
```

## Extreme Medication Quantity Check

Example for Metformin.

```sql
SELECT
    drug_exposure_id,
    person_id,
    drug_concept_id,
    quantity,
    sig,
    drug_exposure_start_date
FROM drug_exposure
WHERE drug_concept_id = 1503297
  AND quantity > 10000;
```

---

# 4. Temporal Consistency Checks

## Verify Baseline HbA1c Prior to Medication Initiation

Identify patients whose first HbA1c measurement occurs after their first diabetes medication exposure.

```sql
WITH first_med AS (
    SELECT
        person_id,
        MIN(drug_exposure_start_date) AS first_med_date
    FROM drug_exposure
    WHERE drug_concept_id IN (
        1503297,
        1583251,
        19022611,
        19022619,
        19122183
    )
    GROUP BY person_id
),
first_hba1c AS (
    SELECT
        person_id,
        MIN(measurement_date) AS first_hba1c_date
    FROM measurement
    WHERE measurement_concept_id IN (
        3004410,
        3004249
    )
    GROUP BY person_id
)
SELECT
    f.person_id,
    f.first_med_date,
    h.first_hba1c_date
FROM first_med f
LEFT JOIN first_hba1c h
    ON f.person_id = h.person_id
WHERE h.first_hba1c_date IS NULL
   OR h.first_hba1c_date > f.first_med_date;
```

> Adjust the logic depending on your study protocol and expected temporal sequence.

---

# 5. Diabetes-Specific Linkage Verification

## Verify Drug Exposure References

```sql
SELECT d.drug_exposure_id
FROM drug_exposure d
LEFT JOIN person p
    ON d.person_id = p.person_id
WHERE d.drug_concept_id IN (
    1503297,
    1583251,
    19022611,
    19022619,
    19122183
)
AND p.person_id IS NULL;
```

## Verify Measurement Visit References

```sql
SELECT m.measurement_id
FROM measurement m
LEFT JOIN visit_occurrence v
    ON m.visit_occurrence_id = v.visit_occurrence_id
WHERE m.measurement_concept_id IN (
    3004410,
    3004249,
    3003692,
    3014618
)
AND m.visit_occurrence_id IS NOT NULL
AND v.visit_occurrence_id IS NULL;
```

---

# 6. Missingness and Coverage Assessment

## Proportion of Type 2 Diabetes Patients with HbA1c Measurements

```sql
WITH t2d_patients AS (
    SELECT DISTINCT person_id
    FROM condition_occurrence
    WHERE condition_concept_id IN (
        201820,
        40484648,
        201254
    )
)
SELECT
    COUNT(DISTINCT m.person_id) AS n_with_hba1c,
    COUNT(DISTINCT t.person_id) AS n_t2d,
    COUNT(DISTINCT m.person_id)::DECIMAL
        / NULLIF(COUNT(DISTINCT t.person_id), 0)
        AS pct_t2d_with_hba1c
FROM t2d_patients t
LEFT JOIN measurement m
    ON t.person_id = m.person_id
    AND m.measurement_concept_id IN (
        3004410,
        3004249
    );
```

---

# 7. Audit Table Example

## Store Orphan Records for Review

```sql
INSERT INTO audit_orphans (
    source_table,
    source_id,
    person_id,
    visit_occurrence_id,
    reason,
    detected_at
)
SELECT
    'condition_occurrence',
    condition_occurrence_id,
    person_id,
    visit_occurrence_id,
    'orphan_person',
    CURRENT_TIMESTAMP
FROM condition_occurrence co
LEFT JOIN person p
    ON co.person_id = p.person_id
WHERE p.person_id IS NULL;
```

---

# Notes

- Validate all concept IDs against your OMOP vocabulary version.
- Replace example concept sets with project-specific concept sets.
- Consider incorporating these checks into automated ETL validation workflows.
- Record all detected issues and remediation actions in ETL audit logs.
