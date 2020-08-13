#Region Get-DellTags
<#
.SYNOPSIS
    Gather Dell Tag information.
.DESCRIPTION
    Generate the ServiceTag and ExpressServiceCode of a dell computer.
.PARAMETER ServiceTag
    Providing the ServiceTag (SerialNumber) will generate the accompanying ExpressServiceCode.
.PARAMETER ExpressServiceCode
    Providing the ExpressServiceCode will generate the accompanying ServiceTag (SerialNumber).
.PARAMETER ComputerName
    Providing the ComputerName will attempt to generate the ServiceTag and ExpressServiceCode.
    The computer specified must be turned on, online, and your account must have remote access rights to it.
    If the Get-CimInstance query finds that the specified computer is not a Dell, your query will fail.
.EXAMPLE
    PS> Get-DellTags -ServiceTag M11P21T

    ServiceTag ExpressServiceCode
    ---------- ------------------
    M11P21T           47952526241

    Description
    -----------
    Providing the -ServiceTag will generate the ExpressServiceCode
.EXAMPLE
    PS> Get-DellTags -ExpressServiceCode 47952526241

    ServiceTag ExpressServiceCode
    ---------- ------------------
    M11P21T           47952526241

    Description
    -----------
    Providing the -ExpressServiceCode will generate the ServiceTag.
.EXAMPLE
    PS> Get-DellTags -ComputerName some-domain-computer

    ServiceTag ExpressServiceCode
    ---------- ------------------
    M11P21T           47952526241

    Description
    -----------
    Providing the -ComputerName will attempt to generate this information if the computer is online, and it is a Dell computer.
.NOTES
    Author: Matthew J. DeGarmo
    GitHub: https://github.com/matthewjdegarmo
#>
function Get-DellTags() {
    [cmdletBinding(DefaultParameterSetName='ComputerName')]
    param (
        [Parameter(Mandatory,Position=0,ValueFromPipeline,ValueFromPipelineByPropertyName,ParameterSetName="ServiceTag")]
        [System.String] $ServiceTag,

        [Parameter(Mandatory,Position=0,ValueFromPipeline,ValueFromPipelineByPropertyName,ParameterSetName="ExpressServiceCode")]
        [System.Int64] $ExpressServiceCode,

        [Parameter(Mandatory,Position=0,ValueFromPipeline,ValueFromPipelineByPropertyName,ParameterSetName="ComputerName")]
        [System.String] $ComputerName
    )

    begin {}

    process {
        try {
            switch($PSBoundParameters.Keys) {
                'ServiceTag' {
                    $ExpressServiceCode = ConvertServiceTagTo-ExpressServiceCode -ServiceTag $ServiceTag
                }
                'ExpressServiceCode' {
                    $ServiceTag = ConvertExpressServiceCodeTo-ServiceTag -ExpressServiceCode $ExpressServiceCode
                }
                'ComputerName' {
                    $params = @{
                        ClassName = 'Win32_BIOS'
                        ComputerName = $ComputerName
                    }
                    $ComputerInfo = Get-CimInstance @params
                    if ($ComputerInfo.Manufacturer -like "*DELL*") {
                        $ServiceTag = $ComputerInfo.SerialNumber
                    } else {
                        Throw("Computer: $($ComputerName.ToUpper()) is not a Dell computer. Manufacturer is $($ComputerInfo.Manufacturer)")
                    }
                    $ExpressServiceCode = ConvertServiceTagTo-ExpressServiceCode -ServiceTag $ServiceTag
                }
                DEFAULT {}
            }

            [PSCustomObject]@{
                ServiceTag = $ServiceTag
                ExpressServiceCode = $ExpressServiceCode
            }
        } catch {
            Write-Error "$($_.Exception.Message)"
        }
    }

    end {}
}
#EndRegion Get-DellTags