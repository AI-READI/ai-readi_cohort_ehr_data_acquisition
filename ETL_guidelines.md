# OMOP CDM ETL Guidelines

## Orphan Person/Visits or Unlinked Person/Visits

Orphan person/visit links are records that reference `PERSON` or `VISIT` entries that don't exist in the CDM.

- **Unlinked PERSONs** exist in the `PERSON` table but have no clinical records associated with them.
- **Unlinked VISITs** exist in the `VISIT_OCCURRENCE` table but are not referenced by any clinical/domain tables.

Orphans break referential integrity and do not provide useful analytic information. Unlinked PERSONs and VISITs generally have no analytic signal and can distort denominators or complicate visit-based analyses unless they represent legitimate administrative or enrollment records. ETL should detect all three kinds, investigate and fix mapping/source issues, and either exclude orphaned rows from the analytic CDM or move them to an audit table. For unlinked PERSONs and VISITs, keep if needed for coverage/audit (but flag), otherwise correct and archive/remove. Avoid creating synthetic PERSON/VISIT records unless necessary and clearly flagged.

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
#### Check for Orphans

```sql
SELECT person_id 
FROM PERSON
EXCEPT SELECT DISTINCT person_id 
FROM (
SELECT person_id FROM visit_occurrence 
UNION ALL 
SELECT person_id FROM condition_occurrence 
UNION ALL 
SELECT person_id FROM procedure_occurrence 
UNION ALL SELECT person_id FROM measurement 
UNION ALL SELECT person_id FROM drug_exposure 
);
```

```sql
SELECT visit_occurrence_id 
FROM VISIT_OCCURRENCE 
EXCEPT SELECT DISTINCT visit_occurrence_id 
FROM (SELECT visit_occurrence_id 
FROM condition_occurrence 
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
Add automated warnings/alerts if any orphan IDs, unlinked PERSONs, or unlinked VISITs are found (log file, dashboard, or notification).

#### Handling guidance:
Investigate source data and ETL mapping rules to understand why the reference is missing or why visits/persons are unlinked (mapping error, upstream missing record, filtering rules, timing issues, or legitimate non-clinical entities such as administrative scheduling).

If the source truly lacks the referenced person/visit, do not create synthetic PERSON or VISIT records solely to satisfy the link; synthetic records can contaminate analyses.
##### Preferred options for orphans:
Fix the ETL mapping so the fact row correctly links to an existing PERSON/VISIT, or
Exclude the orphaned fact rows from the analytic CDM load and log them for review, or

If retention is required for audit purposes, load the facts into a separate audit table that preserves the original IDs but is excluded from analytic cohorts.

##### Preferred options for unlinked PERSON records:
Keep them when they represent legitimate enrollments/administrative records needed for coverage, enrollment, or audit analyses; flag them clearly (e.g., via observation_period entries) so analysts can include/exclude them intentionally.

If they are the result of ETL errors (duplicate/person creation mistakes), correct the ETL and remove or consolidate the records.
Consider archiving truly inactive/unneeded PERSON rows to a non-analytic archive while preserving audit trails.

##### Preferred options for unlinked VISIT records:
Keep visits that are legitimate administrative/scheduling entries if they are needed for coverage or operational reporting, but flag them clearly so analysts can exclude them from clinical cohorts.

If unlinked visits are due to ETL/mapping errors (visits created but encounter events not mapped), correct the mapping and either link the events or remove the empty visit records.
Consider moving empty/unneeded VISIT_OCCURRENCE rows to an audit/archive area if they are not needed for analyses.

If a decision is made to create placeholder records (only when justified and documented), flag them clearly (use a special source_concept_id, visit_source_value, or observation_period/visit flag) so downstream analysts can exclude them.

##### Documentation & governance:

Record all orphan/unlinked detections, root causes, and remediation actions in the ETL change log.

Define a regular schedule for running these checks (daily/weekly depending on load frequency).

## Minimum QC Before Declaring Data Fit-for-Use in AI-READI Research
Preliminary checks should confirm the presence, plausibility, and correct linkage of diabetes‑relevant medications and labs (e.g., metformin/insulin/SGLT2/GLP‑1, HbA1c, fasting glucose)

Type 2 diabetes patients should have records representing their diagnosis in the CONDITION_OCCURRENCE domain, laboratory measurements relevant to diabetes management (e.g., HbA1c and glucose) in the MEASUREMENT domain, and records of diabetes-related medications in the DRUG_EXPOSURE domain. The presence and appropriate linkage of these records should be verified as part of routine data quality assessment to ensure the data are fit for diabetes research and analytics.

Tailor checks to the cohort: because the data will be used for Type 2 diabetes research, include targeted quality checks for medications and labs commonly associated with Type 2 diabetes (e.g., metformin, insulin, SGLT2 inhibitors, GLP-1 agonists; HbA1c, fasting glucose, lipid panel, creatinine).

### Preliminary Validation

Confirm:

- Presence of diabetes-related medications
- Presence of diabetes-related laboratory measurements
- Correct linkage to PERSON and VISIT records
### QC Check List

Coverage: sufficient number of patients with diabetes diagnosis or treatment to support the intended analyses.

Key data presence: drug_exposure entries for common diabetes medications and measurement entries for HbA1c and glucose exist where expected.

Linkage: diabetes medications and labs correctly reference PERSON and VISIT_OCCURRENCE (no orphans/unlinked visits)

Completeness/timing: dates and sequence of diagnoses, medications, and labs make clinical sense (e.g., baseline labs preceding treatment changes)

Plausibility: lab values and dosages fall within clinically plausible ranges; flag extreme values for review

Consistency: coding (drug and lab concept IDs) is consistent and mappable to standard concepts

Missingness impact: quantify missingness for key variables and assess whether it biases cohort selection or outcomes

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
