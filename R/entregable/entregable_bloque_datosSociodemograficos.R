library(officer)
library(dplyr)

path_export <- 
  encuestar:::formato_archivo(nombre = "./presentaciones/entregable_bloque_datosSociodemograficos", 
                              extension = "pptx", 
                              tolerancia = 60)

pptx <- 
  read_pptx(path = "./insumos/plantilla_general_09_12_24.pptx")


add_slide(pptx, layout = "gerencia_subportada", master = "gerencia") %>%
  ph_with(value = 'Datos sociodemograficos',
          location = ph_location_label(ph_label = "titulo")) 

# Lenguas indigenas


add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
  ph_with(value = p9.0_graf, 
          location = ph_location_label(ph_label = "imagen_principal")) |>
  ph_with(value = "Hablantes de leguas o dialectos  indigenas",
          location = ph_location_label(ph_label = "titulo"))


#Edad y sexo

add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
  ph_with(value = p9.1_graf , 
          location = ph_location_label(ph_label = "imagen_principal")) |>
  ph_with(value = "Distribución de población",
          location = ph_location_label(ph_label = "titulo"))

## Gráfico de grados de estudios

add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
  ph_with(value = p9.2_graf , 
          location = ph_location_label(ph_label = "imagen_principal")) |>
  ph_with(value = "Nivel educativo",
          location = ph_location_label(ph_label = "titulo"))

## Gráfico de principal ocupación
 
add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
  ph_with(value = p8.3_graf , 
          location = ph_location_label(ph_label = "imagen_principal")) |>
  ph_with(value = "Actividades desempeñadas",
          location = ph_location_label(ph_label = "titulo"))


#Gráfico de salario

add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
  ph_with(value = p8.4_graf , 
          location = ph_location_label(ph_label = "imagen_principal")) |>
  ph_with(value = "Ingresos economicos mensuales",
          location = ph_location_label(ph_label = "titulo"))



print(pptx, path_export)
