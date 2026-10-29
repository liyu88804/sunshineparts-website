Add-Type -AssemblyName System.Drawing
$files=Get-ChildItem 'public/assets/images/catalog' -File
$dims=@{}
foreach($f in $files){try{$b=[Drawing.Bitmap]::new($f.FullName);$key="$($b.Width)x$($b.Height)";$dims[$key]=1+($dims[$key]??0);$b.Dispose()}catch{}}
$dims.GetEnumerator()|Sort-Object Value -Descending|Select-Object -First 12|ForEach-Object{Write-Output "$($_.Name) $($_.Value)"}
