# Get-ADGroupsManagedByUser

## SYNOPSIS
Generate a list of group names owned by a specified.

## SYNTAX

```
Get-ADGroupsManagedByUser [-Username] <String> [<CommonParameters>]
```

## DESCRIPTION
This will look up groups owned by the specified user.

## EXAMPLES

### EXAMPLE 1
```
Get-ADGroupsManagedByUser mjdegar
```

Description
-----------
This will generate all groups (Security or Distribution) Managed by \`mjdegar\`.

## PARAMETERS

### -Username
This is the Identity used by \`Get-ADUser\` to look up the Distinguished name used by \`Get-ADGroup\`.

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
