function Get-FolderSize {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$Path,
        [switch]$Force,
        [ValidateSet("MB", "GB")]
        [string]$Unit = "GB"
    )

    $job = Start-Job -ScriptBlock {
        param($Path, $Force)

        $files = Get-ChildItem -Path $Path -File -Recurse -Force:$Force
        ($files | Measure-Object -Property Length -Sum).Sum
    } -ArgumentList $Path, $Force

    Show-Spinner -Job $job

    $totalSizeInBytes = Receive-Job -Job $job
    Remove-Job -Job $job

    switch ($Unit) {
        "MB" { $totalSize = [Math]::Round($totalSizeInBytes / 1MB, 2) }
        "GB" { $totalSize = [Math]::Round($totalSizeInBytes / 1GB, 2) }
    }

    $sizePropertyName = "Size in $Unit"
    $result = [PSCustomObject]@{
        Path              = $Path
        $sizePropertyName = $totalSize
    }

    return $result
}