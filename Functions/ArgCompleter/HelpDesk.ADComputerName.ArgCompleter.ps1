# Get-Computer
$HelpDeskADComputernameArgCompleter = {
    param ($CommandName, $ParameterName, $StringMatch)
    if ($null -eq $StringMatch) {
        $Filter = "*"
    }
    else {
        $Filter = "*$StringMatch*"
    }
    (Get-ADComputer -filter { Name -like $Filter }).Name
}
Register-ArgumentCompleter -CommandName Get-Computer, Add-LocalAdmin, Remove-LocalAdmin, Get-LocalAdmin, Get-DellTags -ParameterName ComputerName -ScriptBlock $HelpDeskADComputernameArgCompleter

