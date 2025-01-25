
# Bloque Conocimiento elecciones judiciales ---------------------------------------------------------------

# Conocimeinto de fecha de eleccion

p_eleccion_pjn_fecha_tit <- 
  dicc |> 
  filter(grepl(pattern = "eleccion_pjn_fecha",
               x = llaves)) |> 
  distinct(pregunta) |> 
  pull() |> 
  stringr::str_wrap(width = 55)

colores_eleccion_pjn_fecha <- 
  enc_neza$muestra$diseno$variables |>
  as_tibble() |> 
  select(contains("eleccion_pjn_fecha")) |> 
  tidyr::pivot_longer(cols = everything(), 
                      names_to = "pregunta", 
                      values_to = "respuesta") |> 
  na.omit() |> 
  distinct(respuesta) |> 
  asignar_colores()

orden_eleccion_pjn_fecha <- c("1 junio 2025", "En junio 2025", "En este año, 2025", "No sabe" )



# Intencion de participacion a eleccion

p_eleccion_pjn_participacion_tit <- 
  dicc |> 
  filter(grepl(pattern = "eleccion_pjn_participacion",
               x = llaves)) |> 
  distinct(pregunta) |> 
  pull() |> 
  stringr::str_wrap(width = 55)

colores_eleccion_pjn_participacion <- 
  enc_neza$muestra$diseno$variables |>
  as_tibble() |> 
  select(contains("eleccion_pjn_participacion")) |> 
  tidyr::pivot_longer(cols = everything(), 
                      names_to = "pregunta", 
                      values_to = "respuesta") |> 
  na.omit() |> 
  distinct(respuesta) |> 
  asignar_colores()

orden_eleccion_pjn_participacion <- c("Sí, definitivamente votaré", "Probablemente votaré", 
                              "No, definitivamente no votaré", "Ns/Nc" )

