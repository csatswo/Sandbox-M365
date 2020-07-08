ECHO off
ECHO:
ECHO:
ECHO Downloading installation files...
ECHO:
ECHO off

REM Download VSCode
curl -sS -L "https://update.code.visualstudio.com/latest/win32-x64-user/stable" --output C:\users\WDAGUtilityAccount\Downloads\vscode.exe

REM Download Edge
curl -sS -L "http://dl.delivery.mp.microsoft.com/filestreamingservice/files/6bb6cf57-3fd8-48df-a810-2374bae95639/MicrosoftEdgeEnterpriseX64.msi" --output C:\users\WDAGUtilityAccount\Downloads\MicrosoftEdgeEnterpriseX64.msi

REM Download SfBO PowerShell Module
curl -sS -L "https://download.microsoft.com/download/2/0/5/2050B39B-4DA5-48E0-B768-583533B42C3B/SkypeOnlinePowerShell.exe" --output C:\users\WDAGUtilityAccount\Downloads\SkypeOnlinePowerShell.exe

REM Download Microsoft Online Services Sign-In Assistant for IT Professionals RTW
curl -sS -L "https://download.microsoft.com/download/5/0/1/5017D39B-8E29-48C8-91A8-8D0E4968E6D4/en/msoidcli_64.msi" --output C:\users\WDAGUtilityAccount\Downloads\msoidcli_64.msi

REM Download updated PowerShell
curl -sS -L "https://github.com/PowerShell/PowerShell/releases/download/v6.2.4/PowerShell-6.2.4-win-x64.msi" --output C:\users\WDAGUtilityAccount\Downloads\PowerShell-6.2.4-win-x64.msi

ECHO:
ECHO Installing applications...
ECHO:

REM Install and run VSCode
C:\Users\WDAGUtilityAccount\Downloads\vscode.exe /VERYSILENT /MERGETASKS=!runcode

REM Install Edge
msiexec.exe /package C:\Users\WDAGUtilityAccount\Downloads\MicrosoftEdgeEnterpriseX64.msi /quiet

ECHO:
ECHO Updating PowerShell and installing modules...
ECHO:

REM Set ExecutionPolicy
reg add HKLM\Software\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell /v Path /t REG_SZ /d C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe /f>Nul
reg add HKLM\Software\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell /v ExecutionPolicy /t REG_SZ /d Unrestricted /f>Nul
reg add HKLM\Software\Wow6432Node\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell /v Path /t REG_SZ /d C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe /f>Nul
reg add HKLM\Software\Wow6432Node\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell /v ExecutionPolicy /t REG_SZ /d Unrestricted /f>Nul

REM Install Updated PowerShell and Modules
mkdir C:\Windows\System32\WindowsPowerShell\v1.0\Modules\PackageManagement
mkdir C:\Windows\System32\WindowsPowerShell\v1.0\Modules\PowerShellGet
xcopy C:\M365Sandbox\PackageManagement C:\Windows\System32\WindowsPowerShell\v1.0\Modules\PackageManagement /e /q>Nul
xcopy C:\M365Sandbox\PowerShellGet C:\Windows\System32\WindowsPowerShell\v1.0\Modules\PowerShellGet /e /q>Nul

msiexec.exe /package C:\users\WDAGUtilityAccount\Downloads\PowerShell-6.2.4-win-x64.msi /quiet
C:\Users\WDAGUtilityAccount\Downloads\SkypeOnlinePowerShell.exe /install /passive /quiet

powershell.exe "Get-ChildItem -Path C:\Windows\System32\WindowsPowerShell\v1.0\Modules\PackageManagement -Recurse | Unblock-File"
powershell.exe "Get-ChildItem -Path C:\Windows\System32\WindowsPowerShell\v1.0\Modules\PowerShellGet -Recurse | Unblock-File"
powershell.exe Import-Module PackageManagement
powershell.exe Import-Module PowerShellGet
powershell.exe Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
powershell.exe Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
powershell.exe Install-Module AzureAD
powershell.exe Install-Module MSOnline
powershell.exe Install-Module MicrosoftTeams
powershell.exe Install-Module ExchangeOnlineManagement

REM Add PowerShell profile to create aliases for M365 management
copy C:\M365Sandbox\profile.ps1 C:\Windows\System32\WindowsPowerShell\v1.0\profile.ps1>Nul

exit 0
