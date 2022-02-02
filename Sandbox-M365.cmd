ECHO off
ECHO:
ECHO:
ECHO Downloading installation files...
ECHO:
ECHO off

REM Download VSCode
curl -sS -L "https://update.code.visualstudio.com/latest/win32-x64-user/stable" --output C:\users\WDAGUtilityAccount\Downloads\vscode.exe

ECHO:
ECHO Installing applications...
ECHO:

REM Install and run VSCode
C:\Users\WDAGUtilityAccount\Downloads\vscode.exe /VERYSILENT /MERGETASKS=!runcode

ECHO:
ECHO Configuring PowerShell and installing modules...
ECHO:

powershell.exe "Set-ExecutionPolicy -ExecutionPolicy Unrestricted"
powershell.exe "Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force"
powershell.exe "Set-PSRepository -Name PSGallery -InstallationPolicy Trusted"
powershell.exe "Update-Module"
powershell.exe "Install-Module AzureADPreview"
powershell.exe "Install-Module MSOnline"
powershell.exe "Install-Module MicrosoftTeams"
powershell.exe "Install-Module ExchangeOnlineManagement"
powershell.exe "Install-Module Microsoft.Online.SharePoint.PowerShell"

REM Create PowerShell profile
> C:\Windows\System32\WindowsPowerShell\v1.0\profile.ps1 (
    ECHO Function func_recent {
    ECHO     [CmdletBinding^(^)] 
    ECHO     [Alias^('recent'^)]
    ECHO     Param^(
    ECHO         [string] $search^)
    ECHO         Get-History ^| ? {$_.CommandLine -like "*$search*"}}
    ECHO Set-Alias -Name recent -Value func_recent
    ECHO: 
    ECHO Function func_again {
    ECHO     [CmdletBinding^(^)] 
    ECHO     [Alias^('again'^)]
    ECHO     Param^(
    ECHO         [string] $id^)
    ECHO         Invoke-History $id}
    ECHO Set-Alias -Name again -Value func_again
    ECHO:
    ECHO function iseTitle { $Host.UI.RawUI.WindowTitle = ^(Get-MsolDomain ^| Where-Object {$_.isDefault}^).name }
    ECHO: 
    ECHO Function msol { Import-Module MSOnline;Connect-MsolService ^| Out-Null }
    ECHO: 
    ECHO Function aad { Import-Module AzureADPreview;Connect-AzureAD ^| Out-Null }
    ECHO: 
    ECHO Function teams { Import-Module MicrosoftTeams;Connect-MicrosoftTeams ^| Out-Null }
    ECHO: 
    ECHO Function exo { Import-Module ExchangeOnlineManagement;Connect-ExchangeOnline -ShowBanner:$false }
    ECHO: 
    ECHO Function spo {
    ECHO     $domain = ^(^(Get-AzureADDomain ^| Where-Object {$_.Name -like "*.onmicrosoft.com" -and $_.Name -notlike "*.mail.onmicrosoft.com"}^).Name^) -replace "\.onmicrosoft\.com"
    ECHO     $spoAdminUrl = "https://"+$domain+"-admin.sharepoint.com"
    ECHO     Import-Module Microsoft.Online.SharePoint.PowerShell;Connect-SPOService -Url $spoAdminUrl
    ECHO }
    ECHO: 
    ECHO Function m365mfa {
    ECHO     Write-Host "Connecting to MSOnline..."
    ECHO     msol
    ECHO     Write-Host "Connecting to AzureAD..."
    ECHO     aad
    ECHO     Write-Host "Connecting to Teams..."
    ECHO     teams
    ECHO     Write-Host "Connecting to ExchangeOnline..."
    ECHO     exo
    ECHO     iseTitle
    ECHO }
    ECHO: 
    ECHO Function m365 {
    ECHO     $Credential  = Get-Credential
    ECHO     Write-Host "Connecting to MSOnline..."
    ECHO     Import-Module MSOnline;Connect-MsolService -Credential $Credential ^| Out-Null
    ECHO     Write-Host "Connecting to AzureAD..."
    ECHO     Import-Module AzureADPreview;Connect-AzureAD -Credential $Credential ^| Out-Null
    ECHO     Write-Host "Connecting to Teams..."
    ECHO     Import-Module MicrosoftTeams;Connect-MicrosoftTeams -Credential $Credential ^| Out-Null
    ECHO     Write-Host "Connecting to ExchangeOnline..."
    ECHO     Import-Module ExchangeOnlineManagement;Connect-ExchangeOnline -Credential $Credential -ShowBanner:$false
    ECHO     iseTitle
    ECHO }
)

exit 0
