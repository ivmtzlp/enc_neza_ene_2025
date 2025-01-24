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

link_dicc <- "https://docs.google.com/spreadsheets/d/1cNcfNgkLEV42k7QYc62dnmfNdPmCEofn/edit?usp=drive_link&ouid=107325048037311002262&rtpof=true&sd=true"
path_dicc <- "Insumos/diccionario_edomex_enero_2025.xlsx"

link_eliminadas <- "https://docs.google.com/spreadsheets/d/1gWPqb48NvoMz11_L_invde4RmbrQmZyMsj4t5wWY4Hg/edit?gid=0#gid=0"
path_eliminadas <- "data-raw/bd_eliminadas_enc_edomex_general_ene_2025.xlsx"


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

# Actualizacion diccionario
# googledrive::drive_auth(path = path_api_key)
# 2
# googledrive::drive_download(file = link_dicc,
#                             path = path_dicc,
#                             overwrite = T)

dicc <- 
  readxl::read_excel(path = path_dicc) |> 
  filter(!grepl(pattern = "Registro", x = bloque)) |>
  # filter(grepl(pattern = "Filtros", x = bloque)) |>
  filter(!llaves %in% c("vivienda", "ine")) |> 
  mutate(tema = gsub(pattern = "NA", replacement = NA, x = tema),
         tema = gsub(pattern = "NANA", replacement = NA, x = tema),
         tema = if_else(is.na(tema), NA_character_, tema),
         tema = stringr::str_trim(string = tema, side = "both"),
         respuestas = stringr::str_split(respuestas, "_")) |>
  filter(!grepl('programa_social_O',llaves)) |> 
  filter(!grepl('problemas_edomex_O',llaves)) |> 
  filter(bloque != "Sitema") |> 
  mutate(llaves =  gsub("demo_","",llaves)) |> 
  mutate(llaves =  gsub("amai_jefe","jefe_grado",llaves),
         llaves =  gsub("amai_wc","cantidad_wc",llaves),
         llaves =  gsub("amai_autos","cantidad_autos",llaves),
         llaves =  gsub("amai_internet","internet",llaves),
         llaves =  gsub("amai_trabajo","trabajo",llaves),
         llaves =  gsub("amai_cuartos","cantidad_cuartos",llaves)
  ) |> 
  filter(llaves!='ocupacion_otro') |> 
  mutate(llaves = gsub("conoce_per_ ","conoce_per_",llaves) ) |> 
  mutate(llaves = gsub("medios_com_o","medios_com_O",llaves) ) |> 
  mutate(llaves = gsub("problemas_edomex_o","problemas_edomex_O",llaves) ) |> 
  mutate(llaves = gsub("programa_social_o","programa_social_O",llaves) )
#        respuestas = gsub(pattern = "\\(No leer\\)| \\(No leer\\)|\\(ROTAR\\)|\\(No leer)|:",
#                                   replacement = "",
#                                   x = respuestas))

# Data raw ------------------------------------------------------------------------------------

# Respuestas
bd_respuestas_campo <-
  readxl::read_excel(path = './data-raw/bd_respuestas_enc_neza_ene_2024.xlsx')

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
googledrive::drive_auth(path = path_api_key)
2
googledrive::drive_download(file = link_eliminadas,
                            path = path_eliminadas,
                            overwrite = T)

bd_eliminadas <-
  readxl::read_xlsx(path = path_eliminadas) |>
  transmute(SbjNum = ID,
            razon = Observaciones)

# bd_eliminadas <- tibble(SbjNum = c(000),
#                         razon = c("A"))

# Clase ---------------------------------------------------------------------------------------

enc_neza <- 
  Encuesta$new(respuestas = bd_respuestas_campo,
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


copiar_archivos_con_nombre_modificado(origen = "./auditoria/data/",
                                      destino = "C:/Users/ivans/GitHub/audit_general_edomex_2025/auditoria/data",
                                      string_agregar = "neza"
                                        )

source(file = './R/revisar_cuotas.R')


# enc_neza$Auditoria$run_app()

# source("./R/entregable_press_general.R")

# enc_neza$error_muestral_maximo(quitar_patron = c("medios_com_O",
#                                                  "otro_",
#                                                  "opinion_",
#                                                  "per2_",
#                                                  "razonopinion_"))
