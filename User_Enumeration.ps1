Write-Host -NoNewLine "Reading Users."
$String = net users /domain
$String = $String[6..($String.length-3)]
[System.Collections.ArrayList]$String = $String
$count = 0
$warning = ""
$dupeWarn = ""
$lastUser = ""
foreach ($line in $String) {
	$line = $line.trim()
	$line = $line -split '\s\s+'
	foreach ($user in $line){
		if ($lastUser -eq $user){
			$dupeWarn = "Warning, some usernames were found to have duplicates"
		}
		$lastUser = $user
		if ($user -match " "){
			$warning = "Warning, some usernames were found to contain spaces"
		}
		Add-Content usernames.txt $user
		$count = $count + 1
		if ($count % 1000 -eq 0){
			Write-Host -NoNewLine "."
		}
	}
 }
if ($warning) { 
	Write-Output ""
	Write-Host $warning -foregroundcolor "yellow"
}
if ($dupeWarn) { 
	Write-Output ""
	Write-Host $dupeWarn -foregroundcolor "yellow"
}
Write-Output ""
Write-Host "Number of Users: $count" -foregroundcolor "green"
Write-Output ""
Write-Host -NoNewLine "Names saved to "
Write-Host -NoNewLine "usernames.txt" -foregroundcolor "magenta"
