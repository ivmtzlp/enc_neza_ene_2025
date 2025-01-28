library(officer)
library(dplyr)

path_export <- 
  encuestar:::formato_archivo(nombre = "./presentaciones/entregable_bloque_intencion_voto_gobernador", 
                              extension = "pptx", 
                              tolerancia = 60)

pptx <- 
  read_pptx(path = "./insumos/plantilla_general_09_12_24.pptx")


add_slide(pptx, layout = "gerencia_subportada", master = "gerencia") %>%
  ph_with(value = 'Conocimiento Personajes Secundarios',
          location = ph_location_label(ph_label = "titulo")) 

# Intencion del voto gb 27

add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
  ph_with(value = p_voto_gb_27_graf, 
          location = ph_location_label(ph_label = "imagen_principal")) |>
  ph_with(value = "Perspectivas electorales",
          location = ph_location_label(ph_label = "titulo"))


# Identificacion partidista

add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
  ph_with(value = p_identificacion_partido_graf , 
          location = ph_location_label(ph_label = "imagen_principal")) |>
  ph_with(value = "Preferencia electoral",
          location = ph_location_label(ph_label = "titulo"))



print(pptx, path_export)
