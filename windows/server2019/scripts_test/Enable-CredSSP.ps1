Write-Output "Enabling CredSSP"
Enable-WSManCredSSP -Role Server -Force
Enable-WSManCredSSP -Role Client -DelegateComputer * -Force
Set-Item wsman:localhost\client\trustedhosts -Value * -Force
Set-Item -Path "wsman:\localhost\service\auth\credSSP" -Value $True -Force

New-Item -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation -Name AllowFreshCredentialsWhenNTLMOnly -Force
New-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\CredentialsDelegation\AllowFreshCredentialsWhenNTLMOnly -Name 1 -Value * -PropertyType String

Write-Output "Verify CredSSP is enabled"
Get-WSManCredSSP