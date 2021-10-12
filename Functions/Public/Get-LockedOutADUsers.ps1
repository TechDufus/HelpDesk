#Region Get-LockedOutADUsers

<#
.SYNOPSIS
    This function performs a search of users in ActiveDirectory who are currently locked out.
.DESCRIPTION
    This function is a simple Search-ADAccount -Lockedout to generate a list of users who are currently locked out. This function provides the Name, SAMAccountName, and LockoutTime for each user that is locked out.
.INPUTS
    System.String
        This function does not accept pipeline data. The values for all parameters must be specified.
.OUTPUTS
    None
        This function does not produce output except for write-host data
.EXAMPLE
    PS>Get-LockedOutADUsers

    Name                SamAccountName LockoutTime
    ----                -------------- -----------
    DeGarmo, Matthew J. matthewjd      6/26/2019 13:32:15

    Description
    -----------
    This will show all users who are currently locked out.
.EXAMPLE
    PS>Get-LockedOutADUsers
    No users are currently locked out.

    Description
    -----------
    This will display the results of the query, in this case there were no results to display.
.NOTES
    Author: Matthew J. DeGarmo
    GitHub: https://github.com/matthewjdegarmo

    You can either submit a [PR](https://github.com/matthewjdegarmo/HelpDesk/pulls)
        or create an [Issue](https://github.com/matthewjdegarmo/HelpDesk/issues/new)
        on this GitHub project at https://github.com/matthewjdegarmo/HelpDesk
#>
Function Get-LockedOutADUsers() {
    [CmdletBinding()]
    param(
        [System.String[]] $Properties,

        [Switch] $IncludeLockoutSource
    )

    Begin {
        If ($IncludeLockoutSource.IsPresent) {
            $params = @{
                LogName      = 'Security'
                ComputerName = "$((Get-ADDomain).PDCEmulator)"
                MaxEvents    = 1
                ErrorAction  = 'Stop'
            }
            Try {
                $TestLogAbility = Get-WinEvent @params | Select-Object -First 1
            }
            Catch {
                $LogFailed = $True
            }
        }
    }

    Process {
        If ($Properties -ne '*') {
            $Properties = @('Name', 'SAMAccountName', 'LockoutTime') + @($Properties) | Select-Object -Unique
        }
        Search-ADAccount -LockedOut | Foreach-Object { Get-ADUser $_.SamAccountName -Properties LockoutTime | Where-Object { $_.Name -ne 'Guest' } | Select-Object $Properties | Foreach-Object {
                $Date = [DateTime]$_.LockoutTime
                $_.LockoutTime = $Date.AddYears(1600).ToLocalTime()
                If ($IncludeLockoutSource.IsPresent) {
                    [PSCustomObject] @{
                        Name           = $_.Name
                        SAMAccountName = $_.SAMAccountName
                        LockoutTime    = $_.LockoutTime
                        LockOutSource  = $(Get-LockoutSource -Identity $_.SAMAccountName).LockoutSource
                    }
                }
                else {
                    $_
                }
            }
        }
    }
}
#EndRegion Get-LockedOutADUsers