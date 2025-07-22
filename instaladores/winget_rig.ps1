
# Autor: José Fernando Aguilera González
# Fecha de cración: 2025-07-21 
# Última actualización: 2025-07-21
# Requisitos: windows, conexión a Internet
# Licencia: MIT
# Descripción: Este script instala rig, R, RStudio y pak en un sistema Windows.
# Curso: Instalación de R y RStudio en Windows
# Uso: Copia y pega este comando en PowerShell como administrador:
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
Write-Host ""

# ---------------------------
# VERIFICAR EJECUCIÓN COMO ADMINISTRADOR
# ---------------------------

Write-Host ""
Write-Host "🔐 Es posible que Windows te solicite permisos de administrador." -ForegroundColor Yellow
Write-Host "ℹ️ Si ves una ventana emergente, haz clic en 'Sí' para continuar." -ForegroundColor Gray
Write-Host "🔑 Si se te pide una contraseña, usa la de un usuario con privilegios de administrador." -ForegroundColor Gray
Write-Host ""

Write-Host "ℹ️  TIPOS DE CUENTA Y QUÉ OCURRE AL EJECUTAR COMO ADMINISTRADOR" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Tipo de cuenta              | Lo que se solicita"
Write-Host "  ----------------------------|-------------------------------------------"
Write-Host "  Cuenta local con admin      | Solo se muestra una ventana (Sí/No)"
Write-Host "  Cuenta restringida          | Solicita la contraseña de un usuario admin"
Write-Host "  Cuenta Microsoft con admin  | Pide la contraseña de esa cuenta"
Write-Host ""

If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Host "❌ Este script debe ejecutarse como administrador." -ForegroundColor Red
    Write-Host "ℹ️ Haz clic derecho sobre el icono de PowerShell y selecciona 'Ejecutar como administrador'." -ForegroundColor Yellow
    Exit 1
}

# ---------------------------
# VERIFICAR Y/O INSTALAR WINGET
# ---------------------------
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "⚠️ winget no está disponible en este sistema." -ForegroundColor Yellow
    Write-Host "💡 Intentaremos abrir Microsoft Store para instalar 'App Installer'..." -ForegroundColor Gray

    try {
        Start-Process "ms-windows-store://pdp/?ProductId=9NBLGGH4NNS1"
        Write-Host ""
        Write-Host "⏳ Se ha abierto Microsoft Store. Instala manualmente 'App Installer' y luego vuelve a ejecutar este script." -ForegroundColor Cyan
    } catch {
        Write-Host "❌ No se pudo abrir Microsoft Store automáticamente." -ForegroundColor Red
        Write-Host "🔗 Busca manualmente 'App Installer' en la Microsoft Store." -ForegroundColor Yellow
    }

    Exit 1
}

Write-Host "🔄 Actualizando catálogos de winget..." -ForegroundColor Blue
winget source update

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
# INSTALAR RIG
# ---------------------------
Write-Host "📦 Instalando rig..." -ForegroundColor Blue
winget install --id posit.rig -e --accept-source-agreements --accept-package-agreements
# Verificar que rig esté en el PATH antes de continuar
if (-not (Get-Command rig -ErrorAction SilentlyContinue)) {
    Write-Host "⚠️ rig no está disponible en el PATH aún." -ForegroundColor Yellow
    Write-Host "🔁 Reinicia PowerShell o abre una nueva terminal para asegurar su disponibilidad." -ForegroundColor Gray
    Exit 1
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
Write-Host "🎉 Instalación completada: R y RStudio ya están disponibles en tu sistema." -ForegroundColor Green
Write-Host "💡 Puedes buscar 'RStudio' en el menú de inicio para comenzar a trabajar." -ForegroundColor Cyan
Write-Host ""