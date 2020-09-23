#Region New-Password

<#
.SYNOPSIS
    Create a random password

.DESCRIPTION
    The function creates a random password using a given set of available characters.
    The password is generated with fixed or random length.
    Passwords will never end with a number, and never start with a special character.

.PARAMETER Admin
    This switch will change all of the password requirements to be a 24-character password with all character types.

.PARAMETER Size
    Specify the fixed length of the password.

.PARAMETER Count
    Number of passwords to generate, default = 1

.PARAMETER CharSets
    Specify the character-type requirements. U=Upper, L=Lower, N=Number, S=Special.

.PARAMETER Exclude
    Specify any characters to exclude from the new password generated.

.EXAMPLE
    PS> New-RandomPassword -Admin

    Description
    -----------
    This generates a random password of 24-character length, and includes all character types.
.EXAMPLE
    PS> New-RandomPassword -Size 20

    Description
    -----------
    Generates a password of 20 characters

.NOTES
    Author: Matthew J. DeGarmo
    GitHub: https://github.com/matthewjdegarmo
#>
Function New-Password () {
    [CmdletBinding()]
    param (
        [Int]$Size = 12,
        [Char[]]$CharSets = "ULNS",
        [Char[]]$Exclude,
        [int]$Count = 1,
        [switch]$Admin
    )

    if ($Admin.IsPresent) {
        $Size = 24
    }
    for ($i = 0; $i -lt $Count; $i++) {
        $Chars = @(); $TokenSets = @()
        #Creates a disctionary of character arrays for each character set
        If (!$TokenSets) {
            $TokenSets = @{
                U = [Char[]]'ABCDEFGHJKLMNPQRTUVWXYZ'       #Upper case
                L = [Char[]]'abcdefghijkmnrstuvwxyz'        #Lower case
                N = [Char[]]'2346789'                        #Numerals
                S = [Char[]]'_!@#%&'                          #Symbols
            }
        }
        #Cycles through each character set for a random character from each.
        $CharSets | ForEach-Object {
            #Creates a single array from all character and token sets.
            $Tokens = $TokenSets."$_" | ForEach-Object { If ($Exclude -cNotContains $_) { $_ } }
            If ($Tokens) {
                $TokensSet += $Tokens
                If ($_ -cle [Char]"Z") { $Chars += $Tokens | Get-Random }             #Character sets defined in upper case are mandatory
            }
        }
        #Loops through each character and grabs a random one.
        While ($Chars.Count -lt $Size) { $Chars += $TokensSet | Get-Random }
        #Further randomizes the ending password.
        $PW = ($Chars | Sort-Object { Get-Random }) -Join ""     #Mix the (mandatory) characters and output string
        
        #Password must not end with a number, must start with an alpha character, and must have at least 1 of each character type.
        #If password doesn't meet the below regexs, it adds 1 to the amount of password needed, and skips that password.
        if (($PW[-1] -match '\d') -or (-Not ($PW[0] -match '[a-zA-Z]')) -or (-Not($PW -match "^(?=.{8,})(?=.*[a-z])(?=.*[A-Z])(?=.*[_!@#%&]).*$"))) {
            $Count++
            continue
        }
        else {
            $PW
        }
    }
}
#EndRegion New-Password