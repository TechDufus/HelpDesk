# Disable-Account

## SYNOPSIS
Disable an enabled AD Account.

## SYNTAX

```
Disable-Account [-Username] <Object> [<CommonParameters>]
```

## DESCRIPTION
Disables a specified Active Directory Account

## EXAMPLES

### EXAMPLE 1
```
Disable-ADAccount -Username JohnDoe
```

Description
-----------
Use the Samaccountname of the account being disabled

### EXAMPLE 2
```
Disable-ADAccount -Username "CN=Matt Degar,OU=AI,OU=UserAccounts,DC=FAKE,DC=COM"
```

Description
-----------
Use the DistinguishedName of the account being disabled

### EXAMPLE 3
```
Disable-ADAccount -Username JohnD@Company.com
```

Description
-----------
Use the UserPrincipalName of the account being disabled

## PARAMETERS

### -Username
Specify the SAMAccountName or DistinguishedName of the user to disable.

```yaml
Type: Object
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
GitHub: https://github.com/matthewjdegarmo

You can either submit a \[PR\](https://github.com/matthewjdegarmo/HelpDesk/pulls)
    or create an \[Issue\](https://github.com/matthewjdegarmo/HelpDesk/issues/new)
    on this GitHub project at https://github.com/matthewjdegarmo/HelpDesk

## RELATED LINKS
