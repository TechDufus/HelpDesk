#Region Set-Password

<#
.SYNOPSIS
    Reset domain password for an ActiveDirectory user.

.DESCRIPTION
    Sets a Active Directory Password and provides an option to require a password change on login.

.EXAMPLE
    Specifies the username being set and then prompts for a password.

    Set-Password -username domain\username

.NOTES
    Author: Matthew J. DeGarmo
    GitHub: https://github.com/matthewjdegarmo
#>
Function Set-Password {
    [CmdletBinding()]

    Param (
        [Parameter(Mandatory = $true)]$Username,
        [Parameter()][SecureString]$Password = (Read-Host -Prompt "Password" -AsSecureString),
        [Switch]$RequireReset
    )

    Set-ADAccountPassword -Identity $username -Reset -NewPassword $Password

    if ($RequireReset.IsPresent) {
        Set-ADUser -Identity $Username -ChangePasswordAtLogon $true
    }
}
#EndRegion Set-Password