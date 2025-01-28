
# Bloque Introduccion ---------------------------------------------------------------

source(file = './R/parametros/parametros_bloque_introduccion.R')

# Temas
p_temas_graf <-
  enc_neza$Resultados$Descriptiva$barras_categorica(codigo = "temas", 
                                                    salto = 60, 
                                                    pct_otros = 0.0,
                                                    text_size = 10) +
  scale_fill_manual(values = colores_temas) +
  labs(caption = p_temas_tit) +
  theme(axis.text.y = element_text(size = 16),
        axis.text.x = element_text(size = 14),
        legend.text = element_text(size = 14))


# MEDIOS DE COMUNICACION
p_medios_com_graf <- 
  enc_neza$Resultados$Descriptiva$lollipops_multirespuesta(patron_inicial = "medios_com_", 
                                                           orden = NULL, 
                                                           limits = c(0, 1), 
                                                           width_cats = 45, 
                                                           size = 2, 
                                                           size_pct = 6) +
  labs(caption = p_medios_com_tit) +
  scale_color_manual(values = colores_medios_com) +
  theme(text = element_text(family = "Poppins"), 
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 14),
        plot.title = element_text(size = 18))

# Redes sociales
p_utiliza_graf <- 
  enc_neza$Resultados$Descriptiva$barras_aspectos(patron_inicial = "utiliza", 
                                                  aspectos = aspectos_utiliza, 
                                                  salto = 50,
                                                  text_size = 10
  ) +
  labs(caption = paste0(p_utiliza_tit,
                        "\n",
                        "El resultado corresponde a los que contestaron que Sí")
  ) +
  scale_fill_manual(values = rep(color_general, length(aspectos_utiliza))) +
  theme(text = element_text(family = "Poppins"), 
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 16),
        plot.title = element_text(size = 18))

