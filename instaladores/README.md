# Instaladores para el Curso "Introducción al análisis en R"

Este directorio contiene los scripts automatizados para instalar:
1. rig 
2. R 
3. RTools (Solo en windows)
4. pak
5. RStudio

Dependiendo del sistema operativo que utilices:
- 💻 **Windows**: utiliza `winget` y PowerShell.
- 🍏 **macOS**: utiliza `Homebrew` y terminal zsh/bash.

---

## 🖥️ Opción 1 (Windows): Usar PowerShell directamente

Abre PowerShell **como administrador** y ejecuta este comando:

```powershell
irm https://raw.githubusercontent.com/fherglez501/IVE/main/instaladores/winget_rig.ps1 | iex
```

---

## 🧰 Opción 2 (Windows): Ejecutar automáticamente con `.bat`

Si prefieres no copiar archivos manualmente:

1. Abre PowerShell
2. Ejecuta esta línea para descargar y ejecutar el instalador `.bat` con permisos:

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/fherglez501/IVE/main/instaladores/instalador_windows.bat" -OutFile "$env:TEMP\instalador_windows.bat"; Start-Process -FilePath "$env:TEMP\instalador_windows.bat" -Verb RunAs
```

---

## 🍏 Opción (macOS): Usar Homebrew y terminal

1. Abre la terminal (zsh por defecto)
2. Ejecuta el siguiente comando:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/fherglez501/IVE/main/instaladores/instalador_mac.sh)"
```

Este script instalará:
- Homebrew
- rig
- Última versión de R
- pak
- RStudio

---

## 📋 ¿Qué instalan estos scripts?

- [rig](https://github.com/r-lib/rig): gestor de versiones de R
- Última versión estable de R (desde CRAN)
- Paquete [`pak`](https://pak.r-lib.org/) para instalación rápida y reproducible de paquetes
- [RTools](https://cran.r-project.org/bin/windows/Rtools/) (solo Windows)
- [RStudio Desktop](https://posit.co/download/rstudio-desktop/): entorno de desarrollo para R

---

## ⚠️ Requisitos del sistema

- Windows 10 (versión 21H1 o superior) o Windows 11
- macOS Monterey (12.0) o superior
- Conexión a Internet estable
- Permisos de administrador (se solicitarán automáticamente)

---

## 🧠 ¿Qué hacer si no puedes ejecutar los scripts?

Si **no tienes permisos de administrador**, o no recuerdas la contraseña:

- 🔸 Instala R manualmente desde: https://www.r-project.org/
- 🔸 Instala RStudio desde: https://posit.co/download/rstudio-desktop/
- 🔸 Luego abre RStudio y ejecuta en la consola:

```r
install.packages("pak")
```

---

## 📁 Archivos disponibles

- `winget_rig.ps1`: Script PowerShell para Windows
- `instalador_windows.bat`: Script auxiliar para ejecutar PowerShell con permisos
- `instalador_mac.sh`: Script para macOS usando Homebrew

---

## 👨‍🏫 Autor

**José Fernando Aguilera González**  
Curso: *Introducción al análisis en R*  
Licencia: MIT

---

> ¿Dudas o errores? Abre un Issue en este repositorio.
