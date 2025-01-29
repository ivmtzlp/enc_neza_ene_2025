source(file = './R/parametros/parametros_bloque_intencion_voto_gobernador.R')


# Bloque Intención de voto a Gobernador ---------------------------------------------------------------

# Intencion del voto gb 27

p_voto_gb_27_graf <-
  enc_neza$Resultados$Descriptiva$barras_categorica(codigo = 'voto_gb_27',text_size = 10, salto = 100)+
  scale_fill_manual(values =colores_voto_gb_27)+
  scale_y_continuous(limits = c(0, 1.), 
                     labels = scales::percent) +
  labs(caption = p_voto_gb_27_tit)


# Identificacion partidista

p_identificacion_partido_graf <- 
  enc_neza$Resultados$Descriptiva$barras_categorica(codigo = 'identificacion_partido',text_size = 10, salto = 100)+
  scale_fill_manual(values =colores_identificacion_partido )+
  scale_y_continuous(limits = c(0, 1.), 
                     labels = scales::percent) +
  labs(caption = p_identificacion_partido_tit)

