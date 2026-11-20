"""Charts for README.md and status reporting.

unit_assignment and conversion: counts copied from the E_review_outputs
notebook run (cells E1 and 19a). lab_unit_outcomes: reads E7's export,
lab_unit_outcomes.csv.
Run: uv run --no-project --with matplotlib python make_charts.py
"""
import csv
import re
from pathlib import Path

import matplotlib.pyplot as plt
from matplotlib.ticker import FuncFormatter

OUT = Path(__file__).parent
SURFACE, INK, INK2, MUTED, GRID = '#fcfcfb', '#0b0b0b', '#52514e', '#898781', '#e1e0d9'
SERIES = ['#2a78d6', '#eb6834']  # validated categorical slots 1-2

plt.rcParams.update({
    'font.family': 'sans-serif',
    'font.sans-serif': ['Helvetica Neue', 'Helvetica', 'Arial', 'DejaVu Sans'],
    'font.size': 10, 'text.color': INK, 'axes.labelcolor': INK2,
    'xtick.color': MUTED, 'ytick.color': INK2,
    'figure.facecolor': SURFACE, 'axes.facecolor': SURFACE,
})
millions = FuncFormatter(lambda x, _: f'{x / 1e6:g}M' if x else '0')


def style(ax):
    for side in ('top', 'right', 'left'):
        ax.spines[side].set_visible(False)
    ax.spines['bottom'].set_color(GRID)
    ax.tick_params(axis='y', length=0)
    ax.grid(axis='x', color=GRID, linewidth=0.8)
    ax.set_axisbelow(True)
    ax.xaxis.set_major_formatter(millions)


def unit_assignment():
    # (group, unit found, no UCUM unit exists, failed to find unit); E1 by part.
    # B's failures include the few {log} records a correction leaves with no
    # unit (too few to show alone), as in the README's opening table.
    parts = [
        ('A  No unit, has a reference range', 185_111, 5_780, 83),
        ('B  Unit text, or a unit code with no UCUM unit', 231_597, 106, 447),
        ('C  No unit, no reference range', 1_078_361, 15_032, 4_528),
    ]
    outcomes = ['Unit found', 'No UCUM unit exists', 'Failed to find unit']
    colors = SERIES + [MUTED]
    fig, ax = plt.subplots(figsize=(8, 3.4))
    labels = [f'{p[0]}\n{sum(p[1:]):,} records' for p in parts]
    left = [0] * len(parts)
    for i, (name, color) in enumerate(zip(outcomes, colors)):
        vals = [p[i + 1] for p in parts]
        ax.barh(labels, vals, left=left, height=0.5, color=color,
                edgecolor=SURFACE, linewidth=0.5, label=name)
        left = [l + v for l, v in zip(left, vals)]
    # the two smaller outcomes are too thin to see at this scale, so all three are spelled out
    for y, (p, end) in enumerate(zip(parts, left)):
        no_ucum = f'{p[2]:,} no UCUM unit\n' if p[2] else ''
        ax.text(end + 12_000, y, f'{p[1]:,} unit found\n{no_ucum}{p[3]:,} failed to find unit',
                va='center', color=INK2, fontsize=8.5)
    ax.invert_yaxis()
    ax.set_xlim(0, 1_450_000)
    style(ax)
    ax.legend(loc='lower right', frameon=False, ncol=3, fontsize=9,
              bbox_to_anchor=(1, -0.38))
    ax.set_title('Records that arrived without a unit concept',
                 loc='left', fontsize=11, fontweight='bold')
    fig.tight_layout()
    fig.savefig(OUT / 'unit_assignment.png', dpi=200)


def conversion():
    # 19a, records by conversion method
    rows = [
        ('Already in canonical unit', 5_556_849),
        ('Converted by unit factor', 920_376),
        ('Converted via molar mass or charge', 56_202),
        ('No fixed conversion', 3_534),
    ]
    fig, ax = plt.subplots(figsize=(8, 2.8))
    ax.barh([r[0] for r in rows], [r[1] for r in rows], height=0.5,
            color=SERIES[0], edgecolor=SURFACE, linewidth=2)
    for y, (_, n) in enumerate(rows):
        ax.text(n + 40_000, y, f'{n:,}', va='center', color=INK2, fontsize=9)
    ax.invert_yaxis()
    ax.set_xlim(0, 6_900_000)
    style(ax)
    ax.set_title('Records with a unit, by conversion to the canonical unit',
                 loc='left', fontsize=11, fontweight='bold')
    fig.tight_layout()
    fig.savefig(OUT / 'conversion.png', dpi=200)


# E7 segments in stack order: (segment, legend label, color). Gray is data that
# arrived ready; colors are what harmonization did; the last five are failures.
SEGMENTS = [
    ('source_canonical', 'Arrived with the canonical unit', '#c3c2b7'),
    ('source_converted', 'Arrived with a unit, converted', '#2a78d6'),
    ('text_mapped', 'Unit text mapped to a unit', '#e87ba4'),
    ('inferred_canonical', 'Unit inferred, already canonical', '#005f00'),
    ('inferred_converted', 'Unit inferred, converted', '#d95926'),
    ('no_conversion', 'No conversion to the canonical unit', '#eda100'),
    ('no_ucum_unit', 'No UCUM unit exists', '#6250d6'),
    ('unable_to_infer', 'Unable to infer a unit', '#e34948'),
    ('nonsensical', 'Unit or value nonsensical', INK),
    ('suppressed', 'Under 11 records, merged', MUTED),
]
IMPROVED = {'source_converted', 'text_mapped', 'inferred_canonical', 'inferred_converted'}
VALID = IMPROVED | {'source_canonical'}
SHORT_NAMES = {'3029187': 'NT-proBNP', '3019897': 'RDW'}


def short_name(concept_id, name):
    if concept_id in SHORT_NAMES:
        return SHORT_NAMES[concept_id]
    name = re.sub(r'\s*\[[^]]*\]', '', name)
    name = re.sub(r' (in|of) (Serum or Plasma|Blood|Red Blood Cells)| by (Automated count|calculation)', '', name)
    name = name.replace(' by High sensitivity method', ' (hs)').replace(' in Urine', ', urine')
    return re.sub(r'(?<=\w)\.(?=[a-z])', ', ', name)


def pct_text(n, total, floor=False):
    """floor: the suppressed segment could hold more of these records, so the share is a minimum."""
    p = 100 * n / total
    if floor and p >= 99.95:
        return '≥99.9%'
    text = f'{p:.1f}%' if p >= 0.1 or not n else '<0.1%'
    return '≥' + text if floor and n else text


def lab_unit_outcomes(src=OUT / 'lab_unit_outcomes.csv', out=OUT):
    """Per-lab unit outcomes (after Bradwell et al., JAMIA 2022): a 100% bar per
    lab, PNG/SVG/PDF, plus a wide table with shares. E7 has already rounded and
    suppressed the counts; an empty n is a segment still under 11."""
    labs = {}
    for r in csv.DictReader(open(src)):
        lab = labs.setdefault(r['concept_id'], {
            'name': short_name(r['concept_id'], r['concept_name']),
            'fields': r['fields'], 'total': int(r['n_total']), 'n': {}})
        lab['n'][r['segment']] = int(r['n']) if r['n'] else None
    # rounding every count up makes the parts sum past n_total, so shares are of the parts' sum
    for l in labs.values():
        l['parts'] = sum(n or 0 for n in l['n'].values())
        l['improved'], l['valid'] = (sum(l['n'].get(s) or 0 for s in group) for group in (IMPROVED, VALID))
    labs = sorted(labs.values(), key=lambda l: (-l['improved'] / l['parts'], -l['total']))
    present = [s for s in SEGMENTS if any(s[0] in l['n'] for l in labs)]

    with open(out / 'lab_unit_outcomes_table.csv', 'w', newline='') as f:
        w = csv.writer(f)
        w.writerow(['lab', 'fields', 'records'] + [x for s in present for x in (s[0], s[0] + '_pct')])
        for l in labs:
            row = [l['name'], l['fields'], l['total']]
            for seg, *_ in present:
                n = l['n'].get(seg, 0)
                row += ['<11', ''] if n is None else [n, round(100 * n / l['parts'], 2)]
            w.writerow(row)

    height = 0.24 * len(labs) + 2.2
    fig, ax = plt.subplots(figsize=(10, height))
    y = range(len(labs))
    left = [0.0] * len(labs)
    for seg, label, color in present:
        vals = [100 * (l['n'].get(seg) or 0) / l['parts'] for l in labs]
        ax.barh(y, vals, left=left, height=0.72, color=color, edgecolor=SURFACE, linewidth=1,
                hatch='////' if seg == 'suppressed' else None, label=label)
        left = [a + v for a, v in zip(left, vals)]
    ax.set_yticks(list(y), [l['name'] for l in labs], fontsize=8.5)
    ax.invert_yaxis()
    ax.set_xlim(0, 100)
    ax.set_xticks(range(0, 101, 25), [f'{t}%' for t in range(0, 101, 25)])
    for side in ('top', 'right', 'left', 'bottom'):
        ax.spines[side].set_visible(False)
    ax.tick_params(length=0)
    # the improved share is often too thin to see, so it is spelled out
    # a suppressed segment makes Valid a floor; Improved shows one only where it would round to 100%
    sup = lambda l: 'suppressed' in l['n']
    columns = [(1.17, 'Records', lambda l: f"{l['total']:,}"),
               (1.31, 'Improved', lambda l: pct_text(l['improved'], l['parts'],
                                                     sup(l) and l['improved'] == l['valid'])),
               (1.45, 'Valid', lambda l: pct_text(l['valid'], l['parts'], sup(l)))]
    at = ax.get_yaxis_transform()  # x in axes fractions, y in rows
    for x, head, cell in columns:
        ax.text(x, -1, head, transform=at, fontsize=8, color=MUTED, va='center', ha='right')
        for i, l in enumerate(labs):
            ax.text(x, i, cell(l), transform=at, fontsize=8, color=INK2, va='center', ha='right')
    ax.legend(loc='upper left', bbox_to_anchor=(0, -0.035), frameon=False, ncol=2,
              fontsize=8.5, handlelength=1.2)
    ax.set_title('Unit outcomes for REDCap-list labs, all partners pooled',
                 loc='left', fontsize=11, fontweight='bold', pad=14)
    fig.text(0.01, 0.005, 'Numeric records by harmonized test concept, sorted by share improved. Counts rounded up '
             'to a multiple of 10. Outcomes with under 11 records are combined into the hatched segment,\n'
             'drawn only when it reaches 11. Improved: unit converted, mapped or inferred. '
             'Valid: has a value in the canonical unit.', fontsize=7, color=MUTED)
    # fixed margins: tight_layout would count the text columns as plot and shrink the bars
    fig.subplots_adjust(left=0.24, right=0.68, top=1 - 0.7 / height, bottom=1.45 / height)
    for ext in ('png', 'svg', 'pdf'):
        fig.savefig(out / f'lab_unit_outcomes.{ext}', dpi=200)


if __name__ == '__main__':
    unit_assignment()
    conversion()
    lab_unit_outcomes()
