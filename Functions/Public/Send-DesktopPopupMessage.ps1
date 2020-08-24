#Region Send-DesktopPopupMessage

<#
.SYNOPSIS
    Send individual Pop-up message to remote host.
.DESCRIPTION
    This script sends a custom pop-up message to desired server/host with no options or required action. This script must be run as an Administrator.
.PARAMETER ComputerName
    This parameter is to specify the remote PC to attempt to send a message popup to. This parameter needs to pass a Test-Connection to attempt to send the message.
.PARAMETER Message
    This parameter should be inside quotation marks. This will be the text to be displayed in the popup.
.PARAMETER Seconds
    This parameter specifies the number of seconds that the popup will remain on the screen before auto-closing. This has a default value of 120.
.EXAMPLE
    PS> Send-DesktopPopupMessage -ComputerName computer1,FakeServer -Message "This is a test message. Get back to work!"
    [06/05/2019 09:46:36]  : Message to computer1 sent successfully.
    [06/05/2019 09:46:36]  : Unable to establish a connection with FAKESERVER.
    ___________________________________
    | Message from 6/5/2019 9:46 AM |X|
    |_________________________________|
    | This is a test message. Get back|
    | to work!                        |
    | From: Matthew J. DeGarmo        |
    | ComputerName: SourceServer   __ |
    |                             |OK||
    |_________________________________|

    Description
    -----------
    This will create a small popup window on the target computer with the message text, and the From: and ComputerName: information at the bottom.
.NOTES
    Author: Matthew J. DeGarmo
    GitHub: https://github.com/matthewjdegarmo
#>
function Send-DesktopPopupMessage() {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string[]] $ComputerName,

        [Parameter(Mandatory = $true, Position = 1)]
        [string] $Message,

        [Parameter(Position=2)]
        [int] $Seconds = 120
    )

    begin {
        $ComputerName = $ComputerName.ToUpper()
        $Username = (Get-ADUser -Identity $Env:Username | Select-Object Name).Name
        $LocalComputer = $Env:COMPUTERNAME
    }

    process {
        try {
            foreach ($Computer in $ComputerName) {
                if (Test-Connection $Computer -Count 1 -Quiet -ErrorAction Stop) {
                    try {
                        Write-Output "Sending message to Computer: $Computer..."
                        Invoke-Command -ComputerName $Computer -ScriptBlock {
                            C:\windows\system32\msg.exe * /time:$using:Seconds "$using:Message
        
From: $using:Username
Source: $using:LocalComputer"
                        }
                    }
                    catch {
                        Write-Error "Failed to send message to $ComputerName."
                    }
                }
                else {
                    Write-Error "Unable to establish a connection with $Computer."
                }
            }
            ""
        }
        catch {
            Write-Error "$($_.Exception.Message) - Line Number: $($_.InvocationInfo.ScriptLineNumber)"
        }
    }
}
#EndRegion Send-DesktopPopupMessage