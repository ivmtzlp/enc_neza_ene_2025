library(officer)
library(dplyr)

path_export <- 
  encuestar:::formato_archivo(nombre = "./presentaciones/entregable_bloque_programas_sociales", 
                              extension = "pptx", 
                              tolerancia = 60)

pptx <- 
  read_pptx(path = "./insumos/plantilla_general_09_12_24.pptx")


add_slide(pptx, layout = "gerencia_subportada", master = "gerencia") %>%
  ph_with(value = 'Conocimiento Personajes Secundarios',
          location = ph_location_label(ph_label = "titulo")) 


# Contar con programas sociales


add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
  ph_with(value = p_prog_soc_graf, 
          location = ph_location_label(ph_label = "imagen_principal")) |>
  ph_with(value = "Beneficiarios de programas sociales",
          location = ph_location_label(ph_label = "titulo"))


# Principales programas sociales


add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
  ph_with(value = p_programa_social_graf , 
          location = ph_location_label(ph_label = "imagen_principal")) |>
  ph_with(value = "Principales programas sociales",
          location = ph_location_label(ph_label = "titulo"))



print(pptx, path_export)
