# Add-LocalAdmin

## SYNOPSIS
Adds user to local admin group.

## SYNTAX

```
Add-LocalAdmin [-Username] <String> [[-ComputerName] <String>] [-Domain <String>] [<CommonParameters>]
```

## DESCRIPTION
This function adds a local admin to the computer or server it is run from.

## EXAMPLES

### EXAMPLE 1
```
Add-LocalAdmin -Username username
```

Description
-----------
Adds specified domain user to the local administrators group

### EXAMPLE 2
```
Add-LocalAdmin -ComputerName Some-Remote-Computer -Username username
```

Description
-----------
This will attempt to add the specified user to the local admin group of the specified remote computer.
You must be an admin on the remote computer for this to work.

## PARAMETERS

### -Username
Specify the SAMAccountName of the user to add.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputerName
Specify the remote computer to run against.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: $env:COMPUTERNAME
Accept pipeline input: False
Accept wildcard characters: False
```

### -Domain
Specify the domain that the user belongs to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: $env:USERDOMAIN
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

Azure AD Joined machines will require the user to first login to a computer with their domain account before adding their domain account as a local admin.
The user logging in registers their SID so that the command is successful.

## RELATED LINKS
