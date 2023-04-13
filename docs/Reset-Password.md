# Reset-Password

## SYNOPSIS
Reset domain password for an ActiveDirectory user.

## SYNTAX

```
Reset-Password [-Username] <String> [[-Password] <SecureString>] [[-ComputerName] <String>] [-RequireReset]
 [-Admin] [<CommonParameters>]
```

## DESCRIPTION
Sets a Active Directory Password and provides an option to require a password change on login.

## EXAMPLES

### EXAMPLE 1
```
Reset-Password someuser1
```

Username   Password
--------   --------
someuser1  xh9GKKtN!64v

Description
-----------
Calls \`New-Password\`

## PARAMETERS

### -Username
Specify the username to reset the password for.

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

### -Password
Specify the password to set.
By default, a strong, random password is generated, unless a password is provided.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ComputerName
Specify the computer name that the user would be sitting at.
This will attempt to display a popup on their screen displaying the new password.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequireReset
With this switch present, the user will be forced to reset their password immediately after signing in.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Admin
With this switch present, a stronger random password will be auto-generated.
#Security

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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

## RELATED LINKS
