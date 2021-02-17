# Watch-Connection

## SYNOPSIS
Loops through a test-connection and sends email when connection is made.

## SYNTAX

```
Watch-Connection [-ComputerName] <String> [-Message <String>] [-Recipients <String[]>] [-Email]
 [-From <String>] [-SmtpServer <String>] [<CommonParameters>]
```

## DESCRIPTION
This script simply is a test-connection that loops until a connection is made.

## EXAMPLES

### EXAMPLE 1
```
Watch-Connection -ComputerName SomeServer -Message "A connection to SomeServer has been made. Please remove admin access from user 'SomeUser'" -Recipients "myself@me.com","someoneelse@them.com","OtherEmailsSeperatedByCommas@site.com"
Connecting to SOMESERVER....
Sending email to the following recipients: "myself@me.com","someoneelse@them.com","OtherEmailsSeperatedByCommas@site.com"
Connection Successful.
Message: A connection to SomeServer has been made. Please remove admin access from user 'SomeUser'
```

Description
-----------
This will loop through a Test-Connection -Count 1 command against 'SomeServer' until a connection is made.
Once it is made, an email is sent to the user running the script and to the additional users specified in the -Recipients Parameter.

### EXAMPLE 2
```
Watch-Connection SomeComputer -Notification "Finally connected to user 'SomeUser' PC."
Connecting to SOMECOMPUTER....
Connection Successful.
Message: Finally connected to user 'SomeUser' PC.
```

Description
-----------
This will loop through a \`Test-Connection -Count 1\` command against 'SomeComputer'.

## PARAMETERS

### -ComputerName
This parameter should specify the computer name you are testing a connections with.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Message
This parameter will include text to be included in the success email.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Recipients
This parameter specifies additional recipients to receive the successful connection email.
These values should be separated by commas and wrapped in quotation marks.

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

### -Email
This switch allows the function to send an email when a successful connection is made.
If this switch is present, an email will be sent.

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

### -From
This is the email address that this alert will originate from.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SmtpServer
This is the SMTP server that you will be using to send the email.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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
