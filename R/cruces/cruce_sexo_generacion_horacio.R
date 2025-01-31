

source(file = './R/parametros/parametros_bloque_conocimiento_personajes.R')

#cruce por sexo conoce horacio duarte

bd_horacio_edad_sexo <- 
  srvyr::as_survey_design(enc_neza$muestra$diseno)
bd_conoce_per2_horacio <- srvyr::as_survey_design(enc_neza$Resultados$diseno)




bd_horacio_generacion_sexo <- 
  encuestar:::analizar_cruce(diseno = enc_neza$muestra$diseno ,
                             
                             variable_principal = "sexo_cat",
                             variable_secundaria = "generacion",
                             vartype =  'cv'  )




encuestar:::analizar_cruce(diseno = enc_neza$muestra$diseno ,
                           variable_principal = "sexo_cat",
                           variable_secundaria = "conoce_per2_horacio",
                           vartype =  'cv'  )




#grafica generacion




p_conoce_per2_horacio_graf_sexo_generacion <-
  
  bd_horacio_edad_sexo %>% 
  
  
  mutate(

    conoce_per2_horacio = case_when(conoce_per2_horacio == "Sí" ~ "s",
                                    conoce_per2_horacio == "No" ~ "n")
  ) %>%
  #group_by(sexo_cat, generacion, conoce_per2_horacio ) %>%
  filter(conoce_per2_horacio == "s") %>%
  group_by(sexo_cat, generacion) %>%
  summarise(coeficiente = srvyr::survey_mean(na.rm = TRUE, vartype = NULL)) %>%
  mutate(
    porcentaje = sum(coeficiente, na.rm = TRUE),
    coef = coeficiente / porcentaje * ifelse(sexo_cat == "Hombre", 0.124, 0.132)
  ) %>%

   
   mutate(coef = if_else( sexo_cat == "Hombre", -coef, coef))%>% 
   
  # filter(conoce_per2_horacio == "s") %>% 
  ungroup() %>%
 
  ggplot(aes(x = generacion , y = coef, fill = sexo_cat, label = scales::percent(abs(coef), 1))) +
  ggchicklet::geom_chicklet(alpha = 0.9) +
  coord_flip() +
  scale_fill_manual(values = c("Mujer" = "#F5CD5F", "Hombre" = "#A6032F" )) +
  ggfittext::geom_bar_text(contrast = TRUE) +
  lemon::scale_y_symmetric(labels = function(x) scales::percent(abs(x), accuracy = 1)) +
  encuestar:::tema_morant() + 
  theme(
    legend.position = "bottom",
    legend.title = element_blank(),
    axis.title.y = element_text(size = 18),
    legend.text = element_text(size = 16),
    plot.background = element_rect(color = "transparent", fill = "transparent"),
    panel.background = element_rect(color = "transparent", fill = "transparent")
  ) +
  labs(x = "Generación" ,caption = "¿Usted conoce o ha escuchado hablar de Horacio Duarte?")

  
  
  






