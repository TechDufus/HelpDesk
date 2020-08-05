# Get-LastName
$HelpDeskADLastNameArgCompleter = {
    param ($CommandName, $ParameterName, $StringMatch)
    if ($null -eq $StringMatch) {
        $Filter = "*"
    }
    else {
        $Filter = "*$StringMatch*"
    }
    $SurNames = (Get-ADUser -Filter { SurName -like $Filter }).SurName
    $QuotedNames = foreach ($Name in $SurNames) {
        if ($Name.Contains(" ")) {
            "`"$Name`""
        }
        else {
            $Name
        }
    }
    return $QuotedNames
}
Register-ArgumentCompleter -CommandName Get-LastName -ParameterName LastName -ScriptBlock $HelpDeskADLastNameArgCompleter

