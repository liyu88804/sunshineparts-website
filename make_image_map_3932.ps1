Add-Type -TypeDefinition @"
using System; using System.Drawing; using System.Drawing.Drawing2D; using System.IO; using System.Collections.Generic;
public static class ProductImageMap {
 public static string Build(string dir) {
  var names=new List<string>();var sigs=new List<float[]>();
  foreach(var path in Directory.GetFiles(dir)){try{using(var src=new Bitmap(path))using(var small=new Bitmap(12,12)){using(var g=Graphics.FromImage(small)){g.InterpolationMode=InterpolationMode.HighQualityBilinear;g.DrawImage(src,0,0,12,12);}var sig=new float[144];float mean=0;for(int y=0;y<12;y++)for(int x=0;x<12;x++){var c=small.GetPixel(x,y);var v=(.299f*c.R+.587f*c.G+.114f*c.B)/255f;sig[y*12+x]=v;mean+=v;}mean/=144f;float norm=0;for(int i=0;i<144;i++){sig[i]-=mean;norm+=sig[i]*sig[i];}norm=(float)Math.Sqrt(norm)+.00001f;for(int i=0;i<144;i++)sig[i]/=norm;names.Add(Path.GetFileName(path));sigs.Add(sig);}}catch{}}
  var p=new int[names.Count];for(int i=0;i<p.Length;i++)p[i]=i;Func<int,int> r=null;r=(i)=>{while(p[i]!=i){p[i]=p[p[i]];i=p[i];}return i;};
  for(int i=0;i<sigs.Count;i++)for(int j=i+1;j<sigs.Count;j++){double dot=0;for(int k=0;k<144;k++)dot+=sigs[i][k]*sigs[j][k];if(1-dot<.008){int a=r(i),b=r(j);if(a!=b)p[b]=a;}}
  var rep=new Dictionary<int,string>();for(int i=0;i<names.Count;i++){int root=r(i);if(!rep.ContainsKey(root))rep[root]=names[root];}
  var lines=new List<string>();for(int i=0;i<names.Count;i++){int root=r(i);lines.Add(names[i]+"\t"+rep[root]);}return string.Join("\n",lines);
 }
}
"@ -ReferencedAssemblies System.Drawing
$dir=(Get-Location).Path+'\public\assets\images\catalog';$lines=[ProductImageMap]::Build($dir);Set-Content -Encoding UTF8 -Path (Join-Path (Get-Location) 'visual-image-map.tsv') -Value $lines; $rows=$lines -split "`n"; $groups=@{}; foreach($row in $rows){$parts=$row.Trim() -split "`t";if($parts.Count -eq 2){$groups[$parts[0]]=$parts[1]}}; $groups | ConvertTo-Json -Compress | Set-Content -Encoding UTF8 -Path (Join-Path (Get-Location) 'visual-image-map.json'); $dups=@($groups.GetEnumerator()|Group-Object Value|Where-Object Count -gt 1);$removed=($dups|ForEach-Object{$_.Count-1}|Measure-Object -Sum).Sum;Write-Output ('FILES '+$groups.Count);Write-Output ('GROUPS '+($groups.Values|Select-Object -Unique).Count);Write-Output ('DUP_GROUPS '+$dups.Count);Write-Output ('MERGED_RECORD_TARGETS '+$removed)
