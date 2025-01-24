# Preambulo -----------------------------------------------------------------------------------

library(dplyr)
library(ggplot2)
# library(encuestar)

Sys.setlocale(locale = "es_ES.UTF-8")

devtools::load_all(path = "../encuestar/")
source(file = "./R/pool.R")

# Rutas ---------------------------------------------------------------------------------------

# AZURE
# source(file = "./R/pool.R")

# GOOGLE DRIVE
wd_proyecto_drive = "H:/Shared drives/Morant Consultores/Clientes/CruzPérezCuéllar_Chihuahua/Encuesta/"
path_insumos_drive <- paste0(wd_proyecto_drive, "Insumos/")

# LOCALES
path_api_key <- "Insumos/api-key.json"
link_dicc <- "https://docs.google.com/spreadsheets/d/13SwZM3HU_SjYuODMx4ZxtXHt4FFHBi_p/edit?usp=drive_link&ouid=109752880662829183106&rtpof=true&sd=true"
path_dicc <- "Insumos/dicc_enc_chihuahua_nov2024.xlsx"

# Insumos -----------------------------------------------------------------

#  Cartografía
shp_chih <- readr::read_rds(paste0(path_insumos_drive, "shp.rda"))

# Diseño muestral 
diseno_chih <- readr::read_rds(paste0(path_insumos_drive, "diseño.rda"))

# Clasificaciones electorales
bd_clasificacion_chihuaha <- 
  readxl::read_xlsx(path = "./Insumos/clasificaciones.xlsx") |> 
  transmute(seccion = as.character(as.double(gsub(pattern = '08_', 
                                                  replacement = "", 
                                                  x = seccion))), 
            clasificacionGS = case_when(clasificacionGS == "Perdidas" ~ "Competitivas",
                                        clasificacionGS == "Competitivas" ~ "Voto Blando",
                                        T ~ clasificacionGS))

# Incluir clasifiacion electoral
diseno_chih$poblacion$marco_muestral <- 
  diseno_chih$poblacion$marco_muestral |> 
  left_join(bd_clasificacion_chihuaha, 
            by = c("SECCION" = "seccion")) 

# Actualizar diccionario desde el drive
# googledrive::drive_auth(path = path_api_key)
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
  filter(llaves!='otro_ocupacion') |> 
  filter(bloque != "Sitema") |> 
  filter(!grepl("otro_",llaves)) |>   
  filter(!grepl("segundo_candidato_gb_27",llaves)) |>   
  filter(!grepl("_loera",llaves))   

# Data raw ------------------------------------------------------------------------------------

cuestionario_opinometro <-
  encuestar:::Opinometro$new(id_cuestionarioOpinometro = 199,
                             pool = pool)

bd_respuestas_campo <-
  openxlsx2::read_xlsx(file = "./data-raw/respuestas_campo_hermosillo_agosto.xlsx", na.strings = "-1") |>
  as_tibble() |>
  filter(!Srvyr %in% c("test", "Katheryn Hernandez")) |>
  mutate(SECCION = as.character(as.numeric(cluster)))

id_pruebas <- 
  c(2762838, 2762846, 2762849, 2762851, 2762852, 2762853, 2762854, 2762855)

variables_cuestionario <-
  dicc |> 
  pull(llaves)

bd_respuestas <- 
  cuestionario_opinometro$bd_respuestas_raw |> 
  rename(opinion_per1_cruz = opinion_cruz, 
         opinion_per1_andrea = opinion_andrea,
         razonopinion_per1_cruz = razonopinion_cruz ,
         razonopinion_per1_andrea = razon_opinion_andrea) |> 
  transmute(SbjNum = Id,
            edad,
            sexo,
            Date = lubridate::as_datetime(FechaInicio, tz = "America/Mexico_City"),
            Srvyr = paste(Nombre, APaterno, AMaterno, sep = " "),
            VStart = lubridate::as_datetime(FechaInicio, tz = "America/Mexico_City"),
            VEnd = lubridate::as_datetime(FechaFin, tz = "America/Mexico_City"),
            Duration = as.character(difftime(VEnd, VStart, units = "hours")),
            across(all_of(variables_cuestionario)),
            across(starts_with("intento")),
            cluster,
            SECCION = as.character(as.numeric(cluster))) 

temporal <- 
  cuestionario_opinometro$bd_respuestas_raw |> 
  mutate(across(.cols =  starts_with("gps"), 
                .fns = ~ gsub(pattern = "Ubicación actual: ",
                              replacement = "",
                              x = .x)),
         across(.cols =  starts_with("gps"), 
                .fns = ~ gsub(pattern = "Longitud: ",
                              replacement = "",
                              x = .x)),
         across(.cols =  starts_with("gps"), 
                .fns = ~ gsub(pattern = "Latitud  ",
                              replacement = "",
                              x = .x)))

ubicacion_limpia <- 
  paste0(seq.int(from = 1, to = 15, by = 1)) %>%
  purrr::map_df(.x = ., 
                .f = ~ temporal |> 
                  select(Id, paste0("gps", .x)) |> 
                  tidyr::separate(col = paste0("gps", .x),
                                  into = c(paste0("GPS_INT", .x, "_LA"), 
                                           paste0("GPS_INT", .x, "_LO")),
                                  sep = ", ",
                                  remove = TRUE) 
  ) |> 
  tidyr::pivot_longer(cols = !Id, 
                      names_to = "variable", 
                      values_to = "value") |>  
  filter(!is.na(value)) |> 
  tidyr::pivot_wider(id_cols = Id, 
                     names_from = variable, 
                     values_from = value)

bd_respuestas_test <- 
  bd_respuestas |> 
  rename_with(.fn = ~ gsub(pattern = "intento",
                           replacement = "INT", .x)) |>
  left_join(ubicacion_limpia, by = c("SbjNum" = "Id")) |> 
  select(!INTs) |> 
  mutate(across(.cols = starts_with("GPS"),
                .fns = ~ as.numeric(.x))) |> 
  mutate(edad = as.numeric(edad),
         sexo = dplyr::if_else(condition = sexo == 'Mujer',
                               true = "F",
                               false = "M"))

# Clase ---------------------------------------------------------------------------------------

# enc_chih <-
#   Encuesta$new(# respuestas = FALSE,
#                n_simulaciones = 50,
#                muestra = diseno_chih,
#                cuestionario = dicc,
#                # auditoria_telefonica = tibble(SbjNum = c(""),
#                #                               razon = c("")),
#                shp = shp_chih,
#                # tipo_encuesta = "ine",
#                # mantener_falta_coordenadas = F,
#                # quitar_vars = c(),
#                sin_peso = F,
#                rake = T, ######### con postestratificacion
#                patron = "\\(No leer\\)| \\(No leer\\)|\\(ROTAR\\)|\\(No leer)|:")

enc_chih <- 
  Encuesta$new(respuestas = bd_respuestas_test |> 
                 filter(!is.na(SECCION)) |> 
                 filter(!is.na(edad)) |> 
                 filter(17 < edad),
               #n_simulaciones = 50, 
               muestra = diseno_chih,
               cuestionario = dicc, 
               auditoria_telefonica = tibble(SbjNum = c(""), 
                                             razon = c("")),
               shp = shp_chih, 
               tipo_encuesta = "ine",
               mantener_falta_coordenadas = F, 
               quitar_vars = c(),
               sin_peso = F,
               rake = T, ######### con postestratificacion
               patron = "\\(No leer\\)| \\(No leer\\)|\\(ROTAR\\)|\\(No leer)|:")

options(survey.lonely.psu="remove")

source('./R/constantes.R')
source('./R/funciones.R')

# enc_chih$Auditoria$run_app()