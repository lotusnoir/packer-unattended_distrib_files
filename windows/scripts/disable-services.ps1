# Windows 2019 Datacenter and Standard - Disable Services
# https://docs.microsoft.com/en-us/windows-server/security/windows-services/security-guidelines-for-disabling-system-services-in-windows-server

$ErrorActionPreference = "Stop"

# Determine if Core or Desktop Experience
$osVersion = Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name InstallationType

# Common Services

Write-Output "Disable Internet Connection Sharing (ICS)"
Get-Service -Name SharedAccess | Set-Service -StartupType Disabled | Out-Null

Write-Output "Disable Link-Layer Topology Discovery Mapper"
Get-Service -Name lltdsvc | Set-Service -StartupType Disabled | Out-Null

Write-Output "Disable Smart Card Device Enumeration Service"
Get-Service -Name ScDeviceEnum | Set-Service -StartupType Disabled | Out-Null

Write-Output "Disable Windows Insider Service"
Get-Service -Name wisvc | Set-Service -StartupType Disabled | Out-Null

# If Desktop Experience is installed disable these services, otherwise Exit cleanly

if ( $osVersion -eq "Server" ) {
    Write-Output "Disable ActiveX Installer (AxInstSV)"
    Get-Service -Name AxInstSV | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable Bluetooth Support Service"
    Get-Service -Name bthserv | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable CDPUserSvc"
    Get-Service -Name CDPUserSvc | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable Contact Data"
    Get-Service -Name PimIndexMaintenanceSvc | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable WAP Push Message Routing Service"
    Get-Service -Name dmwappushservice | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable Downloaded Maps Manager"
    Get-Service -Name MapsBroker | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable Geolocation Service"
    Get-Service -Name lfsvc | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable Microsoft Account Sign-in Assistant"
    Get-Service -Name wlidsvc | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable Network Connection Broker"
    Get-Service -Name NcbService | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable Phone Service"
    Get-Service -Name PhoneSvc | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable Print Spooler"
    Get-Service -Name Spooler | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable Printer Extensions and Notifications"
    Get-Service -Name PrintNotify | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable Program Compatibility Assistant Service"
    Get-Service -Name PcaSvc | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable Quality Windows Audio Video Experience"
    Get-Service -Name QWAVE | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable Radio Management Service"
    Get-Service -Name RmSvc | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable Sensor Data Service"
    Get-Service -Name SensorDataService | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable Sensor Monitoring Service"
    Get-Service -Name SensrSvc | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable Sensor Service"
    Get-Service -Name SensorService | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable Shell Hardware Detection"
    Get-Service -Name ShellHWDetection | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable SSDP Discovery"
    Get-Service -Name SSDPSRV | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable Still Image Acquisition Events"
    Get-Service -Name WiaRpc | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable Touch Keyboard and Handwriting Panel Service"
    Get-Service -Name TabletInputService | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable UPnP Device Host"
    Get-Service -Name upnphost | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable User Data Access"
    Get-Service -Name UserDataSvc | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable WalletService"
    Get-Service -Name WalletService | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable Windows Audio"
    Get-Service -Name Audiosrv | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable Windows Audio Endpoint Builder"
    Get-Service -Name AudioEndpointBuilder | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable Windows Camera Frame Server"
    Get-Service -Name FrameServer | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable Windows Image Acquisition (WIA)"
    Get-Service -Name stisvc | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable Windows Mobile Hotspot Service"
    Get-Service -Name icssvc | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable Windows Push Notifications System Service"
    Get-Service -Name WpnService | Set-Service -StartupType Disabled | Out-Null

    Write-Output "Disable Windows Push Notifications User Service"
    Get-Service -Name WpnUserService | Set-Service -StartupType Disabled | Out-Null
}
else {
    exit 0
}
