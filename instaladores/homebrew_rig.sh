#!/bin/bash
# Script de instalación de Homebrew + rig + R + pak en macOS
# Autor: Fer, curso Ciencia de Datos con R
# Uso: curl -fsSL https://raw.githubusercontent.com/fherglez501/IVE/main/instaladores/homebrew_rig.sh | bash

echo "💬 Este script instalará Homebrew, rig, R y pak en tu Mac."
read -p "¿Deseas continuar? [s/N]: " resp
if [[ ! "$resp" =~ ^[Ss]$ ]]; then
  echo "❌ Instalación cancelada."
  exit 1
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
echo "📄 Archivo de configuración detectado: $PROFILE_FILE"

# ---------------------------
# INSTALAR HOMEBREW
# ---------------------------
if ! command -v brew &> /dev/null; then
  echo "🍺 Instalando Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$('"$HOMEBREW_PREFIX"'/bin/brew shellenv)"' >> "$PROFILE_FILE"
  eval "$("$HOMEBREW_PREFIX"/bin/brew shellenv)"
else
  echo "✅ Homebrew ya está instalado."
fi

# ---------------------------
# INSTALAR RIG
# ---------------------------
if ! command -v rig &> /dev/null; then
  echo "🚀 Instalando rig con Homebrew..."
  brew tap r-lib/rig
  brew install --cask rig
else
  echo "✅ rig ya está instalado."
fi

# ---------------------------
# INSTALAR R (última versión estable)
# ---------------------------
echo "📦 Instalando R con rig..."
rig add release

# ---------------------------
# INSTALAR PAK
# ---------------------------
echo "📦 Verificando si 'pak' está instalado..."
Rscript -e "if (!requireNamespace('pak', quietly = TRUE)) install.packages('pak', repos = 'https://cloud.r-project.org')"

# ---------------------------
# VERIFICACIÓN FINAL
# ---------------------------
echo "🧪 Verificación:"
rig --version
R --version
which R
which rig

echo -e "\n🎉 Todo listo: Homebrew, rig, R y pak están instalados."
echo "💡 Para futuras sesiones, reinicia tu terminal o ejecuta:"
echo "   source $PROFILE_FILE"
echo "   o simplemente abre una nueva ventana de terminal."
echo "🚀 ¡Disfruta de tu entorno de R en macOS!"