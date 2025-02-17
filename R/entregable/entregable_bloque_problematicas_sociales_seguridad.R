# library(officer)
# library(dplyr)
# 
# path_export <- 
#   encuestar:::formato_archivo(nombre = "./presentaciones/bloque_problematicas_sociales_seguridad", 
#                               extension = "pptx", 
#                               tolerancia = 60)
# 
# pptx <- 
#   read_pptx(path = "./insumos/plantilla_general_09_12_24.pptx")


add_slide(pptx, layout = "gerencia_subportada", master = "gerencia") %>%
  ph_with(value = 'Problemáticas sociales y seguridad',
          location = ph_location_label(ph_label = "titulo")) 

# Principales problemas edomex

add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
  ph_with(value = p_problemas_edomex_graf , 
          location = ph_location_label(ph_label = "imagen_principal")) |>
  ph_with(value = "Principales problemas en el Estado de México",
          location = ph_location_label(ph_label = "titulo"))

# Cruce de percepcion de seguridad contra desempeno del gobierno de delfina gomez
add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
  ph_with(value = aprueba_per_delfina_delincuencia_edomex_graf , 
          location = ph_location_label(ph_label = "imagen_principal")) |>
  ph_with(value = "Niveles de aprobación del gobierno de Delfina Gómez por percepción de seguridad",
          location = ph_location_label(ph_label = "titulo"))

# # Percepción de delincuencia
# add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
#   ph_with(value = p_delincuencia_edomex_graf , 
#           location = ph_location_label(ph_label = "imagen_principal")) |>
#   ph_with(value = "Percepción de la seguridad en el Estado de México",
#           location = ph_location_label(ph_label = "titulo"))
# 
# 
# #Principales delitos
# 
#  add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
#   ph_with(value = p_delito_frecuente_graf , 
#           location = ph_location_label(ph_label = "imagen_principal")) |>
#   ph_with(value = "Delitos de mayor incidencia",
#           location = ph_location_label(ph_label = "titulo"))
 
#Percepcion del delito
add_slide(pptx, layout = "gerencia_dos_graficas_equitativas", master = "gerencia") %>%
  ph_with(value = p_delincuencia_edomex_graf, location = ph_location_label(ph_label = "grafica_uno")) |>
  ph_with(value = p_delito_frecuente_graf, location = ph_location_label(ph_label = "grafica_dos")) |>
  ph_with(value = "Percepción de la seguridad en el Estado de México",
           location = ph_location_label(ph_label = "titulo"))

 

# # Presencia delitos
# add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
#   ph_with(value = p_seguridad_graf, 
#           location = ph_location_label(ph_label = "imagen_principal")) |>
#   ph_with(value = "Personajes publicos",
#           location = ph_location_label(ph_label = "titulo"))
# 
# 
# 
# # Presencia extorcion
# 
# add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
#   ph_with(value = p_extorsion_edomex_graf , 
#           location = ph_location_label(ph_label = "imagen_principal")) |>
#   ph_with(value = "Victimas de extorsión",
#           location = ph_location_label(ph_label = "titulo"))

# Presencia delitos
add_slide(pptx, layout = "gerencia_dos_graficas_equitativas", master = "gerencia") %>%
  ph_with(value = p_seguridad_graf, location = ph_location_label(ph_label = "grafica_uno")) |>
  ph_with(value = p_extorsion_edomex_graf, location = ph_location_label(ph_label = "grafica_dos")) |>
  ph_with(value = "Visibilidad de crímenes en el Estado de México",
          location = ph_location_label(ph_label = "titulo"))




#print(pptx, path_export)
