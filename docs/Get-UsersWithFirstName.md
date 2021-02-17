# Get-UsersWithFirstName

## SYNOPSIS
This function performs a search of users in ActiveDirectory for a first name.

## SYNTAX

```
Get-UsersWithFirstName [-Properties <String[]>] [-FirstName] <String> [<CommonParameters>]
```

## DESCRIPTION
This function is a simple Get-ADUser with a filter for GivenName to generate a list of users with the provided first name.
This function provides the Name, SAMAccountName, and Office for each user with the specified first name.
These are sorted by office first, and then name second.

## EXAMPLES

### EXAMPLE 1
```
Get-UsersWithFirstName Matt -Properties Title
```

Name                          SamAccountName Office          Title
----                          -------------- ------          -----
JoeBobJenkins, Matt           mjoebob        Chicago         Position
Jackson, Matt                 mjackso        Chicago         Position
Williamson-bob, Matt          mwillia        Boston-North    Position
Zachery, Matt                 mzacher        Boston-East     Position
Zebras, Matt                  mzebras        Chicago         Position

Description
-----------
This will find all ActiveDirectory users with the first name of 'Matt' and display the results.

### EXAMPLE 2
```
Get-FirstName FakeName
```

FName : There is no user with 'FakeName' as their first name.

Description
-----------
This will display an error indicating there were no users who matched the first name provided.

### EXAMPLE 3
```
fname michael
```

Desctiption
-----------
This example shows using the alias for this function.
The alias is FName.

## PARAMETERS

### -Properties
This parameter will declare additional properties to include with the default values generated.
To see what other properties can be included, fun this function against a name that is successful and add "| Get-Member" to get a list.
The items with a MemberType of NoteProperty can be named in this -Properties parameter separated by commas.

Example
-------
FirstName Matthew | Get-Member

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

### -FirstName
This parameter should specify the ActiveDirectory account GivenName (first name).
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
