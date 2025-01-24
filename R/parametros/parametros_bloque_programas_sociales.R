

# Bloque Programas sociales ---------------------------------------------------------------

# Contar con programas sociales

p_prog_soc_tit <-
  dicc |> 
  filter(grepl(pattern = "prog_soc_",
               x = llaves)) |> 
  distinct(pregunta) |> 
  pull() |> 
  stringr::str_wrap(width = 55)
  

prog_soc_aspectos <- 
  dicc |> 
  filter(grepl(pattern = "Programas Sociales", 
               x = bloque)) |> 
  filter(grepl(pattern = "prog_soc", 
               x = llaves)) |> 
  distinct(llaves) |> 
  pull() |> 
  gsub(pattern = "prog_soc_",
       replacement = "")

color_cuartil_1 <- '#6a104d'
color_cuartil_2 <- '#802e9e'
color_cuartil_3 <- '#8447ff'
color_cuartil_4 <- '#ff8cf2'

colores_cuantiles <- 
  c(color_cuartil_1, color_cuartil_2, color_cuartil_3, color_cuartil_4)

colores_prog_soc <- 
  c("No" = color_opinion_muyMala, 
    "Sí, el entrevistado" = color_cuartil_3,
    "Sí, otro miembro del hogar" = color_cuartil_4,
    "Sí, ambos" = color_cuartil_2)


# Principales programas sociales

p_programa_social_tit <- 
  dicc |> 
  filter(grepl(pattern = "programa_social_",
               x = llaves)) |> 
  distinct(pregunta) |> 
  pull() |> 
  stringr::str_wrap(width = 55)

colores_programa_social <- 
  enc_neza$muestra$diseno$variables |>
  as_tibble() |> 
  select(contains("programa_social_O")) |> 
  tidyr::pivot_longer(cols = everything(), 
                      names_to = "pregunta", 
                      values_to = "respuesta") |> 
  na.omit() |> 
  distinct(respuesta) |> 
  asignar_colores()





