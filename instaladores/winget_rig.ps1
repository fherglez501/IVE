# ----------------------------------------------------------------
# AVISO IMPORTANTE:
# Para ejecutar este script necesitas permisos de administrador.
# Si NO tienes acceso como administrador, o NO recuerdas tu contraseña:
# Descarga e instala R manualmente desde: https://www.r-project.org/
# Descarga e instala RStudio manualmente desde: https://posit.co/download/rstudio-desktop/
# Luego, abre RStudio y ejecuta en la consola: install.packages("pak")
# ----------------------------------------------------------------

if (-not $DryRun) { $DryRun = $false }

Write-Host ""
Write-Host " Autor:                 MVZ, MSc, PhD(c) JOSE FERNANDO AGUILERA GONZALEZ" -ForegroundColor DarkGray
Write-Host " Fecha de creacion:     2025-07-21" -ForegroundColor DarkGray
Write-Host " Ultima actualizacion:  2025-07-24" -ForegroundColor DarkGray
Write-Host " Requisitos:            windows, conexion a Internet" -ForegroundColor DarkGray
Write-Host " Licencia:              MIT" -ForegroundColor DarkGray
Write-Host " Descripcion:           Este script instala Windows Terminal, Git, rig, R, pak, y RStudio en un sistema Windows." -ForegroundColor DarkGray
Write-Host ""
Write-Host " SE OMITEN ACENTOS POR COMPATIBILIDAD " -ForegroundColor White
Write-Host ""
Write-Host " Curso: Introduccion al analisis en R" -ForegroundColor Cyan
Write-Host " Tema:  Instalacion de R y RStudio" -ForegroundColor DarkGreen
Write-Host ""
Write-Host " Iniciando instalacion automatizada en Windows..." -ForegroundColor Red
Start-Sleep -Seconds 10


# ---------------------------
# VERIFICAR EJECUCIoN COMO ADMINISTRADOR
# ---------------------------
Write-Host "...Verificando permisos de administrador..." -ForegroundColor Red

If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host ""
    Write-Host " Este script debe ejecutarse como administrador." -ForegroundColor Red
    Write-Host " Haz clic derecho sobre PowerShell o CMD y selecciona 'Ejecutar como administrador'." -ForegroundColor Yellow
    Write-Host " Se cancela toda instalacion. El script se cerrara automaticamente en 10 segundos..." -ForegroundColor DarkGray
    Start-Sleep -Seconds 10
    Exit 1
}

# ---------------------------
# FUNCION: INSTALAR O ACTUALIZAR WINGET
# ---------------------------
function Install-WingetIfNeeded {
    Write-Host ""
    Write-Host "...Verificando disponibilidad de winget..." -ForegroundColor Blue

    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Host " === winget | NO INSTALADO === Intentando instalar App Installer..." -ForegroundColor Yellow

        $msixPath = "$env:TEMP\AppInstaller.msixbundle"
        try {
            Invoke-WebRequest -Uri "https://aka.ms/getwinget" -OutFile $msixPath -UseBasicParsing
            Add-AppxPackage -Path $msixPath
            Write-Host "App Installer instalado. Puedes cerrar esta terminal y volver a ejecutar el script si es necesario." -ForegroundColor Green
            Exit 0
        } catch {
            Write-Host "No se pudo instalar winget automaticamente." -ForegroundColor Red
            Write-Host "Instalalo manualmente desde: https://aka.ms/getwinget" -ForegroundColor Cyan
            Write-Host "El script se cerrara automaticamente en 10 segundos..." -ForegroundColor DarkGray
            Start-Sleep -Seconds 10
            Exit 1
        }
    } else {
        Write-Host " === winget | INSTALADO === " -ForegroundColor Yellow
        Write-Host "...Actualizando App Installer..." -ForegroundColor Blue
        try {
            winget upgrade --id Microsoft.DesktopAppInstaller -e --silent --accept-source-agreements --accept-package-agreements 2>&1 | Out-Null
            winget source update 2>&1 | Out-Null
            Write-Host " origenes actualizados correctamente " -ForegroundColor DarkGray
        } catch {
            Write-Host "No se pudo actualizar winget. Continuando..." -ForegroundColor Yellow
        }
    }
}

# Ejecutar funcion
Install-WingetIfNeeded


# ---------------------------
# INSTALAR WINDOWS TERMINAL
# ---------------------------
Write-Host ""
if (-not (Get-Command wt.exe -ErrorAction SilentlyContinue)) {
    Write-Host "Instalando Windows Terminal..." -ForegroundColor Blue
    winget install --id Microsoft.WindowsTerminal -e --accept-source-agreements --accept-package-agreements
} else {
    Write-Host "...Verificando disponibilidad de Terminal..." -ForegroundColor Blue
    Write-Host " === Terminal de Windows | INSTALADO === " -ForegroundColor Yellow
    Write-Host " Para concer mas sobre la terminal consulta el siguiente enlace con Ctrl + click derecho: " -ForegroundColor Cyan
    Write-Host " https://docs.microsoft.com/en-us/windows/terminal/" -ForegroundColor DarkYellow
    Start-Sleep -Seconds 5
}

# ---------------------------
# INSTALAR GIT
# ---------------------------
Write-Host ""
if (-not (Get-Command git.exe -ErrorAction SilentlyContinue)) {
    Write-Host " Instalando Git for Windows... " -ForegroundColor Blue
    winget install --id Git.Git -e --accept-source-agreements --accept-package-agreements
} else {
    Write-Host "...Verificando disponibilidad de Git..." -ForegroundColor Blue
    Write-Host " === Git | INSTALADO === " -ForegroundColor Yellow
    Write-Host " Puedes usar Git directamente desde la terminal de Windows o Git Bash." -ForegroundColor Cyan
    Write-Host " Para conocer mas sobre Git consulta el siguiente enlace con Ctrl + click derecho: " -ForegroundColor Cyan
    Write-Host " https://github.com/git-guides" -ForegroundColor DarkYellow
    Start-Sleep -Seconds 5
}

# ---------------------------
# VERIFICAR QUE GIT ESTÉ EN EL PATH
# ---------------------------
Write-Host ""
Write-Host "...Verificando que Git se ubique en el PATH..." -ForegroundColor Blue
Write-Host " El PATH es una variable de entorno del sistema operativo" -ForegroundColor White
Write-Host " que contiene una lista de directorios donde se buscan los ejecutables" -ForegroundColor White
Write-Host " Si Git no esta en el PATH, no podras usarlo desde la terminal" -ForegroundColor White
Start-Sleep -Seconds 10

$gitCmd = Get-Command git.exe -ErrorAction SilentlyContinue
if (-not $gitCmd) {
    $gitPath = "C:\Program Files\Git\cmd\git.exe"
    if (Test-Path $gitPath) {
        $envPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
        if ($envPath -notlike "*C:\Program Files\Git\cmd*") {
            Write-Host "Agregando Git al PATH del sistema..." -ForegroundColor Yellow
            $newPath = $envPath + ";C:\Program Files\Git\cmd"
            [Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
            Write-Host "Git ha sido agregado al PATH del sistema." -ForegroundColor Green
        } else {
            Write-Host "Pero necesitas reiniciar la terminal para usarlo al finalizar." -ForegroundColor Gray
        }
    } else {
        Write-Host "Git no se ubica en el PATH y tampoco en la ruta por defecto." -ForegroundColor Red
        Write-Host "Puedes agregarlo manualmente desde Configuracion avanzada del sistema." -ForegroundColor Yellow
    }
} else {
    Write-Host " === Git | en el PATH === " -ForegroundColor DarkGreen
}

# ---------------------------
# INSTALAR RIG
# ---------------------------
Write-Host ""
Write-Host "...Instalando = RIG -- The R Installation Manager..." -ForegroundColor Blue

# 1. Verificar si 'rig' esta instalado
$rigCmd = Get-Command rig -ErrorAction SilentlyContinue

if (-not $rigCmd) {
    Write-Host "... Procediendo ..." -ForegroundColor Blue

    if (-not $DryRun) {
        winget install --id Posit.rig -e --accept-source-agreements --accept-package-agreements
    } else {
        Write-Host "SIMULACION: rig NO se instalara (modo DryRun)." -ForegroundColor DarkGray
    }

    # Reintentar detectar rig después de instalar (en caso de ejecucion real)
    $rigCmd = Get-Command rig -ErrorAction SilentlyContinue
    if (-not $rigCmd) {
        Write-Host "rig sigue sin estar disponible tras la instalacion" -ForegroundColor Red
    }
} else {
    Write-Host " === rig | INSTALADO === " -ForegroundColor Yellow
}

# 2. Verificar si rig esta en el PATH
if (-not $rigCmd) {
    # ruta por defecto donde rig instala el ejecutable
    $rigPath = "$env:USERPROFILE\.rig\bin"
    if (Test-Path "$rigPath\rig.exe") {
        $envPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
        if ($envPath -notlike "*$rigPath*") {
            Write-Host " ...Agregando rig al PATH del sistema... " -ForegroundColor DarkGray
            $newPath = "$envPath;$rigPath"
            [Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
            Write-Host " === rig agregado al PATH correctamente === " -ForegroundColor Yellow
        } else {
            Write-Host " ... rig ya estaba en el PATH, pero puede requerir reinicio de PowerShell... " -ForegroundColor DarkGray
        }
    } else {
        Write-Host "No se encontro rig.exe en la ruta por defecto." -ForegroundColor Red
        Write-Host "Verifica manualmente si rig se instalo correctamente." -ForegroundColor DarkGray
    }
} else {
    Write-Host " === rig | en el PATH === " -ForegroundColor DarkGreen
}

# ---------------------------
# INSTALAR R CON RIG
# ---------------------------
Write-Host ""
Write-Host "...Instalando = Ultima version de R con rig..." -ForegroundColor Blue

if (-not $DryRun) {
    rig add release
} else {
    Write-Host "SIMULACION: rig add release NO ejecutado (modo DryRun)." -ForegroundColor DarkGray
}

# ---------------------------
# CONFIGURAR RIG
# ---------------------------
Write-Host ""
Write-Host "...Configurando entorno con rig..." -ForegroundColor Blue
Write-Host "Se agrega 'pak' al sistema para instalacion de paquetes en R..." -ForegroundColor White
Write-Host "Asi como 'RTools' (compilador y entorno de desarrollo nativo)..." -ForegroundColor White
Write-Host "Y la 'libreria de usuario' para instalacion persistente de paquetes..." -ForegroundColor White
Start-Sleep -Seconds 10

if (-not $DryRun) {
    rig system add-pak
    rig system rtools
    rig system setup-user-lib
} else {
    Write-Host "SIMULACION: configuracion de rig NO ejecutada (modo DryRun)." -ForegroundColor DarkGray
}

# ---------------------------
# INSTALAR RSTUDIO
# ---------------------------
Write-Host ""
Write-Host "...Instalando RStudio Desktop..." -ForegroundColor Blue
Write-Host "RStudio es el entorno de desarrollo integrado (IDE) para trabajar con R de forma visual y eficiente." -ForegroundColor White

if (-not $DryRun) {
    winget install --id Posit.RStudio -e --accept-source-agreements --accept-package-agreements
} else {
    Write-Host "SIMULACION: RStudio NO se instalara (modo DryRun)." -ForegroundColor DarkGray
    Start-Sleep -Seconds 5
}

# ---------------------------
# MENSAJE FINAL
# ---------------------------
Write-Host ""
Write-Host "Instalacion completa: rig, R, pak, RStudio y Git ya estan INSTALADOS en tu sistema." -ForegroundColor Yellow
Write-Host "Puedes buscar 'RStudio' en el menu de inicio para comenzar a trabajar." -ForegroundColor Cyan
Write-Host "Puedes usar Git directamente desde RStudio o abrir Git Bash." -ForegroundColor Cyan
Write-Host "Reinicia PowerShell para asegurar que todos los cambios surtan efecto correctamente." -ForegroundColor Red
Write-Host ""
Write-Host "Este script se cerrara automaticamente en 10 segundos..." -ForegroundColor DarkGray
Start-Sleep -Seconds 10

Exit 0