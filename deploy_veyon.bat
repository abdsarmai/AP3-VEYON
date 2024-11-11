@echo off
setlocal enabledelayedexpansion

echo Installation de Veyon en cours...
echo.

:: Vérifier si le script est exécuté en tant qu'administrateur
NET SESSION >nul 2>&1
if %errorLevel% neq 0 (
    echo Ce script necessite des droits administrateur.
    echo Veuillez executer en tant qu'administrateur.
    pause
    exit /b 1
)

:: Afficher les informations de débogage
echo Repertoire du script : %~dp0
echo Fichier recherche : %~dp0veyon-4.9.0.0-win64-setup.exe

:: Vérifier si le fichier d'installation existe
if not exist "%~dp0veyon-4.9.0.0-win64-setup.exe" (
    echo Le fichier veyon-4.9.0.0-win64-setup.exe n'a pas ete trouve.
    echo Chemin complet recherche : %~dp0veyon-4.9.0.0-win64-setup.exe
    pause
    exit /b 1
)

echo Installation silencieuse de Veyon...
"%~dp0veyon-4.9.0.0-win64-setup.exe" /S

:: Attendre que l'installation se termine
timeout /t 10 /nobreak

:: Vérifier si l'installation a réussi
if exist "C:\Program Files\Veyon" (
    echo Installation de Veyon terminee avec succes!
) else (
    echo Erreur lors de l'installation de Veyon.
)

echo.
echo Installation terminee.
pause
exit /b 0
