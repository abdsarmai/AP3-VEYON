@echo off
setlocal enabledelayedexpansion

echo Vérification des droits administrateur...
NET SESSION >nul 2>&1
if %errorLevel% neq 0 (
    echo Ce script nécessite des droits administrateur. Exécution annulée
    exit /b 1
)

:: Définition des chemins
set "SHARE=\"
set "LOCAL_PATH=C:\VEYON"

:: Création du dossier local si inexistant
if not exist "%LOCAL_PATH%" mkdir "%LOCAL_PATH%"

echo Recherche du dernier fichier d'installation de Veyon...
for /f "delims=" %%i in ('dir /b /o-n "%SHARE%\veyon-*-win64-setup.exe"') do (
    set "veyon_installer=%%i"
    goto :found
)

echo Aucun fichier d'installation de Veyon trouvé dans le partage réseau.
exit /b 1

:found
echo Fichier trouvé : %veyon_installer%

:: Copie du fichier localement
echo Copie de l'installateur dans %LOCAL_PATH%...
copy "%SHARE%\%veyon_installer%" "%LOCAL_PATH%\%veyon_installer%" /Y >nul

:: Installation silencieuse
echo Installation de Veyon en cours...
"%LOCAL_PATH%\%veyon_installer%" /S

:: Attente de l'installation
timeout /t 10 /nobreak >nul

:: Vérification de l'installation
if exist "C:\Program Files\Veyon" (
    echo Installation de Veyon terminée avec succès
) else (
    echo Erreur lors de l'installation de Veyon.
)

exit /b 0
