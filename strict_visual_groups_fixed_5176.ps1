Add-Type -AssemblyName System.Drawing
$dir=Join-Path (Get-Location) 'public/assets/images/catalog'; $files=Get-ChildItem -LiteralPath $dir -File; $map=@{}; $ok=0
foreach($f in $files){
 try {
  $bmp=[System.Drawing.Bitmap]::new($f.FullName); $small=[System.Drawing.Bitmap]::new(16,16); $g=[System.Drawing.Graphics]::FromImage($small); $g.InterpolationMode=[System.Drawing.Drawing2D.InterpolationMode]::HighQualityBilinear; $g.DrawImage($bmp,0,0,16,16); $g.Dispose(); $bmp.Dispose()
  $bytes=New-Object System.Collections.Generic.List[byte]
  for($y=0;$y -lt 16;$y++){for($x=0;$x -lt 16;$x++){ $c=$small.GetPixel($x,$y); $bytes.Add([byte]([math]::Floor($c.R/32))); $bytes.Add([byte]([math]::Floor($c.G/32))); $bytes.Add([byte]([math]::Floor($c.B/32))) }}
  $small.Dispose(); $sha=[System.Security.Cryptography.SHA256]::Create(); $map[$f.Name]=([BitConverter]::ToString($sha.ComputeHash($bytes.ToArray()))).Replace('-','').ToLower(); $ok++
 } catch {}
}
$out=Join-Path (Get-Location) 'visual-image-groups.json'; $map | ConvertTo-Json -Compress | Set-Content -Encoding UTF8 $out; $groups=$map.GetEnumerator() | Group-Object Value; $dups=@($groups | Where-Object Count -gt 1); $dupTotal=($dups | ForEach-Object { $_.Count-1 } | Measure-Object -Sum).Sum
Write-Output ('FILES '+$files.Count); Write-Output ('HASHED '+$ok); Write-Output ('GROUPS '+$groups.Count); Write-Output ('DUP_GROUPS '+$dups.Count); Write-Output ('DUP_FILES '+$dupTotal); Write-Output ('MAP '+$out)
