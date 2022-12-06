function Stop-Caffeine {
    $AlreadyRunningCheck = if (Get-Process | Where-Object -Property ProcessName -EQ "caffeine64") { $true }else { $false }
    switch ($AlreadyRunningCheck) {
        $true {
            $Path = $PSScriptRoot.Substring(0, $PSScriptRoot.Length - 10)
            $Run = Join-Path -Path $Path -ChildPath "Executables\caffeine64.exe"
            & $Run -appexit
            $ProcessC = if (Get-Process | Where-Object -Property ProcessName -EQ "caffeine64") { $true }else { $false }
            switch ($ProcessC) {
                $true {
                    Write-Host "Decaf!" -ForegroundColor Green
                }
                $false {
                    Write-Host "Still wired!" -ForegroundColor Red
                }
            }
        }
        $false {
            Write-Host "Been decaf for a while" -ForegroundColor Red
        }
    }
}