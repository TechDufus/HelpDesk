#Region Unlock-LockedOutADUsers

<#
.SYNOPSIS
    This function performs an unlock of users in ActiveDirectory who are currently locked out.
.DESCRIPTION
    This function is a simple wrapper for Unlock-ADAccount.
.OUTPUTS
    None
        This function does not produce output except for write-output data
.PARAMETER SAMAccountName
    Specify the SAMAccountName or username of the AD User you want to unlock.
.EXAMPLE
    PS>Unlock-LockedOutADUsers -SAMAccountName matthewjd
    Unlocking: matthewjd

    Description
    -----------
    This will unlock the AD Account for user 'matthewjd'.
.EXAMPLE
    PS>Get-LockedOutADUsers | Unlock-LockedOutADUsers
    Unlocking: User1
    Unlocking: User2

    Description
    -----------
    This gets a list of all current locked out users from Get-LockedOutADUsers and forwards each user to Unlock-LockedOutADUsers, which effectively unlocked all currently locked AD Users
    A short-handed command for this using aliases: PS> glo | ul
.NOTES
    Author: Matthew J. DeGarmo
    GitHub: https://github.com/TechDufus

    You can either submit a [PR](https://github.com/TechDufus/HelpDesk/pulls)
        or create an [Issue](https://github.com/TechDufus/HelpDesk/issues/new)
        on this GitHub project at https://github.com/TechDufus/HelpDesk
#>
Function Unlock-LockedOutADUsers() {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('Username')]
        [string[]]$SAMAccountName
    )

    begin {}

    process {
        try {
            foreach ($Username in $SAMAccountName) {
                Write-Output "Unlocking: $Username"
                Unlock-ADAccount -Identity $Username -ErrorAction Stop
            }
        }
        catch {
            Write-Error "$($_.Exception.Message)"
        }
    }
}
#EndRegion Unlock-LockedOutADUsers
