---
external help file: Lab04-help.xml
Module Name: Lab04
online version:
schema: 2.0.0
---

# Write-Log

## SYNOPSIS
Writes a log file.

## SYNTAX

### LogMessage (Default)
```
Write-Log [-FilePath] <String[]> [-Message] <String[]> -Category <String> [-Delimiter <String>] [-ToScreen]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### LogHeader
```
Write-Log [-FilePath] <String[]> [-Header] [-Delimiter <String>] [-ToScreen] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### LogFooter
```
Write-Log [-FilePath] <String[]> [-Footer] [-Delimiter <String>] [-ToScreen] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
This function writes a log file.

## EXAMPLES

### EXAMPLE 1
```
Initialisation du fichier de logs (écriture de l'entête)
Write-Log -Filepath C:\logs\mylog.txt -Header
```

### EXAMPLE 2
```
Ecriture d'un message d'information dans un fichier de log
Write-Log -Category Information -Message "Ceci est un message d'information" -Filepath C:\logs\mylog.txt
```

### EXAMPLE 3
```
Ecriture d'un message d'information dans un fichier de log + renvoi des informations dans la console
Write-Log -Category Information -Message "Ceci est un message d'information" -Filepath C:\logs\mylog.txt -ToScreen
```

### EXAMPLE 4
```
Finalisation du fichier de logs (écriture du pied de page)
Write-Log -Filepath C:\logs\mylog.txt -Footer
```

## PARAMETERS

### -FilePath
Mandatory.
Specify the path for the logfile.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: Path

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Message
Mandatory.
Specify the message that is written to the log file.

```yaml
Type: String[]
Parameter Sets: LogMessage
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Category
Optional.
Specify to generate the log footer and close the logfile.

```yaml
Type: String
Parameter Sets: LogMessage
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Header
Optional.
Specify to open the logfile and generate the log header.

```yaml
Type: SwitchParameter
Parameter Sets: LogHeader
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Footer
Optional.
Specify to generate the log footer and close the logfile.

```yaml
Type: SwitchParameter
Parameter Sets: LogFooter
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Delimiter
Optional.
Specify the delimiter to separate log data.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: ;
Accept pipeline input: False
Accept wildcard characters: False
```

### -ToScreen
Optional.
Select whether to display the log text on screen.
Default is TRUE.

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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
2022-12-05 v1 Initial version

## RELATED LINKS
