#Region Remove-LocalAdmin

<#
.SYNOPSIS
    Removes user from local admin group.

.DESCRIPTION
    This function removes a local admin from the computer or server it is run from.

.PARAMETER Username
    Specify the SAMAccountName of the user to remove.

.PARAMETER ComputerName
    Specify a remote computer to run against.

.PARAMETER Domain
    Specify the domain that the user belongs to.

.EXAMPLE
    PS> Remove-LocalAdmin -Username someuser

    Description
    -----------
    Removes specified domain user from the local administrators group

.NOTES
    Author: Matthew J. DeGarmo
    GitHub: https://github.com/matthewjdegarmo

    Azure AD Joined machines will require the user to first login to a computer with their domain account before adding their domain account as a local admin.
    The user logging in registers their SID so that the command is successful.
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
                #Invoke-Command -ComputerName $ComputerName -ScriptBlock { Remove-LocalGroupMember -Group Administrators -Member $using:FullUsername }
                Invoke-Command -ComputerName $ComputerName -ScriptBlock { net.exe Localgroup Administrators $using:FullUsername /delete }
            }
            else {
                #Remove-LocalGroupMember -Group Administrators -Member $FullUsername
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