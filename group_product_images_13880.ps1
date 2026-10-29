Add-Type -TypeDefinition @"
using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Collections.Generic;
public static class ProductImageGroups {
  public static string Run(string dir, double threshold) {
    var names = new List<string>(); var sigs = new List<float[]>();
    foreach (var path in Directory.GetFiles(dir)) {
      try {
        using (var src = new Bitmap(path)) using (var small = new Bitmap(12,12)) {
          using (var g = Graphics.FromImage(small)) { g.InterpolationMode = InterpolationMode.HighQualityBilinear; g.DrawImage(src, 0, 0, 12, 12); }
          var sig = new float[144]; float mean=0;
          for(int y=0;y<12;y++) for(int x=0;x<12;x++){var c=small.GetPixel(x,y); var v=(0.299f*c.R+0.587f*c.G+0.114f*c.B)/255f; sig[y*12+x]=v; mean+=v;}
          mean/=144f; float norm=0; for(int i=0;i<144;i++){sig[i]-=mean;norm+=sig[i]*sig[i];} norm=(float)Math.Sqrt(norm)+0.00001f; for(int i=0;i<144;i++) sig[i]/=norm;
          names.Add(Path.GetFileName(path)); sigs.Add(sig);
        }
      } catch {}
    }
    var parent=new int[names.Count]; for(int i=0;i<parent.Length;i++) parent[i]=i;
    Func<int,int> root=null; root=(i)=>{while(parent[i]!=i){parent[i]=parent[parent[i]];i=parent[i];}return i;};
    Action<int,int> join=(a,b)=>{int ra=root(a),rb=root(b);if(ra!=rb)parent[rb]=ra;};
    int pairs=0;
    for(int i=0;i<sigs.Count;i++) for(int j=i+1;j<sigs.Count;j++) { double dot=0; for(int k=0;k<144;k++) dot+=sigs[i][k]*sigs[j][k]; double dist=1-dot; if(dist<threshold){join(i,j);pairs++;} }
    var map=new Dictionary<string,string>(); var reps=new Dictionary<int,string>();
    for(int i=0;i<names.Count;i++){int r=root(i);if(!reps.ContainsKey(r))reps[r]=names[r];map[names[i]]=reps[r];}
    var groups=new Dictionary<string,List<string>>(); foreach(var kv in map){if(!groups.ContainsKey(kv.Value))groups[kv.Value]=new List<string>();groups[kv.Value].Add(kv.Key);}
    int dupGroups=0,removed=0; foreach(var g in groups.Values)if(g.Count>1){dupGroups++;removed+=g.Count-1;}
    var json="{\"files\":"+names.Count+",\"groups\":"+groups.Count+",\"duplicateGroups\":"+dupGroups+",\"removed\":"+removed+",\"pairs\":"+pairs+",\"map\":{";
    bool first=true; foreach(var kv in map){if(!first)json+=",";first=false;json+=\"\"\"+kv.Key.Replace(\"\\\",\"\\\\\").Replace(\"\"\",\"\\\"\")+\"\":\"\"\"+kv.Value.Replace(\"\\\",\"\\\\\").Replace(\"\"\",\"\\\"\")+\"\"\"\";} return json+\"}}\";
  }
}
"@ -ReferencedAssemblies System.Drawing
$dir=(Get-Location).Path+'\public\assets\images\catalog'; $result=[ProductImageGroups]::Run($dir,0.015); Set-Content -Encoding UTF8 -Path (Join-Path (Get-Location) 'visual-image-groups.json') -Value $result; Write-Output $result.Substring(0,[Math]::Min(180,$result.Length))
