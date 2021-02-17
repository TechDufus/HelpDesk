# Get-UserProfile

## SYNOPSIS
Quickly generate a list of user profiles for a computer.

## SYNTAX

```
Get-UserProfile [[-ComputerName] <String>] [<CommonParameters>]
```

## DESCRIPTION
This will generate a local or a remote list of non-special (SYSTEM, Administrator, etc.) profiles on a computer.

## EXAMPLES

### EXAMPLE 1
```
Get-UserProfile
```

Description
-----------
This will display CIM Objects for each profile on the local system.

### EXAMPLE 2
```
Get-UserProfile -ComputerName Some-Remote-PC1
```

Description
-----------
This will retrieve User Profile CIM Objects from the remote PC.

## PARAMETERS

### -ComputerName
Specify the remote machine to query.
You must have rights to connect to this computer.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
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
Handle: @matthewjdegarmo

You can either submit a \[PR\](https://github.com/matthewjdegarmo/HelpDesk/pulls)
    or create an \[Issue\](https://github.com/matthewjdegarmo/HelpDesk/issues/new)
    on this GitHub project at https://github.com/matthewjdegarmo/HelpDesk

## RELATED LINKS
