"""Turn the exported G notebook into one CSV per cell, in tables/.

Export G_rule_tables as .ipynb to ref_files/, then:
    python3 make_tables.py [notebook] [out_dir]
"""
import csv
import json
import re
import sys
from pathlib import Path

HERE = Path(__file__).parent
DBX = 'application/vnd.databricks.v1+output'


def table(cell):
    """Column names and rows of a cell's result, or None if it has none."""
    for output in cell.get('outputs', []):
        meta = output.get('metadata', {}).get(DBX, {})
        if meta.get('data') is None:
            continue
        return [f['name'] for f in meta['datasetInfos'][0]['schema']['fields']], meta['data']
    return None


def main(notebook, out_dir):
    out_dir.mkdir(exist_ok=True)
    for cell in json.loads(notebook.read_text(encoding='utf8'))['cells']:
        name = re.search(r'^-- G\d+ (\w+):', ''.join(cell['source']), re.M)
        result = table(cell)
        if not name or result is None:
            continue
        columns, rows = result
        with (out_dir / f'{name[1]}.csv').open('w', newline='', encoding='utf8') as f:
            writer = csv.writer(f, lineterminator='\n')
            writer.writerow(columns)
            writer.writerows(rows)
        print(f'{name[1]}.csv: {len(rows)} rows')


if __name__ == '__main__':
    args = sys.argv[1:]
    main(Path(args[0]) if args else HERE / 'ref_files' / 'G_rule_tables.ipynb',
         Path(args[1]) if len(args) > 1 else HERE / 'tables')
