# librerías ----
# garantiza que instales el paquete "pacman"
if (!require("pacman")) install.packages("pacman")
if (!require("pak")) install.packages("pak")

# Colección de paquetes "easystats"
# https://github.com/easystats/easystats
# https://easystats.github.io/blog/posts/easystats_threeyears/
# install.packages("easystats", repos = "https://easystats.r-universe.dev")

pkgs <- c(
  "tidyverse", # ecosistema_importar_transformar_manipular_explorar_visualizar
  # paquetes que conforman el ecosistema de tidyverse
    # ggplot2:   sistema para crear gráficos
    # dplyr:     gramática de manipulación de datos; conjunto de verbos
    # tidyr:     funciones que ayudan a obtener datos ordenados
    # readr:     leer datos rectangulares (csv, tsv, fwf)
    # purrr:     programación funcional para funciones y vectores
    # tibble:    marcos de datos <tbl_df>
    # stringr:   trabajar con cadenas de texto
    # forcats:   resuelve problemas con factores
    # lubridate: para fechas y horas
  "here",          # trabaja_con_rutas_relativas
  "readxl",        # importar_excel
  "rio",           # importar_diferentes_formatos
  "googledrive",   # interfaz_googledrive
  "googlesheets4", # interfaz_googlesheets
  "janitor",       # limpieza_examinar_tablas_datos
  "gtsummary",     # estadísticas_cuadros_descriptivos_para_publicación
  "rstatix",       # pruebas_resúmenes_estadísticos
  "easystats",     # ecosistema_modelado_visualización_informes
  # paquetes que conforman el ecosistema de easystats
    # insight:      extraer información sobre modelos estadísticos.
    # datawizard:   manipulación de datos, similar a tidyverse
    # bayeststR:    herramientas para manipular y visualizar modelos bayesianos
    # effecsize:    calcular tamaños de efectos
    # correalation: computa y visualiza correlaciones
    # modelbased:   predicciones de modelos
    # performance:  analiza y prueba el rendimiento de los modelos estadísticos
    # see:          visualización, interactúa con ggplot2
    # report:       automatización de informes con resultados de los análisis
  "cowplot",       # combinar_gráficas
  "patchwork",     # combinar_múltiples_gráficos
  "RColorBrewer",  # escalas_colores
  "ggnewscale",    # capas_adicionales_color
  "parzer"         # convertir_coordenadas   
  )

# instalar paquetes -----------------------------------------------
pak::pak(pkgs) # pak = instala los paquetes rápido

# caragar paquetes ------------------------------------------------
pacman::p_load(char = pkgs) # pacman = instala y carga, en este caso
# como ya estan instalados, unicamente los cargará