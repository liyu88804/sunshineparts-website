Add-Type -AssemblyName System.Drawing
$dir=Join-Path (Get-Location) 'public/assets/images/catalog'
$files=@(Get-ChildItem -LiteralPath $dir -File)
$data=@()
foreach($f in $files){
  try {
    $bmp=[System.Drawing.Bitmap]::new($f.FullName)
    $small=[System.Drawing.Bitmap]::new(24,24)
    $g=[System.Drawing.Graphics]::FromImage($small)
    $g.InterpolationMode=[System.Drawing.Drawing2D.InterpolationMode]::HighQualityBilinear
    $g.DrawImage($bmp,0,0,24,24)
    $g.Dispose(); $bmp.Dispose()
    $v=@()
    for($y=0;$y -lt 24;$y++){ for($x=0;$x -lt 24;$x++){ $c=$small.GetPixel($x,$y); $v += (0.299*$c.R+0.587*$c.G+0.114*$c.B)/255 } }
    $small.Dispose()
    $data += [pscustomobject]@{Name=$f.Name; V=$v}
  } catch {}
}
$parent=@{}
foreach($d in $data){$parent[$d.Name]=$d.Name}
function FindRoot([string]$n){ while($parent[$n] -ne $n){$parent[$n]=$parent[$parent[$n]];$n=$parent[$n]}; return $n }
function JoinGroup([string]$a,[string]$b){$ra=FindRoot $a;$rb=FindRoot $b;if($ra -ne $rb){$parent[$rb]=$ra}}
$matches=0
for($i=0;$i -lt $data.Count;$i++){
  for($j=$i+1;$j -lt $data.Count;$j++){
    $d=0.0
    for($k=0;$k -lt 576;$k++){ $z=$data[$i].V[$k]-$data[$j].V[$k]; $d += $z*$z }
    $rmse=[math]::Sqrt($d/576)
    if($rmse -lt 0.018){ JoinGroup $data[$i].Name $data[$j].Name; $matches++ }
  }
}
$groups=@{}
foreach($d in $data){$r=FindRoot $d.Name;if(-not $groups.ContainsKey($r)){$groups[$r]=@()};$groups[$r]+=$d.Name}
$map=@{}
foreach($g in $groups.Values){$rep=$g[0];foreach($n in $g){$map[$n]=$rep}}
$out=Join-Path (Get-Location) 'visual-image-near-groups.json';$map|ConvertTo-Json -Compress|Set-Content -Encoding UTF8 $out
$dups=@($groups.Values|Where-Object Count -gt 1);$removed=($dups|ForEach-Object{$_.Count-1}|Measure-Object -Sum).Sum
Write-Output ('FILES '+$data.Count);Write-Output ('GROUPS '+$groups.Count);Write-Output ('NEAR_DUP_GROUPS '+$dups.Count);Write-Output ('NEAR_DUP_FILES '+$removed);Write-Output ('PAIRS '+$matches);Write-Output ('MAP '+$out)
$dups|Sort-Object Count -Descending|Select-Object -First 12|ForEach-Object{Write-Output ('GROUP '+($_ -join ', '))}
