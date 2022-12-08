#Get function files
$Public = @(Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -Recurse -ErrorAction Stop)
$Private = @(Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -Recurse -ErrorAction Stop)

#Dot source the files
Foreach ($Function in @($Public + $Private)) {
    Try {
        . $Function.fullname
    } Catch {
        Write-Error -Message "Failed to import function $($Function.fullname): $PSItem"
    }
}

function Get-PowerShellTrainer {
    'Arnaud PETITJEAN (Start-Scripting.io)'
}

#Export public functions
Export-ModuleMember -Function $Public.BaseName