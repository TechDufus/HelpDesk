# Unlock-LockedOutADUsers

## SYNOPSIS
This function performs an unlock of users in ActiveDirectory who are currently locked out.

## SYNTAX

```
Unlock-LockedOutADUsers [-SAMAccountName] <String[]> [<CommonParameters>]
```

## DESCRIPTION
This function is a simple wrapper for Unlock-ADAccount.

## EXAMPLES

### EXAMPLE 1
```
Unlock-LockedOutADUsers -SAMAccountName matthewjd
Unlocking: matthewjd
```

Description
-----------
This will unlock the AD Account for user 'matthewjd'.

### EXAMPLE 2
```
Get-LockedOutADUsers | Unlock-LockedOutADUsers
Unlocking: User1
Unlocking: User2
```

Description
-----------
This gets a list of all current locked out users from Get-LockedOutADUsers and forwards each user to Unlock-LockedOutADUsers, which effectively unlocked all currently locked AD Users
A short-handed command for this using aliases: PS\> glo | ul

## PARAMETERS

### -SAMAccountName
Specify the SAMAccountName or username of the AD User you want to unlock.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: Username

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### None
###     This function does not produce output except for write-output data
## NOTES
Author: Matthew J.
DeGarmo
GitHub: https://github.com/matthewjdegarmo

You can either submit a \[PR\](https://github.com/matthewjdegarmo/HelpDesk/pulls)
    or create an \[Issue\](https://github.com/matthewjdegarmo/HelpDesk/issues/new)
    on this GitHub project at https://github.com/matthewjdegarmo/HelpDesk

## RELATED LINKS
