function Show-Spinner {
    param (
        [Parameter(Mandatory = $true)]
        [System.Management.Automation.Job]$Job,
        [int]$Interval = 100
    )

    $spinnerChars = '|/-\'
    $spinnerIndex = 0

    Write-Host "Processing... " -NoNewline

    while ($Job.JobStateInfo.State -eq "Running") {
        $spinnerChar = $spinnerChars[$spinnerIndex++ % $spinnerChars.Length]
        Write-Host "`b$spinnerChar" -NoNewline

        Start-Sleep -Milliseconds $Interval
    }

    Write-Host "`bDone!"
}
