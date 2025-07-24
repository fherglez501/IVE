@echo off
:: Autor: José Fernando Aguilera Gonzalez
:: Fecha: 2025-07-22
:: Descripcion: Este script descarga y ejecuta el instalador rig + R + pak + RStudio + Git en Windows mediante PowerShell

:: VERIFICAR EJECUCIoN COMO ADMINISTRADOR
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Este script debe ejecutarse como administrador.
    echo 🔐 Haz clic derecho sobre el archivo y selecciona "Ejecutar como administrador".
    pause
    exit /b
)

:: VERIFICAR CONEXIoN A INTERNET
ping -n 1 github.com >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ No hay conexion a Internet. Conéctate y vuelve a intentarlo.
    pause
    exit /b
)

:: DESCARGAR Y EJECUTAR EL SCRIPT DE POWERSHELL DESDE GITHUB
powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/fherglez501/IVE/main/instaladores/winget_rig.ps1 | iex"

pause
