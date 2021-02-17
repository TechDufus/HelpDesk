# Test-Administrator

## SYNOPSIS
Test to see if the current user / process is being run as an Administrator.

## SYNTAX

```
Test-Administrator [[-User] <Object>] [<CommonParameters>]
```

## DESCRIPTION
Test if the credentials running this function are elevated on the local system.

## EXAMPLES

### EXAMPLE 1
```
Test-Administrator
```

Description
-----------
This will return a boolean based on if the user is an admin or not.

## PARAMETERS

### -User
Specify the windows identity to test.
This defaults to the current signed-in user running the command.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: [Security.Principal.WindowsIdentity]::GetCurrent()
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
