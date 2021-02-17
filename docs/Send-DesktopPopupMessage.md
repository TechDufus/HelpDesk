# Send-DesktopPopupMessage

## SYNOPSIS
Send individual Pop-up message to remote host.

## SYNTAX

```
Send-DesktopPopupMessage [-ComputerName] <String[]> [-Message] <String> [[-Seconds] <Int32>]
 [<CommonParameters>]
```

## DESCRIPTION
This script sends a custom pop-up message to desired server/host with no options or required action.
This script must be run as an Administrator.

## EXAMPLES

### EXAMPLE 1
```
Send-DesktopPopupMessage -ComputerName computer1,FakeServer -Message "This is a test message. Get back to work!"
[06/05/2019 09:46:36]  : Message to computer1 sent successfully.
[06/05/2019 09:46:36]  : Unable to establish a connection with FAKESERVER.
___________________________________
| Message from 6/5/2019 9:46 AM |X|
|_________________________________|
| This is a test message. Get back|
| to work!                        |
| From: Matthew J. DeGarmo        |
| ComputerName: SourceServer   __ |
|                             |OK||
|_________________________________|
```

Description
-----------
This will create a small popup window on the target computer with the message text, and the From: and ComputerName: information at the bottom.

## PARAMETERS

### -ComputerName
This parameter is to specify the remote PC to attempt to send a message popup to.
This parameter needs to pass a Test-Connection to attempt to send the message.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Message
This parameter should be inside quotation marks.
This will be the text to be displayed in the popup.

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

### -Seconds
This parameter specifies the number of seconds that the popup will remain on the screen before auto-closing.
This has a default value of 120.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: 120
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
