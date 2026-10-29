import urllib.request
from pathlib import Path
url='https://sc04.alicdn.com/kf/Af51d2cedf8c8413d89aee8b78230c97dO.mp4'
out=Path('public/assets/videos/production-line.mp4')
out.parent.mkdir(parents=True, exist_ok=True)
handler=urllib.request.ProxyHandler({})
opener=urllib.request.build_opener(handler)
opener.addheaders=[('User-Agent','Mozilla/5.0')]
with opener.open(url, timeout=60) as r:
 data=r.read()
if len(data)==0: raise SystemExit('empty response')
out.write_bytes(data)
print('VIDEO_BYTES',len(data)); print('VIDEO_PATH',out.resolve()); print('HEADER',data[:12].hex())
