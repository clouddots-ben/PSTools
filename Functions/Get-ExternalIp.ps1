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
function Get-ExternalIp {
    Invoke-WebRequest -Uri "http://ipinfo.io/ip" | Select-Object @{N = "External IP"; E = { $_.Content } }
}