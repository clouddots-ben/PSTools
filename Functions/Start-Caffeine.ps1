function Start-Caffeine {
    [switch]$AlreadyRunningCheck = Get-Process | Where-Object -Property ProcessName -EQ "caffeine64"
    switch ($AlreadyRunningCheck) {
        $true {
            Write-Host "Aleady Caffeinated" -ForegroundColor Green
        }
        $false {
            $Path = $PSScriptRoot.Substring(0, $PSScriptRoot.Length - 10)
            $Run = Join-Path -Path $Path -ChildPath "caffeine.exe"
            & $Run 300 -noicon -notwhenlocked
        }
    }
}