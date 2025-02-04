
# Bloque Evaluacion de gobierno ---------------------------------------------------------------

# Conocimeinteo personajes 
p_conoce_per_tit <-
  dicc |> 
  filter(grepl(pattern = "conoce_per",
               x = llaves)) |> 
  distinct(pregunta) |> 
  pull() |> 
  stringr::str_wrap(width = 55)

aspectos_conoce_per <-
  dicc |> 
  filter(grepl(pattern = "conoce_per",
               x = llaves)) |> 
  distinct(llaves) |> 
  filter(grepl("claudia|delfina|neza",llaves)) |> 
  pull() |> 
  gsub(pattern = "conoce_per_",
       replacement = "")

colores_conoce_per <- 
  dicc |> 
  filter(grepl(pattern = "conoce_per", x = llaves)) |> 
  distinct(llaves, tema) |> 
  filter(grepl("claudia|delfina|neza",llaves)) |> 
  select(tema) |> 
  asignar_colores()


# Evaluacion de autoridades

# p_aprueba_per_tit <-
#   dicc |> 
#   filter(grepl(pattern = "aprueba_per",
#                x = llaves)) |>
#   filter(!grepl(pattern = "razon",
#                x = llaves)) |>
#   distinct(pregunta) |> 
#   pull() |> 
#   stringr::str_wrap(width = 55)

p_aprueba_per_tit <-
  "¿Usted aprueba o desaprueba el trabajo de (...)? ¿Mucho o poco?"


aspectos_aprueba_per <-
  dicc |> 
  filter(grepl(pattern = "aprueba_per",
               x = llaves)) |>
  filter(!grepl(pattern = "razon",
                x = llaves)) |>
  distinct(llaves) |> 
  filter(!grepl("_mex",llaves)) |> 
  pull() |> 
  gsub(pattern = "aprueba_per_",
       replacement = "")


colores_evaluacion <- 
  c("Aprueba mucho" = color_opinion_muyBuena,
    "Aprueba poco" = color_opinion_buena, 
    "Desaprueba poco" = color_opinion_mala,
    "Desaprueba mucho" = color_opinion_muyMala)


# Confianza en autoridades

p_confia_per_tit <-
  dicc |>
  filter(grepl(pattern = "confia_per",
               x = llaves)) |>
  filter(!grepl(pattern = "razon",
               x = llaves)) |>
  distinct(pregunta) |>
  pull() |>
  stringr::str_wrap(width = 55)


aspectos_confia_per <-
  dicc |> 
  filter(grepl(pattern = "confia_per",
               x = llaves)) |>
  filter(!grepl(pattern = "razon",
                x = llaves)) |>
  distinct(llaves) |> 
  filter(!grepl("_mex",llaves)) |> 
  pull() |> 
  gsub(pattern = "confia_per_",
       replacement = "")


# Aprueba trabajo presidente municipal

p_aprueba_trabajo_pm_tit <-
  dicc |>
  filter(grepl(pattern = "aprueba_trabajo_pm",
               x = llaves)) |>
  filter(!grepl(pattern = "razon",
                x = llaves)) |>
  distinct(pregunta) |>
  pull() |>
  stringr::str_wrap(width = 55)


aspectos_aprueba_trabajo_pm <-
  dicc |> 
  filter(grepl(pattern = "aprueba_trabajo",
               x = llaves)) |>
  filter(!grepl(pattern = "razon",
                x = llaves)) |>
  distinct(llaves) |> 
  pull() |> 
  gsub(pattern = "aprueba_trabajo_",
       replacement = "")


# Proegreso Mexico

p_progeso_mex_tit <- 
  dicc |> 
  filter(grepl(pattern = "progeso_mex",
               x = llaves)) |> 
  distinct(pregunta) |> 
  pull() |> 
  stringr::str_wrap(width = 55)

colores_progeso_mex <- 
  enc_neza$muestra$diseno$variables |>
  as_tibble() |> 
  select(contains("progeso_mex")) |> 
  tidyr::pivot_longer(cols = everything(), 
                      names_to = "pregunta", 
                      values_to = "respuesta") |> 
  na.omit() |> 
  distinct(respuesta) |> 
  asignar_colores()

orden_progreso_mex <- c("Progresando",  "Estancado", "En retroceso", "Ns/Nc" )

# Proegreso Edomex

p_progeso_edomex_tit <- 
  dicc |> 
  filter(grepl(pattern = "progeso_edomex",
               x = llaves)) |> 
  distinct(pregunta) |> 
  pull() |> 
  stringr::str_wrap(width = 55)

colores_progeso_edomex <- 
  enc_neza$muestra$diseno$variables |>
  as_tibble() |> 
  select(contains("progeso_edomex")) |> 
  tidyr::pivot_longer(cols = everything(), 
                      names_to = "pregunta", 
                      values_to = "respuesta") |> 
  na.omit() |> 
  distinct(respuesta) |> 
  asignar_colores()

orden_progreso_edomex <- c("Progresando",  "Estancado", "En retroceso", "Ns/Nc" )


# Proegreso Municipio

p_progeso_municipio_tit <- 
  dicc |> 
  filter(grepl(pattern = "progeso_municipio",
               x = llaves)) |> 
  distinct(pregunta) |> 
  pull() |> 
  stringr::str_wrap(width = 55)

colores_progeso_municipio <- 
  enc_neza$muestra$diseno$variables |>
  as_tibble() |> 
  select(contains("progeso_municipio")) |> 
  tidyr::pivot_longer(cols = everything(), 
                      names_to = "pregunta", 
                      values_to = "respuesta") |> 
  na.omit() |> 
  distinct(respuesta) |> 
  asignar_colores()

# Progreso general

orden_progreso_municipio <- c("Progresando",  "Estancado", "En retroceso", "Ns/Nc" )

colores_progreso <- c(
  "En retroceso" = color_opinion_mala,
  "Estancado" =  color_opinion_regular,
  "Progresando" = color_opinion_buena)


p_progeso_gen_tit <- "¿Cree usted que, en este momento, (...) está: progresando, estancado o en retroceso?" |> 
  stringr::str_wrap(width = 55)
