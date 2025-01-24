

library(officer)


revision_sexo <-enc_neza$muestra$revisar_sexo()

revision_edad <- enc_neza$muestra$revisar_rango_edad()

# Parametros ----------------------------------------------------------------------------------

proyecto_fecha <- "Encuesta Estatal Estado de México - Enero 2025"

# path_export <-
#   encuestar:::formato_archivo(nombre = "./presentaciones/",
#                               extension = "pptx",
#                               tolerancia = 60)

pref <- "neza"
municipio_cuo <- "Nazahualcóyotl"

path_export <-  paste0("../audit_general_edomex_2025/presentaciones/cuotas/cuota_",pref,".pptx")


pptx <-
  read_pptx(path = "../audit_general_edomex_2025/presentaciones/cuotas/cuota_general.pptx")
add_slide(pptx, layout = "gerencia_subportada", master = "gerencia") %>%
  ph_with(value = paste0('Revision cuota ',municipio_cuo),
          location = ph_location_label(ph_label = "titulo"))


add_slide(pptx, layout = "gerencia_dos_graficas_equitativas", master = "gerencia") %>%
  ph_with(value = revision_sexo, location = ph_location_label(ph_label = "grafica_uno")) |>
  ph_with(value = revision_edad, location = ph_location_label(ph_label = "grafica_dos")) |>
  ph_with(value = paste0('Cuotas ',municipio_cuo),
          location = ph_location_label(ph_label = "titulo"))

#print(pptx, path_export)
print(pptx, "../audit_general_edomex_2025/presentaciones/cuotas/cuota_general.pptx")




