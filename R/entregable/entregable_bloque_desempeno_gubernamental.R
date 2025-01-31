#library(officer)
library(dplyr)

# path_export <-
#   encuestar:::formato_archivo(nombre = "./presentaciones/bloque_desempeno_gubernamental",
#                               extension = "pptx",
#                               tolerancia = 60)
# 
# pptx <-
#   read_pptx(path = "./insumos/plantilla_general_09_12_24.pptx")

revision<-F
if(revision){
  source('./R/resultados/resultados_bloque_desempeno_gubernamental.R')

  library(officer)

  bloque<-'Desempeño gubernamental'

  fecha_hoy<- lubridate::now()
  fecha <-paste0(lubridate::day(fecha_hoy),'_',lubridate::month(fecha_hoy),'_24','_',lubridate::hour(fecha_hoy),"hrs")
  path_export <- paste0("./presentaciones/",bloque,"_",fecha,".pptx")
  pptx <- read_pptx(path = "./insumos/plantilla_general_09_12_24.pptx")


  proyecto_fecha <- ""
}

add_slide(pptx, layout = "gerencia_subportada", master = "gerencia") %>%
  ph_with(value = 'Desempeño gubernamental',
          location = ph_location_label(ph_label = "titulo")) 

# Desempeno gobierno delfina

 
add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
  ph_with(value = p_delfina_1_graf, 
          location = ph_location_label(ph_label = "imagen_principal")) |>
  ph_with(value = "Evaluación ciudadana de Delfina Gómez",
          location = ph_location_label(ph_label = "titulo"))
#grafica 2
add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
  ph_with(value = p_delfina_2_graf, 
          location = ph_location_label(ph_label = "imagen_principal")) |>
  ph_with(value = "Evaluación ciudadana de Delfina Gómez",
          location = ph_location_label(ph_label = "titulo"))

# Satisfación sevicios 

add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
  ph_with(value = g_satisfacion, 
          location = ph_location_label(ph_label = "imagen_principal")) |>
  ph_with(value = "Evaluación de servicios publicos",
          location = ph_location_label(ph_label = "titulo"))

# Problemas agua


add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
  ph_with(value = p_problemas_agua_graf , 
          location = ph_location_label(ph_label = "imagen_principal")) |>
  ph_with(value = "Frecuencia de problemas con el suministro de agua",
          location = ph_location_label(ph_label = "titulo"))

# Mejora inmediata

add_slide(pptx, layout = "gerencia_grafica_unica", master = "gerencia") %>%
  ph_with(value = p_mejora_servicio_graf , 
          location = ph_location_label(ph_label = "imagen_principal")) |>
  ph_with(value = "Mejoras inmediatas solicitadas ",
          location = ph_location_label(ph_label = "titulo"))




#print(pptx, path_export)
if(revision){

  print(pptx,path_export)

}