# Get-LocalAdmin
## SYNOPSIS
Retrieves a list of users in the local Administrators group.

## SYNTAX

```
Get-LocalAdmin [[-ComputerName] <String>] [<CommonParameters>]
```

## DESCRIPTION
This function identifies local admins from the computer or server it is run from.

## EXAMPLES

### EXAMPLE 1
```
Get-LocalAdmin
```

Description
-----------
Generates a list of local admins

### EXAMPLE 2
```
Get-LocalAdmin -ComputerName SomeRemoteComputer-PC
```

Description
-----------
Generate a list of local admins on a remote PC.

## PARAMETERS

### -ComputerName
Specify the remote computer to query.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $env:COMPUTERNAME
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Author: Matthew J.
DeGarmo
GitHub: https://github.com/TechDufus

You can either submit a \[PR\](https://github.com/TechDufus/HelpDesk/pulls)
    or create an \[Issue\](https://github.com/TechDufus/HelpDesk/issues/new)
    on this GitHub project at https://github.com/TechDufus/HelpDesk

Requires -Assembly C:\Windows\system32\net.exe

## RELATED LINKS
