import re,json,collections
s=open('src/catalog-import.js',encoding='utf-8-sig').read(); data=json.loads(re.search(r'export const importedProducts = (.*);\s*$',s,re.S).group(1))
# report records whose titles/models contain likely repeated product families
for needle in ['XLF','PGH','NBZ5','PGH5','K5V80','A11VO','K3V']:
 rows=[p for p in data if needle.lower() in (p.get('model','')+' '+p.get('name','')).lower()]
 print('\n',needle,len(rows))
 for p in rows[:20]: print(p.get('model'),p.get('image'),p.get('sourceImage','')[-35:])
print('TOTAL',len(data))
