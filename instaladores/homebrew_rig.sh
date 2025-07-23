#!/bin/bash
# Autor: José Fernando Aguilera González
# Fecha de cración: 2025-07-21 
# Última actualización: 2025-07-21
# Requisitos: macOS, conexión a Internet
# Licencia: MIT
# Descripción: Este script instala Homebrew, rig, R, RStudio y pak en un sistema macOS.
# Tema: Instalación de R y RStudio en macOS
# Uso: copia y pega este comando en tu terminal: 
# curl -fsSL https://raw.githubusercontent.com/fherglez501/IVE/main/instaladores/homebrew_rig.sh | bash


# ---------------------------
# DESCRIPCIÓN DEL SCRIPT   
# ---------------------------
# Este script automatiza la instalación de Homebrew, rig, R, pak , RStudio y Git en macOS.
# Incluye detección de arquitectura, configuración del shell y verificación de permisos.
# El flujo de trabajo es el siguiente:
# 1. Solicita confirmación del usuario.
# 2. Verifica permisos de administrador.    
# 3. Detecta arquitectura (arm64 o x86_64)
# 4. Detecta el shell y configura el PATH
# 5. Instala o actualiza Homebrew
# 6. Instala Git si no está presente
# 7. Instala rig con Homebrew
# 8. Instala la última versión de R con rig
# 9. Instala pak desde R
# 10. Instala RStudio Desktop con Homebrew si no está presente
# 11. Imprime sugerencias finales para el usuario

# ---------------------------

echo "💬 Este script instalará Homebrew, rig, R, pak y RStudio Desktop en tu Mac."
read -p "¿Deseas continuar? [s/N]: " resp
if [[ ! "$resp" =~ ^[Ss]$ ]]; then
  echo "❌ Instalación cancelada."
  exit 1
fi

# ---------------------------
# ELEVACIÓN DE PERMISOS
# ---------------------------
# Verificar si el usuario tiene permisos de sudo
# Si no tiene permisos, solicitar contraseña
echo "🔐 Verificando permisos de administrador..."
echo ""
echo "🔐 Se requerirá tu contraseña para continuar."
echo "ℹ️ Es la contraseña de tu usuario en este Mac — la misma que usas para iniciar sesión o instalar aplicaciones."
echo "🛑 No se mostrará nada mientras escribes, eso es normal. Es una medida de seguridad del sistema."
echo ""

if ! sudo -n true 2>/dev/null; then
  sudo -v || { echo "❌ No se pudo obtener permisos de administrador. Abortando."; exit 1; }
fi

# ---------------------------
# DETECTAR ARQUITECTURA
# ---------------------------
ARCH=$(uname -m)
if [ "$ARCH" = "arm64" ]; then
  echo "✅ Apple Silicon (arm64) detectado."
  HOMEBREW_PREFIX="/opt/homebrew"
else
  echo "✅ Intel (x86_64) detectado."
  HOMEBREW_PREFIX="/usr/local"
fi

# ---------------------------
# DETECTAR SHELL
# ---------------------------
SHELL_NAME=$(basename "$SHELL")
if [ "$SHELL_NAME" = "zsh" ]; then
  PROFILE_FILE="$HOME/.zprofile"
elif [ "$SHELL_NAME" = "bash" ]; then
  PROFILE_FILE="$HOME/.bash_profile"
else
  PROFILE_FILE="$HOME/.profile"
  echo "⚠️ Shell no reconocido, se usará ~/.profile por defecto."
fi
echo "📄 Archivo de configuración: $PROFILE_FILE"

# ---------------------------
# INSTALAR HOMEBREW
# ---------------------------
if ! command -v brew &> /dev/null; then
  echo "🍺 Instalando Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$('"$HOMEBREW_PREFIX"'/bin/brew shellenv)"' >> "$PROFILE_FILE"
  eval "$("$HOMEBREW_PREFIX"/bin/brew shellenv)"
else
  echo "✅ Homebrew ya está instalado."
  echo "📦 Ejecutando 'brew update'..."
  brew update
fi

ChatGPT dijo:
Aquí tienes el script completo homebrew_rig.sh actualizado, con la sección de verificación e instalación opcional de Git ya integrada de forma pedagógica y segura. Puedes copiarlo directamente y subirlo a tu repositorio:

bash
Copiar
Editar
#!/bin/bash
# Autor: José Fernando Aguilera González
# Fecha de creación: 2025-07-21 
# Última actualización: 2025-07-23
# Requisitos: macOS, conexión a Internet
# Licencia: MIT
# Descripción: Este script instala Homebrew, rig, R, pak, RStudio y Git en un sistema macOS.
# Curso: Instalación de R y RStudio en macOS
# Uso: copia y pega este comando en tu terminal: 
# curl -fsSL https://raw.githubusercontent.com/fherglez501/IVE/main/instaladores/homebrew_rig.sh | bash

# ---------------------------
# CONFIRMACIÓN INICIAL
# ---------------------------
echo "💬 Este script instalará Homebrew, rig, R, pak, Git y RStudio Desktop en tu Mac."
read -p "¿Deseas continuar? [s/N]: " resp
if [[ ! "$resp" =~ ^[Ss]$ ]]; then
  echo "❌ Instalación cancelada."
  exit 1
fi

# ---------------------------
# ELEVACIÓN DE PERMISOS
# ---------------------------
echo "🔐 Verificando permisos de administrador..."
echo ""
echo "🔐 Se requerirá tu contraseña para continuar."
echo "ℹ️ Es la contraseña de tu usuario en este Mac — la misma que usas para iniciar sesión o instalar aplicaciones."
echo "🛑 No se mostrará nada mientras escribes, eso es normal. Es una medida de seguridad del sistema."
echo ""

if ! sudo -n true 2>/dev/null; then
  sudo -v || { echo "❌ No se pudo obtener permisos de administrador. Abortando."; exit 1; }
fi

# ---------------------------
# DETECTAR ARQUITECTURA
# ---------------------------
ARCH=$(uname -m)
if [ "$ARCH" = "arm64" ]; then
  echo "✅ Apple Silicon (arm64) detectado."
  HOMEBREW_PREFIX="/opt/homebrew"
else
  echo "✅ Intel (x86_64) detectado."
  HOMEBREW_PREFIX="/usr/local"
fi

# ---------------------------
# DETECTAR SHELL
# ---------------------------
SHELL_NAME=$(basename "$SHELL")
if [ "$SHELL_NAME" = "zsh" ]; then
  PROFILE_FILE="$HOME/.zprofile"
elif [ "$SHELL_NAME" = "bash" ]; then
  PROFILE_FILE="$HOME/.bash_profile"
else
  PROFILE_FILE="$HOME/.profile"
  echo "⚠️ Shell no reconocido, se usará ~/.profile por defecto."
fi
echo "📄 Archivo de configuración: $PROFILE_FILE"

# ---------------------------
# INSTALAR HOMEBREW
# ---------------------------
if ! command -v brew &> /dev/null; then
  echo "🍺 Instalando Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$('"$HOMEBREW_PREFIX"'/bin/brew shellenv)"' >> "$PROFILE_FILE"
  eval "$("$HOMEBREW_PREFIX"/bin/brew shellenv)"
else
  echo "✅ Homebrew ya está instalado."
  echo "📦 Ejecutando 'brew update'..."
  brew update
fi

# ---------------------------
# VERIFICAR E INSTALAR GIT
# ---------------------------
echo "🔍 Verificando si Git ya está instalado..."
if command -v git &> /dev/null; then
  GIT_PATH=$(which git)
  GIT_VERSION=$(git --version)
  echo "✅ Git ya está instalado: $GIT_VERSION"
  echo "📍 Ubicación actual: $GIT_PATH"

  if [[ "$GIT_PATH" == "/usr/bin/git" ]]; then
    echo "⚠️ Esta versión de Git proviene de las herramientas de línea de comandos de macOS."
    echo "🔄 Se recomienda instalar Git con Homebrew para obtener actualizaciones y compatibilidad con RStudio."
    read -p "¿Deseas instalar Git con Homebrew de todos modos? [s/N]: " git_resp
    if [[ "$git_resp" =~ ^[Ss]$ ]]; then
      echo "📦 Instalando Git con Homebrew..."
      brew install git
    else
      echo "⏭️ Git no será instalado por Homebrew."
    fi
  else
    echo "👍 Git proviene de Homebrew u otra fuente compatible. No es necesario reinstalarlo."
  fi
else
  echo "📦 Git no está instalado. Procediendo con Homebrew..."
  brew install git
fi

# ---------------------------
# INSTALAR RIG
# ---------------------------
if ! command -v rig &> /dev/null; then
  echo "🚀 Instalando rig..."
  brew tap r-lib/rig
  brew install --cask rig
else
  echo "✅ rig ya está instalado."
fi

# ---------------------------
# INSTALAR R
# ---------------------------
echo "📥 Instalando R con rig..."
rig add release

# ---------------------------
# INSTALAR PAK
# ---------------------------
echo "📦 Verificando si 'pak' está instalado..."
rig system add-pak
rig system make-links   
rig system setup-user-lib  

# ---------------------------
# INSTALAR RSTUDIO
# ---------------------------
echo "🖥️ Verificando instalación de RStudio Desktop..."
if ! [ -d "/Applications/RStudio.app" ]; then
  echo "📥 Instalando RStudio Desktop con Homebrew..."
  brew install --cask rstudio
else
  echo "✅ RStudio ya está instalado."
fi

# ---------------------------
# VERIFICACIÓN FINAL
# ---------------------------
echo -e "\n🧪 Verificación:"
rig --version
R --version
which R
which rig

echo -e "\n🎉 Todo listo: Homebrew, rig, R, pak, RStudio y Git están instalados."
echo "💡 Para futuras sesiones, reinicia tu terminal o ejecuta:"
echo "   source $PROFILE_FILE"
echo "   o simplemente abre una nueva ventana de terminal."
echo "🚀 ¡Disfruta de tu entorno de R en macOS!"
echo "📂 Puedes abrir RStudio o ejecutarlo con una versión específica de R usando:"
echo "   rig rstudio"