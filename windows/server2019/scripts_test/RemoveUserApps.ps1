function Get-LogDir {
    try {
        $ts = New-Object -ComObject Microsoft.SMS.TSEnvironment -ErrorAction Stop
        if ($ts.Value("LogPath") -ne "") {
            $logDir = $ts.Value("LogPath")
        }
        else {
            $logDir = $ts.Value("_SMSTSLogPath")
        }
    }
    catch {
        $logDir = $env:TEMP
    }
    return $logDir
}


# ---------------------------------------------------------------------------
# Main logic
# ---------------------------------------------------------------------------

$logDir = Get-LogDir
Start-Transcript "$logDir\RemoveUserApps.log"

# Get the list of provisioned packages
$provisioned = Get-AppxProvisionedPackage -online

# Check each installed app
$count = 0

for ($i = 1; $i -ile 2; $i++) {
    # Check each app (two loops just in case there are dependencies that can't be removed until the
    # main app is removed)
    Get-AppxPackage | Where-Object { $_.SignatureKind -ne 'System' } | ForEach-Object {
        $current = $_
        $found = $provisioned | Where-Object { $_.DisplayName -eq $current.Name -and $_.Version -eq $current.Version }
        if ($found.Count -eq 0) {
            Write-Output "$($current.Name) version $($current.Version) is not provisioned, removing."
            Remove-AppxPackage -Package $current.PackageFullName
            $count++
        }
    }
}
Write-Output "Number of apps removed: $count"

Stop-Transcript
