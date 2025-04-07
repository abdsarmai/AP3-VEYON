@echo off
setlocal enabledelayedexpansion

echo V鲩fication des droits administrateur...
NET SESSION >nul 2>&1
if %errorLevel% neq 0 (
    echo Ce script n飥ssite des droits administrateur. Ex飵tion annul饮
    exit /b 1
)

:: D馩nition des chemins
set "SHARE=\\Easystore\veyon$"
set "LOCAL_PATH=C:\VEYON"

:: Cr顴ion du dossier local si inexistant
if not exist "%LOCAL_PATH%" mkdir "%LOCAL_PATH%"

echo Recherche du dernier fichier d'installation de Veyon...
for /f "delims=" %%i in ('dir /b /o-n "%SHARE%\veyon-*-win64-setup.exe"') do (
    set "veyon_installer=%%i"
    goto :found
)

echo Aucun fichier d'installation de Veyon trouv頤ans le partage r鳥au.
exit /b 1

:found
echo Fichier trouv頺 %veyon_installer%

:: Copie du fichier localement
echo Copie de l'installateur dans %LOCAL_PATH%...
copy "%SHARE%\%veyon_installer%" "%LOCAL_PATH%\%veyon_installer%" /Y >nul

:: Installation silencieuse
echo Installation de Veyon en cours...
"%LOCAL_PATH%\%veyon_installer%" /S

:: Attente de l'installation
timeout /t 10 /nobreak >nul

:: V鲩fication de l'installation
if exist "C:\Program Files\Veyon" (
    echo Installation de Veyon termin饠avec succ賡
) else (
    echo Erreur lors de l'installation de Veyon.
)

exit /b 0
