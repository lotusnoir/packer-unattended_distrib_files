$ErrorActionPreference = "Stop"

# Switch network connection to private mode
# Required for WinRM firewall rules
$profile = Get-NetConnectionProfile
Set-NetConnectionProfile -Name $profile.Name -NetworkCategory Private

# Enable WinRM service
Enable-PSRemoting -SkipNetworkProfileCheck
Enable-WSManCredSSP -Role Server -Force
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'

# Enable WinRM service
#winrm quickconfig -quiet
#winrm set winrm/config/service '@{AllowUnencrypted="true"}'
#winrm set winrm/config/service/auth '@{Basic="true"}'
#Set-Service winrm -startuptype "auto"
#Restart-Service winrm

#Enable-PSRemoting -Force
#Enable-WSManCredSSP -Role Server -Force
#Enable-WSManCredSSP -Role Client -DelegateComputer "*" -Force
#winrm quickconfig -q
#winrm quickconfig -transport:http
#winrm set winrm/config '@{MaxTimeoutms="1800000"}'
#winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="800"}'
#winrm set winrm/config/service '@{AllowUnencrypted="true"}'
#winrm set winrm/config/service/auth '@{Basic="true"}'
#winrm set winrm/config/client/auth '@{Basic="true"}'
#winrm set winrm/config/service/auth '@{CredSSP="true"}'
#winrm set winrm/config/client/auth '@{CredSSP="true"}'
#winrm set winrm/config/listener?Address=*+Transport=HTTP '@{Port="5985"}'
#netsh advfirewall firewall set rule group="Windows Remote Administration" new enable=yes
#netsh advfirewall firewall set rule name="Windows Remote Management (HTTP-In)" new enable=yes action=allow remoteip=any
#Set-Service winrm -startuptype "auto"
#Restart-Service winrm
