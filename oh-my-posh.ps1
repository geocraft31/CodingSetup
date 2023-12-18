$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$hasAdminRights = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if( -Not $hasAdminRights) 
{
    Write-Host "Please execute the script with admin rights."
    exit
}
 
# install oh my posh
winget install JanDeDobbeleer.OhMyPosh -s winget

# install a font
Write-Host
Write-Host "--------------------------"
Write-Host "Font to use: JetBrainsMono"
Write-Host "--------------------------"

oh-my-posh font install

# change font to new one
Write-Host
Write-Host "--------------------------"
Write-Host "To change font go to a new terminal without admin rights"
Write-Host "Press 'ctrl' + 'alt' + ','"
Write-Host "Go to 'Profiles: Default: font' "
Write-Host 'And add "face: JetBrainsMono Nerd Font"'
Write-Host "--------------------------"

# set theme command
$profileCommand = "oh-my-posh init pwsh --config 'C:/Users/Nuria/.mytheme.omp.json' | Invoke-Expression"
$profileCommand | Out-File -FilePath $profile

# Install theme
