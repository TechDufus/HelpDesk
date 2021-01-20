#Region Get-Computer

<#
.SYNOPSIS
    This function performs a quick lookup of an ActiveDirectory computer.
.DESCRIPTION
    This function is a simple Get-ADComputer with certain fields to display.
.PARAMETER ComputerName
    This parameter should specify the ActiveDirectory ComputerName. This parameter can accept multiple values, separated by commas.
.PARAMETER FilePath
    This parameter should specify a .CSV or a .TXT file containing only computername values.

    NOTE: The CSV must have a value title at the top, aka the first line should say ComputerName or something similar.

        CSV files - first row should be column headers
            - The first row should be ComputerName
            EXAMPLE:    ComputerName
                        computer1
                        computer2

        TXT files - just input data, no headers necessary.
            EXAMPLE:    computer1
                        computer2
.INPUTS
    System.String[]
        This function does not accept pipeline data. The values for all parameters must be specified.
.OUTPUTS
    None
        This function does not produce output except for write-host data
.EXAMPLE
    PS>Get-Computer -ComputerName Computer1

    Name            : Computer1
    Description     : Some description of this computer
    OperatingSystem : Windows 10 Enterprise
    CanonicalName   : some.domain.com/ou/path/to/computer

    Description
    -----------
    This will display information about the computer.
.EXAMPLE
    PS>PCLookup -ComputerName Fake-Computer
    PCLookup : The PC named 'Fake-Computer' does not exist.
    At line:1 char:1
    + PCLookup -ComputerName Fake-Computer
    + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        + CategoryInfo          : NotSpecified: (:) [Write-Error], WriteErrorException
        + FullyQualifiedErrorId : Microsoft.PowerShell.Commands.WriteErrorException,PCLookup

    Description
    -----------
    This will write an error to the screen that 'Fake-Computer' is not a computer that exists in ActiveDirectory. This also shows the usage of the alias `PCLookup` which points to `Get-Computer`.
.EXAMPLE
    PS>PC -ComputerName Computer1,Fake-Computer,Computer2

    Name            : Computer1
    Description     : Some description of this computer
    OperatingSystem : Windows 10 Enterprise
    CanonicalName   : some.domain.com/ou/path/to/computer

    PCLookup : The PC named 'Fake-Computer' does not exist.
    At line:1 char:1
    + PCLookup -ComputerName Computer1,Fake-Computer,Computer2
    + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        + CategoryInfo          : NotSpecified: (:) [Write-Error], WriteErrorException
        + FullyQualifiedErrorId : Microsoft.PowerShell.Commands.WriteErrorException,PCLookup

    Name            : Computer2
    Description     : Some description of this computer
    OperatingSystem : Windows 10 Enterprise
    CanonicalName   : some.domain.com/ou/path/to/computer

    Description
    -----------
    This will generate results for all three specified ComputerName's, and will generate an error in place of the Fake-Computer, and continue generating results. This also shows the usage of the alias `PC`, which points to the alias `PCLookup`, which points to the command `Get-Computer`.
.EXAMPLE
    PS>Get-Computer -FilePath .\Computers.txt
.NOTES
    Author: Matthew J. DeGarmo
    GitHub: https://github.com/matthewjdegarmo

    You can either submit a [PR](https://github.com/matthewjdegarmo/HelpDesk/pulls)
        or create an [Issue](https://github.com/matthewjdegarmo/HelpDesk/issues/new)
        on this GitHub project at https://github.com/matthewjdegarmo/HelpDesk
    
    Change Log:

    Version: 2.0 - Added the FilePath parameter, and loads error-checking to detect if computername is used or filepath used without having to specify -Computername or -FilePath
                    Example: You can use PCLookup test-pc      AND       PCLookup C:\temp\file.txt       AND        PCLookup C:\temp\nonexistentfile.csv
                    This script will now generate results, OR display the correct error message for all these scenarios.
    Version: 1.0 - Function Creation.
#>
Function Get-Computer() {
    [CmdletBinding(DefaultParameterSetName = "Named")]
    param(
        [parameter(Mandatory = $true, Position = 0, ParameterSetName = "Named", ValueFromPipelineByPropertyName = $true, ValueFromPipeline = $true)]
        [ALias("Name")]
        [string[]]$ComputerName,
        
        [parameter(Mandatory = $true, Position = 0, ParameterSetName = "File")]
        [string]$FilePath
    )
    begin {
        if ($ComputerName.Count -le 1) {
            if (([System.IO.File]::Exists($ComputerName)) -or (Test-Path $ComputerName)) {
                $FilePath = (Get-ChildItem $ComputerName).Fullname
                $Computername = $null
            }
            else {
                if (($ComputerName -match "\\") -and (-Not(Test-Path $ComputerName))) {
                    Write-Error "File $ComputerName does not exist. Please provide a correct file path for -FilePath."
                    break
                }
            }
        }

        if ($FilePath) {
            $ImportFileInfo = Get-Item $FilePath -ErrorAction SilentlyContinue
            $ImportFileData = Get-Content $FilePath -ErrorAction SilentlyContinue
            if (!$ImportFileData) {
                Write-Error "$FilePath is null or empty."
                break
            }

            switch ($ImportFileInfo.Extension) {
                '.csv' {
                    $FileData = Import-Csv $FilePath
                }
                '.txt' {
                    $FileData = $ImportFileData
                } #End '.txt'
                Default {
                    Write-Error "Please use an approved file format for the -FilePath parameter."
                    break
                }
            }# End switch ($ImportFile.Extension)
            $ComputerName = $FileData
        }
    }

    process {
        try {
            foreach ($Computer in $ComputerName) {
                try {
                    Get-ADComputer $Computer -Property "Name", "Description", "OperatingSystem", "OperatingSystemVersion", "CanonicalName" -ErrorAction Stop | Select-Object Name, Description, OperatingSystem, OperatingSystemVersion, CanonicalName
                }
                catch {
                    try {
                        $regex = "*$Computer*"
                        $Filter = "Name -like `"$regex`""
                        Get-ADComputer -Filter $Filter -Properties "Name", "Description", "OperatingSystem", "OperatingSystemVersion", "CanonicalName" -ErrorAction Stop -OutVariable ComputerExists | Select-Object Name, Description, OperatingSystem, OperatingSystemVersion, CanonicalName
                        if (!$ComputerExists) { Throw }
                    }
                    catch { Write-Error "The PC named '$Computer' does not exist." }
                }
            }
        }
        catch {
            Write-Error "$($_.Exception.Message) - Line Number: $($_.InvocationInfo.ScriptLineNumber)"
        }
    }
    end {}
}
#EndRegion Get-Computer