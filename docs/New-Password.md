# New-Password

## SYNOPSIS
Create a random password

## SYNTAX

```
New-Password [[-Size] <Int32>] [[-CharSets] <Char[]>] [[-Exclude] <Char[]>] [[-Count] <Int32>] [-Admin]
 [<CommonParameters>]
```

## DESCRIPTION
The function creates a random password using a given set of available characters.
The password is generated with fixed or random length.
Passwords will never end with a number, and never start with a special character.

## EXAMPLES

### EXAMPLE 1
```
New-RandomPassword -Admin
```

Description
-----------
This generates a random password of 24-character length, and includes all character types.

### EXAMPLE 2
```
New-RandomPassword -Size 20
```

Description
-----------
Generates a password of 20 characters

## PARAMETERS

### -Size
Specify the fixed length of the password.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 12
Accept pipeline input: False
Accept wildcard characters: False
```

### -CharSets
Specify the character-type requirements.
U=Upper, L=Lower, N=Number, S=Special.

```yaml
Type: Char[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: ULNS
Accept pipeline input: False
Accept wildcard characters: False
```

### -Exclude
Specify any characters to exclude from the new password generated.

```yaml
Type: Char[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Count
Number of passwords to generate, default = 1

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### -Admin
This switch will change all of the password requirements to be a 24-character password with all character types.

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
GitHub: https://github.com/matthewjdegarmo

You can either submit a \[PR\](https://github.com/matthewjdegarmo/HelpDesk/pulls)
    or create an \[Issue\](https://github.com/matthewjdegarmo/HelpDesk/issues/new)
    on this GitHub project at https://github.com/matthewjdegarmo/HelpDesk

## RELATED LINKS
