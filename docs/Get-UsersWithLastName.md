# Get-UsersWithLastName

## SYNOPSIS
This function performs a search of users in ActiveDirectory for a last name.

## SYNTAX

```
Get-UsersWithLastName [-Properties <String[]>] [-LastName] <String> [<CommonParameters>]
```

## DESCRIPTION
This function is a simple Get-ADUser with a filter for SurName to generate a list of users with the provided last name.
This function provides the Name, SAMAccountName, and Office for each user with the specified last name.
These are sorted by office first, and then name second.

## EXAMPLES

### EXAMPLE 1
```
Get-UsersWithLastName Smith -Property Title
```

Name            SamAccountName Office         Title
----            -------------- ------         -----
Smith, Deborah  dsmith         Chicago        Position
Smith, Kent     ksmith         Boston-South   Position
Smith, Matthew  msmith         Chicago        Position
Smith, Trent    tsmith         Boston-North   Position

Description
-----------
This will find all ActiveDirectory users with the last name of 'Smith' and display the results.

### EXAMPLE 2
```
LastName FakeName
```

LastName : There is no user with 'FakeName' as their last name.

Description
-----------
This will display an error indicating there were no users who matched the last name provided.

### EXAMPLE 3
```
Lname degarmo
```

Desctiption
-----------
This example shows using the alias for this function.
The alias is LName.

## PARAMETERS

### -Properties
This parameter will declare additional properties to include with the default values generated.
To see what other properties can be included, fun this function against a name that is successful and add "| Get-Member" to get a list.
The items with a MemberType of NoteProperty can be named in this -Properties parameter separated by commas.

Example
-------
Get-UsersWithLastName Matthew | Get-Member

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -LastName
This parameter should specify the ActiveDirectory account SurName (last name).
This parameter will only accept alpha characters and will halt the function if it detects numeric characters.

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

### System.String
###     This function does not accept pipeline data. The values for all parameters must be specified.
## OUTPUTS

### System.Object[]
###     Objects generated from the AD query.
## NOTES
Author: Matthew J.
DeGarmo
GitHub: https://github.com/matthewjdegarmo

You can either submit a \[PR\](https://github.com/matthewjdegarmo/HelpDesk/pulls)
    or create an \[Issue\](https://github.com/matthewjdegarmo/HelpDesk/issues/new)
    on this GitHub project at https://github.com/matthewjdegarmo/HelpDesk

## RELATED LINKS
