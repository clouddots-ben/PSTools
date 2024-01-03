$ModuleFolder = Split-Path $PSCommandPath -Parent

$Functions = Join-Path -Path $ModuleFolder -ChildPath 'functions'

# Write-Information -MessageData "Scripts Path  = $Scripts" -InformationAction Continue
# Write-Information -MessageData "Functions Path  = $Functions" -InformationAction Continue

$Script:ModuleFiles = @(
    $(Join-Path -Path $functions -ChildPath 'Get-RealCopy.ps1')
    $(Join-Path -Path $functions -ChildPath 'Get-Speedtest.ps1')
    $(Join-Path -Path $functions -ChildPath 'Get-ExternalIp.ps1')
    $(Join-Path -Path $functions -ChildPath 'Get-CaffeineStatus.ps1')
    $(Join-Path -Path $functions -ChildPath 'Get-FolderSize.ps1')
    $(Join-Path -Path $functions -ChildPath 'Show-Spinner.ps1')
    $(Join-Path -Path $functions -ChildPath 'Start-Caffeine.ps1')
    $(Join-Path -Path $functions -ChildPath 'Stop-Caffeine.ps1')
    $(Join-Path -Path $functions -ChildPath 'Set-BasicProfile.ps1')
)

# Write-Information -MessageData $($ModuleFiles -join ';') -InformationAction Continue

foreach ($f in $ModuleFiles) {
    . $f
}