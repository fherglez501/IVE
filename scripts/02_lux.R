
# SCRIPT ----------------------------------------------------------------

# El script es:
# Creamos los objetos de cada archivo de actividad
library(readxl)

Control <- read_excel("Control Actividad.xlsx")
Quince  <- read_excel("Quince Lux Actividad.xlsx")
Treinta <- read_excel("Treinta Lux Actividad.xlsx")
Cuarentaycinco <- read_excel("Cuarentaycinco Lux Actividad.xlsx")
Sesenta <- read_excel("Sesenta Lux Actividad.xlsx")
Setentaycinco <- read_excel("Setentaycinco Lux Actividad.xlsx")

save(
  list = c("Control",
           "Quince",
           "Treinta",
           "Cuarentaycinco",
           "Sesenta",
           "Setentaycinco"),
  file = "data.Rdata"
)

# Crear data frame con los seis objetos
library(dplyr)

Control <- 
  Control %>% # Que tendríamos que hacer para que se eejcute correctamente?
  mutate(Tratamiento = "Control") %>%
  select(Tratamiento, everything())
head(Control)

Quince <- Quince %>%
  mutate(Tratamiento = "Quince_Lux") %>%
  select(Tratamiento, everything())
head(Quince)

Treinta <- Treinta %>%
  mutate(Tratamiento = "Treinta_Lux") %>%
  select(Tratamiento, everything())

Cuarentaycinco <- Cuarentaycinco %>%
  mutate(Tratamiento = "Cuarentaycinco_Lux") %>%
  select(Tratamiento, everything()) 

Sesenta <- Sesenta %>%
  mutate(Tratamiento = "Control") |>
  select(Tratamiento, everything())

Setentaycinco <- Setentaycinco %>%
  mutate(Tratamiento = "Control") |> select(Tratamiento, everything())

df <- dplyr::bind_rows(Control, Quince, Treinta, Cuarentaycinco, Sesenta, Setentaycinco)

summary(df)

# saveRDS(df, "df.rds")

# lubridate ---------------------------------------------------------------
names(df)

# Muestreo de 100 observaciones
df1 <- df |> sample_n(size = 100) 

# R dispone en su paquete base de dos clases específicamente diseñadas para tratar con datos de tipo fecha/hora:
## Date = solo para fechas
## POSITXt = Portable Operating System Interface, la X = Sistema operativo UNIX

# El término POSIX engloba a una colección de estándares de acceso a funciones del sistema operativo
# POSIXt = además de la fecha incluye hora y huso horario. Esta clase contiene dos subclases:
## POSIXct: almacena internamente esta cifra como un número entero
## POSIXlt: almacena las fechas como lista con elementos para los segundos, minutos, horas, día, mes y año.

df1 <- df1  |>
  mutate(
    dt_1 = as.POSIXct(paste(df1$ANO, df1$MES, df1$DIA, df1$HORA, df1$MINUTO,
                            df1$SEGUNDO, sep = " "), format = "%Y %m %d %H %M %S")
    )

# Primero convertimos en el df las columnas de hora, minuto y segundo a formato de fecha y hora
df$hora_min_seg <- as.POSIXct(paste(df$ANO, df$MES, df$DIA, df$HORA, df$MINUTO,
                                    df$SEGUNDO, sep = " "), format = "%Y %m %d %H %M %S")

sum(is.na(df$hora_min_seg))

df$hora_min_seg

# AGREGAMOS columnas para el día y la hora del día
df$dia <- as.numeric(format(df$hora_min_seg, "%j"))
df$hora_dia <- as.numeric(format(df$hora_min_seg, "%H"))

tail(df$dia)
