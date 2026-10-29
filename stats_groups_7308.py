import re,json,collections
s=open('src/catalog-import.js',encoding='utf-8-sig').read(); data=json.loads(re.search(r'export const importedProducts = (.*);\s*$',s,re.S).group(1))
g=collections.defaultdict(list)
for p in data:g[p.get('image') or p.get('sourceImage') or p.get('model')].append(p)
print('RECORDS',len(data),'GROUPS',len(g),'MERGED_GROUPS',sum(1 for v in g.values() if len(v)>1),'MERGED_RECORDS',sum(len(v)-1 for v in g.values() if len(v)>1))
for k,v in sorted(g.items(),key=lambda kv:-len(kv[1]))[:20]:
 if len(v)>1: print(len(v),k,[x.get('model') for x in v[:12]])
