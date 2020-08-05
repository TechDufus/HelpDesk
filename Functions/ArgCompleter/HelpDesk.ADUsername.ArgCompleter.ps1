$HelpDeskADUsernameArgCompleter = {
    param ($CommandName, $ParameterName, $StringMatch)
    if ($null -eq $StringMatch) {
        $Filter = "*"
    }
    else {
        $Filter = "*$StringMatch*"
    }
    $Users = (Get-ADUser -Filter { SamAccountName -like $Filter }).SamAccountName
    $QuotedUsers = foreach ($User in $Users) {
        if ($User[0] -eq "-") {
            "`"$User`""
        }
        else {
            $User
        }
    }
    return $QuotedUsers
}
Register-ArgumentCompleter -CommandName Get-User, Get-OtherADUserAccounts, Reset-Password, Add-LocalAdmin, Remove-LocalAdmin, Get-LocalAdmin, Get-ADGroupsManagedByUser -ParameterName Username -ScriptBlock $HelpDeskADUsernameArgCompleter

