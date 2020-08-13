

<#
.SYNOPSIS
    Generate a list of group names owned by a specified.
.DESCRIPTION
    This will look up groups owned by the specified user.
.PARAMETER Identity
    This is the Identity used by `Get-ADUser` to look up the Distinguished name used by `Get-ADGroup`.
.EXAMPLE
    PS>Get-ADGroupsManagedByUser mjdegar

    Description
    -----------
    This will generate all groups (Security or Distribution) Managed by `mjdegar`.
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo
.LINK
    https://zero.comaround.com/link/19fc2b232c2a4cc149c508d821a4d624/
#>
function Get-ADGroupsManagedByUser() {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory,Position=0)]
        [string] $Username
    )
    try {
        $User_DN = (Get-ADUser -Identity $Username).DistinguishedName
        Get-ADGroup -Properties ManagedBy -Filter * | `
        Where-Object {$_.ManagedBy -eq $User_DN} | `
        Select-Object Name
    } catch {
        Write-Error "$($_.Exception.Message) - Line Number: $($_.InvocationInfo.ScriptLineNumber)"
    }
}




