#Region Remove-LocalAdmin

<#
.SYNOPSIS
    Removes user from local admin group.

.DESCRIPTION
    This function removes a local admin from the computer or server it is run from.

.NOTES
    Azure AD Joined machines will require the user to first login to a computer with their domain account before adding their domain account as a local admin.
    The user logging in registers their SID so that the command is successful.

.EXAMPLE
    PS> Remove-LocalAdmin -Username someuser

    Description
    -----------
    Removes specified domain user from the local administrators group

.NOTES
    Author: Matthew J. DeGarmo
    GitHub: https://github.com/matthewjdegarmo
#>
function Remove-LocalAdmin() {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory, Position = 0)]
        [string] $Username,

        [Parameter(Position = 1, ValueFromPipelineByPropertyName)]
        [string] $ComputerName = $env:COMPUTERNAME,

        [Parameter()]
        [string] $Domain = $env:USERDOMAIN
    )

    begin {
        function Get-UsernameDomainFormat($Username, $Domain) {
            return ("$Domain\$Username")
        }
    }

    process {
        try {
            $FullUsername = Get-UsernameDomainFormat $Username $Domain
            if ($PSBoundParameters.ContainsKey('ComputerName')) {
                Invoke-Command -ComputerName $ComputerName -ScriptBlock { net.exe Localgroup Administrators $using:FullUsername /delete }
            }
            else {
                net.exe Localgroup Administrators $FullUsername /delete
            }
        }
        catch {
            Write-Error "$($_.Exception.Message)"
        }
    }

    end {}
}
#EndRegion Remove-LocalAdmin