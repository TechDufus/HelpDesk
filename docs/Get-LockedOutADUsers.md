# Get-LockedOutADUsers

## SYNOPSIS
This function performs a search of users in ActiveDirectory who are currently locked out.

## SYNTAX

```
Get-LockedOutADUsers [<CommonParameters>]
```

## DESCRIPTION
This function is a simple Search-ADAccount -Lockedout to generate a list of users who are currently locked out.
This function provides the Name, SAMAccountName, and LockoutTime for each user that is locked out.

## EXAMPLES

### EXAMPLE 1
```
Get-LockedOutADUsers
```

Name                SamAccountName LockoutTime
----                -------------- -----------
DeGarmo, Matthew J.
matthewjd      6/26/2019 13:32:15

Description
-----------
This will show all users who are currently locked out.

### EXAMPLE 2
```
Get-LockedOutADUsers
No users are currently locked out.
```

Description
-----------
This will display the results of the query, in this case there were no results to display.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
###     This function does not accept pipeline data. The values for all parameters must be specified.
## OUTPUTS

### None
###     This function does not produce output except for write-host data
## NOTES
Author: Matthew J.
DeGarmo
GitHub: https://github.com/matthewjdegarmo

You can either submit a \[PR\](https://github.com/matthewjdegarmo/HelpDesk/pulls)
    or create an \[Issue\](https://github.com/matthewjdegarmo/HelpDesk/issues/new)
    on this GitHub project at https://github.com/matthewjdegarmo/HelpDesk

## RELATED LINKS
