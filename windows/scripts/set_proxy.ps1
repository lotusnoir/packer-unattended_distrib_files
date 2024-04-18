$ipv4 = (Get-NetIPAddress | Where-Object { $_.AddressState -eq "Preferred" -and $_.ValidLifetime -lt "24:00:00" }).IPAddress
if ($ipv4 -eq "10.4.255.22" ) {
    $proxy = 'http://10.1.98.5:80'  # update this
}
else {
    $proxy = 'http://10.1.80.5:80'  # update this
}

#[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
#[system.net.webrequest]::defaultwebproxy = new-object system.net.webproxy($proxy)
#[system.net.webrequest]::defaultwebproxy.credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
#[system.net.webrequest]::defaultwebproxy.BypassProxyOnLocal = $true


reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f | Out-Null
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "$proxy" /f | Out-Null

# notifying wininet
$source = @"

[DllImport("wininet.dll")]

public static extern bool InternetSetOption(int hInternet, int dwOption, int lpBuffer, int dwBufferLength);

"@

#Create type from source
$wininet = Add-Type -MemberDefinition $source -PassThru -Name InternetSettings

#INTERNET_OPTION_PROXY_SETTINGS_CHANGED
$wininet::InternetSetOption([IntPtr]::Zero, 95, [IntPtr]::Zero, 0) | Out-Null

#INTERNET_OPTION_REFRESH
$wininet::InternetSetOption([IntPtr]::Zero, 37, [IntPtr]::Zero, 0) | Out-Null

# save proxy details in environment variables
#$env:APPVEYOR_HTTP_PROXY_IP = $proxy_ip
#$env:APPVEYOR_HTTP_PROXY_PORT = $proxy_port

Write-Output "Proxy OK" -ForegroundColor Green
