

# Bloque Intención de voto a Gobernador ---------------------------------------------------------------

# Intencion del voto gb 27

p_voto_gb_27_tit <-
  dicc |> 
  filter(grepl(pattern = "voto_gb_27", x = llaves)) |> 
  distinct(pregunta) |> 
  pull() |> 
  stringr::str_wrap(width = 65)

colores_voto_gb_27 <- 
  enc_neza$muestra$diseno$variables |>
  as_tibble() |> 
  select(contains("voto_gb_27")) |> 
  select(-contains("otro")) |> 
  tidyr::pivot_longer(cols = everything(), 
                      names_to = "pregunta", 
                      values_to = "respuesta") |> 
  na.omit() |> 
  distinct(respuesta) |> 
  asignar_colores()

##########################3


# Identificacion partidista

p_identificacion_partido_tit <-
  dicc |> 
  filter(grepl(pattern = "identificacion_partido", x = llaves)) |> 
  distinct(pregunta) |> 
  pull() |> 
  stringr::str_wrap(width = 65)


colores_identificacion_partido <- 
  dicc |> 
  filter(grepl(pattern = "identificacion_partido", x = llaves)) |> 
  select(respuestas) |> 
  #mutate(respuestas =  stringr::str_split(pattern = '_',respuestas)) |> 
  unnest(respuestas) |> 
  as_tibble() |> 
  asignar_colores()
