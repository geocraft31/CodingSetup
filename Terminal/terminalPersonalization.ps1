$fontFamily = "JetBrainsMono Nerd Font"
$colorScheme = "One Half Dark"
$opcaity = 50
$imageOpacity = 0.2

$imageURL = "https://w.wallhaven.cc/full/l8/wallhaven-l8rloq.jpg"
$backgroundImage = "$env:USERPROFILE\Pictures\TerminalBackground.png"

Invoke-WebRequest -URI $imageURL -OutFile $backgroundImage

$settingsPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$settings = Get-Content -Raw -Path $settingsPath | ConvertFrom-Json

if ( $null -eq $settings.profiles.defaults.font ) {
    $settings.profiles.defaults | Add-Member -MemberType NoteProperty -Name "font" -Value @{
        "face" = "$fontFamily"
    }
}

if ( $null -eq $settings.profiles.defaults.colorScheme ) {
    $settings.profiles.defaults | Add-Member -MemberType NoteProperty -Name "colorScheme" -Value $colorScheme
}

if ( $null -eq $settings.profiles.defaults.opacity ) {
    $settings.profiles.defaults | Add-Member -MemberType NoteProperty -Name "opacity" -Value $opcaity
}

if ( $null -eq $settings.profiles.defaults.useAcrylic ) {
    $settings.profiles.defaults | Add-Member -MemberType NoteProperty -Name "useAcrylic" -Value $true
}

if ( $null -eq $settings.profiles.defaults.backgroundImageOpacity ) {
    $settings.profiles.defaults | Add-Member -MemberType NoteProperty -Name "backgroundImageOpacity" -Value $imageOpacity
}

if ( $null -eq $settings.profiles.defaults.backgroundImage ) {
    $settings.profiles.defaults | Add-Member -MemberType NoteProperty -Name "backgroundImage" -Value $backgroundImage
}

$settings | ConvertTo-Json -depth 32 | Set-Content $settingsPath -Encoding UTF8 -Force