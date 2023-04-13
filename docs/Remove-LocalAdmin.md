# Remove-LocalAdmin

## SYNOPSIS
Removes user from local admin group.

## SYNTAX

```
Remove-LocalAdmin [-Username] <String> [[-ComputerName] <String>] [-Domain <String>] [<CommonParameters>]
```

## DESCRIPTION
This function removes a local admin from the computer or server it is run from.

## EXAMPLES

### EXAMPLE 1
```
Remove-LocalAdmin -Username someuser
```

Description
-----------
Removes specified domain user from the local administrators group

## PARAMETERS

### -Username
Specify the SAMAccountName of the user to remove.

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
Specify a remote computer to run against.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: $env:COMPUTERNAME
Accept pipeline input: True (ByPropertyName)
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
GitHub: https://github.com/TechDufus

You can either submit a \[PR\](https://github.com/TechDufus/HelpDesk/pulls)
    or create an \[Issue\](https://github.com/TechDufus/HelpDesk/issues/new)
    on this GitHub project at https://github.com/TechDufus/HelpDesk

Azure AD Joined machines will require the user to first login to a computer with their domain account before adding their domain account as a local admin.
The user logging in registers their SID so that the command is successful.

## RELATED LINKS
