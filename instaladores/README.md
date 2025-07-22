# Instaladores para el Curso "Introducción al análisis en R"

Este directorio contiene los scripts automatizados para instalar **R, rig, RTools, pak y RStudio** en sistemas Windows.

---

## 🖥️ Opción 1: Usar PowerShell directamente

Abre PowerShell **como administrador** y ejecuta este comando:

```powershell
irm https://raw.githubusercontent.com/fherglez501/IVE/main/instaladores/instalador_windows.ps1 | iex
```

---

## 🧰 Opción 2: Ejecutar automáticamente con `.bat`

Si prefieres no copiar archivos manualmente:

1. Abre PowerShell (puede ser sin admin)
2. Ejecuta esta línea para descargar y ejecutar el instalador `.bat` con permisos:

```powershell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/fherglez501/IVE/main/instaladores/instalador_windows.bat" -OutFile "$env:TEMP\instalador_windows.bat"; Start-Process -FilePath "$env:TEMP\instalador_windows.bat" -Verb RunAs
```

---

## 📋 ¿Qué instala este script?

- [rig](https://github.com/r-lib/rig): gestor de versiones de R
- Última versión estable de R (desde CRAN)
- Paquete [`pak`](https://pak.r-lib.org/) para instalación rápida y reproducible de paquetes
- [RTools](https://cran.r-project.org/bin/windows/Rtools/) (compilador para instalar paquetes desde fuente)
- [RStudio Desktop](https://posit.co/download/rstudio-desktop/): entorno de desarrollo para R

---

## ⚠️ Requisitos del sistema

- Windows 10 (versión 21H1 o superior) o Windows 11
- Conexión a Internet estable
- Permisos de administrador (te pedirá confirmación)

---

## 🧠 ¿Qué hacer si no puedes ejecutar el script?

Si **no tienes permisos de administrador**, o no recuerdas la contraseña:

- 🔸 Instala R manualmente desde: https://www.r-project.org/
- 🔸 Instala RStudio desde: https://posit.co/download/rstudio-desktop/
- 🔸 Luego abre RStudio y ejecuta en la consola:

```r
install.packages("pak")
```

---

## 📁 Archivos disponibles

- `instalador_windows.ps1`: Script principal en PowerShell para instalar todo.
- `instalador_windows.bat`: Script auxiliar para ejecutar automáticamente `ps1` con permisos.

---

## 👨‍🏫 Autor

**José Fernando Aguilera González**  
Curso: *Introducción al análisis en R*  
Licencia: MIT

---

> ¿Dudas o errores? Abre un Issue en este repositorio.
