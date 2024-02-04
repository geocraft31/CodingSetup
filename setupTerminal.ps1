$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$hasAdminRights = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if( -Not $hasAdminRights) 
{
    Write-Host "Please execute the script with admin rights."
    exit
}

& "$PSScriptRoot\Terminal\installFont.ps1"
& "$PSScriptRoot\Terminal\oh-my-posh.ps1"
& "$PSScriptRoot\Terminal\terminalPersonalization.ps1"
