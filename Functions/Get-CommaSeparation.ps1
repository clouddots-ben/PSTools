function Get-CommaSeparation {
    [cmdletbinding()]
    param(
        [parameter(mandatory = $true)]
        $List
    )
    $valueInQuotes = $list | foreach { "`"$($_)`"" }
$valueInQuotes -join ','
}