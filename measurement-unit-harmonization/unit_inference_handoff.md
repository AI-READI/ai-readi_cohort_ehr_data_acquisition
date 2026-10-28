# Unit inference: status and handoff

AI-READI EHR data on Databricks. Goal: every numeric measurement record gets a
unit (or is marked unitless), a canonical unit, and a harmonized value.

## Tables

- Source: `ehr_union_clean.measurement` (never modified)
- Target: `hive_metastore.ehr_union_clean_metrics.measurement_unit_harmonized`
  (full copy of measurement, 7,835,317 rows) plus these columns:
  - `harmonized_measurement_concept_id`: the test as Parts A-D see it:
    `measurement_concept_id`, or its replacement from
    `measurement_concept_corrections` (below); 0 where the concept is NULL
  - `unit_inference_method`: how the unit was decided (values below);
    `copied_from_unit_concept_id` for records that arrived with a unit concept
  - `inferred_unit_concept_id`, `inferred_unit_source_value`: the record's unit
    (UCUM concept id and code), assigned or copied from `unit_concept_id`
  - `canonical_unit_concept_id`, `canonical_unit_value`: the test's canonical
    unit (concept id and UCUM code); set only where
    `harmonized_value_as_number` is in it (NULL for unitless records)
  - `harmonized_value_as_number`: value in the canonical unit, or
    value_as_number for unitless records
  - `unit_conversion_method`: Part D's conversion_method for the record
- A cell 1 creates the table (`CREATE TABLE IF NOT EXISTS`) with all of these;
  1b fills the inferred columns for records with a unit concept; 1d fills
  `harmonized_measurement_concept_id`, and 1e checks the corrected records;
  1f creates the view `measurement_unit_keyed` that C and D read. A view's
  `SELECT *` is expanded when it is created, so 1f has to rerun whenever the
  table is recreated. The table used to be
  created by the Python in [exploration_queries.md](exploration_queries.md)
  ("Target output table"), which lacks the last two columns.
- Original `measurement_concept_id`, `unit_concept_id` and
  `unit_source_value` are left untouched. A record's
  effective unit is `COALESCE(NULLIF(unit_concept_id, 0), inferred_unit_concept_id)`;
  after 1b that's the same as `inferred_unit_concept_id`.

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
  is the evidence for the concept correction below); nothing in A-E
  depends on it.

[exploration_queries.md](exploration_queries.md) is the earlier exploration:
the original list of diabetes-related tests that were to get inferred units,
the target table's creation, and sizing queries, in `<details>` blocks. It
also holds the "Why every test, not the diabetes list" section, moved out of
the README so the README stays on results.

## Done

**Concept correction** (Part A, cell 1d). `measurement_concept_corrections`
maps a concept to the one its records really hold; Parts A-D group by the
result, `harmonized_measurement_concept_id`. One rule: 3023884
"Cholesterol in HDL/Cholesterol.total [Mass Ratio]" -> 3011163
"Cholesterol.total/Cholesterol in HDL [Mass Ratio]". Its 6,464 records
(partner 3058) run 1.5-34.3, median 3.5, and HDL/total can't exceed 1.
F_probes cell F4 matched each record against the same person's same-day
total cholesterol and HDL: 6,454 of 6,457 Part C records, 5 of 6 Part A
records and the one record that arrived with a unit equal total/HDL within
10%; the other 4 have no same-day lipids. Partner 2084's 3011163 records and
3058's concept-0 "Cholesterol/HDL Ratio" match the same way. Check 1e flags
corrected records at or below 1 (`implausible_max`). The one corrected
record that arrived labeled mg/dL is relabeled to {ratio} in 17d.

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

**Part A.** Numeric records with no unit string and no unit concept, but with a
reference range: 205,212 records.

| Method | Meaning |
|---|---|
| dataset_unit / partner_unit / range_match | unit copied from other records of the same test (any partner / same partner / same partner and same reference range) |
| explicit | unit set by hand per concept (unit_concept_rules), including pH, INR, ratios, indexes |
| source_name | concept 0; unit decided from measurement_source_value |
| unitless | specific gravity |
| suspect_concept | values don't fit the concept (likely concept-mapping error); 82 records |
| needs_review / no_concept | undetermined; 6 records |

Result (last run): 195,464 got a unit, 9,660 unitless (specific
gravity), 88 without a unit (82 suspect_concept, 6 undetermined).

**Part B.** Numeric records with a unit string but no unit concept: about 55,000
records, 223 strings.

| Method | Meaning |
|---|---|
| mapped_string | hand map (unit_string_map) |
| reused_mapping | same string already maps to a concept elsewhere in the table |
| unitless | ACTIVITY COEFF only ({ratio}, Index, S/CO, ISR, OD are mapped_string now) |
| not_a_unit | junk in the unit field ("Possible", "**Please", "PharmD", "Urine") |
| unmapped_string | left on purpose (58 strings: log viral loads, FLU, CU, per-ejaculate counts) |

Result (last run): 55,267 records; 49,035 got a unit (mapped_string,
reused_mapping), 1 unitless, 6,231 without a unit (5,956 unmapped_string,
275 not_a_unit).

**Part C.** Numeric records with no unit string, no unit concept and no
reference range: 1,066,251 records, almost all from one partner, mostly
flowsheet and exam data. About 100 tests cover 97% of them, and most of those
tests have no labeled records to copy a unit from, so name rules
(`unit_no_range_rules`, regexes on the test name) do most of the work.
Decisions are per (partner, test). Records are picked by their raw columns
(no unit string, no unit concept, no range_high), so rerunning sees the same
records and never uses its own output as evidence.

| Method | Meaning |
|---|---|
| explicit / unitless / not_a_quantity / needs_review | name rule (not_a_quantity: codes, IDs, admin fields such as EKG impression codes, HLA alleles, case numbers; unitless: counts, Ct values, RAST class) |
| partner_unit / dataset_unit | copied from labeled records of the same test, same partner first; group median within a factor of 2 of the candidate's |
| source_name | concept 0, Part A's source-name rules (no median check, so name rules override the wrong ones) |
| value_split | group holds two units (or a unit and a different test); each record gets the unit and method of its value band (`unit_no_range_value_rules`) |

value_split covers body temperature (Cel / [degF]), "Protein/Creatinine
Ratio, Exte" (mg/mg / mg/g) and "Residual volume/Total capacity". That last
test holds two records per exam: RV/TLC in % and TLC in L (100 * RV / low =
high in all 214 exams, cell 15f). Values under 8 are TLC and get
suspect_concept. SVR is `dyn.sec/cm5` (32703) and SVR index `dyn.s/cm5/m2`
(720841); OMOP spells the two inconsistently.

pH, saturation fractions and ratios have a name rule each (31-33). The
name rules were renumbered on 2026-10-27, so 14b outputs from earlier runs
use other numbers.

Unitless records no longer count as evidence (cell 13a): what's still
unitless gets it from a rule.

Result (last run): 971,623 explicit (6,457 of them the HDL/total records,
{ratio} under 3011163), 14,784 unitless, 74,361 copied, 469 source_name,
3,790 not_a_quantity, 225 suspect_concept (TLC under RV/TLC), 659
needs_review, 340 value_split.

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
  showed it (a PR review pointed out that `deg` -> [degF] for everyone would
  turn a Celsius "deg" partner's 37 into 2.8 °C). In the last run each of
  those rules hit exactly one partner (two for eGFR `mL/min`: 2084 and
  3058). Partner 2084's "Body weight" `[lb_us]` records are ounces (raw
  median 2,847; partner 8469's pounds match its kg records per person, cell
  20c).
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

| Method | Meaning |
|---|---|
| identity | already in the canonical unit (possibly after a relabel) |
| same_base | converted by unit factors |
| analyte_bridge | converted through molar mass or charge |
| no_conversion | different quantity under one test, or no fixed factor (log viral loads, Lp(a), arbitrary antibody units) |
| blocked | relabel rule says don't convert |

Run order is A, B, C, D. Part C uses units from A and B as evidence, and
Part D converts the units all three assign. Every apply (cells 6, 9, 12, 16)
clears Part D's columns (canonical unit concept and code, conversion method,
harmonized value) on the records it writes, so a rerun of any part needs a Part D rerun after it. D's apply
touches only records with a unit, so without that clearing a record whose
unit was taken away keeps a stale canonical unit (E2 checks for this).

Numeric records after Parts A-D (cell 20a, last run): 7,008,376 in
canonical unit, 24,445 unitless, 4,653 with a unit but no conversion,
10,993 with no unit.

## Next step

The last full run (Siggie's E_review_outputs.ipynb, 2026-10-28, with the
concept correction and the UCUM units) had every check empty and every
review matching its comment. The README, this file and the charts
([charts/make_charts.py](charts/make_charts.py) has the counts typed in)
carry its counts. After a rerun, update all three from E.

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
     as no_conversion: `s` and `S` rows, 720 each with the same median,
     which look like duplicates.
   - Reticulocytes [#/volume] by automated count: 312 records in 10\*6/mm3
     with median 4.25, so RBC counts, not reticulocytes (about 0.06)
   - Expiratory minute volume: `L` and `l` rows, 869 each with the same
     median, look like duplicates
   - Tidal volume setting: mL and mL/kg (labeled kg) under one concept
3. **Write-up for the boss**: drafted as
   [README.md](README.md), charts from
   [charts/make_charts.py](charts/make_charts.py) (counts copied from the E
   run). The scope section ("Why every test", now in
   exploration_queries.md) rests on this evidence about the original
   diabetes test list ([exploration_queries.md](exploration_queries.md),
   "Target variables"), which nobody has a record of; it's reconstructed from
   exploration_queries.md's queries and outputs:
   - The list's query sorts concepts into 29 categories with `LIKE` on the
     OMOP concept name, using clinical labels OMOP names don't contain. 14
     categories match nothing: ALT, AST, total bilirubin, total protein,
     serum albumin, urine albumin, uACR, random urine creatinine, HDL, LDL,
     non-HDL, C-peptide, and eGFR and A/G ratio (both caught first by
     broader patterns, Creatinine and Globulin). BUN's `%bun%` matches only
     hCG "beta su**bun**it"; real BUN ("Urea nitrogen") isn't in the list.
   - Matched categories are too broad: Creatinine takes every x/creatinine
     ratio (arsenic, metanephrine, ...) and all eGFR, Globulin takes
     thyroglobulin, SHBG and thyroid-stimulating immunoglobulins, Glucose
     takes G6PD, Calcium takes stone composition and a channel antibody.
   - The missing units are mostly elsewhere. Of 1,272,255 numeric records
     with no unit at all, 17,860 (1.4%) are in concepts the list matched;
     the bulk is flowsheet data (ETCO2, pain scores, tidal volume, heart
     rate, MAP, BMI). Of 1,327,684 without a unit concept, 33,608 (2.5%).
   - Inside the list the problems are mostly unit variants that need
     conversion (mEq/L vs mmol/L, IU/L vs U/L, spellings), plus mislabels
     (HbA1c in s/co and g/dL, ionized calcium in %). Conversion is
     dataset-wide anyway: about 1.01M records needed converting (19a).
     (exploration_queries.md's sizing query counts unit concept 0 as a unit,
     so its "concepts with several units" figure overstates.)
   - Inferring a unit needs other records of the same test as evidence, and
     once written, the same rules apply to every test.

4. **Canonical-unit judgment calls** (19f, run as an ad hoc query on the
   pre-tiebreaker run; 64 rows). Undecided:
   - AI-READI's REDCap mapping (`_ai_readi_redcap_value_set_mapping_common.csv`
     in the AI-READI DataElementMaps repo; Siggie keeps a copy in the
     untracked `ref_files/`) gives a unit per test for about 50 tests. Where
     it differs from ours: Na, K, Cl, total CO2 in mEq/L (ours mmol/L, same
     numbers), AST/ALT/ALP in [iU]/L (equivalent to our [U]/L), urine
     albumin mg/L. It has no temperature. Every test on it that's in the
     EHR data is harmonized (F2).
   - C-peptide and insulin in the list (CSV lines 509-518): each unit row
     sits under its own question. C-peptide's ng/L doesn't fit our data:
     all 181 records under 3010084 arrived in ng/mL, median 2.74 (2.74 ng/L
     would be far below any C-peptide level). Insulin's ng/mL can't be
     checked: there are no records under its concept 3022466 (Insulin
     [Mass/volume]); F3a found insulin under 3009413 and 3016244 (Insulin
     [Units/volume]), in uIU/mL.
   - Real choices in the data: CRP mg/L vs mg/dL (51/49), testosterone ng/mL
     vs ng/dL (56/44), T3 ng/dL vs ng/mL, radiation dose cGy vs Gy, 24 h
     urine urea nitrogen g vs mg.
   - Two quantities under one test, so no canonical unit covers both: RA/RV/LV
     lead pacing threshold V vs ms, RV free wall S' mm[Hg] vs cm/s, tidal
     volume setting mL/kg vs mL, ionized calcium mmol/L vs %.
5. **Relabels whose result still doesn't match** (ad hoc query on
   unit_conversion_medians, relabeled rows): CEA mg/dL -> ng/mL ratio 0.31,
   testosterone ug/dL -> ng/mL ratio 2.29, 24 h urine protein g/[dose] ratio
   0.53, expiratory minute volume `L` and `l` duplicates ratio 1.79.
6. **Source-name rules** (PR review: broad LIKE patterns). Checked on the
   data: 560 concept-0 records, and the hits look right ("Hemoglobin,
   External" median 11.9 is hemoglobin, not A1c; "Globulin" median 3.1).
   Doubtful single records: "Testosterone, External" 4.0 ng/dL, "Free
   Testosterone, Calculated" 0.8 pg/mL. Tightening the patterns is still
   worth doing before new data arrives.
7. **HDL mass records that look like ratios** (F4a): 31 records under
   3007070 "Cholesterol in HDL [Mass/volume]" are under 15 mg/dL (values
   1.8-13), across partners 2084, 3058 and 8469. Only one (2084, value 13,
   same-day total/HDL 13.1) could be matched to that day's lipids; the
   rest have no same-day total and HDL. They're converted as mg/dL for now.
8. **A/G and BUN/creatinine ratios** (F2, F3c). Albumin/Globulin 3020509
   (1,455 records) and Urea nitrogen/Creatinine 3018311 (1,728) were
   unitless apart from the ones that arrived as {calc}; they now get
   {ratio}, the same class as {calc}. Left over: 4 A/G records whose unit
   text is `**Please` (not_a_unit, so no unit, values about 1.8). The REDCap list
   has two BUN/creatinine entries: import_bun_creatinine_ratio is 3018311,
   but import_buncreatinineratio is 3033837 "Creatinine/Urea nitrogen", the
   inverse ratio, which has no records.

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
- After the first import, changed cells come in chat as paste-ready `%sql`
  blocks, with a note saying which cells changed and that nothing else did.
- Every query whose result needs looking at gets its own cell;
  table-building statements can share a cell.
- When several outputs are needed from cells spread across notebooks, put
  them in one review notebook (like [E_review_outputs.sql](E_review_outputs.sql)) so Siggie runs
  one file and pastes everything once.
- Pattern for each step: build rules, run a check (should return no rows),
  build decisions, review, then apply with a rerunnable MERGE.
