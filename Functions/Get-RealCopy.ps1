<#
.SYNOPSIS
 Creates a copy of an array rather than another variable pointing to the original array

.DESCRIPTION
Long description

.PARAMETER SourceData
Parameter description

.EXAMPLE
An example

.NOTES
General notes
#>
function Get-RealCopy {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        $SourceData
    )
    $TempCliXMLString = [System.Management.Automation.PSSerializer]::Serialize($SourceData, [int32]::MaxValue)
    [System.Management.Automation.PSSerializer]::Deserialize($TempCliXMLString)
}