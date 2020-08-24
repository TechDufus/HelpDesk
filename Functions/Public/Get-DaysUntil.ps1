#Region Get-DaysUntil

<#
.SYNOPSIS
    Calculate the number of days between today and any future (or past) date.
.DESCRIPTION
    This function provides the quantity of days between today and any given date.
.PARAMETER Date
    Specifies a date.
    Enter the date in a format that is standard for the system locale.
    Example Date Formats:
        06/06/2020
        6/6
        june6
        june6/2020
        aug12
        october18
.EXAMPLE
    Let's say today is January 1st, 2020.

    PS> Get-DaysUntil 10/18
    291

    Description
    -----------
    This will generate the number of days between today (jan1/2020) and October 18th, 2020.
    See `Get-Help Get-DaysUntil -Parameter Date` for example date formats.
.EXAMPLE
    Let's say today is January 1st, 2020.

    PS> Get-DaysUntil 10/18/2000
    -7014

    Description
    -----------
    This will generate a negative number, for the number of days in the past the specified date is.
    See `Get-Help Get-DaysUntil -Parameter Date` for example date formats.
.NOTES
    Author: Matthew J. DeGarmo
    GitHub: https://github.com/matthewjdegarmo
#>
Function Get-DaysUntil() {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string] $Date
    )

    $TimeSpan = (New-TimeSpan -Start (Get-Date -Hour 0 -Minute 0 -Second 0) -End (Get-Date -Date $Date))
    if ([math]::Round($TimeSpan.Hours / 24) -eq 1) {
        if ($TimeSpan.Days -ge 0) {$Days = $TimeSpan.Days + 1}
        elseif ($TimeSpan.Days -lt 0) {$Days = $TimeSpan.Days - 1}
    } else {
        $Days = $TimeSpan.Days
    }

    $Days
}
#EndRegion Get-DaysUntil