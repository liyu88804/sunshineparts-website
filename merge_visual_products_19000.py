import re,json,collections
from pathlib import Path
project=Path.cwd(); src=project/'src/catalog-import.js'; mp=json.loads((project/'visual-image-map.json').read_text(encoding='utf-8-sig'))
data=json.loads(re.search(r'export const importedProducts = (.*);\s*$',src.read_text(encoding='utf-8-sig'),re.S).group(1))
for p in data:
    image=p.get('image') or ''
    filename=Path(image).name
    rep=mp.get(filename,filename)
    p['image']='/assets/images/catalog/'+rep
    p['visualGroup']=rep
# Aggregate all records by visual group while preserving all source records in variants.
groups=collections.OrderedDict()
for p in data:
    key=p['visualGroup']
    if key not in groups: groups[key]=[]
    groups[key].append(p)
merged=[]
for key,items in groups.items():
    primary=dict(items[0])
    variants=[]
    for item in items:
        variants.append({k:item.get(k,'') for k in ['model','name','price','moq','sourceUrl','sourceTitle','productId','catalogCategory','sourceImage']})
    primary['variants']=variants
    primary['modelCount']=len(variants)
    primary['image']='/assets/images/catalog/'+key
    primary['imageType']='catalog-local'
    merged.append(primary)
src.write_text('export const importedProducts = '+json.dumps(merged,ensure_ascii=False,separators=(',',':'))+';\n',encoding='utf-8')
print('ORIGINAL_RECORDS',len(data));print('MERGED_RECORDS',len(merged));print('MERGED_AWAY',len(data)-len(merged));print('MULTI_MODEL_GROUPS',sum(1 for p in merged if p['modelCount']>1));print('MAX_MODELS_IN_GROUP',max(p['modelCount'] for p in merged))
