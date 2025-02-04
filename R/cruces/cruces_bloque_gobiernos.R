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
        variables_secundarias = c("conoce_per_neza","conoce_per_delfina", "conoce_per_claudia"),
        filtro_variables_secundarias = "Sí lo conoce", 
        orden_variablePrincipal = c( "Adolfo Cerqueda Rebollo","Delfina Gómez Álvarez","Claudia Sheinbaum" ),
        colores_variables_secundarias = c("Hombre" = "#A6032F", "Mujer" = "#F5CD5F"),  
        caption = "Conocimiento de autoridades por sexo", 
        invertir_variables = TRUE,
        limits = c(0,1.05), 
        nudge_x = 0.3,
        wrap_y = 80,
        wrap_ = 90,
        traslape = T,
        limite_dif_pct = 0.02,
        ajuste_pos = 0.03
        
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
                                                   limits = c(0,1.1), 
                                                   nudge_x= 0.3,
                                                   wrap_y = 60,
                                                   wrap_caption = 20, size_text_legend = 15,
                                                   traslape =T,
                                                   limite_dif_pct = 0.5
                                                   
                                                   
    )
enc_neza$muestra$diseno$variables %>% distinct(generacion)
