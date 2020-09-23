#Region Reset-Password

<#
.SYNOPSIS
    Reset domain password for an ActiveDirectory user.

.DESCRIPTION
    Sets a Active Directory Password and provides an option to require a password change on login.
.PARAMETER Username
    Specify the username to reset the password for.
.PARAMETER Password
    Specify the password to set. By default, a strong, random password is generated, unless a password is provided.
.PARAMETER ComputerName
    Specify the computer name that the user would be sitting at. This will attempt to display a popup on their screen displaying the new password.
.PARAMETER RequireReset
    With this switch present, the user will be forced to reset their password immediately after signing in.
.PARAMETER Admin
    With this switch present, a stronger random password will be auto-generated. #Security
.EXAMPLE
    PS> Reset-Password someuser1

    Username   Password
    --------   --------
    someuser1  xh9GKKtN!64v

    Description
    -----------
    Calls `New-Password`

.NOTES
    Author: Matthew J. DeGarmo
    GitHub: https://github.com/matthewjdegarmo
#>
function Reset-Password() {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $true)]
        [string] $Username,

        [Parameter()][SecureString] 
        [string] $Password,

        [string] $ComputerName,

        [Switch] $RequireReset = $false,

        [Switch] $Admin
    )

    if ([String]::IsNullOrEmpty($Password)) {
        #Many domain admin accounts do not start with an alpha character. Edit this for your needs.
        if ($Username[0] -notmatch '[a-zA-Z]' -or $Admin.IsPresent) {
            $NewPasswordArgs = @{Admin = $True }
        }
        else { $NewPasswordArgs = @{} }
    
        $SecurePassword = New-Password @NewPasswordArgs | ConvertTo-SecureString -AsPlainText -Force
    }
    else {
        $SecurePassword = $Password | ConvertTo-SecureString -AsPlainText -Force
    }

    $ResetPasswordArgs = @{
        Username     = $Username
        RequireReset = $RequireReset
    }
    try {
        Set-Password @ResetPasswordArgs -Password $SecurePassword

        [pscustomobject] @{
            Username    = $Username
            NewPassword = ($SecurePassword | Get-PlainText)
        }
        #Copies
        $SecurePassword | Get-PlainText | Clip

        if ($PSBoundParameters.ContainsKey('ComputerName')) {
            Send-DesktopPopupMessage -ComputerName $ComputerName -Message "Password: $($SecurePassword | Get-PlainText)"
        }
    }
    catch {
        Write-Error "$($_.Exception.Message)"
    }
}
#EndRegion Reset-Password