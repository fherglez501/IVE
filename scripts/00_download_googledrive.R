# Librerias -----
install.packages("tidiverse")
pak::pak("tidyverse")
pak::pak("here")
pak::pak("pacman")
pak::pak("purrr")

# Cargar librerias ----

pacman::p_load(tidyverse, here, googledrive)

# Crear carpeta de descarga -----

dir.create(
  here::here("data/raw"), showWarnings = FALSE, recursive = TRUE
)

# Descarga datos -----
# Ruta completa de la carpeta
# https://drive.google.com/drive/folders/1ld8Hs0csJ9TOjXq8llcmwFGjm1q4jI4d

folder_id_data <- "1ld8Hs0csJ9TOjXq8llcmwFGjm1q4jI4d"

files_in_folder <- 
  googledrive::drive_ls(
    googledrive::as_id(folder_id_data)
  ) 

# Verificamos el contenido completo del OBJETO
files_in_folder

# Accedemos a la columna "id" utilizando "$"
files_in_folder$id

# Descargar todos los archivos
purrr::walk2(
  files_in_folder$id,
  file.path(here::here("data/raw"), files_in_folder$name),
  ~ tryCatch({
      googledrive::drive_download(file = .x, path = .y, overwrite = TRUE)
      message("✅ ", basename(.y), " descargado.")
    }, error = function(e) { })
)

# ADEVERTENCIA: 
# ¿Por qué usamos tryCatch aquí?
# Cuando descargamos varios archivos con walk2(), si uno falla por cualquier motivo (por ejemplo,
# si fue eliminado, tiene permisos restringidos o hay problemas de conexión), R se detiene
# y no descarga los demás archivos.
#
# Con tryCatch, le decimos a R: "Intenta descargar el archivo, y si hay un error, ignóralo
# y continúa con el siguiente." Así el script no se interrumpe y seguimos descargando los demás archivos.