from pathlib import Path
from zipfile import ZipFile
from xml.etree import ElementTree as ET
import csv, io, json, re, shutil

PROJECT = Path(__file__).resolve().parent
ARCHIVE = Path(r'E:\所有图片\MIC_All_Product_Images.zip')
CATALOG_FILE = PROJECT / 'src' / 'catalog-import.js'
OUT_DIR = PROJECT / 'public' / 'assets' / 'images' / 'product-gallery'
IMAGE_EXTS = {'.jpg', '.jpeg', '.png', '.webp'}


def norm(value):
    value = str(value or '').strip().lower()
    return re.sub(r'[^a-z0-9]+', '', value)


def read_csv(raw):
    for encoding in ('utf-8-sig', 'gb18030', 'utf-16'):
        try:
            return list(csv.DictReader(io.StringIO(raw.decode(encoding))))
        except (UnicodeDecodeError, UnicodeError):
            continue
    raise UnicodeDecodeError('unknown', raw, 0, 1, 'Unable to decode CSV')


def load_catalog():
    source = CATALOG_FILE.read_text(encoding='utf-8')
    payload = source.split('export const importedProducts = ', 1)[1].rsplit(';', 1)[0]
    return json.loads(payload)


def write_catalog(products):
    payload = json.dumps(products, ensure_ascii=False, separators=(',', ':'))
    CATALOG_FILE.write_text(f'export const importedProducts = {payload};\n', encoding='utf-8')


products = load_catalog()
by_url = {str(item.get('sourceUrl', '')).strip().lower(): item for item in products if item.get('sourceUrl')}

with ZipFile(ARCHIVE) as archive:
    rename_rows = read_csv(archive.read('MIC_All_Product_Images/重命名记录.csv'))
    category_rows = read_csv(archive.read('MIC_All_Product_Images/产品大类归类记录.csv'))
    extraction_rows = read_csv(archive.read('MIC_All_Product_Images/提取结果.csv'))
    def product_id(url):
        match = re.search(r'/product/([^/]+)/', str(url or ''), re.I)
        return match.group(1).lower() if match else ''
    rename_by_id = {product_id(row.get('产品链接')): row for row in rename_rows if product_id(row.get('产品链接'))}
    category_by_id = {product_id(row.get('产品链接')): row for row in category_rows if product_id(row.get('产品链接'))}
    extraction_by_id = {product_id(row.get('产品链接')): row for row in extraction_rows if product_id(row.get('产品链接'))}

    file_names = [info.filename for info in archive.infolist() if not info.is_dir() and Path(info.filename).suffix.lower() in IMAGE_EXTS]
    folder_files = {}
    for filename in file_names:
        folder = filename.rsplit('/', 1)[0]
        folder_files.setdefault(folder, []).append(filename)

    folder_by_base = {}
    for folder in folder_files:
        folder_by_base.setdefault(norm(folder.rsplit('/', 1)[-1]), []).append(folder)

    matched = 0
    copied = 0
    missing = []
    gallery_map = {}

    for item in products:
        item_id = str(item.get('productId') or '').strip().lower()
        rename = rename_by_id.get(item_id, {})
        category = category_by_id.get(item_id, {})
        extraction = extraction_by_id.get(item_id, {})
        final_folder = str(rename.get('新文件夹名称') or extraction.get('文件夹') or item.get('sourceTitle') or '').strip()
        category_folder = str(category.get('分类文件夹') or '').strip()
        candidate = f'MIC_All_Product_Images/{category_folder}/{final_folder}' if category_folder and final_folder else ''
        folder = candidate if candidate in folder_files else None
        if folder is None:
            candidates = folder_by_base.get(norm(final_folder), [])
            folder = candidates[0] if len(candidates) == 1 else None
        if folder is None:
            missing.append({'productId': item.get('productId'), 'model': item.get('model'), 'sourceTitle': item.get('sourceTitle'), 'sourceUrl': item.get('sourceUrl'), 'expectedFolder': candidate})
            continue

        image_files = sorted(folder_files[folder], key=lambda filename: filename.rsplit('/', 1)[-1].lower())[:6]
        if not image_files:
            missing.append({'productId': item.get('productId'), 'model': item.get('model'), 'sourceTitle': item.get('sourceTitle'), 'sourceUrl': item.get('sourceUrl'), 'expectedFolder': folder})
            continue

        product_key = str(item.get('productId') or item.get('model') or f'product-{matched}').strip()
        safe_key = re.sub(r'[^A-Za-z0-9_-]+', '-', product_key).strip('-') or f'product-{matched}'
        target_dir = OUT_DIR / safe_key
        target_dir.mkdir(parents=True, exist_ok=True)
        gallery = []
        for index, filename in enumerate(image_files, start=1):
            suffix = Path(filename).suffix.lower()
            target_name = f'{index:02d}{suffix}'
            target = target_dir / target_name
            if not target.exists() or target.stat().st_size != archive.getinfo(filename).file_size:
                target.write_bytes(archive.read(filename))
            gallery.append(f'/assets/images/product-gallery/{safe_key}/{target_name}')
            copied += 1
        item['gallery'] = gallery
        item['image'] = gallery[0]
        gallery_map[str(item.get('productId') or item.get('model'))] = gallery
        matched += 1

write_catalog(products)
report = {
    'catalogProducts': len(products),
    'matchedProducts': matched,
    'copiedImages': copied,
    'missingProducts': len(missing),
    'missingSample': missing[:50],
    'outputDir': str(OUT_DIR),
}
(PROJECT / 'product-gallery-import-report.json').write_text(json.dumps(report, ensure_ascii=False, indent=2), encoding='utf-8')
print(json.dumps(report, ensure_ascii=False, indent=2))
