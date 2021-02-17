# Get-User

## SYNOPSIS
This function performs a quick lookup of an ActiveDirectory user, group membership, and possible computers belonging to that user.

## SYNTAX

```
Get-User [-Username] <String> [-Groups] [-Computers] [<CommonParameters>]
```

## DESCRIPTION
This function is a simple Get-ADUser with certain fields to display.
This function also uses the user Surname against ActiveDirectory Computer Descriptions to generate a list of possible PC's used by the user.
This assumes that the AD Computer Descriptions are being used and that full last names are used.
This function also generates a list (if the parameter -Groups is used) of groups that a user is a member of using Get-ADPrincipalGroupMembership.

## EXAMPLES

### EXAMPLE 1
```
Get-User matthewjd
```

DisplayName    : DeGarmo, Matthew J.
Manager        : Elon Musk
Department     : AI Relations
Title          : AI Architect
Office         : Jupiter-K12-A
Mail           : jpytr_MailMe@AICorp.com
OfficePhone    : 90acedb3-afb1-4986-99de-378fa797fa58
IPPhone        : a66f0778
SamAccountName : matthewjd
Description    : Head of AI Relations
PassLastSet    : DATE HERE

Possible Computers...
Name        : Some-Computer
Description : Matthew DeGarmo, AI Relations

Description
-----------
This will display generic information about the user as well as attempt to locate AD Computers that may belong to them.

### EXAMPLE 2
```
Lookup -Username user1 -Groups
```

Description
-----------
Additionally, this will add the group names from \`Get-ADPrincipalGroupMembership\` to the beginning of the output.
This also shows the usage of the previous command \`Lookup\`.
This is an alias.

### EXAMPLE 3
```
lu user1
```

Description
-----------
This shows the usage of the alias \`LU\`, which points to the old command name \`Lookup\`, which now points to \`Get-User\`

## PARAMETERS

### -Username
This parameter should specify the ActiveDirectory account name or SamAccountName.

```yaml
Type: String
Parameter Sets: (All)
Aliases: SAMAccountName

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Groups
This is a switch that will have the function include a listing of user group membership.

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

### -Computers
Specifying this switch will check the desired user's last name (SurName) against all AD Computer Descriptions for a possible match.
If your organization used the ManagedBy value to tie an AD Computer to an AD User, then you can change the script.
I will look into how to do both in the future.

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

Change Log:

Version: 1.2 - Added Password Last Set date to the end of data.
This is useful to help troubleshoot lockout issues.
Version: 1.1 - Added Description to the user data section.
Version: 1.0 - Function Creation.

## RELATED LINKS
