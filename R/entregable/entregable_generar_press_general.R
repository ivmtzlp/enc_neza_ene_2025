# Preambulo -----------------------------------------------------------------------------------

library(officer)

# Constantes ----------------------------------------------------------------------------------
source('./R/constantes.R')


# Resultados ----------------------------------------------------------------------------------

source(file = "./R/resultados/resultados_bloque_problematicas_sociales_seguridad.R")
source(file = "./R/resultados/resultados_bloque_conocimiento_elecciones_judiciales.R")
source(file = './R/resultados/resultados_bloque_conocimiento_personajes.R')
source(file = './R/resultados/resultados_bloque_datosSociodemograficos.R')
source(file = './R/resultados/resultados_bloque_desempeno_gubernamental.R')
source(file = './R/resultados/resultados_bloque_evaluacion_gobiernos.R')
source(file = './R/resultados/resultados_bloque_intencion_voto_gobernador.R')
source(file = './R/resultados/resultados_bloque_introduccion.R')
source(file = './R/resultados/resultados_bloque_programas_sociales.R')
# Parametros ----------------------------------------------------------------------------------

proyecto_fecha <- "Encuesta Nezahualcoyotl - Enero 2025"

path_export <- 
  encuestar:::formato_archivo(nombre = "./presentaciones/Press_general", 
                              extension = "pptx", 
                              tolerancia = 60)

#dia <- lubridate::today() |> lubridate::day()
dia <- "30"

c("completo", "sin nubes", "solo nubes")

modo <- "completo"

# Entregable ----------------------------------------------------------------------------------

# pptx <- 
#   read_pptx(path = "./insumos/plantilla_general_09_12_24pptx")

pptx <- 
  read_pptx(path = "./insumos/plantilla_general_09_12_24.pptx")

## Introduccion -------------------------------------------------------------------------------

add_slide(pptx, layout = "gerencia_portada", master = "gerencia") %>%
  ph_with(value = 'Encuesta Estatal',
          location = ph_location_label(ph_label = "titulo")) |> 
  ph_with(value = 'Ciudad Nezahualcoyotl',
          location = ph_location_label(ph_label = "subtitulo")) |> 
  ph_with(value = paste0('Del 1 al ',dia,' de diciembre del 2024'),
          location = ph_location_label(ph_label = "periodo"))

#add_slide(pptx, layout = "gerencia_nota_metodologica", master = "gerencia")


## Bloque introductorio  ----------------------------------------------------------------------

source('./R/entregable/entregable_bloque_introduccion.R')


## Evaluación de autoridades ------------------------------------------------------------------

source('./R/entregable/entregable_bloque_evaluacion_gobiernos.R')

## Problemáticas sociales  --------------------------------------------------------------------

source('./R/entregable/entregable_bloque_problematicas_sociales_seguridad.R')

## Bloque desempeño gubernamental  -----------------------------------------------------------

source('./R/entregable/entregable_bloque_desempeno_gubernamental.R')


## Conocimiento de personajes secundarios  ----------------------------------------------------

source('./R/entregable/entregable_bloque_conocimiento_personajes.R')

## Candidato ideal ----------------------------------------------------------------------------

source('./R/entregable/entregable_bloque_intencion_voto_gobernador.R')

## Programas Sociales  ------------------------------------------------------------------------

source('./R/entregable/entregable_bloque_programas_sociales.R')


## conocimieto de elecciones judiciales ----------------------------------------------------------------------

source('./R/entregable/entregable_bloque_conocimiento_elecciones_judiciales.R')



## Datos sociodemográficos --------------------------------------------------------------------

source('./R/entregable/entregable_bloque_datosSociodemograficos.R')


print(pptx, path_export)

