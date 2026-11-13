# Unit harmonization: notes for changing the pipeline

Results, tables, notebooks, run steps and known issues are in
[README.md](README.md). How each part works is in the comments of its SQL
file. This file holds what those don't.

## After a rerun

The README, [charts/make_charts.py](charts/make_charts.py) (counts typed in),
and E's expectations carry the counts of the last run. Update all three from
E, and refresh `tables/` from G.

Nothing identifying goes in the repo:

- No partner ids in text. They appear only as rule keys in A's cell 1g.
- No medians or record values in rationales or notes.
- Docs report no count under 11. Merge the row or cell instead, and check that
  totals don't give it back. Low counts aren't PHI; this avoids inviting
  curiosity. E's expectation comments follow the same rule. Part B's
  `no_ucum_unit` records are counted with B's failures for this reason.
- Read every CSV from [make_tables.py](make_tables.py) before committing it.
  `ref_files/` is excluded from git; `tables/` isn't.

## Project decisions

- **Scope:** keep every test. Tests on the REDCap list get the most careful
  checks; their accuracy is never traded for more rows overall.
- **Unit codes:** standard UCUM (our mmol/L, [iU]/L), not the list's mEq/L and
  IU/L labels.
- **Map version:** the latest. Part 0 loads the files from DataElementMaps'
  `main` on every run, not the copies in `redcapsurveydb`.
- **Plausibility limits flag values and never change units.** On list tests,
  Part A's implausible values were bad values with a correct unit, and most of
  those records carry an entry limit as their "reference range". Dropping units
  would have removed correct units and caught no wrong one.

## Conventions in the data

- A record's unit is `inferred_unit_concept_id` with 0 read as no unit; never
  `unit_concept_id`, which stays as it arrived. 0 means unit text that maps to
  no unit, or a correction left none. NULL means no unit text. Records with no
  numeric value are outside Part B, so they keep NULL unless they arrived with
  a unit concept.
- Corrections are computed from `COALESCE(unit_corrected_from, ...)`, so
  reruns agree and a removed rule shows up in E5.
- Corrections based on a code's meaning apply to every partner. Those based on
  medians apply only to the partners whose medians showed it: applied to
  everyone, `deg` -> [degF] would turn a Celsius partner's 37 into 2.8 °C.
- Part D gives each dimensionless code its own base in `unit_factors`, so
  nothing converts between, say, a ratio and an index.

## Gotchas

- A view's `SELECT *` is expanded when it is created, so cell 1j has to rerun
  whenever the table is recreated.
- The measurement table has no `value_source_value` column, so there's no raw
  value text to look for units in.
- OMOP UCUM codes write international units as `[iU]` (lowercase i) and
  prefixes as powers of ten: `10*-6.[iU]/mL` = uIU/mL, `10*-3.eq/L` = mEq/L,
  `mL/min/(173.10*-2.m2)` = eGFR units, `[lb_us]` = pound.
- Every hand-written unit code needs a check in the gate against `ucum_units`;
  codes written from memory are often wrong.
- Some unit codes in the data aren't standard UCUM (`[degC]`,
  `mL/min/1.73.m2`). `unit_mapping` corrects them; don't give them a factor
  row.
- In Spark SQL an apostrophe inside a string is `\'`. `''` silently joins two
  strings (`'[APL''U]'` became `[APLU]`).
- Every `max_by` / `ROW_NUMBER` pick needs a tiebreaker (the unit code or
  concept id after the count). Without one, tests with two units of equal count
  got a different canonical unit on each run.
- Name patterns are Java regexes with `(?i)` applying to the whole pattern:
  `(?i)BUN` matched "sub**un**it" and `urate` matched "unsat**urate**d". Anchor
  them or use `(?-i:...)`.

## Working conventions

- Notebook files are in Databricks source format, so they import without
  splitting cells by hand: first line `-- Databricks notebook source`, cells
  separated by `-- COMMAND ----------`, no `%sql` lines.
- After each change: delete the notebooks, re-import every file, rerun A-D
  and the gate (Part 0 only to reload the list), run E and F, and export them
  to `ref_files/` for checking. Docs carry no Databricks URLs: they change on
  every re-import.
- Cell numbers run on across the parts: Part 0 is 0a-0d, A ends at 9, B is
  10-12, C is 13-16, D is 17-20.
- No queries in 0 or A-D, because they run in batch. Each step's cell comment
  names its checks and reviews, which keep the step's cell number.
- A query that should return no rows is a check: a temp view in
  [E_gate_checks.sql](E_gate_checks.sql), named in the `CHECKS` list in its last
  cell. Every other query gets its own cell in
  [E_review_outputs.sql](E_review_outputs.sql). Table-building statements can
  share a cell.
- Pattern for each step: build rules, build decisions, then apply with a
  rerunnable MERGE.
