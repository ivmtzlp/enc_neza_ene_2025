# library(tidyverse)
# library(srvyr)

#encuesta <- srvyr::as_survey_design(enc_neza$Resultados$diseno)

# Cruce entre participacion en las elecciones del poder judicial e identificación partidista

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
 

identificacion_partido_eleccion_pjn_participacion <- 
bd_voto_jud %>% 
  rename(respuesta = identificacion_partido,media = coef) %>% 
  encuestar:::graficar_barras(text_size = 10)+
  facet_wrap(~ eleccion_pjn_participacion, ncol = 3 )+
  labs(caption = "Intención de voto por identificación partidista para elecciones judiciales") +
  scale_fill_manual(values =colores_identificacion_partido)+
  #scale_fill_manual(values = c("MORENA" = "#A6032F", "PRI" = "#038C33", "PAN" = "#0339A6"))+
  encuestar::tema_morant()


# Cruce entre participacion en las elecciones del poder judicial e interes en la politics

temas_eleccion_pjn_participacion_graf <- 
  enc_neza$muestra$diseno$variables |> 
  mutate(pesos =  weights(enc_neza$muestra$diseno)) |> 
  mutate(temas_b = case_match(temas,
                              "Política"~"Política",
                              "Ns/Nc"~"Ns/Nc",
                              .default = "Otros")) |>
  mutate(temas_b = factor(temas_b,levels = c("Política","Otros","Ns/Nc"))) |> 
  count(temas_b,eleccion_pjn_participacion,wt = pesos) |> 
  group_by(temas_b) |> 
  mutate(media = n/sum(n)) |> 
  rename(respuesta = eleccion_pjn_participacion)|> 
  encuestar:::graficar_barras(text_size = 10,
                              orden_respuestas = rev(orden_eleccion_pjn_participacion) )+
  scale_fill_manual(values = colores_eleccion_pjn_participacion)+
  labs(caption = "Intención de voto por nivel de interés en la política para elecciones judiciales") +
  facet_wrap(~temas_b)+
  tema_morant()
  

  