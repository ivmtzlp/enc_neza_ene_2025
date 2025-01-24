

# Conocimeinteo personajes secundarios 

p_conoce_per2_horacio_tit <-
  dicc |> 
  filter(grepl(pattern = "conoce_per2",
               x = llaves)) |> 
  distinct(pregunta) |> 
  pull() |> 
  stringr::str_wrap(width = 55)



# Opinion de personajes secundarios

p_conocimiento_per2_tit <- 
  dicc |> 
  filter(grepl(pattern = "personajes", 
               x = bloque)) |> 
  filter(grepl(pattern = "opinion_per2_horacio", 
               x = llaves)) |> 
  distinct(pregunta) |> 
  pull(pregunta) 

aspectos_conocimiento_per2 <- 
  dicc |> 
  filter(grepl(pattern = "opinion_per2", 
               x = llaves)) |> 
  filter(!grepl(pattern = "razon",
               x = llaves)) |>
  pull(llaves) |> 
  gsub(pattern = "opinion_per2_",
       replacement = "")

colores_opinion_per2 <- 
  c("Buena" = color_opinion_buena,
    "Regular" = color_opinion_regular,
    "Mala" = color_opinion_mala)


