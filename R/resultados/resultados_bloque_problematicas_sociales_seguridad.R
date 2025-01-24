

# Problemas mas importantes

p_problemas_edomex_graf <- 
  enc_neza$Resultados$Descriptiva$lollipops_multirespuesta(patron_inicial = "problemas_edomex_", 
                                                           orden = NULL, 
                                                           limits = c(0, 1), 
                                                           width_cats = 45, 
                                                           size = 2, 
                                                           size_pct = 6) +
  labs(caption = p_problemas_edomex_tit) +
  scale_color_manual(values = colores_problemas_edomex) +
  theme(text = element_text(family = "Poppins"), 
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 14),
        plot.title = element_text(size = 18))





