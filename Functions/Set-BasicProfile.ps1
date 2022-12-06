<#
.SYNOPSIS
Short description

.DESCRIPTION
Long description

.EXAMPLE
An example

.NOTES
General notes
#>
function Set-BasicProfile {
    $value = @(
        'Set-Location "C:\"'
        'Import-Module PSTools'
        'Import-Module Posh-Git'
        'Set-PSReadLineOption -PredictionSource HistoryAndPlugin'
        'Import-Module CompletionPredictor'
    )
    Add-Content -Path $PROFILE -Value $Value
}
