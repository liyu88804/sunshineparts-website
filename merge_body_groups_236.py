import json,re,collections
from pathlib import Path
project=Path.cwd(); src=project/'src/catalog-import.js'; bucket_file=project/'visual-body-buckets.json'
data=json.loads(re.search(r'export const importedProducts = (.*);\s*$',src.read_text(encoding='utf-8-sig'),re.S).group(1))
buckets=json.loads(bucket_file.read_text(encoding='utf-8-sig'))
for p in data:
    fn=Path(p.get('image') or '').name
    p['visualGroup']=buckets.get(fn, fn)
# Group by catalog family + body signature, preserving all variants.
groups=collections.OrderedDict()
for p in data:
    key=(p.get('family','Others'),p.get('visualGroup',''))
    groups.setdefault(key,[]).append(p)
merged=[]
for (family, signature), items in groups.items():
    primary=dict(items[0])
    variant_map=collections.OrderedDict()
    for item in items:
        incoming=item.get('variants') or [{k:item.get(k,'') for k in ['model','name','price','moq','sourceUrl','sourceTitle','productId','catalogCategory','sourceImage']}]
        for v in incoming:
            key=(v.get('model',''),v.get('sourceUrl',''),v.get('sourceTitle',''))
            variant_map[key]=v
    primary['variants']=list(variant_map.values())
    primary['modelCount']=len(primary['variants'])
    primary['visualGroup']=signature
    merged.append(primary)
src.write_text('export const importedProducts = '+json.dumps(merged,ensure_ascii=False,separators=(',',':'))+';\n',encoding='utf-8')
print('ORIGINAL_GROUP_RECORDS',len(data)); print('MERGED_MAIN_RECORDS',len(merged)); print('REMOVED_DUPLICATE_RECORDS',len(data)-len(merged)); print('MULTI_MODEL_GROUPS',sum(1 for p in merged if p['modelCount']>1)); print('MAX_MODELS',max(p['modelCount'] for p in merged))
