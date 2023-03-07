ECHO off

REM Download installation files
REM Download VSCode
curl -sS -L "https://update.code.visualstudio.com/latest/win32-x64-user/stable" --output C:\users\WDAGUtilityAccount\Downloads\vscode.exe
REM Download Chrome
curl -sS -L "http://dl.google.com/edgedl/chrome/install/GoogleChromeStandaloneEnterprise64.msi" --output C:\users\WDAGUtilityAccount\Downloads\GoogleChromeStandaloneEnterprise64.msi

REM Install applications
REM Install  VSCode
C:\Users\WDAGUtilityAccount\Downloads\vscode.exe /VERYSILENT /MERGETASKS=!runcode
REM Install Chrome
C:\Users\WDAGUtilityAccount\Downloads\GoogleChromeStandaloneEnterprise64.msi /qn

REM Configure PowerShell and install modules
powershell.exe "Set-ExecutionPolicy -ExecutionPolicy Unrestricted"
powershell.exe "Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force"
powershell.exe "Set-PSRepository -Name PSGallery -InstallationPolicy Trusted"
powershell.exe "Update-Module"
REM Install Azure AD module
powershell.exe "Install-Module -Repository PSGallery -Name AzureADPreview"
REM Install MSOnline module
powershell.exe "Install-Module -Repository PSGallery -Name MSOnline"
REM Install Teams module
powershell.exe "Install-Module -Repository PSGallery -Name MicrosoftTeams"
REM Install Exchange Online module
powershell.exe "Install-Module -Repository PSGallery -Name ExchangeOnlineManagement"
REM Install SharePoint Online module
powershell.exe "Install-Module -Repository PSGallery -Name Microsoft.Online.SharePoint.PowerShell"
REM Install Teams Graph modules
powershell.exe "Install-Module -Repository PSGallery -Name Microsoft.Graph.Groups"
powershell.exe "Install-Module -Repository PSGallery -Name Microsoft.Graph.Teams"
powershell.exe "Install-Module -Repository PSGallery -Name Microsoft.Graph.Users"
REM Install BurntToast module
powershell.exe "Install-Module -Repository PSGallery -Name BurntToast"

REM Create PowerShell profile
(
    ECHO:
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
) > C:\Windows\System32\WindowsPowerShell\v1.0\profile.ps1 

(
    ECHO [Theme]
    ECHO ^; Windows - IDS_THEME_DISPLAYNAME_AERO_LIGHT
    ECHO DisplayName^=BasicDark
    ECHO ThemeId^={FF64120E-B325-4FC1-8F8F-1A193C55BAE6}
    ECHO:
    ECHO [Control Panel\Cursors]
    ECHO AppStarting^=%%SystemRoot%%\cursors\wait_i.cur
    ECHO Arrow^=%%SystemRoot%%\cursors\arrow_i.cur
    ECHO Crosshair^=%%SystemRoot%%\cursors\cross_i.cur
    ECHO Hand^=%%SystemRoot%%\cursors\aero_link_i.cur
    ECHO Help^=%%SystemRoot%%\cursors\help_i.cur
    ECHO IBeam^=%%SystemRoot%%\cursors\beam_i.cur
    ECHO No^=%%SystemRoot%%\cursors\no_i.cur
    ECHO NWPen^=%%SystemRoot%%\cursors\pen_i.cur
    ECHO SizeAll^=%%SystemRoot%%\cursors\move_i.cur
    ECHO SizeNESW^=%%SystemRoot%%\cursors\size1_i.cur
    ECHO SizeNS^=%%SystemRoot%%\cursors\size4_i.cur
    ECHO SizeNWSE^=%%SystemRoot%%\cursors\size2_i.cur
    ECHO SizeWE^=%%SystemRoot%%\cursors\size3_i.cur
    ECHO UpArrow^=%%SystemRoot%%\cursors\up_i.cur
    ECHO Wait^=%%SystemRoot%%\cursors\busy_i.cur
    ECHO DefaultValue^=Windows Inverted
    ECHO:
    ECHO [Control Panel\Desktop]
    ECHO Pattern^=
    ECHO MultimonBackgrounds^=0
    ECHO PicturePosition^=4
    ECHO WindowsSpotlight^=0
    ECHO:
    ECHO [VisualStyles]
    ECHO Path^=%%SystemRoot%%\resources\themes\Aero\Aero.msstyles
    ECHO ColorStyle^=NormalColor
    ECHO Size^=NormalSize
    ECHO AutoColorization^=0
    ECHO ColorizationColor^=0XC40078D4
    ECHO SystemMode^=Dark
    ECHO AppMode^=Light
    ECHO VisualStyleVersion^=10
    ECHO:
    ECHO [MasterThemeSelector]
    ECHO MTSM^=RJSPBS
    ECHO:
    ECHO [Sounds]
    ECHO ^; IDS_SCHEME_DEFAULT
    ECHO SchemeName^=No Sounds
    ECHO:
    ECHO [Control Panel\Colors]
    ECHO Scrollbar^=200 200 200
    ECHO Background^=74 84 89
    ECHO ActiveTitle^=153 180 209
    ECHO InactiveTitle^=191 205 219
    ECHO Menu^=240 240 240
    ECHO Window^=255 255 255
    ECHO WindowFrame^=100 100 100
    ECHO MenuText^=0 0 0
    ECHO WindowText^=0 0 0
    ECHO TitleText^=0 0 0
    ECHO ActiveBorder^=180 180 180
    ECHO InactiveBorder^=244 247 252
    ECHO AppWorkspace^=171 171 171
    ECHO Hilight^=0 120 215
    ECHO HilightText^=255 255 255
    ECHO ButtonFace^=240 240 240
    ECHO ButtonShadow^=160 160 160
    ECHO GrayText^=109 109 109
    ECHO ButtonText^=0 0 0
    ECHO InactiveTitleText^=0 0 0
    ECHO ButtonHilight^=255 255 255
    ECHO ButtonDkShadow^=105 105 105
    ECHO ButtonLight^=227 227 227
    ECHO InfoText^=0 0 0
    ECHO InfoWindow^=255 255 225
    ECHO ButtonAlternateFace^=0 0 0
    ECHO HotTrackingColor^=0 102 204
    ECHO GradientActiveTitle^=185 209 234
    ECHO GradientInactiveTitle^=215 228 242
    ECHO MenuHilight^=0 120 215
    ECHO MenuBar^=240 240 240
) > C:\Users\WDAGUtilityAccount\Downloads\BasicDark.theme

(
    ECHO Windows Registry Editor Version 5.00
    ECHO: 
    ECHO [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
    ECHO "TaskbarAl"^=dword:00000000
    ECHO:
    ECHO [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search]
    ECHO "SearchboxTaskbarMode"^=dword:00000001
) > C:\Users\WDAGUtilityAccount\Downloads\UITweaks.reg

(
    ECHO ^<?xml version^="1.0" encoding^="utf-8"?^>
    ECHO ^<LayoutModificationTemplate
    ECHO     xmlns^="http://schemas.microsoft.com/Start/2014/LayoutModification"
    ECHO     xmlns:defaultlayout^="http://schemas.microsoft.com/Start/2014/FullDefaultLayout"
    ECHO     xmlns:start^="http://schemas.microsoft.com/Start/2014/StartLayout"
    ECHO     xmlns:taskbar^="http://schemas.microsoft.com/Start/2014/TaskbarLayout"
    ECHO     Version^="1"^>
    ECHO ^<CustomTaskbarLayoutCollection^>
    ECHO     ^<defaultlayout:TaskbarLayout^>
    ECHO     ^<taskbar:TaskbarPinList^>
    ECHO         ^<taskbar:DesktopApp DesktopApplicationLinkPath^="%%PROGRAMDATA%%\Microsoft\Windows\Start Menu\Programs\Google Chrome.lnk" /^>
    ECHO         ^<taskbar:DesktopApp DesktopApplicationLinkPath^="%%APPDATA%%\Microsoft\Windows\Start Menu\Programs\Visual Studio Code\Visual Studio Code.lnk" /^>
    ECHO     ^</taskbar:TaskbarPinList^>
    ECHO     ^</defaultlayout:TaskbarLayout^>
    ECHO ^</CustomTaskbarLayoutCollection^>
    ECHO ^</LayoutModificationTemplate^>
) > C:\Users\WDAGUtilityAccount\Downloads\Layout.xml

REM UI Tweaks
powershell.exe "Import-StartLayout -LayoutPath 'C:\Users\WDAGUtilityAccount\Downloads\Layout.xml' -MountPath 'C:\'"
reg import C:\Users\WDAGUtilityAccount\Downloads\UITweaks.reg
start "" C:\Users\WDAGUtilityAccount\Downloads\BasicDark.theme
ping -n 2 127.0.0.1 > nul
taskkill /im "systemsettings.exe" /f
taskkill /im "explorer.exe" /f
ping -n 2 127.0.0.1 > nul
start explorer.exe

REM Cleanup
del "C:\Users\WDAGUtilityAccount\Downloads\GoogleChromeStandaloneEnterprise64.msi"
del "C:\Users\WDAGUtilityAccount\Downloads\vscode.exe"
del "C:\Users\WDAGUtilityAccount\Downloads\UITweaks.reg"
del "C:\Users\WDAGUtilityAccount\Downloads\Layout.xml"
del "C:\Users\WDAGUtilityAccount\Downloads\BasicDark.theme"
del "C:\Users\Public\Desktop\Google Chrome.lnk"

powershell.exe "New-BurntToastNotification -AppLogo C:\Sandbox-M365\sandboxbox-m365.ico -Text 'Configuration Script Complete!'"

exit 0
