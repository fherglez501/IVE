# Introducción al análisis en R
## 📋 ¿Qué instalan estos scripts?

Este directorio contiene scripts automatizados para configurar un entorno funcional para análisis en R, incluyendo:

- [Windows Terminal](https://learn.microsoft.com/es-es/windows/terminal/install) Un emulador de terminal moderna, rápida, eficaz, eficiente y productiva para Windows.
- [Git](https://git-scm.com/) Software de control de versiones, registrando los cambios en archivos
- [rig](https://github.com/r-lib/rig) The R Installation Manager
- [R](https://www.r-project.org/) Última versión estable desde CRAN
- [`pak`](https://pak.r-lib.org/) para instalación rápida y reproducible de paquetes
- [RTools](https://cran.r-project.org/bin/windows/Rtools/) (solo Windows)
- [RStudio Desktop](https://posit.co/download/rstudio-desktop/): entorno de desarrollo integrado

Dependiendo del sistema operativo, en:
- 💻 **Windows**: utiliza [`winget`](https://learn.microsoft.com/es-es/windows/package-manager/winget/) y [`PowerShell`](https://learn.microsoft.com/es-es/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4#winget).
- 🍏 **macOS**: utiliza [`Homebrew`](https://brew.sh/)🍺 y terminal zsh/bash.

### ⚙️ Comportamiento inteligente de los scripts

- Si alguna herramienta ya está instalada, **no se reinstala**.
- En macOS, si Git proviene del sistema (`/usr/bin/git`), se ofrece instalar la versión de Homebrew.
- En Windows, Git se instala con `winget` si no está disponible o no está en el `PATH`.

---

## ⚠️ Requisitos del sistema

- **PERMISOS de ADMINSTRADOR** (se solicitarán automáticamente)
- Windows 10 (versión 21H1 o superior) o Windows 11
- macOS Monterey (12.0) o superior
- Conexión a Internet estable

---

## 🖥️ Opción 1 en Windows con PowerShell

1. Abre **PowerShell como administrador** 
2. Ejecuta el siguiente comando (Copia y Pega):

```powershell
irm https://raw.githubusercontent.com/fherglez501/IVE/main/instaladores/winget_rig.ps1 | iex
```

---

##  Opción 2 en Windows con CMD con .bat
1. Abre **CMD como administrador** 
2. Ejecuta el siguiente comando (Copia y Pega) para ejecutar el instalador `.bat`

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/fherglez501/IVE/main/instaladores/instalador_windows.bat" -OutFile "$env:TEMP\instalador_windows.bat"; Start-Process -FilePath "$env:TEMP\instalador_windows.bat" -Verb RunAs
```

---

**📌 ¿Por qué existe este archivo `.bat`?**  
El archivo `.bat` permite a los usuarios ejecutar el instalador fácilmente desde **CMD**, incluso si no están familiarizados con **PowerShell**.
Este archivo ejecutará el script y pedirá confirmación de administrador si es necesario.

---

## 🍏 Opción en macOS con Homebrew y terminal
1. Abre la terminal (zsh por defecto)
2. Ejecuta el siguiente comando (Copia y Pega):

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/fherglez501/IVE/main/instaladores/homebrew_rig.sh)"
```

## 🧠 ¿Qué hacer si no puedes ejecutar los scripts?
Si **no tienes permisos de administrador**, o no recuerdas la contraseña:

- Instala Git manualmente desde: https://git-scm.com/downloads
- Instala R manualmente desde: https://www.r-project.org/
- Instala RStudio desde: https://posit.co/download/rstudio-desktop/
- Luego abre RStudio y ejecuta en la consola:

```r
install.packages("pak")
```

---

## 📁 Archivos disponibles
- `homebrew_rig.sh`: Script para macOS usando Homebrew
- `instalador_windows.bat`: Script auxiliar para ejecutar PowerShell con permisos
- `winget_rig.ps1`: Script PowerShell para Windows

---

## ⚠️ Descargo de responsabilidad

Estos scripts se proporcionan con fines educativos y de conveniencia. Su ejecución implica la instalación automatizada de software libre de terceros.
**El autor no asume ninguna responsabilidad por posibles daños, fallos del sistema o conflictos que puedan surgir como resultado de su uso.**
Asegúrate de comprender los cambios que se aplicarán a tu sistema

---
## 👨‍🏫 Autor
**José Fernando Aguilera González**  
Curso: *Introducción al análisis en R*  
Licencia: MIT

---

> ¿Dudas o errores? Abre un Issue en este repositorio.
