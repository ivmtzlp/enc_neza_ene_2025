

# Bloque Desempeno gobernatura ---------------------------------------------------------------


# Desempeno gobierno delfina


p_delfina_tit <-
  dicc |>
  filter(grepl(pattern = "delfina_",
               x = llaves)) |>
  filter(!grepl(pattern = "razon",
                x = llaves)) |>
  distinct(pregunta) |>
  pull() |>
  stringr::str_wrap(width = 55)


aspectos_delfina <-
  dicc |> 
  filter(grepl(pattern = "delfina_",
               x = llaves)) |>
  filter(!grepl(pattern = "razon",
                x = llaves)) |>
  distinct(llaves) |> 
  filter(!grepl("_mex",llaves)) |> 
  pull() |> 
  gsub(pattern = "delfina_",
       replacement = "")


# Satisfación sevicios 

p_satisfacion_tit <-
  dicc |> 
  # filter(grepl(pattern = "Problemáticas sociales", 
  #              x = bloque)) |> 
  filter(grepl(pattern = "satisfacion", 
               x = llaves)) |> 
  distinct(pregunta) |> 
  pull(pregunta) |> 
  stringr::str_wrap(width = 55)

aspectos_satisfacion <- 
  dicc |> 
  # filter(grepl(pattern = "Problemáticas sociales", 
  #              x = bloque)) |> 
  filter(grepl(pattern = "satisfacion", 
               x = llaves)) |> 
  pull(llaves) |> 
  gsub(pattern = "satisfacion_",
       replacement = "")

colores_satisfacion <- 
  c("Muy satisfecho" = color_opinion_muyBuena,
    "Algo satisfecho" = color_opinion_buena,
    "Ni satisfecho, ni insatisfecho" = color_opinion_regular,
    "Algo insatisfecho" = color_opinion_mala,
    "Muy insatisfecho" = color_opinion_muyMala)


# Problemas agua

p_problemas_agua_tit <- 
  dicc |> 
  filter(grepl(pattern = "problemas_agua",
               x = llaves)) |> 
  distinct(pregunta) |> 
  pull() |> 
  stringr::str_wrap(width = 55)

colores_problemas_agua <- 
  enc_neza$muestra$diseno$variables |>
  as_tibble() |> 
  select(contains("problemas_agua")) |> 
  tidyr::pivot_longer(cols = everything(), 
                      names_to = "pregunta", 
                      values_to = "respuesta") |> 
  na.omit() |> 
  distinct(respuesta) |> 
  asignar_colores()

orden_problemas_agua <- c("Todos los días", "Varias veces a la semana", "Rara vez a la semana", "Nunca", "Ns/Nc" )


# Mejora inmediata

p_mejora_servicio_tit <- 
  dicc |> 
  filter(grepl(pattern = "mejora_servicio",
               x = llaves)) |> 
  distinct(pregunta) |> 
  pull() |> 
  stringr::str_wrap(width = 55)

colores_mejora_servicio <- 
  enc_neza$muestra$diseno$variables |>
  as_tibble() |> 
  select(contains("mejora_servicio")) |> 
  tidyr::pivot_longer(cols = everything(), 
                      names_to = "pregunta", 
                      values_to = "respuesta") |> 
  na.omit() |> 
  distinct(respuesta) |> 
  asignar_colores()

