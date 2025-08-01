# Introducción a la ciencia de datos con R
## 📋 ¿Qué instalan estos scripts?

Este directorio contiene scripts automatizados para configurar un entorno funcional para análisis en R, incluyendo:

- [Windows Terminal](https://learn.microsoft.com/es-es/windows/terminal/install): emulador moderno de terminal para Windows, rápido, eficiente y personalizable.
- [Git](https://git-scm.com/): sistema de control de versiones que permite registrar y gestionar cambios en archivos de código y proyectos.
- [rig](https://github.com/r-lib/rig): gestor de versiones de R que facilita la instalación y administración de múltiples versiones.
- [R](https://www.r-project.org/): lenguaje y entorno de programación para análisis estadístico y visualización de datos.
- [`pak`](https://pak.r-lib.org/): paquete que permite instalar otras bibliotecas de R de forma rapida, segura y reproducible.
- [RTools](https://cran.r-project.org/bin/windows/Rtools/) (solo Windows): conjunto de herramientas necesarias para compilar e instalar paquetes de R que incluyen código en C, C++ o Fortran.
- [RStudio Desktop](https://posit.co/download/rstudio-desktop/): entorno de desarrollo integrado (IDE) que facilita escribir, ejecutar y visualizar código en R desde una sóla interfaz.

Dependiendo del sistema operativo, en:
- 💻 **Windows**: utiliza 📦 [`winget`](https://learn.microsoft.com/es-es/windows/package-manager/winget/) y 🟦 [`PowerShell`](https://learn.microsoft.com/es-es/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4#winget).
- 🍏 **macOS**: utiliza 🍺 [`Homebrew`](https://brew.sh/) y terminal 🐚 zsh/bash.

### ⚙️ Comportamiento inteligente de los scripts

- Si alguna herramienta ya esta instalada, **no se reinstala**.
- En macOS, si Git proviene del sistema (`/usr/bin/git`), se ofrece instalar la version de Homebrew.
- En Windows, Git se instala con `winget` si no esta disponible o no esta en el `PATH`.

---

### Puedes verificar el código crudo en:
1. **PowerShell**: https://raw.githubusercontent.com/fherglez501/IVE/main/instaladores/winget_rig.ps1
2. **CMD**: https://raw.githubusercontent.com/fherglez501/IVE/main/instaladores/instalador_windows.bat
3. **Homebrew**: https://raw.githubusercontent.com/fherglez501/IVE/main/instaladores/homebrew_rig.sh

---

## ⚠️ Requisitos del sistema

- **PERMISOS de ADMINSTRADOR** (se solicitaran automáticamente)
- Windows 10 (version 21H1 o superior) o Windows 11
- macOS Monterey (12.0) o superior
- Conexion a Internet estable

### En el caso de PowerShell
- Por defecto, Windows bloquea la ejecución de scripts .ps1. Para permitirlo **temporalmente**, abre PowerShell como administrador y ejecuta:
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```
Esto **no** cambia la politica permanentemente. Solo para la sesión actual. ✔️

### ❗ Advertencia de seguridad
No ejecutes scripts desconocidos si no sabes qué hacen. Este script ha sido creado con fines educativos y no modifica configuraciones críticas del sistema.

---

## 🖥️ Opción 1 en Windows utilizando 🟦 PowerShell

1. Abre **PowerShell como administrador** 
2. Ejecuta el siguiente comando (Copia y Pega):

```powershell
irm https://raw.githubusercontent.com/fherglez501/IVE/main/instaladores/winget_rig.ps1 | iex
```

---

##  Opción 2 en Windows utilizando ⚫ CMD con .bat
1. Abre **CMD como administrador** 
2. Ejecuta el siguiente comando (Copia y Pega) para ejecutar el instalador `.bat`

```powershell
powershell -Command "iwr https://raw.githubusercontent.com/fherglez501/IVE/main/instaladores/instalador_windows.bat -OutFile \"$env:TEMP\instalador_windows.bat\"; Start-Process \"$env:TEMP\instalador_windows.bat\" -Verb RunAs"
```

**📌 ¿Por qué existe este archivo `.bat`?**  
El archivo `.bat` permite a los usuarios ejecutar el instalador facilmente desde **CMD**, incluso si no estan familiarizados con **PowerShell**.
automáticamente descargará y ejecutará el script principal [winget_rig.ps1](https://raw.githubusercontent.com/fherglez501/IVE/main/instaladores/instalador_windows.bat) con permisos de administrador.

---

## 🍏 Opción en macOS utilizando 🐚 zsh con 🍺 Homebrew 
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
- Luego abre RStudio y ejecuta en la consóla:

```r
install.packages("pak")
```

---

## ⚠️ Advertencia de seguridad

Este script se proporciona con fines educativos y de apoyo técnico para facilitar la instalación de software de código abierto (como R, RStudio, Git, etc.). Su ejecución modificará tu sistema instalando programas desde **fuentes oficiales** mediante herramientas automatizadas.

Antes de ejecutar el script, ten en cuenta lo siguiente:
1. Revisa el contenido del código para comprender los cambios que realizará en tu equipo.
2. En caso de dudas técnicas o situaciones legales, el repositorio puede ser auditado para verificar la integridad del código original.
3. Pueden surgir problemas por incompatibilidades con configuraciones específicas del sistema.
4. **El autor no asume ninguna responsabilidad por modificaciones no autorizadas al código original realizadas por terceros.** 
 
---

## 📜 Licencia

Este repositorio utiliza un modelo de licenciamiento dual:

- 📘 **Contenido educativo** (materiales, instrucciones, guías):  
  Licenciado bajo [CC BY-NC 4.0](https://creativecommons.org/licenses/by-nc/4.0/). Puedes compartir y adaptar el contenido, siempre que sea con fines no comerciales y se otorgue la atribución correspondiente.

- 💻 **Código y scripts** (automatización de instalación):  
  Licenciado bajo la [Licencia MIT](../LICENSE-CODE.txt).

Consulta los archivos `LICENSE-CONTENT.txt` y `LICENSE-CODE.txt` para más detalles.

---

## 👨‍🏫 Autor

<p align="left">
  <a href="https://www.linkedin.com/in/mvzferglez/" target="_blank">
    <img src="../img/fer.png" alt="José Fernando Aguilera González" width="140"
    style="border-circle: 50%"/>
  </a>
</p>

**José Fernando Aguilera González**  
Candidato a Doctor en Medicina de la Conservación  
Docente responsable del curso
📬 [Contáctame por correo](mailto:mvzferglez@gmail.com)

---

> ¿Dudas o errores? Abre un Issue en este repositorio.
