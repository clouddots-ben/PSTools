# From Mike Campbell's MBMigrator Module found here: https://github.com/themodulecollective/MBMigrator/blob/8fc219a9c3111fd77a8015cb5400e3a76d95074d/docs/SampleAutomations/Compare-ComplexObject.ps1#L4
Function Compare-ComplexObject {
    [cmdletbinding()]
    param(
        [Parameter(Mandatory)]
        $ReferenceObject
        ,
        [Parameter(Mandatory)]
        $DifferenceObject
        ,
        [string[]]$SuppressedProperties
        ,
        [parameter()]
        [validateset('All', 'EqualOnly', 'DifferentOnly')]
        [string]$Show = 'All'
    )

    #setup properties to compare
    #get properties from the Reference Object
    $RefProperties = @($ReferenceObject | Get-Member -MemberType Properties | Select-Object -ExpandProperty Name)
    #get properties from the Difference Object
    $DifProperties = @($DifferenceObject | Get-Member -MemberType Properties | Select-Object -ExpandProperty Name)
    #Get unique properties from the resulting list, eliminating duplicate entries and sorting by name
    $ComparisonProperties = @(($RefProperties + $DifProperties) | Select-Object -Unique | Sort-Object)
    #remove properties where they are entries in the $suppressedProperties parameter
    $ComparisonProperties = $ComparisonProperties | Where-Object { $SuppressedProperties -notcontains $_ }
    $results = @(
        foreach ($prop in $ComparisonProperties) {
            $property = $prop.ToString()
            $ReferenceObjectValue = @($ReferenceObject.$($property))
            $DifferenceObjectValue = @($DifferenceObject.$($property))
            switch ($ReferenceObjectValue.Count) {
                1 {
                    if ($DifferenceObjectValue.Count -eq 1) {
                        $ComparisonType = 'Scalar'
                        If ($ReferenceObjectValue[0] -eq $DifferenceObjectValue[0]) { $CompareResult = $true }
                        If ($ReferenceObjectValue[0] -ne $DifferenceObjectValue[0]) { $CompareResult = $false }
                    }#if
                    else {
                        $ComparisonType = 'ScalarToArray'
                        $CompareResult = $false
                    }
                }
                0 {
                    $ComparisonType = 'ZeroCountArray'
                    $ComparisonResults = @(Compare-Object -ReferenceObject $ReferenceObjectValue -DifferenceObject $DifferenceObjectValue -PassThru)
                    if ($ComparisonResults.Count -eq 0) { $CompareResult = $true }
                    elseif ($ComparisonResults.Count -ge 1) { $CompareResult = $false }
                }
                Default {
                    $ComparisonType = 'Array'
                    $ComparisonResults = @(Compare-Object -ReferenceObject $ReferenceObjectValue -DifferenceObject $DifferenceObjectValue -PassThru)
                    if ($ComparisonResults.Count -eq 0) { $CompareResult = $true }
                    elseif ($ComparisonResults.Count -ge 1) { $CompareResult = $false }
                }
            }
            $ComparisonObject = New-Object -TypeName PSObject -Property @{Property = $property; CompareResult = $CompareResult; ReferenceObjectValue = $ReferenceObjectValue; DifferenceObjectValue = $DifferenceObjectValue; ComparisonType = $comparisontype }
            $ComparisonObject | Select-Object -Property Property, CompareResult, ReferenceObjectValue, DifferenceObjectValue #,ComparisonType
        }
    )
    switch ($show) {
        'All' { $results }#All
        'EqualOnly' { $results | Where-Object { $_.CompareResult } }#EqualOnly
        'DifferentOnly' { $results | Where-Object { -not $_.CompareResult } }#DifferentOnly
    }

}