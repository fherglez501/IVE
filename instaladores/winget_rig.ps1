
# Autor: José Fernando Aguilera González
# Fecha de creación: 2025-07-21 
# Última actualización: 2025-07-23
# Requisitos: windows, conexión a Internet
# Licencia: MIT
# Descripción: Este script instala rig, R, RStudio y pak en un sistema Windows.
# Tema: Instalación de R y RStudio en Windows
# Uso: Copia y pega este comando en PowerShell como administrador (omite el símbolo #):
# irm https://raw.githubusercontent.com/fherglez501/IVE/main/instaladores/winget_rig.ps1 | iex

# ----------------------------------------------------------------
# ⚠️ AVISO IMPORTANTE:
# Para ejecutar este script necesitas permisos de administrador.
# Si NO tienes acceso como administrador, o NO recuerdas tu contraseña:
# 👉 Descarga e instala R manualmente desde: https://www.r-project.org/
# 👉 Descarga e instala RStudio manualmente desde: https://posit.co/download/rstudio-desktop/
# Luego, abre RStudio y ejecuta en la consola: install.packages("pak")
# ----------------------------------------------------------------

Write-Host ""
Write-Host "🧪 Curso: Introducción al análisis en R" -ForegroundColor Cyan
Write-Host "🔧 Iniciando instalación automatizada en Windows..." -ForegroundColor Green
Write-Host "👁️ Verificando compatibilidad de íconos en esta terminal..." -ForegroundColor Gray
Write-Host "✅ → OK   ❌ → ERROR   ⏳ → ESPERA   📦 → INSTALANDO   💡 → CONSEJO" -ForegroundColor Gray
Write-Host ""
Write-Host ""

# ---------------------------
# VERIFICAR EJECUCIÓN COMO ADMINISTRADOR
# ---------------------------

Write-Host ""
Write-Host "🔐 Es posible que Windows te solicite permisos de administrador." -ForegroundColor Yellow
Write-Host "ℹ️ Si ves una ventana emergente, haz clic en 'Sí' para continuar." -ForegroundColor Gray
Write-Host "🔑 Si se te pide una contraseña, usa la de un usuario con privilegios de administrador." -ForegroundColor Gray
Write-Host ""

Write-Host "TIPOS DE CUENTA Y QUÉ OCURRE AL EJECUTAR COMO ADMINISTRADOR" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Tipo de cuenta              | Lo que se solicita"
Write-Host "  ----------------------------|-------------------------------------------"
Write-Host "  Cuenta local con admin      | Solo se muestra una ventana (Sí/No)"
Write-Host "  Cuenta restringida          | Solicita la contraseña de un usuario admin"
Write-Host "  Cuenta Microsoft con admin  | Pide la contraseña de esa cuenta"
Write-Host ""

If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host ""
    Write-Host "❌ Este script debe ejecutarse como administrador." -ForegroundColor Red
    Write-Host "ℹ️ Haz clic derecho sobre el icono de PowerShell y selecciona 'Ejecutar como administrador'." -ForegroundColor Yellow
    Write-Host "⏳ Esta ventana se cerrará automáticamente en 10 segundos..." -ForegroundColor Gray
    Start-Sleep -Seconds 10
    Exit 1
}

# ---------------------------
# FUNCIÓN: INSTALAR O ACTUALIZAR WINGET
# ---------------------------
function Install-WingetIfNeeded {
    Write-Host ""
    Write-Host "🔍 Verificando disponibilidad de winget..." -ForegroundColor Blue

    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Host "❌ winget no está disponible. Intentando instalar App Installer..." -ForegroundColor Yellow

        $msixPath = "$env:TEMP\AppInstaller.msixbundle"
        try {
            Invoke-WebRequest -Uri "https://aka.ms/getwinget" -OutFile $msixPath -UseBasicParsing
            Add-AppxPackage -Path $msixPath
            Write-Host "✅ App Installer instalado. Puedes cerrar esta terminal y volver a ejecutar el script si es necesario." -ForegroundColor Green
            Exit 0
        } catch {
            Write-Host "❌ No se pudo instalar winget automáticamente." -ForegroundColor Red
            Write-Host "👉 Instálalo manualmente desde: https://aka.ms/getwinget" -ForegroundColor Cyan
            Write-Host "⏳ Esta ventana se cerrará automáticamente en 10 segundos..." -ForegroundColor Gray
            Start-Sleep -Seconds 10
            Exit 1
        }
    } else {
        Write-Host "✅ winget está disponible." -ForegroundColor Green
        Write-Host "🔄 Verificando actualizaciones de winget..." -ForegroundColor Blue
        try {
            winget upgrade --id Microsoft.DesktopAppInstaller -e --silent --accept-source-agreements --accept-package-agreements
            winget source update
        } catch {
            Write-Host "⚠️ No se pudo actualizar winget. Continuando..." -ForegroundColor Yellow
        }
    }
}

# Ejecutar función
Install-WingetIfNeeded

# ---------------------------
# INSTALAR WINDOWS TERMINAL
# ---------------------------
if (-not (Get-Command wt.exe -ErrorAction SilentlyContinue)) {
    Write-Host "📦 Instalando Windows Terminal..." -ForegroundColor Blue
    winget install --id Microsoft.WindowsTerminal -e --accept-source-agreements --accept-package-agreements
} else {
    Write-Host "✅ Windows Terminal ya está instalado." -ForegroundColor Green
}

# ---------------------------
# INSTALAR GIT
# ---------------------------
if (-not (Get-Command git.exe -ErrorAction SilentlyContinue)) {
    Write-Host "📦 Instalando Git for Windows..." -ForegroundColor Blue
    winget install --id Git.Git -e --accept-source-agreements --accept-package-agreements
} else {
    Write-Host "✅ Git ya está instalado." -ForegroundColor Green
}

# ---------------------------
# VERIFICAR QUE GIT ESTÉ EN EL PATH
# ---------------------------
Write-Host "🔍 Verificando que Git esté disponible en el PATH..." -ForegroundColor Blue

$gitCmd = Get-Command git.exe -ErrorAction SilentlyContinue
if (-not $gitCmd) {
    $gitPath = "C:\Program Files\Git\cmd\git.exe"
    if (Test-Path $gitPath) {
        $envPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
        if ($envPath -notlike "*C:\Program Files\Git\cmd*") {
            Write-Host "🔧 Agregando Git al PATH del sistema..." -ForegroundColor Yellow
            $newPath = $envPath + ";C:\Program Files\Git\cmd"
            [Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
            Write-Host "✅ Git ha sido agregado al PATH del sistema." -ForegroundColor Green
        } else {
            Write-Host "ℹ️ Git está instalado, pero necesitas reiniciar la terminal para usarlo." -ForegroundColor Gray
        }
    } else {
        Write-Host "⚠️ Git no se encontró en el PATH ni en la ruta por defecto." -ForegroundColor Red
        Write-Host "👉 Puedes agregarlo manualmente desde Configuración avanzada del sistema." -ForegroundColor Yellow
    }
} else {
    Write-Host "✅ Git está correctamente disponible en el PATH." -ForegroundColor Green
}

# ---------------------------
# INSTALAR RIG
# ---------------------------
Write-Host "📦 Instalando rig..." -ForegroundColor Blue
winget install --id posit.rig -e --accept-source-agreements --accept-package-agreements

if (-not (Get-Command rig -ErrorAction SilentlyContinue)) {
    Write-Host "⚠️ rig no está disponible en el PATH aún." -ForegroundColor Yellow
    Write-Host "🔁 Al finalizar la instalación, reinicia PowerShell o abre una nueva terminal para asegurar su disponibilidad." -ForegroundColor Gray
} else {
    Write-Host "✅ rig instalado correctamente." -ForegroundColor Green    
}


# ---------------------------
# INSTALAR R CON RIG
# ---------------------------
Write-Host "📦 Instalando la última versión de R con rig..." -ForegroundColor Blue
rig add release

# ---------------------------
# CONFIGURAR RIG
# ---------------------------
Write-Host "🔧 Configurando entorno con rig..." -ForegroundColor Blue
rig system add-pak
rig system rtools
rig system setup-user-lib

# ---------------------------
# INSTALAR RSTUDIO
# ---------------------------
Write-Host "📦 Instalando RStudio Desktop..." -ForegroundColor Blue
winget install --id Posit.RStudio -e --accept-source-agreements --accept-package-agreements

# ---------------------------
# MENSAJE FINAL
# ---------------------------
Write-Host ""
Write-Host "🎉 Instalación completada: R, RStudio y Git ya están disponibles en tu sistema." -ForegroundColor Green
Write-Host "💡 Puedes buscar 'RStudio' en el menú de inicio para comenzar a trabajar." -ForegroundColor Cyan
Write-Host "🌿 Puedes usar Git directamente desde RStudio o abrir Git Bash." -ForegroundColor Cyan
Write-Host "🔁 Se recomienda reiniciar PowerShell o tu equipo para asegurar que todos los cambios surtan efecto correctamente." -ForegroundColor Yellow
Write-Host ""
Write-Host "⏳ Esta ventana se cerrará automáticamente en 12 segundos..." -ForegroundColor DarkGray
Start-Sleep -Seconds 12
Exit 0