from PIL import Image
from pathlib import Path
root=Path(__file__).parent
out=root/'dist'/'assets'
out.mkdir(exist_ok=True)
rows=[[220,403,658,909,1137,1360],[102,333,523,712,915,1115,1373],[102,300,507,740,941,1142,1378],[102,318,592,780,982,1200],[102,323,525,718,910,1070,1229],[102,345,674,888,1098,1338],[102,369,621,888]]
n=1
for page,ys in enumerate(rows,1):
 im=Image.open(root.parent/'tmp'/'pdfs'/f'page-{page}.png')
 for a,b in zip(ys,ys[1:]):
  im.crop((587,a+3,925,b-3)).save(out/f'{n}.jpg',quality=88)
  n+=1
assert n==37
