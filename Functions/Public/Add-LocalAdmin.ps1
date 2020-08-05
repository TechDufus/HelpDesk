<#
.SYNOPSIS
    Adds user to local admin group.

.DESCRIPTION
    This function adds a local admin to the computer or server it is run from.

.NOTES
    Azure AD Joined machines will require the user to first login to a computer with their domain account before adding their domain account as a local admin.
    The user logging in registers their SID so that the command is successful.

.EXAMPLE
    PS> Add-LocalAdmin -Username username

    Description
    -----------
    Adds specified domain user to the local administrators group

.EXAMPLE
    PS> Add-LocalAdmin -ComputerName Some-Remote-Computer -Username username

    Description
    -----------
    This will attempt to add the specified user to the local admin group of the specified remote computer. You must be an admin on the remote computer for this to work.

.NOTES
    Author: Matthew J. DeGarmo
    GitHub: https://github.com/matthewjdegarmo
#>
Function Add-LocalAdmin {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory, Position = 0)]
        [string] $Username,

        [Parameter(Position = 1)]
        [string] $ComputerName = $env:COMPUTERNAME,

        [Parameter()]
        [string] $Domain = (Get-ADDomain -Current LoggedOnUser)
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
                Invoke-Command -ComputerName $ComputerName -ScriptBlock { net.exe Localgroup Administrators $using:FullUsername /add }
            }
            else {
                net.exe Localgroup Administrators $FullUsername /add
            }
            
        }
        catch {
            Write-Error "$($_.Exception.Message)"
        }
    }

    end {}
}

