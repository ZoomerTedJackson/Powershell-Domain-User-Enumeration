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
		$user >> usernames.txt
		$count = $count + 1
	}
 }
echo ""
echo "Number of Users: $count"
echo ""
echo $warning
echo ""
echo $dupeWarn
echo ""