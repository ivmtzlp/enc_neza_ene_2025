library(tidyverse)
library(srvyr)

encuesta <- srvyr::as_survey_design(enc_neza$Resultados$diseno)

bd_voto_jud <- 
 
  encuestar:::analizar_cruce(diseno = enc_neza$Resultados$diseno,
                           variable_principal = "eleccion_pjn_participacion",
                           variable_secundaria = "identificacion_partido",
                           vartype =  "cv") %>% 
  filter(identificacion_partido %in%  c("MORENA", "PRI", "PAN")) %>% 
  filter(!eleccion_pjn_participacion %in%  c("Ns/Nc"))




bd_voto_jud$eleccion_pjn_participacion <- 
  factor(
  bd_voto_jud$eleccion_pjn_participacion,
  levels = unique(bd_voto_jud$eleccion_pjn_participacion), 
  labels = stringr::str_wrap(c("Sí, definitivamente votaré", 
                               "Probablemente votaré", 
                               "No, definitivamente no votaré"),
                             width = 18)
)
 


bd_voto_jud %>% 
  rename(respuesta = identificacion_partido,media = coef) %>% 
  encuestar:::graficar_barras(text_size = 10)+
  facet_wrap(~ eleccion_pjn_participacion, ncol = 3 )+
  labs(caption = "Intención de voto por partido para elecciones judiciales ", x = "Partido político", y = "Porcentaje") +
  scale_fill_manual(values =colores_identificacion_partido)+
  #scale_fill_manual(values = c("MORENA" = "#A6032F", "PRI" = "#038C33", "PAN" = "#0339A6"))+
  encuestar::tema_morant()




  

  