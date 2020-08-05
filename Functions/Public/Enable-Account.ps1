

<#
.SYNOPSIS
    Quickly enable a disabled ActiveDirectory user account

.DESCRIPTION
    Enables a specified Active Directory Account

.EXAMPLE
    PS> Enable-ADAccount -Username JohnD

    Description
    -----------
    Use the Samaccountname of the account being disabled

.EXAMPLE
    PS> Enable-ADAccount -Username "CN=Matt Degar,OU=AI,OU=UserAccounts,DC=FAKE,DC=COM"

    Description
    -----------
    Use the DistinguishedName of the account being disabled

.EXAMPLE
    PS> Enable-ADAccount -Username PJohnD@Company.com

    Description
    -----------
    Use the UserPrincipalName of the account being disabled

.NOTES
    Author: Matthew J. DeGarmo
    GitHub: https://github.com/matthewjdegarmo
#>
Function Enable-Account {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [string] $Username
    )

    Enable-ADAccount -Identity $Username -Confirm
}




