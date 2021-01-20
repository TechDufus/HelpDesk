#Region Get-ADGroupsManagedByUser

<#
.SYNOPSIS
    Generate a list of group names owned by a specified.
.DESCRIPTION
    This will look up groups owned by the specified user.
.PARAMETER Username
    This is the Identity used by `Get-ADUser` to look up the Distinguished name used by `Get-ADGroup`.
.EXAMPLE
    PS>Get-ADGroupsManagedByUser mjdegar

    Description
    -----------
    This will generate all groups (Security or Distribution) Managed by `mjdegar`.
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo

    You can either submit a [PR](https://github.com/matthewjdegarmo/HelpDesk/pulls)
        or create an [Issue](https://github.com/matthewjdegarmo/HelpDesk/issues/new)
        on this GitHub project at https://github.com/matthewjdegarmo/HelpDesk
#>
function Get-ADGroupsManagedByUser() {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string] $Username
    )
    try {
        $User_DN = (Get-ADUser -Identity $Username).DistinguishedName
        Get-ADGroup -Properties ManagedBy -Filter * | `
            Where-Object { $_.ManagedBy -eq $User_DN } | `
            Select-Object Name
    }
    catch {
        Write-Error "$($_.Exception.Message) - Line Number: $($_.InvocationInfo.ScriptLineNumber)"
    }
}
#EndRegion Get-ADGroupsManagedByUser