#Region Start-MSRA

<#
.SYNOPSIS
    Starts Microsoft Remote Assistance
.DESCRIPTION
    This function is set to work with the helpdesk mode of Windows Remote Assistance. You can either enter a computer name and the function will attempt to start a connection to the remote computer. If no computer name is specified Windows Remote Assistance will open to the Advanced Help Desk Mode, which is where you can enter a computer name to connect to.
.PARAMETER ComputerName
    This parameter is for the remote computer you wish to connect to. By default if you don’t specify a remote computer Windows Remote Assistant will open up to the helpdesk screen.
.EXAMPLE
    PS C:\> Start-MSRA computer1
    
    Description
    -----------
    This example shows how to call the Start-MSRA function and automatically connect to the remote computer.
.NOTES
    Author: Matthew J. DeGarmo
    GitHub: https://github.com/matthewjdegarmo
#>
Function Start-MSRA() {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $false,
            HelpMessage = 'This is the remote computer you wish to connect to.')]
        [Alias('CN')]
        [string]
        $ComputerName = ""
    )
	
    If ($ComputerName -eq "") {
        Start-Process -FilePath "C:\Windows\System32\msra.exe" -Args "/Offerra"
    }
    Else {
        If (Test-Connection -ComputerName $ComputerName -Count 2 -Quiet) {
            Start-Process -FilePath "C:\Windows\System32\msra.exe" -Args "/Offerra \\$ComputerName"
        }
        Else {
            Return "Failed to Connect to $ComputerName"
        }
    }
}
#EndRegion Start-MSRA