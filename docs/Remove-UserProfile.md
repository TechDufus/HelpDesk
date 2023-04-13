# Remove-UserProfile

## SYNOPSIS
Quickly delete a user profile from a computer

## SYNTAX

### Named (Default)
```
Remove-UserProfile -UserName <String[]> [-ComputerName <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### All
```
Remove-UserProfile [-ComputerName <String>] [-All] [-Except <String[]>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
This command will delete user profiles for the local or remote computer.

## EXAMPLES

### EXAMPLE 1
```
Remove-UserProfile test123
Description
-----------
This will delete the local `test123` account on the local computer.
If this account / profile does not exist, you will get an error.
```

### EXAMPLE 2
```
Remove-UserProfile -All -ComputerName Some-Remote-PC1
Description
-----------
This will delete all non-special profiles on the remote computer.
```

### EXAMPLE 3
```
Remove-UserProfile user1,user2,user3 -ComputerName Some-Remote-PC1 -Verbose
Description
-----------
This will attempt to remove all named user accounts (comma-seperated) from the remote computer and display verbose output.
```

### EXAMPLE 4
```
Remove-UserProfile -ComputerName Some-Remote-PC1 -All -Except user1,specialuser,user4
```

Description
-----------
This will remove all user profiles EXCEPT for the ones listed in the \`-Except\` parameter.

## PARAMETERS

### -UserName
Specify the specific username(s) for the profile(s) to be deleted.

```yaml
Type: String[]
Parameter Sets: Named
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputerName
Specify a remote computer name to remove user profiles from.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -All
This switch will query all non-special profiles for deletion.

```yaml
Type: SwitchParameter
Parameter Sets: All
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Except
This switch is used to exclude profiles when specifying the \`-All\` switch.

```yaml
Type: String[]
Parameter Sets: All
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
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
Handle: @TechDufus

You can either submit a \[PR\](https://github.com/TechDufus/HelpDesk/pulls)
    or create an \[Issue\](https://github.com/TechDufus/HelpDesk/issues/new)
    on this GitHub project at https://github.com/TechDufus/HelpDesk

## RELATED LINKS
