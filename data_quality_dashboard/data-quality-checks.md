
## SQL Query Overview

This repository contains SQL queries used to support the EHR Union Limited Data Set data quality dashboard.  
The queries are organized into dashboard tabs and are designed to provide:

- overall dataset summary counts
- domain-level counts and distributions
- site-level breakdowns across three data partner sites
- data quality checks for invalid or suspicious records
- EHR and survey linkage validation
- checks for orphan or unreferenced records
- age, visit duration, and date range outlier detection
- concept-level summaries for conditions, observations, procedures, drugs, measurements, devices, and deaths
- rare concept review and custom concept search support
- macro visit and multi-day visit analyses

- These SQL queries support dashboard reporting and data quality monitoring for the EHR Union dataset. They include aggregate summaries, concept frequency counts, site-specific comparisons, record linkage checks, orphan record detection, demographic distributions, and outlier checks for dates, age, and visit duration.

## Query Categories in the json file

The SQL queries in this repository are grouped into the following categories:

- **Overview / Unified**: high-level dataset counts and summary metrics
- **Person**: demographic distributions, age checks, and outlier review
- **Condition**: condition counts, standard vs. non-standard concepts, and site-level breakdowns
- **Observation**: observation counts, age-at-first-observation, and frequency summaries
- **Procedure**: procedure counts and site comparisons
- **Measurement**: lab and vital sign summaries, custom search, and value checks
- **Visit**: visit counts, visit duration analysis, future date checks, orphan visit checks
- **Drug Exposure**: drug frequency, diabetic medication usage, and dosage-related summaries
- **Device Exposure**: device counts and device concept summaries
- **Death**: death record summaries and date validity checks
- **EHR Survey Linkage**: participant matching and mismatch checks
- **Misc / Rare Concepts**: rare concept review and unusual record checks
