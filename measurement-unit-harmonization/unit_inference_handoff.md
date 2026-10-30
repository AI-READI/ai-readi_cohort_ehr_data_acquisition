# Unit inference: status and handoff

AI-READI EHR data on Databricks. Goal: every numeric measurement record gets a
unit (or is marked unitless), a canonical unit, and a harmonized value.

## Tables

- Source: `ehr_union_clean.measurement` (never modified)
- Target: `hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized`,
  a full copy of measurement (7,835,317 rows) with added columns. The
  README's column table lists them and which records each is empty for.
- A cell 1 creates the table (`CREATE TABLE IF NOT EXISTS`); 1b fills the
  inferred columns for records with a unit concept; 1d fills
  `harmonized_measurement_concept_id` (0 where the concept is NULL), and 1e
  checks the corrected records; 1f creates the view `measurement_unit_keyed`
  that C and D read. A view's `SELECT *` is expanded when it is created, so
  1f has to rerun whenever the table is recreated. A table made by the old
  Python in [exploration_queries.md](exploration_queries.md) ("Target output
  table") lacks three of the columns and has to be dropped (README, "Setup
  and running").
- Original `measurement_concept_id`, `unit_concept_id` and
  `unit_source_value` are left untouched. A record's effective unit is
  `COALESCE(NULLIF(unit_concept_id, 0), NULLIF(inferred_unit_concept_id, 0))`; after 1b
  that's the same as `inferred_unit_concept_id`, except that 0 means no unit.
  Following OMOP, `inferred_unit_concept_id` is 0 where a record has unit
  text that maps to no unit (Part B's unitless, not_a_unit and
  unmapped_string, and the same records with no numeric value, set in 1b)
  and NULL where there is no unit text.

Decision and rule tables (all in `hive_metastore.ehr_union_clean_metrics`):
`measurement_concept_corrections`, `unit_concept_rules`, `unit_inference_range_decisions`, `unit_source_name_rules`,
`unit_inference_source_name_decisions`, `unit_string_map`, `unit_string_decisions`,
for Part C `unit_no_range_rules`, `unit_no_range_value_rules`,
`unit_no_range_decisions`, and the views `unit_no_range_records`,
`unit_no_range_evidence`; and for Part D `unit_factors`, `unit_analytes`,
`unit_analyte_bridges`, `canonical_unit_rules`, `unit_relabel_rules`,
`unit_test_units`, `unit_test_analytes`, `unit_conversion_decisions`,
`unit_conversion_medians`, plus the view `measurement_unit_keyed`.

## Notebooks (SQL files)

Run in letter order. Cell numbers run on across the parts (Part A ends at
9, B is 10-12, C is 13-16, D is 17-20).

- [A_unit_inference_range_groups.sql](A_unit_inference_range_groups.sql): Part A
- [B_unit_inference_with_source_value_but_no_unit_concept.sql](B_unit_inference_with_source_value_but_no_unit_concept.sql): Part B
- [C_unit_inference_no_unit_no_range.sql](C_unit_inference_no_unit_no_range.sql): Part C
  (no unit string, no reference range)
- [D_unit_conversion.sql](D_unit_conversion.sql): Part D (conversion to canonical units)
- [E_review_outputs.sql](E_review_outputs.sql): read-only; every check and
  review needed to verify a full run, copied from A-D (plus E1, records by
  part and method; E2 and E3, stale or missing columns; E4, the corrected
  records), each with its expected result. A change to one of those
  queries in A-D has to be copied here.
- [F_probes.sql](F_probes.sql): read-only probes for review questions (F4
  is the evidence for the concept correction); nothing in A-E depends on
  it.

[exploration_queries.md](exploration_queries.md) is the earlier
exploration: the original list of diabetes-related tests, the old table
creation and sizing queries, in `<details>` blocks, and the "Why every
test, not the diabetes list" section.

## Done

Counts by part and method, and where every record ended up, are in the
README's tables (E1 and 20a of the last run). This section is how each
part works.

**Concept correction** (Part A, cell 1d). `measurement_concept_corrections`
maps a concept to the one its records really hold; Parts A-D group by the
result, `harmonized_measurement_concept_id`. One rule, 3023884 -> 3011163
(README, "Records under the wrong concept"). The F4 match counts are in
the rule's note in 1d.
Check 1e flags corrected records at or below the rule's `implausible_max`.
The one corrected record that arrived labeled mg/dL is relabeled to
{ratio} in 17d.

**Units for dimensionless quantities.** Records that have a UCUM unit get
it, though it's dimensionless: pH `pH` (8482); ratios, INR, S/CO and the
unit text `{ratio}` / `A/G Ratio` `{ratio}` (8523); indexes and the unit
text Index / `{index_val}` / TSI Index `{index}` (8529); scores, scales and
pain scales `[score]` (44777566); saturation fractions `{fraction}`
(720868); MoM `{MOM}` (8494); ISR `{ISR}` (8488); OD `[OD'U]` (8590). All
checked against omop_vocab.concept (one standard concept per code).
`unitless` is left for specific gravity, counts, Ct values, the activity
coefficient and RAST class, which UCUM has no unit for. Part D gives each
new code its own base in `unit_factors`, so `{ratio}`, `{calc}` and
`[ratio'U]` stay one class and nothing converts between, say, a ratio and
an index. (A code with no factor row would also work: it's its own class
and converts to itself.)

**Part A** (no unit string or concept, but a reference range). Concept
groups (cells 2-6) copy a unit from labeled records of the same test,
accepted only if the medians agree within a factor of 2; an exact
reference-range match is trusted as is. `unit_concept_rules` sets units by
hand (pH, INR, ratios, indexes) and marks suspect concepts. Concept-0
records use the source-name list (cells 7-9, below).

**Part B** (unit string, no unit concept). `unit_string_map` maps each
string by hand (cell 10); a string with no map that already maps to a unit
concept elsewhere in the table is reused_mapping.

**Part C** (no unit string, no unit concept, no reference range). Almost
all from one partner, mostly flowsheet and exam data. About 100 tests cover
97% of the records, and most have no labeled records to copy a unit from,
so name rules (`unit_no_range_rules`, regexes on the test name) do most of
the work. Decisions are per (partner, test), in this order: name rule,
Part A's concept rule, copied from labeled records (same partner first;
group median within a factor of 2 of the candidate's), the source-name
list, needs_review. Records are picked by their raw columns (no unit
string, no unit concept, no range_high), so rerunning sees the same records
and never uses its own output as evidence. Unitless records don't count as
evidence (cell 13a).

value_split covers body temperature (Cel / [degF]), "Protein/Creatinine
Ratio, Exte" (mg/mg / mg/g) and "Residual volume/Total capacity". That last
test holds two records per exam: RV/TLC in % and TLC in L (100 * RV / low =
high in all 214 exams, cell 15f). Values under 8 are TLC and get
suspect_concept. SVR is `dyn.sec/cm5` (32703) and SVR index `dyn.s/cm5/m2`
(720841); OMOP spells the two inconsistently.

**Source-name list** (Part A cell 7, used by Part C). Concept-0 records get
a unit from an exact list of 80 lowercased, trimmed source names (some
source values carry a trailing space). Exact names, not patterns, because
nothing checks these units against the values: `%hemoglobin%` would give
HbA1c g/dL, `%globulin%` thyroglobulin, `%neutrophils%` percentages. Every
name was checked against its values and reference ranges (E 8b for Part A,
F5 for Part C, which lists every Part C group on the list whatever its
method). A new name with no other evidence shows up as no_concept in 8b
(Part A) or needs_review in 15c (Part C).

**Part D.** Conversion to a canonical unit per test. A test is the measurement
concept, or the measurement_source_value for concept 0.

- Every unit maps to a base (`unit_factors`: base = slope * x + intercept).
  Units with the same base convert directly. Equivalent codes are units with
  the same factor (/min = {counts}/min, % = %{of'HGB}, [iU] = [U],
  10\*3/mm3 = 10\*3/uL, and so on).
- Analytes found by name pattern (`unit_analytes`) bridge mass, molar and
  equivalent units using molar mass and charge. So mEq/L = mmol/L only for
  monovalent ions, and HbA1c % <-> mmol/mol uses the IFCC formula.
- `unit_relabel_rules` convert a unit as if it were another one. They cover
  mis-coded units (S/H used for seconds/hours, [foz_us] on weights, `deg` on
  temperature, `m2` on BMI, `mL/min` on eGFR) and a few labels the values
  contradict (CEA "mg/dL"). A rule with no target blocks conversion. Rules
  based on a code's meaning (S, H, [degC], [foz_us] on weights) apply to every
  partner; rules based on medians apply only to the partners whose medians
  showed it (applied to everyone, `deg` -> [degF] would turn a Celsius
  partner's 37 into 2.8 °C). Partner 2084's "Body weight" `[lb_us]` records
  are ounces (raw median 2,847; partner 8469's pounds match its kg records
  per person, cell 20c).
- Decisions are per (partner, test, unit); the canonical unit is per test,
  chosen across partners.
- The canonical unit is the most common one (equivalent codes counted
  together), unless a name-pattern rule in `canonical_unit_rules` sets it
  (body weight kg, height cm, temperature Cel, HbA1c %, 24 h urine protein
  mg/(24.h)).
- The 19e review compares the median converted value with the median of
  records already in the canonical unit. That's how the relabels were found.
- 19f lists the tests whose canonical unit is a judgment call: set by a
  rule, or a second unit class with at least 20% of records.

Run order is A, B, C, D. Part C uses units from A and B as evidence, and
Part D converts the units all three assign. Every apply (cells 6, 9, 12, 16)
clears Part D's columns (canonical unit concept and code, conversion
method, harmonized value) on the records it writes, so a rerun of any part
needs a Part D rerun after it. D's apply touches only records with a unit,
so without that clearing a record whose unit was taken away keeps a stale
canonical unit (E2 checks for this).

## Next step

The last full run (Siggie's E_review_outputs.ipynb, 2026-10-28) had every
check empty and every review matching its comment. The README, this file and the charts
([charts/make_charts.py](charts/make_charts.py) has the counts typed in)
carry its counts. After a rerun, update all three from E. The two changes
since (live REDCap map in F2; inferred unit 0 for unmappable unit text)
haven't been rerun: expect E 20a unchanged and E3 empty.

The work moved from Siggie's fork (PR #3) to a branch in
AI-READI/ai-readi_cohort_ehr_data_acquisition, at Stephanie's request.

Stephanie's decisions (2026-10-30):

- **Scope:** keep every test. Tests on the REDCap list get the most careful
  checks; their accuracy is never traded for more rows overall.
- **Unit codes:** standard UCUM (our mmol/L, [iU]/L), not the list's mEq/L
  and IU/L labels.
- **Map version:** the latest. v1.8.4 is the last release that changed the
  concept map, so `redcapsurveydb.unit_concept_lookup` (v1.8.4) is current.

Agreed work, in order:

1. **Validate Part A against plausibility limits.** Section U8 of
   DataElementMaps'
   [09_validate_units_and_value_ranges.sql](https://github.com/AI-READI/DataElementMaps/blob/main/redCapDataDictionaryWithExtension/value-set-mapping-common/scripts/09_validate_units_and_value_ranges.sql)
   has limits per REDCap field: implausible (imp_lo/imp_hi) and clinically
   extreme (ext_lo/ext_hi), in the list's units. It was written for the
   survey data. Build a limits table keyed by EHR concept in Part A's
   notebook (fields map to concepts through `target_concept_id` in
   `scripts/unit_concept_lookup_extended.csv`), with a pointer to 09's
   version. Check Part A's records on list tests: the value and the
   reference range, in the record's inferred unit. An inferred unit that
   makes them implausible is dropped (no unit), with a method saying why.
   Records that arrived with a unit aren't touched. Extreme values are only
   counted: EHR patients are sicker than survey participants.
2. **Part B unit-text matching.** Trim and ignore case when comparing
   unit_source_value, and map label variants to the standard UCUM concept
   (never SNOMED). Example: the lookup's platelet label `x10E3/µL` (line 56)
   and UCUM `10*3/uL` are both concept 8848. Where case changes the meaning
   (`s` second vs `S` siemens, `h`/`H`, `mU`/`MU`), list the strings for
   review instead of merging them.
3. **Review of records with no concept that got a unit**, through the
   source-name list (1,033 in A, 469 in C) or C's copying on `src:` test
   ids. One row per source name and partner, with n, unit, method and
   median, for Stephanie to sign off; rejected rows get no unit. The 09
   limits can't check these, since they have no concept.
4. **F2 reads `redcapsurveydb.unit_concept_lookup`** instead of its typed
   copy of the list.

## Not done

1. **Part C leftovers** still needs_review (659 records): log viral
   loads (left unmapped, as in Part B), Treadmill MPH (28; OMOP UCUM has no
   mile per hour), and tests with no rule yet: Creatinine/Protein [Mass
   Ratio] in Urine (94, median 235, looks like protein/creatinine mg/g),
   Physical findings of Skin (69, integers 1-10), Aldosterone/Renin ratio
   (33), plus one-offs. The 5 Part B records with unit string
   `dynes-sec/cm5/m2` have concept 0 and could map to 720841.
2. **Flagged items to look at:**
   - suspect_concept records: CD4+CD8+ cells/cells that look like CD4/CD8
     ratios, "total T4" that is free T4, an
     "A1AT phenotype" holding an IgA value
   - Beta-2 glycoprotein IgM (4 records)
   - INR concept: 1,440 records in seconds with median 12, so PT values
     stored under INR. INR's canonical unit is {ratio}, so they show in 19d
     as no_conversion (`s` and `S` rows, 720 each: duplicates, below).
   - Reticulocytes [#/volume] by automated count: 312 records in 10\*6/mm3
     with median 4.25, so RBC counts, not reticulocytes (about 0.06)
   - Records stored twice (F6, F7): partner 2084 stores 4,119 events in 17
     tests twice, under unit codes that differ only in case (`S`/`s` on
     clotting times such as PT, aPTT, INR, ACT, dRVVT; `L`/`l` on
     expiratory minute volume; `H`/`h` on collection durations). Same
     person, time and value. The `S` -> `s`, `H` -> `h` and `l` -> `L`
     relabels make both copies convert to the same value. Left as they
     arrived; deduplicating is upstream's call.
   - Tidal volume setting: mL and mL/kg (labeled kg) under one concept
3. **Canonical-unit judgment calls** (19f). Undecided:
   - AI-READI's REDCap mapping
     ([value-set-mapping-common](https://github.com/AI-READI/DataElementMaps/tree/main/redCapDataDictionaryWithExtension/value-set-mapping-common)
     in DataElementMaps) gives a unit per test for about 50 tests; always
     read the live version. Every test on it that's in the EHR data is
     harmonized (F2). Its labels differ from our UCUM codes for Na, K, Cl,
     total CO2 (mEq/L; ours mmol/L, same numbers) and AST/ALT/ALP (IU/L;
     ours [U]/L, equivalent); UCUM stays (Stephanie, 2026-10-30). Urine
     albumin is mg/dL there; our canonical unit hasn't been checked against
     it. Insulin's ng/mL is for the survey data (09's U5); EHR insulin is
     under 3009413 and 3016244 (Insulin [Units/volume]) in uIU/mL, and
     there are no records under the list's 3022466.
   - Real choices in the data: CRP mg/L vs mg/dL (51/49), testosterone ng/mL
     vs ng/dL (56/44), T3 ng/dL vs ng/mL, radiation dose cGy vs Gy, 24 h
     urine urea nitrogen g vs mg.
   - Two quantities under one test, so no canonical unit covers both: RA/RV/LV
     lead pacing threshold V vs ms, RV free wall S' mm[Hg] vs cm/s, tidal
     volume setting mL/kg vs mL, ionized calcium mmol/L vs %.
4. **Relabels whose result still doesn't match** (ad hoc query on
   unit_conversion_medians, relabeled rows): CEA mg/dL -> ng/mL ratio 0.31,
   testosterone ug/dL -> ng/mL ratio 2.29, 24 h urine protein g/[dose] ratio
   0.53, expiratory minute volume `L` and `l` duplicates ratio 1.79.
5. **HDL mass records that look like ratios** (F4a): 31 records under
   3007070 "Cholesterol in HDL [Mass/volume]" are under 15 mg/dL (values
   1.8-13), across partners 2084, 3058 and 8469. Only one (2084, value 13,
   same-day total/HDL 13.1) could be matched to that day's lipids; the
   rest have no same-day total and HDL. They're converted as mg/dL for now.
6. **A/G and BUN/creatinine ratios** (F2, F3c). 4 A/G records have unit
   text `**Please` (not_a_unit, so no unit; values about 1.8). The REDCap
   list has two BUN/creatinine entries: import_bun_creatinine_ratio is
   3018311, but import_buncreatinineratio is 3033837 "Creatinine/Urea
   nitrogen", the inverse ratio, which has no records.

## Gotchas learned

- The measurement table has no `value_source_value` column, so there's no raw
  value text to look for units in.

- OMOP UCUM codes write international units as `[iU]` (lowercase i) and
  prefixes as powers of ten: `10*-6.[iU]/mL` = uIU/mL, `10*-3.eq/L` = mEq/L,
  `mL/min/(173.10*-2.m2)` = eGFR units, `[lb_us]` = pound.
- Every hand-written unit code needs a check query against `omop_vocab.concept`
  (vocabulary_id = 'UCUM', invalid_reason IS NULL); codes written from
  memory are often wrong.
- In Spark SQL an apostrophe inside a string is `\'`. `''` silently joins two
  strings (`'[APL''U]'` became `[APLU]`).
- Concept-level rules (e.g. "unitless") apply to every group with that concept.
- exploration_queries.md's sizing query counts unit concept 0 as a unit, so
  its "concepts with several units" figure overstates.
- Some unit codes in the data aren't valid UCUM (`[degC]`, `mL/min/1.73.m2`).
  Map them with a relabel rule, not a factor row, so the code check stays clean.
- Every `max_by` / `ROW_NUMBER` pick needs a tiebreaker (the unit code or
  concept id after the count). Without one, tests with two units of equal
  count got a different canonical unit on each run.
- Name patterns are Java regexes with `(?i)` applying to the whole pattern:
  `(?i)BUN` matched "sub**un**it" and `urate` matched "unsat**urate**d". Anchor
  them or use `(?-i:...)`.

## Working conventions

- Claude can't reach Databricks; Siggie runs each query and pastes results back.
- Notebook files are in Databricks source format so Siggie can import them
  (Workspace > Import > File) without splitting cells by hand: first line
  `-- Databricks notebook source`, cells separated by
  `-- COMMAND ----------`, no `%sql` lines.
- Siggie deletes the notebooks, re-imports every file and reruns A-F from
  scratch after each change, then exports E and F to `ref_files/` for
  checking. No paste-ready changed cells needed. Docs carry no Databricks
  URLs: they change on every re-import.
- Every query whose result needs looking at gets its own cell;
  table-building statements can share a cell.
- When several outputs are needed from cells spread across notebooks, put
  them in one review notebook (like [E_review_outputs.sql](E_review_outputs.sql)) so Siggie runs
  one file and pastes everything once.
- Pattern for each step: build rules, run a check (should return no rows),
  build decisions, review, then apply with a rerunnable MERGE.
