# Get-Computer

## SYNOPSIS
This function performs a quick lookup of an ActiveDirectory computer.

## SYNTAX

### Named (Default)
```
Get-Computer [-ComputerName] <String[]> [<CommonParameters>]
```

### File
```
Get-Computer [-FilePath] <String> [<CommonParameters>]
```

## DESCRIPTION
This function is a simple Get-ADComputer with certain fields to display.

## EXAMPLES

### EXAMPLE 1
```
Get-Computer -ComputerName Computer1
```

Name            : Computer1
Description     : Some description of this computer
OperatingSystem : Windows 10 Enterprise
CanonicalName   : some.domain.com/ou/path/to/computer

Description
-----------
This will display information about the computer.

### EXAMPLE 2
```
PCLookup -ComputerName Fake-Computer
PCLookup : The PC named 'Fake-Computer' does not exist.
At line:1 char:1
+ PCLookup -ComputerName Fake-Computer
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) [Write-Error], WriteErrorException
    + FullyQualifiedErrorId : Microsoft.PowerShell.Commands.WriteErrorException,PCLookup
```

Description
-----------
This will write an error to the screen that 'Fake-Computer' is not a computer that exists in ActiveDirectory.
This also shows the usage of the alias \`PCLookup\` which points to \`Get-Computer\`.

### EXAMPLE 3
```
PC -ComputerName Computer1,Fake-Computer,Computer2
```

Name            : Computer1
Description     : Some description of this computer
OperatingSystem : Windows 10 Enterprise
CanonicalName   : some.domain.com/ou/path/to/computer

PCLookup : The PC named 'Fake-Computer' does not exist.
At line:1 char:1
+ PCLookup -ComputerName Computer1,Fake-Computer,Computer2
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : NotSpecified: (:) \[Write-Error\], WriteErrorException
    + FullyQualifiedErrorId : Microsoft.PowerShell.Commands.WriteErrorException,PCLookup

Name            : Computer2
Description     : Some description of this computer
OperatingSystem : Windows 10 Enterprise
CanonicalName   : some.domain.com/ou/path/to/computer

Description
-----------
This will generate results for all three specified ComputerName's, and will generate an error in place of the Fake-Computer, and continue generating results.
This also shows the usage of the alias \`PC\`, which points to the alias \`PCLookup\`, which points to the command \`Get-Computer\`.

### EXAMPLE 4
```
Get-Computer -FilePath .\Computers.txt
```

## PARAMETERS

### -ComputerName
This parameter should specify the ActiveDirectory ComputerName.
This parameter can accept multiple values, separated by commas.

```yaml
Type: String[]
Parameter Sets: Named
Aliases: Name

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -FilePath
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

```yaml
Type: String
Parameter Sets: File
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String[]
###     This function does not accept pipeline data. The values for all parameters must be specified.
## OUTPUTS

### None
###     This function does not produce output except for write-host data
## NOTES
Author: Matthew J.
DeGarmo
GitHub: https://github.com/TechDufus

You can either submit a \[PR\](https://github.com/TechDufus/HelpDesk/pulls)
    or create an \[Issue\](https://github.com/TechDufus/HelpDesk/issues/new)
    on this GitHub project at https://github.com/TechDufus/HelpDesk

Change Log:

Version: 2.0 - Added the FilePath parameter, and loads error-checking to detect if computername is used or filepath used without having to specify -Computername or -FilePath
                Example: You can use PCLookup test-pc      AND       PCLookup C:\temp\file.txt       AND        PCLookup C:\temp\nonexistentfile.csv
                This script will now generate results, OR display the correct error message for all these scenarios.
Version: 1.0 - Function Creation.

## RELATED LINKS
