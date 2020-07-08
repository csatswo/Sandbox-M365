# PowerShell Profile to add aliases for M365 management and other goodness

<# Copy to one of the following locations. These are listed in order of precedence. 
$PROFILE.AllUsersAllHosts
$PROFILE.AllUsersCurrentHost
$PROFILE.CurrentUserAllHosts
$PROFILE.CurrentUserCurrentHost
#>

<# Skype for Business Online
Usage: 'sfbo username@domain.com domain.onmicrosoft.com'
#>
Function func_sfbo {
    [CmdletBinding()] 
    [Alias('sfbo')]
    Param(
        [string] $user,
        [string] $domain)
        Import-Module SkypeOnlineConnector;Import-PSSession -Session (New-CsOnlineSession -UserName $user -OverrideAdminDomain $domain);Enable-CsOnlineSessionForReconnection}
    Set-Alias -Name sfbo -Value func_sfbo

<# Teams using MicrosoftTeams module
Install via 'Install-Module MicrosoftTeams'
Usage: 'teams username@domain.com'
#>
Function func_teams {
    [CmdletBinding()] 
    [Alias('teams')]
    Param(
        [string] $user)
        Import-Module MicrosoftTeams;Connect-MicrosoftTeams -AccountId $user}
    Set-Alias -Name teams -Value func_teams

<# Exchange Online using v2 module (supports MFA)
Install via 'Install-Module ExchangeOnlineManagement'
#>
Function func_exo {
    [CmdletBinding()] 
    [Alias('exo')]
    Param(
        [string] $user)
        Import-Module ExchangeOnlineManagement;Connect-ExchangeOnline -ShowProgress $true -UserPrincipalName $user}
Set-Alias -Name exo -Value func_exo

# Search command history
Function func_recent {
    [CmdletBinding()] 
    [Alias('recent')]
    Param(
        [string] $search)
        Get-History | ? {$_.CommandLine -like "*$search*"}}
Set-Alias -Name recent -Value func_recent

# Re-run command from history
Function func_again {
    [CmdletBinding()] 
    [Alias('again')]
    Param(
        [string] $id)
        Invoke-History $id}
Set-Alias -Name again -Value func_again
