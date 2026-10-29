Add-Type -TypeDefinition @"
using System;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.IO;
using System.Text;
using System.Collections.Generic;
public static class ProductImageGroups {
  public static string Analyze(string dir) {
    var names=new List<string>(); var sigs=new List<float[]>();
    foreach(var path in Directory.GetFiles(dir)) {
      try {
        using(var src=new Bitmap(path)) using(var small=new Bitmap(12,12)) {
          using(var g=Graphics.FromImage(small)){g.InterpolationMode=InterpolationMode.HighQualityBilinear;g.DrawImage(src,0,0,12,12);}
          var sig=new float[144]; float mean=0;
          for(int y=0;y<12;y++)for(int x=0;x<12;x++){var c=small.GetPixel(x,y);var v=(.299f*c.R+.587f*c.G+.114f*c.B)/255f;sig[y*12+x]=v;mean+=v;}
          mean/=144f;float norm=0;for(int i=0;i<144;i++){sig[i]-=mean;norm+=sig[i]*sig[i];}norm=(float)Math.Sqrt(norm)+.00001f;for(int i=0;i<144;i++)sig[i]/=norm;
          names.Add(Path.GetFileName(path));sigs.Add(sig);
        }
      } catch {}
    }
    var sb=new StringBuilder();
    foreach(double threshold in new double[]{.008,.012,.016,.020,.025}) {
      var parent=new int[names.Count];for(int i=0;i<parent.Length;i++)parent[i]=i;
      Func<int,int> root=null;root=(i)=>{while(parent[i]!=i){parent[i]=parent[parent[i]];i=parent[i];}return i;};
      for(int i=0;i<sigs.Count;i++)for(int j=i+1;j<sigs.Count;j++){double dot=0;for(int k=0;k<144;k++)dot+=sigs[i][k]*sigs[j][k];if(1-dot<threshold){int a=root(i),b=root(j);if(a!=b)parent[b]=a;}}
      var roots=new HashSet<int>();for(int i=0;i<parent.Length;i++)roots.Add(root(i));sb.AppendLine("THRESHOLD="+threshold+" FILES="+names.Count+" GROUPS="+roots.Count+" DUPLICATES="+(names.Count-roots.Count));
    }
    return sb.ToString();
  }
}
"@ -ReferencedAssemblies System.Drawing
$dir=(Get-Location).Path+'\public\assets\images\catalog';[ProductImageGroups]::Analyze($dir)
