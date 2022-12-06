function Start-Caffeine {
    $AlreadyRunningCheck = if (Get-Process | Where-Object -Property ProcessName -EQ "caffeine64") { $true }else { $false }
    switch ($AlreadyRunningCheck) {
        $true {
            Write-Host "Aleady Caffeinated" -ForegroundColor Green
        }
        $false {
            $Path = $PSScriptRoot.Substring(0, $PSScriptRoot.Length - 10)
            $Run = Join-Path -Path $Path -ChildPath "Executables\caffeine64.exe"
            & $Run 300 -noicon -notwhenlocked
            $ProcessC = if (Get-Process | Where-Object -Property ProcessName -EQ "caffeine64") { $true }else { $false }
            switch ($ProcessC) {
                $true {
                    Write-Host "Caffeinated!" -ForegroundColor Green
                }
                $false {
                    Write-Host "Still Decaf" -ForegroundColor Red
                }
            }
        }
    }
}