
source(file = './R/parametros/parametros_bloque_problematicas_sociales_seguridad.R')
# Problemas mas importantes


p_problemas_edomex_graf <- 
  enc_neza$Resultados$Descriptiva$lollipops_multirespuesta(patron_inicial = "problemas_edomex_", 
                                                           orden = NULL, 
                                                           limits = c(0, 1), 
                                                           width_cats = 50, 
                                                           size = 2, 
                                                           size_pct = 6) +
  labs(caption = p_problemas_edomex_tit) +
  scale_color_manual(values = colores_problemas_edomex) +
  theme(text = element_text(family = "Poppins"), 
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 10),
        plot.title = element_text(size = 18))


# Percepción de delincuencia

p_delincuencia_edomex_graf <- 
enc_neza$Resultados$Descriptiva$gauge_categorica(codigo = 'delincuencia_edomex',
                                                 filtro = 'respuesta == "Seguro"',
                                                 color = color_general)+
  labs(title = paste0(p_delincuencia_edomex_tit,'\nNota: Pregunta respondida por personas\n que contestaron "Seguro"') )+
  encuestar::tema_transparente() +
  theme(plot.title = element_text(size = 13))





# p_beneficiario_pct_graf <-
#   encuestar:::analizar_frecuencias(diseno = enc_chih$muestra$diseno,
#                                    pregunta = "prog_soc_grupo") |>
#   filter(respuesta == 'Cuenta con algún programa social') |>
#   encuestar:::graficar_gauge(color_principal =color_general,escala = c(0,1),size_text_pct = 15 )+
#   labs(title = "Entrevistados que cuentan con alguno\nde los programas sociales",
#        caption = stringr::str_wrap(string = p_beneficiario_tit, 
#                                    width = 50)) +
#   theme(legend.position = "left",
#         plot.caption = element_text(size = 12))

# Principales delitos

p_delito_frecuente_graf <-
  enc_neza$Resultados$Descriptiva$lollipops_categorica(codigo = "delito_municipio", 
                                                       orden = NULL, 
                                                       limits = c(0, 0.5), 
                                                       width_cats = 55, 
                                                       size = 2,
                                                       size_pct = 4) +
  labs(caption = p_delito_municipio_tit) +
  scale_color_manual(values = rep(color_general, 14)) +
  theme(text = element_text(family = "Poppins"), 
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 13),
        plot.caption = element_text(size = 14))



# Presencia delitos

p_seguridad_graf <-
  enc_neza$Resultados$Descriptiva$barras_aspectos(patron_inicial = "seguridad",
                                                  aspectos = aspectos_seguridad, 
                                                  salto = 45, 
                                                  filtro = "respuesta == 'Sí'",
                                                  text_size = 13) +
  #labs(caption = paste0(p_seguridad_tit, '\nEntrevistados que contestaron "Sí lo conoce"')) +
  labs(caption = paste0(p_seguridad_tit,"\n Personas que contestarón 'Sí'")) +
  scale_fill_manual(values = colores_seguridad) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1),limits = c(0,1))+
  tema_morant() +
  tema_transparente() +
  theme(text = element_text(family = "Poppins"), 
        axis.text.x = element_text(size = 10),
        axis.text.y = element_text(size = 13),
        plot.caption = element_text(size = 14))


# Presencia extorcion

p_extorsion_edomex_graf <- 
  enc_neza$Resultados$Descriptiva$gauge_categorica(codigo = 'extorsion_edomex',
                                                   filtro = 'respuesta == "Sí"',
                                                   color = color_general)+
  labs(title = paste0(p_extorsion_edomex_tit,'\nNota: Pregunta respondida por personas que contestaron "Sí"') )+
  encuestar::tema_transparente() +
  theme(plot.title = element_text(size = 13))




