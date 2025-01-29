library(dplyr)
source(file = './R/parametros/parametros_bloque_desempeno_gubernamental.R')

# Bloque Desempeno gobernatura ---------------------------------------------------------------

# Desempeno gobierno delfina

bd_delfina_calif <- 
  encuestar:::analizar_frecuencias_aspectos(diseno = enc_neza$muestra$diseno,
                                            diccionario = dicc,
                                            patron_pregunta = "delfina",
                                            aspectos = aspectos_delfina) |> 
  filter(!respuesta %in% c("Ns/Nc","99") ) |> 
  mutate(respuesta = as.numeric(as.character(respuesta))) |> 
  mutate(media =  respuesta * media,ee = respuesta*ee) |> 
  group_by(aspecto) |> 
  summarise(media = sum(media)) |> 
  left_join(dicc %>%
              select(aspecto = llaves, tema), by = "aspecto") |>
  mutate(sup =  0,
         inf = 0) 

parte_1 <- bd_delfina_calif[1:7, ]
p_delfina_1_graf <-
  parte_1 |> 
  encuestar:::graficar_intervalo_numerica(escala = c(0,10),text_point_size = 6)+
  scale_y_continuous(limits = c(0,10),breaks = c(0:10))+
  labs(caption = p_delfina_tit)+
  encuestar::tema_morant()

parte_2 <- bd_delfina_calif[8:14, ]
p_delfina_2_graf <-
  parte_2 |> 
  encuestar:::graficar_intervalo_numerica(escala = c(0,10),text_point_size = 6)+
  scale_y_continuous(limits = c(0,10),breaks = c(0:10))+
  labs(caption = p_delfina_tit)+
  encuestar::tema_morant()


# Satisfación sevicios 

g_satisfacion <- 
  enc_neza$Resultados$Especial$candidatoOpinion(patron_inicial = "satisfacion", 
                                                aspectos = aspectos_satisfacion, 
                                                
                                                # Regular
                                                regular = "Ni satisfecho, ni insatisfecho", 
                                                
                                                #grupos positivos negativos
                                                grupo_positivo = c("Algo satisfecho","Muy satisfecho"), 
                                                grupo_negativo = c("Algo insatisfecho","Muy insatisfecho"), 
                                                
                                                # orden de respuetas
                                                orden_resp = rev(c("Muy satisfecho",
                                                               "Algo satisfecho",
                                                               "Ni satisfecho, ni insatisfecho",
                                                               "Algo insatisfecho",
                                                               "Muy insatisfecho")), 
                                                
                                                #Colores
                                                colores_opinion = colores_satisfacion, 
                                                
                                                #Seccion burbuja
                                                burbuja = NA,
                                                
                                                # Seccion Ns/Nc
                                                ns_nc = "Ns/Nc", 
                                                color_nsnc = color_nsnc, 
                                                caption_nsnc = "Ns/Nc", 
                                                
                                                #Titiulo o caption
                                                caption_opinion =  p_satisfacion_tit, 
                                                
                                                #parametros 
                                                size_caption_opinion = 12, 
                                                size_text_legend = 14,
                                                size_caption_nsnc = 12, 
                                                size_text_cat = 14, 
                                                salto_respuestas = 5,
                                                size_pct = 14,
                                                salto = 38) 


# Problemas agua

p_problemas_agua_graf <-
  enc_neza$Resultados$Descriptiva$barras_categorica(codigo = "problemas_agua", 
                                                    salto = 60, 
                                                    pct_otros = 0.0,
                                                    text_size = 10,
                                                    orden_respuestas = rev(orden_problemas_agua)) +
  scale_fill_manual(values = colores_problemas_agua) +
  labs(caption = p_problemas_agua_tit) +
  theme(axis.text.y = element_text(size = 16),
        axis.text.x = element_text(size = 14),
        legend.text = element_text(size = 14))

# Mejora inmediata

p_mejora_servicio_graf <-
  enc_neza$Resultados$Descriptiva$barras_categorica(codigo = "mejora_servicio", 
                                                    salto = 60, 
                                                    pct_otros = 0.0,
                                                    text_size = 10)+

  scale_fill_manual(values = colores_mejora_servicio) +
  labs(caption = p_mejora_servicio_tit) +
  theme(axis.text.y = element_text(size = 16),
        axis.text.x = element_text(size = 14),
        legend.text = element_text(size = 14))


