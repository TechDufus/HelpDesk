#Region Get-LockoutSource

<#
.SYNOPSIS
    Get the lockout (4740) parsed event log from your domain controller.
.DESCRIPTION
    This command will get the lockout (4740) event log from your domain controller.
.PARAMETER Identity
    The Identity of a specific AD User to query.
.PARAMETER ComputerName
    The name of the computer to query.
    This defaults to the correct domain controller.
.EXAMPLE
    Get-LockoutSource -ComputerName DC1

    Description
    -----------
    This will get the lockout (4740) events log from DC1 for any user.
.EXAMPLE
    Get-LockoutSource -Identity "Administrator" -ComputerName DC1

    Description
    -----------
    This will get the lockout (4740) events log from DC1 for the Administrator user.
.EXAMPLE
    Get-LockoutSource -Identity "Administrator"

    Description
    -----------
    This will get the lockout (4740) events log from the current domain controller for the Administrator user.
.NOTES
    Author: TechDufus
    GitHub: https://github.com/TechDufus
#>
Function Get-LockoutSource() {
    [CmdletBinding()]
    Param(
        [Parameter(
            ValueFromPipelineByPropertyName
        )]
        [Alias('SAMAccountName')]
        [System.String] $Identity,

        [Parameter()]
        [System.String] $ComputerName = "$((Get-ADDomain).PDCEmulator)"
    )

    Process {
        Try {
            # If object is from the pipe, need to set $User.SAMAccountName value
            If ($_ -is [System.Object]) {
                $User = @{
                    SAMAccountName = $_.SamAccountName
                }
            }
            Else {
                If ($Identity) {
                    $User = Get-ADUser $Identity -Properties LockedOut
                    If (-Not ($User.LockedOut)) {
                        Throw [System.DirectoryServices.ActiveDirectory.ActiveDirectoryObjectNotFoundException]::new("The user $($User.SamAccountName) is not currently locked out.")
                    }
                }
            }
            $params = @{
                FilterHashTable = @{
                    LogName = 'Security'
                    ID      = '4740'
                }
                ComputerName    = $ComputerName
                ErrorAction     = 'SilentlyContinue'
            }
            If ($ComputerName -ne $env:COMPUTERNAME -or 'localhost') {
                $params['ComputerName'] = $ComputerName
            }

            If ($Identity) {
                Get-WinEvent @params | Where-Object { (($_.Message) -split '\t')[-3].split([System.Environment]::NewLine)[0] -eq $($User.SamAccountName) } | Foreach-Object {
                    [PSCustomObject] @{
                        Identity      = $($User.SamAccountName)
                        LockoutSource = (($_.Message) -split '\t')[-1]
                        TimeCreated   = $_.TimeCreated
                    }
                }
            }
            Else {
                Get-WinEvent @params | Foreach-Object {
                    [PSCustomObject] @{
                        Identity      = (($_.Message) -split '\t')[-3].split([System.Environment]::NewLine)[0]
                        LockoutSource = (($_.Message) -split '\t')[-1]
                        TimeCreated   = $_.TimeCreated
                    }
                }
            }
        }
        Catch {
            Throw $_
        }
    }
}
#EndRegion Get-LockoutSource
