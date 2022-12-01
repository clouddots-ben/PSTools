function Get-CaffeineStatus {
    $AlreadyRunningCheck = if (Get-Process | Where-Object -Property ProcessName -EQ "caffeine64") { $true }else { $false }
    switch ($AlreadyRunningCheck) {
        $true {
            write-host "Caffeinated" -ForegroundColor Green
        }
        $false {
            write-host "Decaf" -ForegroundColor Red
        }
    }
}