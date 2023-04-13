#Region Test-Administrator

<#
.SYNOPSIS
    Test to see if the current user / process is being run as an Administrator.
.DESCRIPTION
    Test if the credentials running this function are elevated on the local system.
.PARAMETER User
    Specify the windows identity to test. This defaults to the current signed-in user running the command.
.EXAMPLE
    PS> Test-Administrator

    Description
    -----------
    This will return a boolean based on if the user is an admin or not.
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @TechDufus

    You can either submit a [PR](https://github.com/TechDufus/HelpDesk/pulls)
        or create an [Issue](https://github.com/TechDufus/HelpDesk/issues/new)
        on this GitHub project at https://github.com/TechDufus/HelpDesk
#>
Function Test-Administrator() {
    [CmdletBinding()]
    param (
        $User = [Security.Principal.WindowsIdentity]::GetCurrent()
    )
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
#EndRegion Test-Administrator
