from pathlib import Path
from zipfile import ZipFile
from xml.etree import ElementTree as ET
import json, re
from difflib import SequenceMatcher

ROOT = Path(__file__).resolve().parent
XLSX = Path(r'C:\Users\Redmi\Desktop\阿里巴巴.xlsx')
NS = {'m':'http://schemas.openxmlformats.org/spreadsheetml/2006/main', 'r':'http://schemas.openxmlformats.org/officeDocument/2006/relationships'}

def read_workbook(path):
    with ZipFile(path) as z:
        shared = []
        shared_root = ET.fromstring(z.read('xl/sharedStrings.xml'))
        for si in shared_root.findall('m:si', NS):
            shared.append(''.join(t.text or '' for t in si.findall('.//m:t', NS)))
        wb = ET.fromstring(z.read('xl/workbook.xml'))
        rel = ET.fromstring(z.read('xl/_rels/workbook.xml.rels'))
        relmap = {x.attrib['Id']: x.attrib['Target'].lstrip('/') for x in rel}
        for sheet in wb.findall('m:sheets/m:sheet', NS):
            rid = sheet.attrib['{http://schemas.openxmlformats.org/officeDocument/2006/relationships}id']
            root = ET.fromstring(z.read(relmap[rid]))
            rows = []
            for row in root.findall('.//m:sheetData/m:row', NS):
                values = []
                for cell in row.findall('m:c', NS):
                    value = cell.find('m:v', NS)
                    text = '' if value is None else (value.text or '')
                    if cell.attrib.get('t') == 's' and text:
                        text = shared[int(text)]
                    values.append(text)
                rows.append(values)
            if rows and 'Product Title (Brand-cleaned)' in rows[0]:
                headers = rows[0]
                return [dict(zip(headers, row)) for row in rows[1:] if any(row)]
    return []

def norm(value):
    return re.sub(r'[^a-z0-9]+', '', str(value or '').lower())

def clean_title(value):
    brands = {'kawasaki','rexroth','yuken','xhlf','xlf','xhnotion','focor','yuciyuken','vickers','tokimec','sun','sunhydraulics','sauer','nachi','permc o','permco','xingyu','airtac','tosion','sy','daewoo','doosan','american','m','oog'}
    words = re.findall(r'[a-z0-9]+', str(value or '').lower())
    return ' '.join(w for w in words if w not in brands)

rows = read_workbook(XLSX)
by_url = {r.get('Product Detail URL',''): r for r in rows if r.get('Product Detail URL')}
by_model = {}
for row in rows:
    model = norm(row.get('Model / Series'))
    if model:
        by_model.setdefault(model, []).append(row)

catalog_path = ROOT / 'src' / 'catalog-import.js'
source = catalog_path.read_text(encoding='utf-8')
json_text = source.split('export const importedProducts = ', 1)[1].rsplit(';', 1)[0]
products = json.loads(json_text)
matched = 0
for product in products:
    row = by_url.get(product.get('sourceUrl',''))
    if row is None:
        candidates = by_model.get(norm(product.get('model')), [])
        row = candidates[0] if len(candidates) == 1 else None
    if row and row.get('Product Title (Brand-cleaned)'):
        title = row['Product Title (Brand-cleaned)'].strip()
        product['name'] = title
        product['sourceTitle'] = title
        for variant in product.get('variants') or []:
            vrow = by_url.get(variant.get('sourceUrl','')) or row
            if vrow and vrow.get('Product Title (Brand-cleaned)'):
                vtitle = vrow['Product Title (Brand-cleaned)'].strip()
                variant['name'] = vtitle
                variant['sourceTitle'] = vtitle
        matched += 1
catalog_path.write_text('export const importedProducts = ' + json.dumps(products, ensure_ascii=False, separators=(',', ':')) + ';\n', encoding='utf-8')

# Update the smaller hand-curated base catalog where a unique model/title match is available.
base_path = ROOT / 'src' / 'catalog.js'
base = base_path.read_text(encoding='utf-8')
lines = base.splitlines()
updated_base = 0
for i, line in enumerate(lines):
    model_match = re.search(r"model:\s*'([^']+)'", line)
    source_match = re.search(r"sourceTitle:\s*'([^']+)'", line)
    if not model_match or not source_match:
        continue
    model = model_match.group(1)
    current_title = source_match.group(1)
    candidates = by_model.get(norm(model), [])
    if not candidates:
        candidates = [r for r in rows if norm(model) and norm(model) in norm(r.get('Model / Series'))]
    if not candidates:
        continue
    current_clean = clean_title(current_title)
    scored = sorted(candidates, key=lambda r: SequenceMatcher(None, current_clean, clean_title(r.get('Product Title (Brand-cleaned)'))).ratio(), reverse=True)
    best = scored[0]
    title = best.get('Product Title (Brand-cleaned)', '').strip()
    if not title:
        continue
    line = re.sub(r"name:\s*'[^']*'", "name: " + repr(title), line, count=1)
    line = re.sub(r"sourceTitle:\s*'[^']*'", "sourceTitle: " + repr(title), line, count=1)
    lines[i] = line
    updated_base += 1
base_path.write_text('\n'.join(lines) + ('\n' if base.endswith('\n') else ''), encoding='utf-8')
print(json.dumps({'workbookRows': len(rows), 'importedUpdated': matched, 'baseUpdated': updated_base}, ensure_ascii=False))
