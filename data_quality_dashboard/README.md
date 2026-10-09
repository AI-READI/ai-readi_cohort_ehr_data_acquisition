## EHR Union Limit Dataset Data Quality Dashboard SQL Queries
This repository contains SQL queries used to support the EHR Union Limit Dataset Data Quality Dashboard.

### Tab Groups
The queries are organized by dashboard tab groups such as:
* overview
* all
* ehr survey linkage
* Person
* Condition
* Observation
* Procedure
* Measurement
* Visit
* Multi-day Visit
* Macro Visit
* Device Exposure
* Drug Exposure
* Death
* Misc - implausible checks

### Purpose
These queries are used to:

extract and validate dashboard data
support data quality checks
generate metrics for specific dashboard tabs
maintain consistency across EHR union limit dataset reporting

### Notes
Query names should be descriptive and indicate the metric or check performed.
If a query is updated, please include a brief note in the commit message.
Add comments in SQL files when business logic or filters are not obvious.


