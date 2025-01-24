

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