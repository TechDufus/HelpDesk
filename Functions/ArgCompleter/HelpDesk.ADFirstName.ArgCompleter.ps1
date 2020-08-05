# Get-UsersWithFirstName
$HelpDeskADFirstNameArgCompleter = {
    param ($CommandName, $ParameterName, $StringMatch)
    if ($null -eq $StringMatch) {
        $Filter = "*"
    }
    else {
        $Filter = "*$StringMatch*"
    }
    $GivenNames = (Get-ADUser -Filter { GivenName -like $Filter }).GivenName
    $QuotedNames = foreach ($Name in $GivenNames) {
        if ($Name.Contains(" ")) {
            "`"$Name`""
        }
        else {
            $Name
        }
    }
    return $QuotedNames
}
Register-ArgumentCompleter -CommandName Get-UsersWithFirstName -ParameterName FirstName -ScriptBlock $HelpDeskADFirstNameArgCompleter

