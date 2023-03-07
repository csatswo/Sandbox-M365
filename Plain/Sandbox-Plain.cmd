ECHO off

REM Configure PowerShell
powershell.exe "Set-ExecutionPolicy -ExecutionPolicy Unrestricted"
powershell.exe "Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force"
powershell.exe "Set-PSRepository -Name PSGallery -InstallationPolicy Trusted"
powershell.exe "Update-Module"

REM Create theme file
(
    ECHO ; PlainDark.theme
    ECHO [Theme]
    ECHO ; Windows - IDS_THEME_DISPLAYNAME_AERO_LIGHT
    ECHO DisplayName^=PlainDark
    ECHO ThemeId^={F2E78538-49AF-43E2-8376-DB766CAB0077}
    ECHO [Control Panel\Cursors]
    ECHO DefaultValue^=Windows Inverted
    ECHO [Control Panel\Desktop]
    ECHO Pattern^=
    ECHO MultimonBackgrounds^=0
    ECHO PicturePosition^=4
    ECHO WindowsSpotlight^=0
    ECHO [VisualStyles]
    ECHO Path^=%%SystemRoot%%\resources\themes\Aero\Aero.msstyles
    ECHO ColorStyle^=NormalColor
    ECHO Size^=NormalSize
    ECHO AutoColorization^=0
    ECHO ColorizationColor^=0XC4007FFF
    ECHO SystemMode^=Dark
    ECHO AppMode^=Light
    ECHO VisualStyleVersion^=10
    ECHO [MasterThemeSelector]
    ECHO MTSM^=RJSPBS
    ECHO [Sounds]
    ECHO ; IDS_SCHEME_DEFAULT
    ECHO SchemeName^=No Sounds
    ECHO [Control Panel\Colors]
    ECHO Background^=64 64 64
) > C:\Users\WDAGUtilityAccount\Downloads\PlainDark.theme

REM Create registry tweaks file
(
    ECHO Windows Registry Editor Version 5.00
    ECHO: 
    ECHO [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
    ECHO "TaskbarAl"^=dword:00000000
    ECHO:
    ECHO [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search]
    ECHO "SearchboxTaskbarMode"^=dword:00000001
) > C:\Users\WDAGUtilityAccount\Downloads\UITweaks.reg

REM Create Start layout xml
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
    ECHO         ^<taskbar:DesktopApp DesktopApplicationLinkPath^="%%APPDATA%%\Microsoft\Windows\Start Menu\Programs\Visual Studio Code\Visual Studio Code.lnk" /^>
    ECHO     ^</taskbar:TaskbarPinList^>
    ECHO     ^</defaultlayout:TaskbarLayout^>
    ECHO ^</CustomTaskbarLayoutCollection^>
    ECHO ^</LayoutModificationTemplate^>
) > C:\Users\WDAGUtilityAccount\Downloads\Layout.xml

REM UI Tweaks
powershell.exe "Import-StartLayout -LayoutPath 'C:\Users\WDAGUtilityAccount\Downloads\Layout.xml' -MountPath 'C:\'"
reg import C:\Users\WDAGUtilityAccount\Downloads\UITweaks.reg
start "" C:\Users\WDAGUtilityAccount\Downloads\PlainDark.theme
ping -n 2 127.0.0.1 > nul
taskkill /im "systemsettings.exe" /f
taskkill /im "explorer.exe" /f
ping -n 2 127.0.0.1 > nul
start explorer.exe

REM Cleanup
del "C:\Users\WDAGUtilityAccount\Downloads\UITweaks.reg"
del "C:\Users\WDAGUtilityAccount\Downloads\Layout.xml"
del "C:\Users\WDAGUtilityAccount\Downloads\PlainDark.theme"

exit 0
