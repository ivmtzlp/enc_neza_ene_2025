#cruce delfina , sheinbaum  y presidente municipal con sexo y edad
source(file = './R/parametros/parametros_bloque_conocimiento_personajes.R')


enc_neza$Resultados$diseno$variables<- enc_neza$Resultados$diseno$variables %>%
  mutate(sexo_cat = if_else(sexo == "F", "Mujer", "Hombre"))

# Inspeccionar la columna 'sexo_cat'
enc_neza$Resultados$diseno$variables %>% 
  select(sexo_cat) %>% 
  glimpse()
p_conoce_per_cruce_sexo_graf <-
  
  enc_neza$Resultados$Cruce$lolipop_diferencias(
        variable_principal = "sexo_cat",
        variables_secundarias = c("conoce_per_delfina", "conoce_per_claudia", "conoce_per_neza"),
        filtro_variables_secundarias = "Sí lo conoce", 
        orden_variablePrincipal = c("Delfina Gómez Álvarez", "Claudia Sheinbaum", "Adolfo Cerqueda Rebollo"),
        colores_variables_secundarias = c("Hombre" = "blue", "Mujer" = "pink"),  # Mantén los colores con las etiquetas originales
        caption = "Conocimiento de personaje por sexo", 
        invertir_variables = TRUE,
        limits = c(0,1.05), 
        nudge_x = 0.15,
        wrap_y = 1,
        wrap_caption = 50,
        traslape = 0.18,
        limite_dif_pct = 0.02,
        
       )
   







#conocimiento de personajes por edad 
encuestar:::analizar_cruce_aspectos(diseno = enc_neza$Resultados$diseno,
                                    variable_principal = "rango_edad",
                                    variables_secundarias =c("conoce_per_delfina","conoce_per_claudia","conoce_per_neza"),
                                    filtro_variables_secundarias = "Sí lo conoce",
                                    vartype = "cv"  )

p_conoce_per_cruce_edad_graf <-
  
  enc_neza$Resultados$Cruce$lolipop_diferencias(variable_principal =  "generacion",
                                                   variables_secundarias = c("conoce_per_delfina","conoce_per_claudia","conoce_per_neza") ,
                                                   
                                                   filtro_variables_secundarias  = "Sí lo conoce", 
                                                   orden_variablePrincipal =  orden_generaciones,
                                                   colores_variables_secundarias =  c("Claudia Sheinbaum" = "#A6032F", 
                                                                                      "Delfina Gómez Álvarez" = "#CF6177",
                                                                                      "Adolfo Cerqueda Rebollo" = "#F5CD5F"),
                                                  
                                                   caption = "Conocimiento de personaje por edad", 
                                                   invertir_variables = F,
                                                   limits = c(0,1.09), 
                                                   nudge_x= 0.15,
                                                   wrap_y = 60,
                                                   wrap_caption = 60,
                                                   traslape =0.18,
                                                   limite_dif_pct = 0.03
                                                   
                                                   
    )
enc_neza$muestra$diseno$variables %>% distinct(generacion)
