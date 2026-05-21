# OMOP CDM ETL Guidelines

## Orphan Person/Visits or Unlinked Person/Visits

Orphan person/visit links are records that reference `PERSON` or `VISIT` entries that don't exist in the CDM.

- **Unlinked PERSONs** exist in the `PERSON` table but have no clinical records associated with them.
- **Unlinked VISITs** exist in the `VISIT_OCCURRENCE` table but are not referenced by any clinical/domain tables.

Orphans break referential integrity and do not provide useful analytic information. Unlinked PERSONs and VISITs generally have no analytic signal and can distort denominators or complicate visit-based analyses unless they represent legitimate administrative or enrollment records.

### Definition

#### Orphan Person/Visit Link

A record in a clinical/event table (for example, `condition_occurrence`, `procedure_occurrence`, `measurement`, `drug_exposure`, etc.) references a `person_id` or `visit_occurrence_id` that does not exist in the target `PERSON` or `VISIT_OCCURRENCE` tables.

#### Unlinked PERSON Record

A `person_id` exists in the `PERSON` table but is not referenced by any clinical/domain tables (no visits, conditions, procedures, measurements, etc.).

#### Unlinked VISIT Record

A `visit_occurrence_id` exists in `VISIT_OCCURRENCE` but is not referenced by any clinical/domain tables (no `condition_occurrence`, `procedure_occurrence`, `measurement`, `drug_exposure`, etc. point to that visit).

### Why They're Problematic

#### Orphan Links

- Break referential integrity.
- Cannot be reliably interpreted in analyses.
- Can lead to:
  - Inaccurate counts
  - Biased denominators
  - Failed joins in downstream processes

#### Unlinked PERSON Records

- Increase dataset size.
- May distort population denominators.
- Generally provide no analytic signal.
- May still be useful for:
  - Enrollment tracking
  - Coverage analyses
  - Auditing

#### Unlinked VISIT Records

- Add noise to the dataset.
- Do not contribute analytic value in most studies.
- Can indicate upstream ETL or mapping problems.

### Detection Steps

#### Check for Unlinked PERSON Records

```sql
SELECT person_id
FROM PERSON
EXCEPT
SELECT DISTINCT person_id
FROM (
    SELECT person_id FROM visit_occurrence
    UNION ALL
    SELECT person_id FROM condition_occurrence
    UNION ALL
    SELECT person_id FROM procedure_occurrence
    UNION ALL
    SELECT person_id FROM measurement
    UNION ALL
    SELECT person_id FROM drug_exposure
);
```

#### Check for Unlinked VISIT Records

```sql
SELECT visit_occurrence_id
FROM VISIT_OCCURRENCE
EXCEPT
SELECT DISTINCT visit_occurrence_id
FROM (
    SELECT visit_occurrence_id FROM condition_occurrence
    UNION ALL
    SELECT visit_occurrence_id FROM procedure_occurrence
    UNION ALL
    SELECT visit_occurrence_id FROM measurement
    UNION ALL
    SELECT visit_occurrence_id FROM drug_exposure
    UNION ALL
    SELECT visit_occurrence_id FROM observation
);
```

## Minimum QC Before Declaring Data Fit-for-Use in AI-READI Research
Type 2 diabetes patients should have records representing their diagnosis in the CONDITION_OCCURRENCE domain, laboratory measurements relevant to diabetes management (e.g., HbA1c and glucose) in the MEASUREMENT domain, and records of diabetes-related medications in the DRUG_EXPOSURE domain. The presence and appropriate linkage of these records should be verified as part of routine data quality assessment to ensure the data are fit for diabetes research and analytics.
 

### Preliminary Validation

Confirm:

- Presence of diabetes-related medications
- Presence of diabetes-related laboratory measurements
- Correct linkage to PERSON and VISIT records

Examples include:

#### Medications

- Metformin
- Insulin
- SGLT2 inhibitors
- GLP-1 receptor agonists

#### Laboratory Tests

- HbA1c
- Fasting glucose
- Lipid panel
- Creatinine

## Suggested Standard Concept IDs

### Type 2 Diabetes Concepts

| Concept ID | Concept |
|------------|----------|
| 201826 | Type 2 diabetes mellitus |
| 201820 | Diabetes mellitus |
| 40484648 | Uncontrolled type 1 diabetes |
| 201254 | Type 1 diabetes |

### HbA1c Measurements

| Concept ID | Concept |
|------------|----------|
| 3004410 | Hemoglobin A1c/Hemoglobin.total in Blood by HPLC (NGSP/DCCT %) |
| 3000963 | Hemoglobin A1C measurement |

### Glucose Measurements

| Concept ID | Concept |
|------------|----------|
| 3003692 | Fasting Glucose [Moles/volume] in Serum or Plasma |
| 4149519 | Glucose measurement |

### Drug Concepts

| Drug | Concept ID |
|------|------------|
| Metformin | 1503297 |
| Insulin | 45884660 |
| Empagliflozin | 45774751 |
| Dapagliflozin | 44785829 |

### Useful SQL queries for data quality checks
[Useful SQL Queries for Data Quality Checks Prior to Submission of ETL-Processed Datasets to the AI-READI EHR Hub.](https://github.com/AI-READI/ai-readi_cohort_ehr_data_acquisition/blob/main/useful_qc_check_code_blocks.md)
