#Region Get-LocalAdmin

<#
.SYNOPSIS
    Retrieves a list of users in the local Administrators group.

.DESCRIPTION
    This function identifies local admins from the computer or server it is run from.

.PARAMETER ComputerName
    Specify the remote computer to query.

.EXAMPLE
    PS> Get-LocalAdmin

    Description
    -----------
    Generates a list of local admins

.EXAMPLE
    PS> Get-LocalAdmin -ComputerName SomeRemoteComputer-PC

    Description
    -----------
    Generate a list of local admins on a remote PC.

.NOTES
    Author: Matthew J. DeGarmo
    GitHub: https://github.com/TechDufus

    You can either submit a [PR](https://github.com/TechDufus/HelpDesk/pulls)
        or create an [Issue](https://github.com/TechDufus/HelpDesk/issues/new)
        on this GitHub project at https://github.com/TechDufus/HelpDesk
#>
#Requires -Assembly C:\Windows\system32\net.exe
Function Get-LocalAdmin() {
    [CmdletBinding()]
    param(
        [Parameter()]
        [string] $ComputerName = $env:COMPUTERNAME
    )

    if ($PSBoundParameters.ContainsKey('ComputerName')) {
        $NetAdminObject = Invoke-Command -ComputerName $ComputerName -ScriptBlock { (net.exe localgroup Administrators) -split '\r?\n' }
    }
    else {
        $NetAdminObject = (net.exe localgroup Administrators) -split '\r?\n'
    }
    $NetAdminObject[6..(($NetAdminObject.count) - 3)]
}
#EndRegion Get-LocalAdmin
