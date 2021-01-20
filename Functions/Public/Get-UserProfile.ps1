#Region Get-UserProfile

<#
.SYNOPSIS
    Quickly generate a list of user profiles for a computer.
.DESCRIPTION
    This will generate a local or a remote list of non-special (SYSTEM, Administrator, etc.) profiles on a computer.
.PARAMETER ComputerName
    Specify the remote machine to query. You must have rights to connect to this computer.
.EXAMPLE
    PS> Get-UserProfile

    Description
    -----------
    This will display CIM Objects for each profile on the local system.
.EXAMPLE
    PS> Get-UserProfile -ComputerName Some-Remote-PC1

    Description
    -----------
    This will retrieve User Profile CIM Objects from the remote PC.
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo

    You can either submit a [PR](https://github.com/matthewjdegarmo/HelpDesk/pulls)
        or create an [Issue](https://github.com/matthewjdegarmo/HelpDesk/issues/new)
        on this GitHub project at https://github.com/matthewjdegarmo/HelpDesk
#>
function Get-UserProfile() {
    [CmdletBinding()]
    Param (
        [System.String] $ComputerName
    )

    Begin {}

    Process {
        Try {
            $Params = @{
                ClassName = 'Win32_UserProfile'
            }
            if ($PSBoundParameters.ContainsKey('ComputerName')) {
                $Params += @{ComputerName = $ComputerName.ToUpper()}
            }

            $Profiles = Get-CimInstance @Params | Where-Object {$_.Special -ne "Special" -and $_.LocalPath -ne "C:\Users\Administrator"}

            if ($Profiles) {
                $Profiles
            } else {
                Throw("There are no user profiles to display.")
            }
        } Catch {
            Write-Error "$($_.Exception.Message)"
        }
    }

    End {}
}
#EndRegion Get-UserProfile