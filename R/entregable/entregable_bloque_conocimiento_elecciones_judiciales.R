# library(officer)
# library(dplyr)
# 
# path_export <- 
#   encuestar:::formato_archivo(nombre = "./presentaciones/entregable_bloque_conocimiento_elecciones_judiciales", 
#                               extension = "pptx", 
#                               tolerancia = 60)
# 
# pptx <- 
#   read_pptx(path = "./insumos/plantilla_general_09_12_24.pptx")


add_slide(pptx, layout = "gerencia_subportada", master = "gerencia") %>%
  ph_with(value = 'Elecciones judiciales',
          location = ph_location_label(ph_label = "titulo")) 


# Conocimeinto de fecha de eleccion


add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
  ph_with(value = p_eleccion_pjn_fecha_graf, 
          location = ph_location_label(ph_label = "imagen_principal")) |>
  ph_with(value = "Fechas de las elecciones judiciales",
          location = ph_location_label(ph_label = "titulo"))


# Intencion de participacion a eleccion

add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
  ph_with(value = p_eleccion_pjn_participacion_graf , 
          location = ph_location_label(ph_label = "imagen_principal")) |>
  ph_with(value = "Intención elecotral",
          location = ph_location_label(ph_label = "titulo"))

# Intencion de participacion a eleccion por temas de interés

add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
  ph_with(value = temas_eleccion_pjn_participacion_graf , 
          location = ph_location_label(ph_label = "imagen_principal")) |>
  ph_with(value = "Intención elecotral por nivel de interés en la política",
          location = ph_location_label(ph_label = "titulo"))

# Intencion de participacion a eleccion por identificacion partidista

add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
  ph_with(value = identificacion_partido_eleccion_pjn_participacion , 
          location = ph_location_label(ph_label = "imagen_principal")) |>
  ph_with(value = "Intención elecotral por identificación partidista",
          location = ph_location_label(ph_label = "titulo"))

#print(pptx, path_export)
