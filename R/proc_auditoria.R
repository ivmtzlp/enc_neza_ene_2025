# Preambulo -----------------------------------------------------------------------------------

library(dplyr)
library(ggplot2)
# library(encuestar)

Sys.setlocale(locale = "es_ES.UTF-8")

devtools::load_all(path = "../encuestar/")

# Rutas ---------------------------------------------------------------------------------------

# GOOGLE DRIVE
wd_proyecto_drive = "H:/Shared drives/Morant Consultores/Clientes/CesarFaz_EdoMex/Encuesta/2025/Enero/Muestra/"
edo_name <- "Nezahualcoyotl"
path_insumos_drive <- paste0(wd_proyecto_drive,edo_name,"/Insumos/")

# LOCALES
path_api_key <- "Insumos/api-key.json"

link_dicc <- "https://docs.google.com/spreadsheets/d/1VC7w2uzfcQQYlssqXx0Vk7q6phteZNvUV1gXlic4FmU/edit?usp=drive_link"
path_dicc <- "Insumos/dicc_enc_chihuahua_nov2024_ori.xlsx"

# link_eliminadas <- "https://docs.google.com/spreadsheets/d/1pMo1l0_xUJrP6kKKrCeJ0pNGmm-ZMs_p/edit?gid=812542906#gid=812542906"
path_eliminadas <- "./data-raw/bd_eliminadas_enc_chih_dic_2024.xlsx"


# link_aprobadas_cluster_esp <- "https://docs.google.com/spreadsheets/d/191P8zSSi0PLW_QGsOilLREEYSnHNodDz/edit?usp=drive_link&ouid=107325048037311002262&rtpof=true&sd=true"
# path_aprobadas_cluster_esp <- "data-raw/bd_aprobadas_clusterEspecificos.xlsx"

# entrevistadores_eliminados<- c()
# Insumos -----------------------------------------------------------------

#  Cartografía
shp_neza <- readr::read_rds(paste0(path_insumos_drive, "shp.rda"))

# Diseño muestral 
diseno_neza <- readr::read_rds(paste0(path_insumos_drive, "diseño.rda"))

# # Clasificaciones electorales
# bd_clasificacion_nezaapan <- 
#   readxl::read_xlsx(path = "./Insumos/clasificaciones.xlsx") |> 
#   transmute(seccion = as.character(as.double(gsub(pattern = '08_', 
#                                                   replacement = "", 
#                                                   x = seccion))), 
#             clasificacionGS = case_when(clasificacionGS == "Perdidas" ~ "Competitivas",
#                                         clasificacionGS == "Competitivas" ~ "Voto Blando",
#                                         T ~ clasificacionGS)) 
# 
# # Incluir clasifiacion electoral
# diseno_neza$poblacion$marco_muestral <- 
#   diseno_neza$poblacion$marco_muestral |> 
#   left_join(bd_clasificacion_nezaapan, by = c("SECCION" = "seccion")) 



dicc <- 
  readxl::read_excel(path = path_dicc)  |> 
  as_tibble() 

# Data raw ------------------------------------------------------------------------------------

# Respuestas
bd_respuestas_campo <-
  #openxlsx2::read_xlsx(file = "./data-raw/bd_respuestas_enc_neza_ene_2024.xlsx", na.strings = "-1") |>
  openxlsx2::read_xlsx(file = "./data-raw/bd_respuestas_enc_edomex_gen_ene_2024.xlsx", na.strings = "-1") |>
  as_tibble()  |>
  mutate(SbjNum   = as.numeric(SbjNum)) |> 
  filter(mun == "NEZAHUALCOYOTL") |> 
  mutate(SECCION = as.character(as.numeric(cluster)))

# CATEGORIAS
# 
# source(file = "./R/bds_categeorias_procesadas.R")
# 
# bd_categorias_procesada <- 
# bd_categorias_procesada |> 
#   distinct(id,.keep_all = T)
# 
# bd_respuestas_campo <- 
#   bd_respuestas_campo |> 
#   left_join(bd_categorias_procesada,
#             by = c("SbjNum" = "id"))

# Eliminar entrevistador

# bd_respuestas_campo <- 
#   bd_respuestas_campo |> 
#   filter(!Srvyr %in% entrevistadores_eliminados) 

# Entrevistas especificas aprobadas
# googledrive::drive_auth(path = path_api_key)
# googledrive::drive_download(file = link_aprobadas_cluster_esp,
#                             path = path_aprobadas_cluster_esp,
#                             overwrite = T)

# bd_aprobadas_cluster_esp <- 
#   readxl::read_xlsx(path = path_aprobadas_cluster_esp) |> 
#   rename(SbjNum = ID) |> 
#   mutate(SECCION = as.character(Cluster))
# 
# aprobadas_cluster<-bd_respuestas_campo |> 
#   filter(SbjNum %in% bd_aprobadas_cluster_esp$SbjNum)


# base_1515<- readxl::read_xlsx('./data-raw/base_nezauahua_1515.xlsx')
# base_1515 |> 
#   filter(SECCION %in% bd_aprobadas_cluster_esp$SECCION) |> 
#   filter(!SbjNum %in% bd_aprobadas_cluster_esp$SbjNum) |> 
#   select(SbjNum ) |> 
#   writexl::write_xlsx(path = './data-raw/bd_Subjnum_elim.xlsx')
# 
# bd_respuestas_campo <-
#   bd_respuestas_campo |> 
#   filter(!SECCION %in% bd_aprobadas_cluster_esp$SECCION  ) |> 
#   bind_rows(aprobadas_cluster)

# Subjnum_elim<-readxl::read_xlsx('./data-raw/bd_Subjnum_elim.xlsx')
# 
# bd_respuestas_campo <-
#   bd_respuestas_campo |>
#   filter(!SbjNum %in% Subjnum_elim$SbjNum) 
# 
# # Eliminadas
# googledrive::drive_auth(path = path_api_key)
# 2
# googledrive::drive_download(file = link_eliminadas,
#                             path = path_eliminadas,
#                             overwrite = T)
# 
 # bd_eliminadas <-
 #   readxl::read_xlsx(path = path_eliminadas) |>
 #   transmute(SbjNum = ID,
 #             razon = Observaciones)

bd_eliminadas <- tibble(SbjNum = c("000"),
                     razon = c("A"))


# Clase ---------------------------------------------------------------------------------------

enc_neza <- 
  Encuesta$new(respuestas = bd_respuestas_campo |> 
                 mutate(SbjNum = as.numeric(SbjNum)),
               muestra = diseno_neza,
               cuestionario = dicc, 
               auditoria_telefonica = bd_eliminadas,
               shp = shp_neza, 
               tipo_encuesta = "ine",
               mantener_falta_coordenadas = F, 
               quitar_vars = c(), 
               #auditar = c("voto_gb_27", "conoce_per1_cruz", "conoce_per1_andrea"),
               # vars_tendencias = c("voto_gb_27", "conoce_per1_andrea"),
               sin_peso = F,
               rake = T, ######### con postestratificacion
               patron = "\\(No leer\\)| \\(No leer\\)|\\(ROTAR\\)| \\(no leer)|\\(No leer)|:")

options(survey.lonely.psu="remove")

source('./R/constantes.R')
source('./R/funciones.R')

# source("./R/Entregable_de_avances_nezauahua.R")

# file.copy(from = "./R/app_temporal.R", to = "./auditoria/app.R", overwrite = TRUE)


# enc_neza$Auditoria$run_app()

copiar_archivos_con_nombre_modificado(origen = "./auditoria/data/",
                                      destino = "C:/Users/ivans/GitHub/audit_general_edomex_2025/auditoria/data",
                                      string_agregar = "neza"
)

# source("./R/entregable_press_general.R")

# enc_neza$error_muestral_maximo(quitar_patron = c("medios_com_O",
#                                                  "otro_",
#                                                  "opinion_",
#                                                  "per2_",
#                                                  "razonopinion_"))
