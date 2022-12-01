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
function Get-Speedtest {

    [CmdletBinding()]
    param (
        [Parameter()][Switch]$PSObject
    )
    $Path = $PSScriptRoot.Substring(0, $PSScriptRoot.Length - 10)
    $Run = Join-Path -Path $Path -ChildPath "speedtest.exe"
    switch ($PSObject) {
        $true {
            $speedtest = & $Run -f csv
            $speedtest_split = $speedtest.Split('"')
            $param = [PSCustomObject]@{
                "server name"    = $speedtest_split[1]
                "server id"      = $speedtest_split[3]
                "latency"        = $speedtest_split[5]
                "jitter"         = $speedtest_split[7]
                "packet loss"    = $speedtest_split[9]
                "download"       = (([int]$speedtest_split[11]) * 0.000008)
                "upload"         = (([int]$speedtest_split[13]) * 0.000008)
                "download bytes" = $speedtest_split[15]
                "upload bytes"   = $speedtest_split[17]
                "share url"      = $speedtest_split[19]
                "date"           = get-date
            }
            $param
        }
        $false {
            & $speedtestRun
        }

    }
}