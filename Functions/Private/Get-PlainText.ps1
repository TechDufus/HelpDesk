#Region Get-PlainText
<#
.SYNOPSIS
    Retrieve the Plain text string from a SecureString object.

.NOTES
    Author: Matthew J. DeGarmo
    GitHub: https://github.com/matthewjdegarmo
#>
function Get-PlainText() {
    [CmdletBinding()]
    param
    (
        [parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [System.Security.SecureString[]]$SecureString
    )
    begin { }
    process {
        foreach ($String in $SecureString) {
            $bstr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($String);

            try {
                [Runtime.InteropServices.Marshal]::PtrToStringBSTR($bstr);
            }
            finally {
                [Runtime.InteropServices.Marshal]::FreeBSTR($bstr);
            }
        }
    }
    end { }
}
#EndRegion Get-PlainText