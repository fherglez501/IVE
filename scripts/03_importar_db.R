# directorio ----
# setwd("~/R/Curso_IVE/data/")

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

# Verificar Directorio de Trabajo ---------------------------------
here::here() # Devuelve la ruta raíz del proyecto; útil para no depender de rutas absolutas

# importar_db -----------------------------------------------------

# importar_db -----------------------------------------------------
# Origen datos de "DB"
# https://github.com/fherglez501/MSc-Tesis 
# https://repositorio.una.ac.cr/items/3f545770-4259-480d-b896-a464dd75b629 

db1 <- readxl::read_excel(here::here("data/raw/BD.xlsx"))  # Importa archivo Excel usando readxl
db2 <- readr::read_csv(here::here("data/raw/BD.csv"))      # Importa archivo CSV usando readr
db3 <- rio::import(here::here("data/raw/BD.csv"))          # Importa usando rio, detecta el formato automáticamente
db3.1 <- rio::import(here::here("data/raw/BD.xlsx"))       # Porqué no se ejecuta? → A veces falla si el archivo tiene formatos especiales, hojas vacías o dependencias no resueltas


## google_sheet ---------------------------------------------------
# Vinculo completo: 
# https://repositorio.una.ac.cr/items/3f545770-4259-480d-b896-a464dd75b629 

# buscar archivos por patron con Googledrive y googlesheets4 
googledrive::drive_find(type = "spreadsheet") %>% print(n = Inf)  # Lista todas las hojas de cálculo en tu Google Drive
googlesheets4::gs4_find()  # Muestra las hojas de cálculo disponibles, filtradas por gs4

# descargar_googlesheet por ID
db4 <- googlesheets4::read_sheet("1ePa_xZpZudYQj23Rkq-NR5pUrF0DqA9HY0BCYDn4CO4", sheet = "BDT")  # Lee directamente una hoja específica usando el ID del documento

# descargar_googlesheet por LINK_COMPARTIDO
db5 <- googlesheets4::read_sheet("https://docs.google.com/spreadsheets/d/1ePa_xZpZudYQj23Rkq-NR5pUrF0DqA9HY0BCYDn4CO4/edit?gid=203608864#gid=203608864")
# También es válido usar el enlace completo compartido, siempre que se tenga permiso de lectura

# Descargar una hoja específica de Google Sheets
# Primero se obtiene la metadata del documento completo usando su ID con gs4_get().
# Luego se utiliza read_sheet() para leer únicamente la hoja llamada "BDA".
# Esto es útil cuando el archivo contiene varias hojas y solo se necesita trabajar con una.

db7 <- 
# metadata_googlesheet por ID
googlesheets4::gs4_get(ss = "1ePa_xZpZudYQj23Rkq-NR5pUrF0DqA9HY0BCYDn4CO4")

db8 <- googlesheets4::read_sheet(ss = db7, sheet = "BDA")  # Lee solo la hoja "BDA" desde el objeto con metadata

# importar_manipular_db ----
## tibbles: comprender su importancia para manipular tbl_df | tbl | data.frame
## ver diapositivas en pdf 
## importar_con_janitor ----
db <- # base_datos
  readxl::read_excel(here::here("data/raw/BD.xlsx")) %>% 
  janitor::clean_names() %>% # limpiar_nombres_variables_a_minúsculas
  janitor::remove_empty(c("rows", "cols")) %>% # limpiar_filas_columnas_vacías
  # ¿por qué es diferente la etiqueta de la variable CCu = c_cu de CCL = ccl?
  # realiza las modificaciones pertinentes en el archivo BD.xlsx y 
  # guarda los cambios en el archivo BD.xlsx
  # corre nuevamente el código
  # ahora convertiremos variables character a factor
  dplyr::mutate_at(vars(sexo:sitio, estacion), as.factor) %>% # opción_1
  #dplyr::mutate(across(c(sexo:sitio,estacion), as.factor)) %>% #opción_2
  dplyr::mutate(fecha = lubridate::ymd(fecha)) %>%  # convertir_fecha
  dplyr::mutate(anio = lubridate::year(fecha), 
                mes = lubridate::month(fecha), 
                dia = lubridate::day(fecha)) %>% 
  # separemos la fecha en columnas = añio, mes, dia
  #tidyr::separate(fecha, sep = "-", into = c("anio", "mes", "dia")) %>% 
  dplyr::mutate(dt = lubridate::make_date(
    year = anio, month = mes, day = dia
    ));db

db9 <- # base_datos
  readr::read_csv(file = here::here("data/raw/BD.csv"), # importaremos el archivo separado por comas
  # locale es la configuración regional de nuestro equipo
  # función readr::default_locale() en la ¡¡consola!! nos permite identificarla
                  locale = locale(date_names = "es", decimal_mark = ",")) %>% 
  # más_info_sobre_configuración_regional(locale)_en: 
  # https://es.wikipedia.org/wiki/Configuraci%C3%B3n_regional
  # https://es.wikipedia.org/wiki/Separador_decimal
  janitor::clean_names() %>% # limpiar_nombres_variables_a_minúsculas
  janitor::remove_empty(c("rows", "cols")) %>% # limpiar_filas_columnas_vacías 
  dplyr::mutate_at(vars(sexo:sitio, estacion), as.factor) %>% # opción_1
  #dplyr::mutate(across(c(sexo:sitio,estacion), as.factor)) %>% # opción_2
  dplyr::mutate(fecha = lubridate::dmy(fecha)) %>%  # convertir_fecha 
  # a continuación, ordenaremos los niveles de los factores (categorías) 
  dplyr::mutate(sitio = forcats::fct_relevel(sitio, c("E", "C", "B"))) %>% 
  tidyr::separate(fecha, sep = "-", into = c("anio", "mes", "dia"));db9
    

db10 <- # base_datos 
  #import("BD.csv", format = "csv2", setclass = "tibble") %>% # importar_con_rio 
  import(here::here("data/raw/BD.xlsx")) %>% 
  janitor::clean_names() %>% # limpiar_nombres_variables_a_minúsculas
  janitor::remove_empty(c("rows", "cols")) %>% # limpiar_filas_columnas_vacías
  mutate_at(vars(sexo:sitio, estacion), as.factor) %>% # convertir a factor
  mutate(fecha = lubridate::ymd(fecha)) %>% # convertir a fecha
  # ordenaremos los niveles de los factores (categorías) 
  dplyr::mutate(sitio = forcats::fct_relevel(sitio, c("E", "C", "B"))) %>% 
  rename( # renombrar variables(columnas)
    htc = hematocrito,
    hg  = hemoglobina,
    trm = trombocitos,
    het = heterofilos,
    lin = linfocitos,
    bas = basofilos,
    mon = monocitos,
    eos = eosinofilos,
    pt  = proteinas_totales,
    alb = albumina,
    glb = globulina,
    glu = glucosa,
    col = colesterol,
    au  = acido_urico
  )

# Funciones de agrupación con dplyr
db10 %>% 
  group_by(clase, sexo) %>%
  # filter(!is.na(clase)) %>%
  select(trm) %>% 
  ggplot(aes(trm)) + 
  geom_boxplot(aes(group = clase)) + 
  coord_flip()+ 
  facet_grid( ~ sexo)