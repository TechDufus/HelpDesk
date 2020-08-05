<#
.SYNOPSIS
    Generate a list of group names owned by a specified.
.DESCRIPTION
    This will look up groups owned by the specified user.
.PARAMETER Identity
    This is the Identity used by `Get-ADUser` to look up the Distinguished name used by `Get-ADGroup`.
.EXAMPLE
    PS>Get-ADGroupsManagedByUser user1

    Description
    -----------
    This will generate all groups (Security or Distribution) Managed by `user1`.
.NOTES
    Author: Matthew J. DeGarmo
    GitHub: https://github.com/matthewjdegarmo
#>
function Get-ADGroupsManagedByUser() {
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
        Write-Error "$($_.Exception.Message)"
    }
}




