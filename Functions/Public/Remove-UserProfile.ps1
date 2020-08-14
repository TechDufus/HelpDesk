#Region Remove-UserProfile
<#
.SYNOPSIS
    Quickly delete a user profile from a computer
.DESCRIPTION
    This command will delete user profiles for the local or remote computer.
.PARAMETER Username
    Specify the specific username(s) for the profile(s) to be deleted.
.PARAMETER ComputerName
    Specify a remote computer name to remove user profiles from.
.EXAMPLE
    PS> Remove-UserProfile test123

    Description
    -----------
    This will delete the local `test123` account on the local computer.
    If this account / profile does not exist, you will get an error.
.EXAMPLE
    PS> Remove-UserProfile -All -ComputerName Some-Remote-PC1

    Description
    -----------
    This will delete all non-special profiles on the remote computer.
.EXAMPLE
    PS> Remove-UserProfile user1,user2,user3 -ComputerName Some-Remote-PC1 -Verbose

    Description
    -----------
    This will attempt to remove all named user accounts (comma-seperated) from the remote computer and display verbose output.
.NOTES
    Author: Matthew J. DeGarmo
    Handle: @matthewjdegarmo
#>
function Remove-UserProfile() {
    [CmdletBinding(DefaultParameterSetName='Named')]
    Param (
        [Parameter(Mandatory)]
        [Parameter(ParameterSetName='Named')]
        [System.String[]] $UserName,

        [Parameter(ParameterSetName='Named')]
        [Parameter(ParameterSetName='All')]
        [System.String] $ComputerName,

        [Parameter(ParameterSetName='All')]
        [Switch] $All,

        [Switch] $WhatIf=$false,
        [Switch] $Confirm=$false
    )

    Begin {}

    Process {
        Try {
            if ($PSBoundParameters.ContainsKey('All')) {
                $Params = @{}
                $Confirm = $true
                if ($PSBoundParameters.ContainsKey('ComputerName')) {
                    $Params += @{ ComputerName = $ComputerName.ToUpper()}
                } else {$ComputerName = $env:COMPUTERNAME}

                $AllProfiles = Get-UserProfile @Params
                if ($null -ne $AllProfiles) {
                    Write-Verbose "Removing all user profiles from computer: $ComputerName"
                    $AllProfiles | Remove-CimInstance -Whatif:$Whatif -Confirm:$Confirm
                } else {
                    Write-Error "There are no user profiles to remove with the specified criteria. Username: $User Computername: $ComputerName"
                }
            } else {
                $Params = @{ }
                if ($PSBoundParameters.ContainsKey('ComputerName')) {
                    $Params += @{ ComputerName = $ComputerName.ToUpper()}
                } else {$ComputerName = $env:COMPUTERNAME}
                $Username | ForEach-Object {
                    $User = $_
                    $UserProfile = Get-UserProfile @Params | Where-Object {$_.LocalPath -match $User}
                    if ($UserProfile) {
                        Write-Verbose "Removing user profile $User on $ComputerName"
                        $UserProfile | Remove-CimInstance -Whatif:$Whatif -Confirm:$Confirm
                    } else {
                        Write-Error "There are no user profiles to remove with the specified criteria. Username: $User Computername: $ComputerName"
                    }
                }
            }
        } Catch {
            Write-Error "$($_.Exception.Message)"
        }
    }

    End {}
}
#EndRegion Remove-UserProfile