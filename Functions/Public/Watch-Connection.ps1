#Region Watch-Connection

<#
.SYNOPSIS
    Loops through a test-connection and sends email when connection is made.
.DESCRIPTION
    This script simply is a test-connection that loops until a connection is made.
.PARAMETER ComputerName
    This parameter should specify the computer name you are testing a connections with.
.PARAMETER Message
    This parameter will include text to be included in the success email.
.PARAMETER Recipients
    This parameter specifies additional recipients to receive the successful connection email. These values should be separated by commas and wrapped in quotation marks.
.PARAMETER Email
    This switch allows the function to send an email when a successful connection is made. If this switch is present, an email will be sent.
.PARAMETER From
    This is the email address that this alert will originate from.
.PARAMETER SmtpServer
    This is the SMTP server that you will be using to send the email.
.EXAMPLE
    PS>Watch-Connection -ComputerName SomeServer -Message "A connection to SomeServer has been made. Please remove admin access from user 'SomeUser'" -Recipients "myself@me.com","someoneelse@them.com","OtherEmailsSeperatedByCommas@site.com"
    Connecting to SOMESERVER....
    Sending email to the following recipients: "myself@me.com","someoneelse@them.com","OtherEmailsSeperatedByCommas@site.com"
    Connection Successful.
    Message: A connection to SomeServer has been made. Please remove admin access from user 'SomeUser'

    Description
    -----------
    This will loop through a Test-Connection -Count 1 command against 'SomeServer' until a connection is made. Once it is made, an email is sent to the user running the script and to the additional users specified in the -Recipients Parameter.
.EXAMPLE
    PS>Watch-Connection SomeComputer -Notification "Finally connected to user 'SomeUser' PC."
    Connecting to SOMECOMPUTER....
    Connection Successful.
    Message: Finally connected to user 'SomeUser' PC.

    Description
    -----------
    This will loop through a `Test-Connection -Count 1` command against 'SomeComputer'.
.NOTES
    Author: Matthew J. DeGarmo
    GitHub: https://github.com/TechDufus

    You can either submit a [PR](https://github.com/TechDufus/HelpDesk/pulls)
        or create an [Issue](https://github.com/TechDufus/HelpDesk/issues/new)
        on this GitHub project at https://github.com/TechDufus/HelpDesk
#>
Function Watch-Connection() {
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [string] $ComputerName,

        [string ]$Message,

        [string[]] $Recipients,

        [switch] $Email,

        [String] $From,

        [String] $SmtpServer
    )

    begin {
        $ComputerName = $ComputerName.ToUpper()
    }

    process {
        try {
            DO {
                Clear-Host
                Write-Host "Connecting to $ComputerName." -ForegroundColor Yellow
                Start-Sleep -Milliseconds 500
                Clear-Host
                Write-Host "Connecting to $ComputerName.." -ForegroundColor Yellow
                Start-Sleep -Milliseconds 500
                Clear-Host
                Write-Host "Connecting to $ComputerName..." -ForegroundColor Yellow
                Start-Sleep -Milliseconds 500
                Clear-Host
                Write-Host "Connecting to $ComputerName...." -ForegroundColor Yellow
            } while (-not(Test-Connection $ComputerName -count 1 -ErrorAction SilentlyContinue))

            if (Test-Connection $ComputerName -count 1 -ErrorAction SilentlyContinue) {
                if ($Email.IsPresent) {
                    $MessageArgs = @{
                        To         = $Recipients
                        From       = $From
                        Subject    = "$ComputerName Online"
                        SmtpServer = $SmtpServer
                        Priority   = 'High'
                        Body       = "$ComputerName is now online. 
                        <p>$Message</p>
                        <p></p><n>From: $env:USERNAME</n>
                        <p></p><n>Source: $env:COMPUTERNAME</n>"
                    }
                    Write-Output "Sending email to the following recipients: $Recipients"
                    Send-MailMessage @MessageArgs -BodyAsHtml
                }
                Write-Host 'Connection Successful.' -ForegroundColor Green
                if ($Message) {
                    Write-Output "Message: $Message"
                }
            }
        }
        catch {
            Write-Error "$($_.Exception.Message) - Line Number: $($_.InvocationInfo.ScriptLineNumber)"
        }
    }

    end {}
}
#EndRegion Watch-Connection
