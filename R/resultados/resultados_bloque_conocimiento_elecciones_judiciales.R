source(file = './R/parametros/parametros_bloque_conocimiento_elecciones_judiciales.R')

# Bloque Conocimiento elecciones judiciales ---------------------------------------------------------------


# Conocimeinto de fecha de eleccion

p_eleccion_pjn_fecha_graf <-
  enc_neza$Resultados$Descriptiva$barras_categorica(codigo = "eleccion_pjn_fecha", 
                                                    salto = 60, 
                                                    pct_otros = 0.0,
                                                    text_size = 10,
                                                    orden_respuestas = rev(orden_eleccion_pjn_fecha)) +
  scale_fill_manual(values = colores_eleccion_pjn_fecha) +
  labs(caption = p_eleccion_pjn_fecha_tit) +
  theme(axis.text.y = element_text(size = 16),
        axis.text.x = element_text(size = 14),
        legend.text = element_text(size = 14))


# Intencion de participacion a eleccion


p_eleccion_pjn_participacion_graf <-
  enc_neza$Resultados$Descriptiva$barras_categorica(codigo = "eleccion_pjn_participacion", 
                                                    salto = 60, 
                                                    pct_otros = 0.0,
                                                    text_size = 10,
                                                    orden_respuestas = rev(orden_eleccion_pjn_participacion)) +
  scale_fill_manual(values = colores_eleccion_pjn_participacion) +
  labs(caption = p_eleccion_pjn_participacion_tit) +
  theme(axis.text.y = element_text(size = 16),
        axis.text.x = element_text(size = 14),
        legend.text = element_text(size = 14))


