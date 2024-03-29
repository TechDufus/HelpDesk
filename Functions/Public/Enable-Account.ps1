#Region Enable-Account

<#
.SYNOPSIS
    Quickly enable a disabled ActiveDirectory user account

.DESCRIPTION
    Enables a specified Active Directory Account

.PARAMETER Username
    Specify the SAMAccountName or DistinguishedName of the user to enable.

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
    GitHub: https://github.com/TechDufus

    You can either submit a [PR](https://github.com/TechDufus/HelpDesk/pulls)
        or create an [Issue](https://github.com/TechDufus/HelpDesk/issues/new)
        on this GitHub project at https://github.com/TechDufus/HelpDesk
#>
Function Enable-Account() {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory)]
        [string] $Username
    )

    Enable-ADAccount -Identity $Username -Confirm
}
#EndRegion Enable-Account
