# Get-DellTags

## SYNOPSIS
Gather Dell Tag information.

## SYNTAX

### ComputerName (Default)
```
Get-DellTags [-ComputerName] <String> [<CommonParameters>]
```

### ServiceTag
```
Get-DellTags [-ServiceTag] <String> [<CommonParameters>]
```

### ExpressServiceCode
```
Get-DellTags [-ExpressServiceCode] <Int64> [<CommonParameters>]
```

## DESCRIPTION
Generate the ServiceTag and ExpressServiceCode of a dell computer.

## EXAMPLES

### EXAMPLE 1
```
Get-DellTags -ServiceTag M11P21T
```

ServiceTag ExpressServiceCode
---------- ------------------
M11P21T           47952526241

Description
-----------
Providing the -ServiceTag will generate the ExpressServiceCode

### EXAMPLE 2
```
Get-DellTags -ExpressServiceCode 47952526241
```

ServiceTag ExpressServiceCode
---------- ------------------
M11P21T           47952526241

Description
-----------
Providing the -ExpressServiceCode will generate the ServiceTag.

### EXAMPLE 3
```
Get-DellTags -ComputerName some-domain-computer
```

ServiceTag ExpressServiceCode
---------- ------------------
M11P21T           47952526241

Description
-----------
Providing the -ComputerName will attempt to generate this information if the computer is online, and it is a Dell computer.

## PARAMETERS

### -ServiceTag
Providing the ServiceTag (SerialNumber) will generate the accompanying ExpressServiceCode.

```yaml
Type: String
Parameter Sets: ServiceTag
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ExpressServiceCode
Providing the ExpressServiceCode will generate the accompanying ServiceTag (SerialNumber).

```yaml
Type: Int64
Parameter Sets: ExpressServiceCode
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -ComputerName
Providing the ComputerName will attempt to generate the ServiceTag and ExpressServiceCode.
The computer specified must be turned on, online, and your account must have remote access rights to it.
If the Get-CimInstance query finds that the specified computer is not a Dell, your query will fail.

```yaml
Type: String
Parameter Sets: ComputerName
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
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
