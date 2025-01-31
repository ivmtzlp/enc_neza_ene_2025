# library(officer)
# library(dplyr)
source(file = "./R/cruces/cruce_sexo_generacion_horacio.R")

# path_export <-
#   encuestar:::formato_archivo(nombre = "./presentaciones/entregable_bloque_conocimiento_personaje",
#                               extension = "pptx",
#                               tolerancia = 60)
# 
# pptx <-
#   read_pptx(path = "./insumos/plantilla_general_09_12_24.pptx")


add_slide(pptx, layout = "gerencia_subportada", master = "gerencia") %>%
  ph_with(value = 'Conocimiento Personajes',
          location = ph_location_label(ph_label = "titulo")) 

# # Conocimeinteo personajes secundarios 
# 
# 
# add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
#   ph_with(value = p_conoce_per2_horacio_graf, 
#           location = ph_location_label(ph_label = "imagen_principal")) |>
#   ph_with(value = "Visibilidad pública de Horacio Duarte",
#           location = ph_location_label(ph_label = "titulo"))
# 
# # Calificacion de personajes 
# 
#  
# add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
#   ph_with(value = p_opinion_per2_graf, 
#           location = ph_location_label(ph_label = "imagen_principal")) |>
#   ph_with(value = "Percepción pública de Horacio Duarte",
#           location = ph_location_label(ph_label = "titulo"))


# Conocimeinteo personajes secundarios 
add_slide(pptx, layout = "gerencia_dos_graficas_equitativas", master = "gerencia") %>%
  ph_with(value = p_conoce_per2_horacio_graf, location = ph_location_label(ph_label = "grafica_uno")) |>
  ph_with(value = p_opinion_per2_graf, location = ph_location_label(ph_label = "grafica_dos")) |>
  ph_with(value = "Visibilidad y percepción pública de Horacio Duarte",
          location = ph_location_label(ph_label = "titulo"))

#conocimiento genero sexo


add_slide(pptx, layout = "gerencia_dos_graficas_equitativas", master = "gerencia") %>%
  ph_with(value = p_conoce_per2_horacio_graf_sexo_generacion, 
          location = ph_location_label(ph_label = "imagen_principal")) |>
  ph_with(value = "Conocimiento de Horacio Duarte por sexo y generación",
          location = ph_location_label(ph_label = "titulo"))

# print(pptx, path_export)
