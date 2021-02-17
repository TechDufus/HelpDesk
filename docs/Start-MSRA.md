# Start-MSRA

## SYNOPSIS
Starts Microsoft Remote Assistance

## SYNTAX

```
Start-MSRA [[-ComputerName] <String>] [<CommonParameters>]
```

## DESCRIPTION
This function is set to work with the helpdesk mode of Windows Remote Assistance.
You can either enter a computer name and the function will attempt to start a connection to the remote computer.
If no computer name is specified Windows Remote Assistance will open to the Advanced Help Desk Mode, which is where you can enter a computer name to connect to.

## EXAMPLES

### EXAMPLE 1
```
Start-MSRA computer1
```

Description
-----------
This example shows how to call the Start-MSRA function and automatically connect to the remote computer.

## PARAMETERS

### -ComputerName
This parameter is for the remote computer you wish to connect to.
By default if you don't specify a remote computer Windows Remote Assistant will open up to the helpdesk screen.

```yaml
Type: String
Parameter Sets: (All)
Aliases: CN

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
GitHub: https://github.com/matthewjdegarmo

You can either submit a \[PR\](https://github.com/matthewjdegarmo/HelpDesk/pulls)
    or create an \[Issue\](https://github.com/matthewjdegarmo/HelpDesk/issues/new)
    on this GitHub project at https://github.com/matthewjdegarmo/HelpDesk

## RELATED LINKS
