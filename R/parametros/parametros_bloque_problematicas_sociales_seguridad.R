

# Problemas mas importantes

p_problemas_edomex_tit <- 
  dicc |> 
  filter(grepl(pattern = "problemas_edomex_",
               x = llaves)) |> 
  distinct(pregunta) |> 
  pull() |> 
  stringr::str_wrap(width = 55)

colores_problemas_edomex <- 
  enc_neza$muestra$diseno$variables |>
  as_tibble() |> 
  select(contains("problemas_edomex_O")) |> 
  tidyr::pivot_longer(cols = everything(), 
                      names_to = "pregunta", 
                      values_to = "respuesta") |> 
  na.omit() |> 
  distinct(respuesta) |> 
  asignar_colores()


# Percepcion de delincuencia

p_delincuencia_edomex_tit <- 
  dicc |> 
  filter(grepl(pattern = "delincuencia_edomex",
               x = llaves)) |> 
  distinct(pregunta) |> 
  pull() |> 
  stringr::str_wrap(width = 55)


# Problemas mas importantes

p_delito_municipio_tit <- 
  dicc |> 
  filter(grepl(pattern = "delito_municipio",
               x = llaves)) |> 
  distinct(pregunta) |> 
  pull() |> 
  stringr::str_wrap(width = 55)

colores_delito_municipio <- 
  enc_neza$muestra$diseno$variables |>
  as_tibble() |> 
  select(contains("delito_municipio")) |> 
  tidyr::pivot_longer(cols = everything(), 
                      names_to = "pregunta", 
                      values_to = "respuesta") |> 
  na.omit() |> 
  distinct(respuesta) |> 
  asignar_colores()



# Presencia delitos

p_seguridad_tit <-
  dicc |> 
  filter(grepl(pattern = "seguridad",
               x = llaves)) |> 
  distinct(pregunta) |> 
  pull() |> 
  stringr::str_wrap(width = 55)

aspectos_seguridad <-
  dicc |> 
  filter(grepl(pattern = "seguridad",
               x = llaves)) |> 
  distinct(llaves) |> 
  pull() |> 
  gsub(pattern = "seguridad_",
       replacement = "")

colores_seguridad <- 
  dicc |> 
  filter(grepl(pattern = "seguridad", x = llaves)) |> 
  distinct(llaves, tema) |> 
  select(tema) |> 
  asignar_colores()


# Presencia extorcion

p_extorsion_edomex_tit <- 
  dicc |> 
  filter(grepl(pattern = "extorsion_edomex",
               x = llaves)) |> 
  distinct(pregunta) |> 
  pull() |> 
  stringr::str_wrap(width = 55)










