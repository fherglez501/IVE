# directorio ----
# setwd("~/direccion/a/tu/carpeta")

# Verificar Directorio de Trabajo ---------------------------------
here::here() # Devuelve la ruta raíz del proyecto; útil para no depender de rutas absolutas

# librerías ----
source(here::here("scripts/00_librerias.R"))

# importar_db ----
db <- # base cruda
  readxl::read_excel(path = here("data/raw/EMA_ANP.xlsx")) %>%  
  janitor::clean_names() %>% 
  janitor::remove_empty(c("rows", "cols")) %>%
  dplyr::mutate(instalacion_en_sitio = lubridate::dmy(instalacion_en_sitio)) %>%
  dplyr::rename(fecha = instalacion_en_sitio) %>% 
  dplyr::mutate(
    anio = lubridate::year(fecha), 
    mes = lubridate::month(fecha), 
    dia = lubridate::day(fecha)
    ) %>% 
  dplyr::mutate_at(vars(altitud_m), as.numeric) %>% 
  dplyr::mutate_at(vars(estado, nombre_2:region, sinap), as.factor) %>% 
  # convertir_coordenadas
  dplyr::mutate(
    latitud_n  = parzer::parse_lat(latitud_n),  # latitud:  N o S 
    longitud_w = parzer::parse_lon(longitud_w)  # longitud: E o W 
    ) %>% 
  dplyr::rename(
    latitud_y  = latitud_n,
    longitud_x = longitud_w,
    altitud_z  = altitud_m
    ) %>% 
  relocate(anio:dia, .after = fecha) %>% 
  glimpse()
summary(db)

# Exportar_dbx ----
## openxlsx::write.xlsx(x = dbx, file = "EMA_01_db.xlsx", overwrite = TRUE)

# EDA ----
# plot_1 ----
## tabla de frecuencias
table(db$estado, db$cat_manejo)
## gráfica de barras
ggplot(db, aes(fct_infreq(estado))) + 
  geom_bar(stat = "count", aes(fill = cat_manejo)) + 
  xlab("") + 
  ylab("") +
  coord_flip() +
  labs(
    title = "Estaciones Meteorológicas Automáticas (EMAS) por \nCategorías de Manejo de las Áreas Naturales Protegidas (ANP) en México",
    caption = "APFF = Áreas de Protección de Fauna y Flora; APRN = Áreas de Protección de Recursos Naturales; PN = Parques Nacionales; MN = Monumentos Naturales \nFuente de Datos: https://smn.conagua.gob.mx/es/observando-el-tiempo/estaciones-meteorologicas-automaticas-ema-s \nhttp://sig.conanp.gob.mx/website/pagsig/listanp/") + 
  theme(
    text = element_text(size = 12,  family = "Sans"), 
    plot.title = element_text(face = "bold", size = 12), # hjust = 0.5
    plot.subtitle = element_text(face = "italic", size = 6), 
    plot.caption = element_text(face = "italic", size = 6), 
    axis.title.x = element_text(margin = margin(t = -1))
  ) + 
  scale_fill_grey(start = 0, end = .9, name = "") +
  theme_classic(base_size = 10) #-> p1
# ggsave("p1.png")

# plot_2 -----
db %>% # 
  ggplot(aes(fct_infreq(estado))) +
  geom_bar(aes(fill = cat_manejo)) +
  xlab("") + 
  ylab("Recuento") +
  labs(
    title = "EMA por Cateogorías de Manejo de las Áreas Naturales Protegidas de México",
    caption = "Fuente de Datos: http://sig.conanp.gob.mx/website/pagsig/listanp/"
    ) + 
  theme(
    text = element_text(size = 10, family = "Sans"), 
    plot.title = element_text(face = "bold", size = 10), # hjust = 0.5
    plot.caption = element_text(face = "italic", size = 6),
    axis.title.x = element_text(margin = margin(t = 1))
    ) + 
  scale_fill_grey(start = 0, end = .9, name = "") + 
  theme_classic(base_size = 8) + 
  coord_flip() # -> p2

# cowplot::plot_grid(p1, p2, labels = c('A', 'B'), label_size = 8)

# plot_3 ----
## tabla_ANP_por_región y categoría_de_manejeo
table(db$region, db$cat_manejo)
## plot_regionalizacion_cat_manejo
ggplot(db, aes(cat_manejo)) + # frequencia por categoría de manejo 
  geom_bar() + # barras
  facet_wrap(~ region) + # agrupar por region
  coord_flip() + # girar barras
  xlab("") + # etiqueta eje x
  ylab("") + # etiqueta eje y
  labs( # título y caption (fuente de los datos)
    title = "Regionalización de EMA por categoría de manejo de las Áreas Naturales Protegidas de México",
    caption = 
      "RB = Reserva de la Biósfera; PN = Parques Nacionales; APRN = Áreas de Protección de Recursos Naturales;APFF = Áreas de Protección de Fauna y Flora; \nFuente de Datos: http://sig.conanp.gob.mx/website/pagsig/listanp/"
    ) +
  theme_classic(base_size = 9)

## tabla_ANP_dentro del_SINAP
table(db$region, db$cat_manejo, db$sinap)
# plot_4----
db %>% # regionalizacion_cat_manejo_SINAP
  filter(sinap != 0) %>% 
  ggplot(aes(cat_manejo)) + # frequencia por categoría de manejo 
  geom_bar() + # barras
  facet_wrap(~ region) + # agrupar por region
  coord_flip() +
  xlab("") + # etiqueta eje x
  ylab("") + # etiqueta eje y
  labs( # título y caption (fuente de los datos)
    title = "EMA por regionalización y categoría de manejo de ANP pertencientes al SINAP",
    subtitle = "Sistema Nacional de Áreas Naturales Protegidas (SINAP)",
    caption = 
      "RB = Reserva de la Biósfera; PN = Parques Nacionales; APRN = Áreas de Protección de Recursos Naturales;APFF = Áreas de Protección de Fauna y Flora; \nFuente de Datos: http://sig.conanp.gob.mx/website/pagsig/listanp/"
  ) +
  theme_classic(base_size = 10)

# resumen----
db %>% 
  filter(sinap !=0) %>% 
  janitor::tabyl(region, cat_manejo) %>%
  #adorn_pct_formatting(digits = 2) %>% 
  arrange(desc(RB))


# Muestreo ----
## Muestro Aleatorio Simple Sin Reemplazo
## base 
sample(1:nrow(db), size = 30, replace = FALSE)
## dplyr
db %>% 
  sample_n(size = 30, replace = FALSE) %>% 
  print(n = Inf)

db %>% 
  sample_n(size = 30, replace = FALSE, weight = cat_manejo) %>% 
  print(n = Inf)

# Filtrando la base de datos 
db %>% 
  filter(sinap !=0) %>% 
  sample_n(size = 30, replace = FALSE) %>% 
  print(n = Inf) -> dbn

