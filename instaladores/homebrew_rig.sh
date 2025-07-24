#!/bin/bash
# Uso: copia y pega este comando en tu terminal (omite el simbolo #): 
# curl -fsSL https://raw.githubusercontent.com/fherglez501/IVE/main/instaladores/homebrew_rig.sh | bash


# ---------------------------
# DESCRIPCIoN DEL SCRIPT   
# ---------------------------
# Este script automatiza la instalacion de Homebrew, rig, R, pak , RStudio y Git en macOS.
# Incluye deteccion de arquitectura, configuracion del shell y verificacion de permisos.
# El flujo de trabajo es el siguiente:
# 1. Solicita confirmacion del usuario.
# 2. Verifica permisos de administrador.    
# 3. Detecta arquitectura (arm64 o x86_64)
# 4. Detecta el shell y configura el PATH
# 5. Instala o actualiza Homebrew
# 6. Instala Git si no esta presente
# 7. Instala rig con Homebrew
# 8. Instala la última version de R con rig
# 9. Instala pak desde R
# 10. Instala RStudio Desktop con Homebrew si no esta presente
# 11. Imprime sugerencias finales para el usuario
# 12. Verifica las instalaciones de rig, R y RStudio
# 13. Imprime un mensaje de éxito final
# ---------------------------

# ---------------------------
# CONFIRMACIoN INICIAL
# ---------------------------

echo "Autor:                MVZ, MSc, PhD(c) JOSE FERNANDO AGUILERA GONZALEZ"
echo "Fecha de creacion:    2025-07-21" 
echo "Última actualizacion: 2025-07-24"
echo "Requisitos:           macOS, conexion a Internet"
echo "Licencia:             MIT"
echo "Descripcion:          Este script instala rig, R, RStudio y pak en un sistema Windows."
echo "Tema:                 Instalacion de R y RStudio"
echo ""
echo "Este script automatiza la instalacion de Homebrew, rig, R, pak, RStudio y Git en macOS."
echo "Incluye deteccion de arquitectura, configuracion del shell y verificacion de permisos."
echo ""
echo " SE OMITEN ACENTOS POR COMPATIBILIDAD "
echo ""
echo "Este script instalara Homebrew, rig, R, pak, Git y RStudio Desktop en tu Mac."
read -p "¿Deseas continuar? [s/N]: " resp
if [[ ! "$resp" =~ ^[Ss]$ ]]; then
  echo "❌ Instalacion cancelada."
  exit 1
fi

# ---------------------------
# ELEVACIoN DE PERMISOS
# ---------------------------
echo " Verificando permisos de administrador..."
echo ""
echo " Se requerira tu contraseña para continuar."
echo " Es el PASSWORD de tu usuario en este Mac — la misma que usas para iniciar sesion o instalar aplicaciones."
echo " No se mostrara nada mientras escribes, eso es normal. Es una medida de seguridad del sistema."
echo ""

if ! sudo -n true 2>/dev/null; then
  sudo -v || { echo " No se pudo obtener permisos de administrador. Abortando."; exit 1; }
fi

# ---------------------------
# DETECTAR ARQUITECTURA
# ---------------------------
ARCH=$(uname -m)
if [ "$ARCH" = "arm64" ]; then
  echo " Apple Silicon (arm64) detectado."
  HOMEBREW_PREFIX="/opt/homebrew"
else
  echo " Intel (x86_64) detectado."
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
  echo " Shell no reconocido, se usara ~/.profile por defecto."
fi
echo " Archivo de configuracion: $PROFILE_FILE"

# ---------------------------
# INSTALAR HOMEBREW
# ---------------------------
if ! command -v brew &> /dev/null; then
  echo " Instalando Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$('"$HOMEBREW_PREFIX"'/bin/brew shellenv)"' >> "$PROFILE_FILE"
  eval "$("$HOMEBREW_PREFIX"/bin/brew shellenv)"
else
  echo " Homebrew ya esta instalado."
  echo " Ejecutando 'brew update'..."
  brew update
fi

# ---------------------------
# VERIFICAR E INSTALAR GIT
# ---------------------------
echo " Verificando si Git ya esta instalado..."
if command -v git &> /dev/null; then
  GIT_PATH=$(which git)
  GIT_VERSION=$(git --version)
  echo " Git ya esta instalado: $GIT_VERSION"
  echo " Ubicacion actual: $GIT_PATH"

  if [[ "$GIT_PATH" == "/usr/bin/git" ]]; then
    echo " Esta version de Git proviene de las herramientas de linea de comandos de macOS."
    echo " Se recomienda instalar Git con Homebrew para obtener actualizaciones y compatibilidad con RStudio."
    read -p "¿Deseas instalar Git con Homebrew de todos modos? [s/N]: " git_resp
    if [[ "$git_resp" =~ ^[Ss]$ ]]; then
      echo " Instalando Git con Homebrew..."
      brew install git
    else
      echo " Git no sera instalado por Homebrew."
    fi
  else
    echo " Git proviene de Homebrew u otra fuente compatible. No es necesario reinstalarlo."
  fi
else
  echo " Git no esta instalado. Procediendo con Homebrew..."
  brew install git
fi

# ---------------------------
# INSTALAR RIG
# ---------------------------
if ! command -v rig &> /dev/null; then
  echo " Instalando rig..."
  brew tap r-lib/rig
  brew install --cask rig
else
  echo " rig ya esta instalado."
fi

# ---------------------------
# INSTALAR R
# ---------------------------
echo " Instalando R con rig..."
rig add release

# ---------------------------
# INSTALAR PAK
# ---------------------------
echo " Verificando si 'pak' esta instalado..."
rig system add-pak
rig system make-links   
rig system setup-user-lib  

# ---------------------------
# INSTALAR RSTUDIO
# ---------------------------
echo " Verificando instalacion de RStudio Desktop..."
if ! [ -d "/Applications/RStudio.app" ]; then
  echo " Instalando RStudio Desktop con Homebrew..."
  brew install --cask rstudio
else
  echo " RStudio ya esta instalado."
fi

# ---------------------------
# VERIFICACIoN FINAL
# ---------------------------
echo -e "\n Verificacion:"
rig --version
R --version
which R
which rig

echo -e "\n Todo listo: Homebrew, rig, R, pak, RStudio y Git estan instalados."
echo "   Para futuras sesiones, reinicia tu terminal o ejecuta:"
echo "   source $PROFILE_FILE"
echo "   o simplemente abre una nueva ventana de terminal con privilegios de Administrador."
echo "   ¡Disfruta de tu entorno de R en macOS!"
echo "   Puedes abrir RStudio o ejecutarlo con una version especifica de R usando:"
echo "   rig rstudio"