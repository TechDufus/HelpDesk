#Region Test-Administrator

<#
.SYNOPSIS
    Test to see if the current user / process is being run as an Administrator.
.DESCRIPTION
    Test if the credentials running this function are elevated on the local system.
.EXAMPLE
    PS> Test-Administrator

    Description
    -----------
    This will return a boolean based on if the user is an admin or not.
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo
.LINK
    https://zero.comaround.com/link/19fc2b232c2a4cc149c508d821a4d624/
#>
function Test-Administrator {
    [CmdletBinding()]
    param (
        $user = [Security.Principal.WindowsIdentity]::GetCurrent()
    )
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
#EndRegion Test-Administrator