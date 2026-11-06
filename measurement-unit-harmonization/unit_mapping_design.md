# Design: one place for what unit a record is in

`unit_mapping` is built in Part A, cells 1g-1l of
[A_unit_inference_range_groups.sql](A_unit_inference_range_groups.sql). How
the pipeline uses it is in [README.md](README.md).

## Why one table

Statements about what unit a record is in need to be in effect before
anything reads units as evidence, or Parts A and C copy wrong units and
`inferred_unit_concept_id` shows them. One table can be looked up for any
unit text or mislabeled unit: what unit it means, where that mapping came
from and why. Mappings come from sources that need no judgment wherever
possible. Judgment calls are allowed only where they are obvious from their
written rationale, so they can be reviewed.

## Rules

1. `unit_mapping` holds every decision about what unit a record is in, other
   than Part A's and Part C's per-test rules. Two kinds of rows:
   - **text**: unit text -> unit, for numeric records with unit text and no
     unit concept (Part B's records).
   - **correction**: a unit code that is wrong for some records -> the unit
     they are really in, or none. Keyed by unit code, optionally a test
     name pattern and a partner.
2. Every row says where it came from (`source`) and why (`rationale`), and
   carries evidence for review.
3. Automatic sources for text, in order of preference:
   1. `ucum_code`: the trimmed text is a standard UCUM code in
      `omop_vocab.concept`.
   2. `redcap_label`: the trimmed text is a `unit_source_value` in
      `redcap_unit_lookup` (Part 0), whose `unit_concept_id` is a standard
      UCUM concept. Example: `x10E3/µL` -> 8848 (`10*3/uL`).
   3. `arrived_unit`: records with the same text arrived with a unit
      concept. The arrived concept is read after the corrections that apply
      to every test and partner, so text `sec` on clotting times counts as
      `s`, not `S`.
   4. `maps_to`: for a non-standard UCUM code, OMOP's "Maps to" target, if
      it is a standard UCUM unit.

   A `judgment` row is typed by hand with a rationale, and applies unless
   an automatic source contradicts it (rule 6).
4. Only standard UCUM concepts are ever assigned (never SNOMED or other
   vocabularies, never non-standard concepts).
5. Matching trims text and ignores case, except where case changes the
   meaning: text goes to review when its candidates disagree.
6. Disagreements are never settled silently. Text gets no unit and is
   listed for review when:
   - its sources give different units, or
   - it matches different units depending on case (`s` second vs `S`
     siemens, `h`/`H`, `mU`/`MU`), or
   - an automatic source contradicts a judgment row.

   Only exact-case automatic matches count as contradicting a judgment row;
   case-insensitive candidates create a case conflict, and a judgment row
   on the exact spelling settles it. So a judgment row mapping `Mu` settles
   it (no exact UCUM match). Where exact sources disagree, a judgment row
   settles it if it picks one of their units (`bpm`: `/min` and
   `{counts}/min`), unless the text is itself a UCUM code: text `S` with a
   judgment row saying `s` stays in review, because `S` is exactly siemens.
7. Part D only picks each test's canonical unit and converts. It writes
   corrections into the table (17d) but doesn't decide them.

## Arrived units that aren't standard UCUM

Every record ends up with a standard UCUM unit or none. Probe run 2026-11-03
(all records with a unit concept that isn't standard, valid UCUM): no
standard non-UCUM units and no SNOMED, only 9 non-standard UCUM concepts,
7,360 records:

| Arrived | n | Maps to | Fits? |
|---|---:|---|---|
| 9117 `mL/min/1.73.m2` | 6,264 | 720870 `mL/min/(173.10*-2.m2)` | yes |
| 9540 `l` | 835 | 8519 `L` | yes |
| 8644 `s/{CO}` | 99 | 8779 `{signal}/[{CO'ratio}]` | yes |
| 8653 `[degC]` | 86 | 586323 `Cel` | yes |
| 8608 `[{index'value}]` | 34 | 8779 `{signal}/[{CO'ratio}]` | yes: all serology (viral IgG/IgM, Strongyloides, gangliosides) with values that fit cutoff indexes |
| 8502 `{smu}` | 13 | 8610 "beta-2 GPI IgG Ab unit" | no: every record is on "Beta 2 glycoprotein 1 IgM Ab" |
| 8501 `{sgu}` | 13 | 8611 "beta-2 GPI IgM Ab unit" | no: every record is on "Beta 2 glycoprotein 1 IgG Ab" |
| 8492 `{log}` | <11 | none (deleted) | no target |
| 8500 `{sau}` | <11 | 8609 `[GPI'IgA'U]` | yes |

So `maps_to` is an automatic source, but not one to trust blind: our
vocabulary swaps SMU and SGU. Also: a few records on "Hemoglobin A1c" arrived as
`s/{CO}`; a concept-mapping error, left in 19d's no-conversion list. The rule:

- Non-standard arrived unit: use its "Maps to" target when that is a
  standard UCUM unit. Every `maps_to` row is listed for review with its
  tests and medians. No target goes to review. A target wrong for the test
  (an IgG unit on an IgM test) gets a judgment row with the right unit and
  the rationale ("SGU is the IgG unit; every record is on the IgG test; OMOP
  maps it to the IgM unit"). A judgment row may override the vocabulary when
  the data supports it, but never the data (rule 6).
- Standard non-UCUM arrived units: none occur. If one appears, it goes to
  review and needs a judgment row (no OMOP relationship links two standard
  concepts).

Signal-to-cutoff results use OMOP's 8779 `{signal}/[{CO'ratio}]` everywhere,
with their own base in `unit_factors`, like the other dimensionless codes.

## Out of scope

- Part A's `unit_concept_rules` and source-name list, and Part C's name
  rules, stay where they are. They decide units per test, not per text.
- No general text rewriting (µ -> u, mc -> u, x10E3 -> 10\*3). Variants come
  only from the automatic sources and judgment rows.
- Deduplicating records one partner stores twice, which belongs upstream.

## Never

- A unit assigned by a judgment row that the data contradicts.
- Case-insensitive matching that merges `s` and `S`.
- Judgment rows whose rationale doesn't make the mapping obvious ("seen in
  data" is not a rationale; "typo for mEq/L", "spelling of mm[Hg]",
  "values fit body weights as ounces; another partner's lb records match its kg (20c)"
  are).

## The table

`hive_metastore.ehr_union_clean_metrics.unit_mapping`, one row per key:

| Column | Meaning |
|---|---|
| `kind` | `text` or `correction` |
| `unit_source_value` | text rows: the text as it appears (trimmed); one row per distinct trimmed spelling, so case variants are separate rows |
| `unit_code`, `test_pattern`, `data_partner_id` | correction rows: the key |
| `unit_concept_id`, `ucum_code` | the unit assigned; NULL when none |
| `decision` | `unit`, `no_ucum_unit` (a quantity UCUM has no unit for, e.g. `ACTIVITY COEFF`), `not_a_unit` (junk), `review` (conflict, no unit until resolved), `unmapped` (no source), `withheld` (correction rows: no unit makes the values fit) |
| `source` | `ucum_code`, `redcap_label`, `arrived_unit`, `maps_to`, `judgment` |
| `matched_by` | text rows: `exact` or `ignoring_case` |
| `rationale` | why; required for `judgment` rows, generated for the others (e.g. "is the UCUM code", "REDCap lookup label for lbscat_plt") |
| `candidates` | every candidate unit with its source |
| `n`, `tests` | record count, and the tests the text or correction applies to (most records first) |
| `median`, `test_median` | median value of the records, and the median of the top test's records, across partners, that arrived in the assigned unit, for spotting wrong mappings |

The typed judgment rows are in `unit_judgments` (1g), merged in with
`source = 'judgment'`. Case variants share one row. Review 1o lists judgment
rows an automatic source already covers with the same unit, so they can be
deleted.

## What this means elsewhere

- A record's unit is `inferred_unit_concept_id` (0 = none), never
  `unit_concept_id`, which stays as it arrived. Corrections apply to a
  record's unit whatever set it: the unit it arrived with, a text row, or
  Part A's and C's copying and rules.
- `review` and `unmapped` text get inferred unit 0.
