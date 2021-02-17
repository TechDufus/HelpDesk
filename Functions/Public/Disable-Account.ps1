#Region Disable-Account

<#
.SYNOPSIS
    Disable an enabled AD Account.
    
.DESCRIPTION
    Disables a specified Active Directory Account

.PARAMETER Username
    Specify the SAMAccountName or DistinguishedName of the user to disable.

.EXAMPLE
    PS> Disable-ADAccount -Username JohnDoe
    
    Description
    -----------
    Use the Samaccountname of the account being disabled
    
.EXAMPLE
    PS> Disable-ADAccount -Username "CN=Matt Degar,OU=AI,OU=UserAccounts,DC=FAKE,DC=COM"
    
    Description
    -----------
    Use the DistinguishedName of the account being disabled
    
.EXAMPLE
    PS> Disable-ADAccount -Username JohnD@Company.com
    
    Description
    -----------
    Use the UserPrincipalName of the account being disabled
    
.NOTES
    Author: Matthew J. DeGarmo
    GitHub: https://github.com/matthewjdegarmo

    You can either submit a [PR](https://github.com/matthewjdegarmo/HelpDesk/pulls)
        or create an [Issue](https://github.com/matthewjdegarmo/HelpDesk/issues/new)
        on this GitHub project at https://github.com/matthewjdegarmo/HelpDesk
#>
Function Disable-Account() {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]$Username
    )

    Disable-ADAccount -Identity $Username -Confirm
}
#EndRegion Disable-Account