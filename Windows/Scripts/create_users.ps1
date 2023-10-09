
$path = Read-Host "Enter a file name to read from"

Import-Csv $path | Foreach-Object {
	$params = @{
		Name = $_.Name
		Pssword = ConvertTo-SecureString $_.Password -AsPlainText -Force
		FullName = $_.FullName
	}

	New-LocalUser @params

}
