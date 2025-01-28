library(officer)
library(dplyr)

path_export <- 
  encuestar:::formato_archivo(nombre = "./presentaciones/introduccion", 
                              extension = "pptx", 
                              tolerancia = 60)

pptx <- 
  read_pptx(path = "./insumos/plantilla_general_09_12_24.pptx")


add_slide(pptx, layout = "gerencia_subportada", master = "gerencia") %>%
  ph_with(value = 'Conocimiento Personajes Secundarios',
          location = ph_location_label(ph_label = "titulo")) 

# Temas
add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
  ph_with(value = p_temas_graf, 
          location = ph_location_label(ph_label = "imagen_principal")) |>
  ph_with(value = "Temas de interés de la población encuestada",
          location = ph_location_label(ph_label = "titulo"))


# MEDIOS DE COMUNICACION
add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
  ph_with(value = p_medios_com_graf, 
          location = ph_location_label(ph_label = "imagen_principal")) |>
  ph_with(value = "Principales medios de comunicación consultados",
          location = ph_location_label(ph_label = "titulo"))

# Redes sociales


add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
  ph_with(value = p_utiliza_graf, 
          location = ph_location_label(ph_label = "imagen_principal")) |>
  ph_with(value = "Redes sociales utilizadas",
          location = ph_location_label(ph_label = "titulo"))

print(pptx, path_export)