function Write-Log {
    
    
    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'LogMessage')]
    param (

        #Mandatory. Specify the path for the logfile.
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias("Path")]
        [ValidateScript({ Test-Path $_ -IsValid })]
        [string[]]
        $FilePath,
            
        #Mandatory. Specify the message that is written to the log file.
        [Parameter(Mandatory = $true,
            Position = 1,
            ParameterSetName = 'LogMessage',
            ValueFromPipeline = $true)]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Message,

        #Optional. Specify to generate the log footer and close the logfile.
        [Parameter(Mandatory = $true, ParameterSetName = 'LogMessage')]
        [Validateset('Information', 'Warning', 'Error', IgnoreCase = $false)]
        [string]$Category, 

        #Optional. Specify to open the logfile and generate the log header.
        [Parameter(Mandatory = $true, ParameterSetName = 'LogHeader')]
        [switch]$Header,

        #Optional. Specify to generate the log footer and close the logfile.
        [Parameter(Mandatory = $true, ParameterSetName = 'LogFooter')]
        [switch]$Footer,
      
        #Optional. Specify the delimiter to separate log data.
        [Parameter(Mandatory = $false)]
        [Validateset(',', ';', '|', 'Tab')]
        [string]$Delimiter = ';',

        #Optional. Select whether to display the log text on screen. Default is TRUE.
        [Parameter(Mandatory = $false)]
        [switch]$ToScreen

    )

    try {

        #Support WhatIf
        if ($PSCmdlet.ShouldProcess($Message, "Write to Log")) {

            #Check if a log file already exists at the specified location
            $LogFile = Get-Item $FilePath -ErrorAction SilentlyContinue

            #Header was specified or logfile doesnt exist: We need to initialize a new logfile (Overtwrite if exists) and write Header before writing out log message
            if (($PSBoundParameters.ContainsKey('Header')) -or ($null -eq $LogFile)) {

                try {
                    $LogFile = New-Item -ItemType File -Path $FilePath -Force -ErrorAction Stop
                } catch {
                    Throw "Error occurred when trying to create new log file at '$FilePath': $PSItem"
                }

                #Generate Header text
                '+----------------------------------------------------------------------------------------+' | Out-File $LogFile.FullName -Append
                "Script fullname:  $($MyInvocation.ScriptName)" | Out-File $LogFile.FullName -Append
                "When generated:   $(Get-Date -Format s)" | Out-File $LogFile.FullName -Append
                "Current user:     $($env:USERNAME)" | Out-File $LogFile.FullName -Append
                "Current computer: $($env:COMPUTERNAME)" | Out-File $LogFile.FullName -Append
                "Operating System: $($env:OS)" | Out-File $LogFile.FullName -Append
                "OS Architecture:  $($env:PROCESSOR_ARCHITECTURE)" | Out-File $LogFile.FullName -Append
                '+----------------------------------------------------------------------------------------+' | Out-File $LogFile.FullName -Append
            }

            if ($PSBoundParameters.ContainsKey('Message')) {
                #Replace TAB delimiter
                If ($Delimiter -eq 'Tab') { [string]$Delimiter = "`t" }
            
                #Log message - always to file
                $Output = (Get-Date -Format s) + $Delimiter + $Category + $Delimiter + $Message 
                $Output | Out-File $LogFile.FullName -Append

                #Log message - to screen if specified
                if ($PSBoundParameters.ContainsKey('ToScreen')) {
                    switch ($Category) {
                        'Warning' { Write-Host $Output -ForegroundColor Yellow }
                        'Error' { Write-Host $Output -ForegroundColor Red }
                        Default { Write-Host $Output -ForegroundColor Cyan }
                    }
                }
            }

            #Footer was specified: We need to determine total exec time (based on file date), write footer and close log.
            if ($PSBoundParameters.ContainsKey('Footer')) {

                #Calculate script run time based on log file generation date (if possible)
                try {
                    $ExecTime = New-Timespan -Start $LogFile.CreationTime -End (Get-Date)
                } catch {
                    Write-Warning "Unable to calculate execution time based on log file creation time."
                    $ExecTime = $null
                }
                
                '+----------------------------------------------------------------------------------------+' | Out-File $LogFile.FullName -Append
                "End time:       $(Get-Date -Format s)" | Out-File $LogFile.FullName -Append
                "Total duration: {0:G}" -f $ExecTime | Out-File $LogFile.FullName -Append
                '+----------------------------------------------------------------------------------------+' | Out-File $LogFile.FullName -Append
            }
        }

    } catch {
        $PSCmdlet.ThrowTerminatingError($PSItem)
    }
}