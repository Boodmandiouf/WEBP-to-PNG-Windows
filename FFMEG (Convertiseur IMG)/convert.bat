@echo off
setlocal enabledelayedexpansion

:: Vérification de la présence de FFmpeg
where ffmpeg >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERREUR] FFmpeg n'a pas ete trouve.
    echo Redemarre ton terminal ou ton PC pour appliquer le PATH de winget.
    pause
    exit /b
)

echo ==========================================
echo    CONVERTISSEUR PROPRE WEBP VERS PNG
echo ==========================================
echo.

:: Définition du dossier de sortie
set "output_dir=Convertis_PNG"

:: Compteur pour afficher le total à la fin
set /a count=0

:: Vérifie s'il y a au moins un fichier .webp avant de continuer
if not exist *.webp (
    echo [INFO] Aucun fichier .webp trouve dans ce dossier.
    pause
    exit /b
)

:: Création du dossier s'il n'existe pas
if not exist "%output_dir%" (
    echo [INFO] Creation du dossier de sortie : %output_dir%
    mkdir "%output_dir%"
)

echo --- Debut de la conversion ---
echo.

:: Boucle sur les fichiers .webp
for %%f in (*.webp) do (
    echo Conversion : "%%f" -^> "%output_dir%\%%~nf.png"
    
    :: Conversion et envoi direct dans le sous-dossier
    ffmpeg -i "%%f" "%output_dir%\%%~nf.png" -loglevel error
    
    if !errorlevel! equ 0 (
        set /a count+=1
    ) else (
        echo [ERREUR] Echec pour "%%f"
    )
)

echo.
echo ==========================================
echo  Termine ! %count% fichier(s) converti(s).
echo  Retrouvez vos images dans : \%output_dir%\
echo ==========================================
pause