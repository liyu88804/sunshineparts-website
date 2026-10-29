Add-Type -AssemblyName System.Drawing
$dir=Join-Path (Get-Location) 'public/assets/images/catalog'
$files=Get-ChildItem -LiteralPath $dir -File
$map=@{}
$ok=0; $bad=0
foreach($f in $files){
  try {
    $bmp=[System.Drawing.Bitmap]::new($f.FullName)
    $small=[System.Drawing.Bitmap]::new(16,16)
    $g=[System.Drawing.Graphics]::FromImage($small)
    $g.DrawImage($bmp,0,0,16,16); $g.Dispose(); $bmp.Dispose()
    $vals=@(); $sum=0.0
    for($y=0;$y -lt 16;$y++){for($x=0;$x -lt 16;$x++){ $c=$small.GetPixel($x,$y); $v=(0.299*$c.R+0.587*$c.G+0.114*$c.B); $vals += $v; $sum += $v }}
    $small.Dispose(); $avg=$sum/$vals.Count; $bits=''; foreach($v in $vals){$bits += if($v -ge $avg){'1'}else{'0'}}
    $bytes=for($i=0;$i -lt 256;$i+=8){[Convert]::ToByte($bits.Substring($i,8),2)}
    $sha=[System.Security.Cryptography.SHA256]::Create(); $hash=([BitConverter]::ToString($sha.ComputeHash($bytes))).Replace('-','').ToLower()
    $map[$f.Name]=$hash; $ok++
  } catch { $bad++; Write-Output ('BAD '+$f.Name+' '+$_.Exception.Message) }
}
$out=Join-Path $env:TEMP ('catalog_visual_hash_'+$PID+'.json'); $map | ConvertTo-Json -Compress | Set-Content -Encoding UTF8 $out; $groups=$map.GetEnumerator() | Group-Object Value; $dups=@($groups | Where-Object Count -gt 1); Write-Output ('FILES '+$files.Count); Write-Output ('HASHED '+$ok); Write-Output ('BAD '+$bad); Write-Output ('HASH_GROUPS '+$groups.Count); Write-Output ('DUP_GROUPS '+$dups.Count); Write-Output ('DUP_FILES '+(($dups | ForEach-Object { $_.Count-1 } | Measure-Object -Sum).Sum)); Write-Output ('JSON '+$out); $dups | Select-Object -First 20 | ForEach-Object { Write-Output ('GROUP '+$_.Name+' :: '+(($_.Group | ForEach-Object Name) -join ', ')) }
