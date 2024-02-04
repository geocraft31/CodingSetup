$tempFolder = [System.IO.Path]::GetTempPath()

$zipPath = "$tempFolder\fonts.zip"
$fontsPath = "$tempFolder\fonts"

$url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip"

function Install-Font {
    
    [CmdletBinding()]
    param(
        [Parameter( Mandatory, ValueFromPipeline )]
        [System.IO.FileInfo[]]
        $FontFile,
        
        [switch]
        $WhatIf
    );
    
    begin {
        $shell = New-Object -ComObject 'Shell.Application';
        $translations = @{
            'cs' = 'Nainstalovat pro &všechny uživatele';
            'da' = 'Installér til &alle brugere';
            'de' = 'Für &alle Benutzer installieren';
            'en' = 'Install for &all users';
            'es' = 'Instalar p&ara todos los usuarios';
            'et' = '&Installi kõigi kasutajate jaoks';
            'fi' = 'Asenna &kaikille käyttäjille';
            'fr' = 'Installer pour &tous les utilisateurs';
            'hu' = 'T&elepítés minden felhasználó számára';
            'it' = 'Inst&alla per tutti gli utenti';
            'lt' = 'Įdiegti &visiems vartotojams';
            'lv' = 'Instalēt &visiem lietotājiem';
            'nl' = 'Installeren voor &alle gebruikers';
            'pl' = 'Zainstaluj dla &wszystkich użytkowników';
            'pt' = 'Instalar para &todos os utilizadores';
            'sk' = 'Inštalovať pre &všetkých používateľov';
            'sl' = 'Namesti za &vse uporabnike';
            'sv' = 'Installera för &alla användare';
        }.Values;
    }
    
    process {
        foreach( $file in $FontFile ) {
            if( $WhatIf ) {
                'Installing font "{0}".' -f $file.Name | Write-Host;
            } else {
                $verbs = $shell.NameSpace( $file.Directory.FullName ).ParseName( $file.Name ).Verbs();
                $verb = $verbs | Where-Object -FilterScript {
                    $_.Name -in $translations;
                };
                if( $verb ) {
                    $verb.DoIt();
                } else {
                    $lang = @(
                        [System.Globalization.CultureInfo]::CurrentUICulture;
                        [System.Globalization.CultureInfo]::CurrentCulture;
                        [System.Globalization.CultureInfo]::InstalledUICulture;
                    ).TwoLetterISOLanguageName | Get-Unique;
                    "Translation for language '$lang' not yet available. Please contact the developer." | Write-Error;
                }
            }
        }
    }
}

Write-Host "Downloading fonts..."
Invoke-WebRequest -Uri $url -OutFile $zipPath

Write-Host "Extracting fonts..."
Expand-Archive -Path $zipPath -DestinationPath $fontsPath

Write-Host "Installing font..."
Get-ChildItem -LiteralPath "$fontsPath" -File -Filter "*.ttf" | Install-Font

Write-Host "Cleaning temporary files..."
Remove-Item -Path $zipPath -Force -Recurse
Remove-Item -Path $fontsPath -Force -Recurse
