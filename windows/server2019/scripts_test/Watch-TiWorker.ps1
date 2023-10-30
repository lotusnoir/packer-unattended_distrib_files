[int]$Interval = 60

$ErrorActionPreference = 'silentlycontinue'
While ($True) {
    if (Get-Process -Name TiWorker.exe) {
        Write-Output -ForegroundColor Green "[*] Host is still processing TiWorker"
    }
    else {
        Write-Output -ForegroundColor Green "[+] TiWorker process has ended moving on to next step"
        exit 0
    }
}
Start-Sleep -Seconds $Interval
