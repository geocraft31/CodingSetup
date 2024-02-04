$themeURL = "https://github.com/geocraft31/CodingSetup/releases/download/Themes/mytheme.omp.json"
$themePath = "$env:USERPROFILE\oh-my-posh-theme.omp.json"

winget install JanDeDobbeleer.OhMyPosh -s winget

Invoke-WebRequest -Uri $themeURL -OutFile $themePath

$profileCommand = "oh-my-posh init pwsh --config '$themePath' | Invoke-Expression"
$profileCommand | Out-File -FilePath $profile
