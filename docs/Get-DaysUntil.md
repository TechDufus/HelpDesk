# Get-DaysUntil

## SYNOPSIS
Calculate the number of days between today and any future (or past) date.

## SYNTAX

```
Get-DaysUntil [-Date] <String> [<CommonParameters>]
```

## DESCRIPTION
This function provides the quantity of days between today and any given date.

## EXAMPLES

### EXAMPLE 1
```
Let's say today is January 1st, 2020.
```

PS\> Get-DaysUntil 10/18
291

Description
-----------
This will generate the number of days between today (jan1/2020) and October 18th, 2020.
See \`Get-Help Get-DaysUntil -Parameter Date\` for example date formats.

### EXAMPLE 2
```
Let's say today is January 1st, 2020.
```

PS\> Get-DaysUntil 10/18/2000
-7014

Description
-----------
This will generate a negative number, for the number of days in the past the specified date is.
See \`Get-Help Get-DaysUntil -Parameter Date\` for example date formats.

## PARAMETERS

### -Date
Specifies a date.
Enter the date in a format that is standard for the system locale.
Example Date Formats:
    06/06/2020
    6/6
    june6
    june6/2020
    aug12
    october18

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
GitHub: https://github.com/matthewjdegarmo

You can either submit a \[PR\](https://github.com/matthewjdegarmo/HelpDesk/pulls)
    or create an \[Issue\](https://github.com/matthewjdegarmo/HelpDesk/issues/new)
    on this GitHub project at https://github.com/matthewjdegarmo/HelpDesk

## RELATED LINKS
