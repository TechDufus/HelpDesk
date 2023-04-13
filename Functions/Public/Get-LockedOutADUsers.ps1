#Region Get-LockedOutADUsers

<#
.SYNOPSIS
    This function performs a search of users in ActiveDirectory who are currently locked out.
.DESCRIPTION
    This function is a simple Search-ADAccount -Lockedout to generate a list of users who are currently locked out. This function provides the Name, SAMAccountName, and LockoutTime for each user that is locked out.
.PARAMETER Properties
    This parameter should specify any AD properties to be returned for each user.
    This parameter is optional. If not specified, the default is to return the following properties:
        - Name
        - SAMAccountName
        - LockoutTime
        - [CONDITIONAL] LockoutSource (See Parameter -IncludeLockoutSource)
.PARAMETER IncludeLockoutSource
    This parameter is optional. If specified, the LockoutSource will be returned for each user. This parameter requires you have rights to query your domain controller for these logs.
    Specifying this parameter will first make a test query to your domain controller to confirm you have rights to query these logs.
    If you do not have rights to query these logs, this parameter will be ignored.

    So far, the SIMPLEST way to grant a domain user rights to read these logs from the correct Domain Controller (that I know of) involves the following:
        - Add the user (or group) to the 'Event Log Readers' group on the domain controller.
        - Grant the user (or group) READ rights to the registry key HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Eventlog\Security on the domain controller.
    Both of the above are required to have rights to the DC's Security logs. Membership to the 'Event Log Readers' group only will NOT grant read rights to the Security logs.
    See: https://social.technet.microsoft.com/Forums/lync/en-US/b72162d1-2c86-4d1a-9727-ec7269814cc4/getwinevent-with-nonadministrative-user?forum=winserverpowershell

    This will grant the user (or group) rights to read the Event Logs on the domain controller, including the Security logs. This is the only registry key that is required to read the Security Event Logs.
    If you do not have these rights, you will not be able to read the Lockout (4740) logs.
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
.EXAMPLE
    PS>GLO -IncludeLockoutSource
    Name                SamAccountName LockoutTime        LockoutSource
    ----                -------------- -----------        -------------
    DeGarmo, Matthew J. matthewjd      6/26/2019 13:32:15 Some-Computer

    Description
    -----------
    This will show all users who are currently locked out and the source computername of the lockout event.
.EXAMPLE
    PS>Get-LockedOutADUsers -IncludeLockoutSource
    You do not have rights to execute remote queries to this Domain Controller: Some-DC-Here
    Please see 'Get-Help Get-LockedOutADUsers -Parameter IncludeLockoutSource' for more information.

    Name                SamAccountName LockoutTime
    ----                -------------- -----------
    DeGarmo, Matthew J. matthewjd      6/26/2019 13:32:15

    Description
    -----------
    This will show all users who are currently locked out, while displaying a message letting you know you do not have rights to read these events from the Domain Controller.
.NOTES
    Author:  Matthew.DeGarmo
    Github:  https://github.com/TechDufus
    Sponsor: https://github.com/sponsors/TechDufus

    You can either submit a [PR](https://github.com/TechDufus/HelpDesk/pulls)
        or create an [Issue](https://github.com/TechDufus/HelpDesk/issues/new)
        on this GitHub project at https://github.com/TechDufus/HelpDesk
#>
Function Get-LockedOutADUsers() {
    [CmdletBinding()]
    param(
        [Switch] $IncludeLockoutSource,
        
        [System.String[]] $Properties

    )

    Begin {
        If ($IncludeLockoutSource.IsPresent) {
            $ComputerName = "$((Get-ADDomain).PDCEmulator)"
            $params = @{
                FilterHashTable = @{
                    LogName = 'Security'
                    ID      = '4740'
                }
                MaxEvents       = 1
                ComputerName    = $ComputerName
                ErrorAction     = 'Stop'
            }
            Try {
                $null = Get-WinEvent @params
            }
            Catch {
                [Switch]$IncludeLockoutSource = $false
                Write-Warning "You do not have rights to execute remote queries to this Domain Controller: $ComputerName"
                Write-Warning "Please see 'Get-Help $($MyInvocation.MyCommand) -Parameter IncludeLockoutSource' for more information."
            }
        }
    }

    Process {
        If ($Properties -ne '*') {
            $Properties = @('Name', 'SAMAccountName', 'LockoutTime') + @($Properties) | Select-Object -Unique
        }
        If ($IncludeLockoutSource.IsPresent) {
            $LockoutEvents = @{}
            Get-LockoutSource -ComputerName $ComputerName | Foreach-Object {
                If (-Not([bool]$LockoutEvents["$($_.Identity)"])) {
                    $LockoutEvents["$($_.Identity)"] = $_.LockoutSource
                }
            }
        }


        Search-ADAccount -LockedOut | Foreach-Object { Get-ADUser $_.SamAccountName -Properties LockoutTime | Where-Object { $_.Name -ne 'Guest' } | Select-Object $Properties | Foreach-Object {
                $Date = [DateTime]$_.LockoutTime
                $_.LockoutTime = $Date.AddYears(1600).ToLocalTime()
                If ($IncludeLockoutSource.IsPresent) {
                    If ([bool]$LockoutEvents["$($_.SamAccountName)"]) {
                        $_ | Add-Member -MemberType NoteProperty -Name 'LockoutSource' -Value $LockoutEvents["$($_.SamAccountName)"]
                    }
                    Else {
                        $_ | Add-Member -MemberType NoteProperty -Name 'LockoutSource' -Value 'UNKNOWN'
                    }
                }
                $_
            }
        }
    }
}
#EndRegion Get-LockedOutADUsers
