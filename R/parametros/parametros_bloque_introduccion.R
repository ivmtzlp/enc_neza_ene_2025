
# Bloque Problematicas temas ---------------------------------------------------------------

# Temas
p_temas_tit <- 
  dicc |> 
  filter(grepl(pattern = "temas",
               x = llaves)) |> 
  distinct(pregunta) |> 
  pull() |> 
  stringr::str_wrap(width = 55)

colores_temas <- 
  enc_neza$muestra$diseno$variables |>
  as_tibble() |> 
  select(contains("temas")) |> 
  tidyr::pivot_longer(cols = everything(), 
                      names_to = "pregunta", 
                      values_to = "respuesta") |> 
  na.omit() |> 
  distinct(respuesta) |> 
  asignar_colores()

colores_temas["Política"] <- color_general_complemento


# MEDIOS DE COMUNICACION
p_medios_com_tit <- 
  dicc |> 
  filter(grepl(pattern = "medios_com_",
               x = llaves)) |> 
  distinct(pregunta) |> 
  pull() |> 
  stringr::str_wrap(width = 55)

colores_medios_com <- 
  enc_neza$muestra$diseno$variables |>
  as_tibble() |> 
  select(contains("medios_com_O")) |> 
  tidyr::pivot_longer(cols = everything(), 
                      names_to = "pregunta", 
                      values_to = "respuesta") |> 
  na.omit() |> 
  distinct(respuesta) |> 
  asignar_colores()


# Redes sociales
p_utiliza_tit <-
  dicc |> 
  filter(grepl(pattern = "utiliza_",
               x = llaves)) |> 
  distinct(pregunta) |> 
  pull() |> 
  stringr::str_wrap(width = 55)

aspectos_utiliza <-
  dicc |> 
  filter(grepl(pattern = "utiliza_",
               x = llaves)) |> 
  distinct(llaves) |> 
  pull() |> 
  gsub(pattern = "utiliza_",
       replacement = "")



