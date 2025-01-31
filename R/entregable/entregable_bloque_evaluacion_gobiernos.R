# library(officer)
# library(dplyr)
# 
# path_export <- 
#   encuestar:::formato_archivo(nombre = "./presentaciones/bloque_evaluacion_gobierno", 
#                               extension = "pptx", 
#                               tolerancia = 60)
# 
# pptx <- 
#   read_pptx(path = "./insumos/plantilla_general_09_12_24.pptx")


add_slide(pptx, layout = "gerencia_subportada", master = "gerencia") %>%
  ph_with(value = 'Evaluación de Gobiernos',
          location = ph_location_label(ph_label = "titulo")) 

# Conocimeinteo personajes 
 
add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
  ph_with(value = p_conoce_per_graf, 
          location = ph_location_label(ph_label = "imagen_principal")) |>
  ph_with(value = "Personajes públicos",
          location = ph_location_label(ph_label = "titulo"))


# Evaluacion de autoridades

add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
  ph_with(value = p_aprueba_per_graf , 
          location = ph_location_label(ph_label = "imagen_principal")) |>
  ph_with(value = "Aprobación de figuras públicas",
          location = ph_location_label(ph_label = "titulo"))

# Confianza en figuras publicas 

add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
  ph_with(value = p_confia_per_graf , 
          location = ph_location_label(ph_label = "imagen_principal")) |>
  ph_with(value = "Confianza en figuras de gobierno",
          location = ph_location_label(ph_label = "titulo"))

# # Progreso México
# add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
#   ph_with(value = p_progeso_mex_graf , 
#           location = ph_location_label(ph_label = "imagen_principal")) |>
#   ph_with(value = "Percepción del progreso en México",
#           location = ph_location_label(ph_label = "titulo"))
# 
# 
# # Progreso Edomex
# add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
#   ph_with(value = p_progeso_edomex_graf , 
#           location = ph_location_label(ph_label = "imagen_principal")) |>
#   ph_with(value = "Percepción del progreso en el Estado de México",
#           location = ph_location_label(ph_label = "titulo"))
# 
# 
# # Proegreso Municipio
# add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
#   ph_with(value = p_progeso_municipio_graf , 
#           location = ph_location_label(ph_label = "imagen_principal")) |>
#   ph_with(value = "Percepción del progreso municipal",
#           location = ph_location_label(ph_label = "titulo"))


# Progreso general
add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
  ph_with(value = progeso_general_graf , 
          location = ph_location_label(ph_label = "imagen_principal")) |>
  ph_with(value = "Percepción del progreso en en los tres niveles del Estado",
          location = ph_location_label(ph_label = "titulo"))

# print(pptx, path_export)
