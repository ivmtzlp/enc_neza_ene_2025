source(file = './R/parametros/parametros_bloque_evaluacion_gobiernos.R')

# Bloque Evaluacion de gobierno ---------------------------------------------------------------

# Conocimeinteo personajes 
p_conoce_per_graf <-
  enc_neza$Resultados$Descriptiva$barras_aspectos(patron_inicial = "conoce_per",
                                                  aspectos = aspectos_conoce_per, 
                                                  salto = 60, 
                                                  filtro = "respuesta == 'Sí lo conoce'",
                                                  text_size = 13) +
  #labs(caption = paste0(p_conoce_per_tit, '\nEntrevistados que contestaron "Sí lo conoce"')) +
  labs(caption = p_conoce_per_tit) +
  scale_fill_manual(values = colores_conoce_per) +
  scale_y_continuous(labels = scales::percent_format(accuracy = 1),limits = c(0,1))+
  tema_morant() +
  tema_transparente() +
  theme(text = element_text(family = "Poppins"), 
        axis.text.x = element_text(size = 12),
        axis.text.y = element_text(size = 16),
        plot.caption = element_text(size = 14))

# enc_neza$muestra$diseno$variables |> 
#   select(contains("conoce_per")) |> 
#   naniar::vis_miss()

# Evaluacion de autoridades

p_aprueba_per_graf <- 
  enc_neza$Resultados$Especial$candidatoOpinion(patron_inicial = "aprueba_per", 
                                                aspectos = aspectos_aprueba_per, 
                                                ns_nc = "Ns/Nc", 
                                                regular = "", 
                                                grupo_positivo = c("Aprueba poco", "Aprueba mucho"), 
                                                grupo_negativo = c("Desaprueba poco", "Desaprueba mucho"), 
                                                colores_opinion = colores_evaluacion, 
                                                color_nsnc = color_nsnc, 
                                                orden_resp = c("Desaprueba poco", "Desaprueba mucho", "Aprueba poco", "Aprueba mucho"), 
                                                size_text_cat = 16, 
                                                size_pct = 16,
                                                salto = 35,
                                                orden_cat = aspectos_aprueba_per,
                                                caption_opinion = p_aprueba_per_tit)



# ,
# burbuja = T,
# llave_burbuja = "conoce_per",
# filtro_burbuja = "Sí lo conoce",
# size_caption_burbuja = "Conocimiento"

# Calificacion a autoridades

# p_confia_per_graf <- 
#   enc_neza$Resultados$Descriptiva$intervalo_numerica(patron = "confia_per", 
#                                                      aspectos = aspectos_confia_per, 
#                                                      escala = c(1, 10), 
#                                                      point_size = 1, 
#                                                      text_point_size = 8) +
#   labs(caption = p_confia_per_tit)


p_confia_per_graf <- 
  encuestar:::analizar_frecuencias_aspectos(diseno = enc_neza$muestra$diseno,
                                            diccionario = dicc,
                                            patron_pregunta = "confia_per",
                                            aspectos = aspectos_confia_per) |> 
  filter(respuesta != "Ns/Nc") |> 
  mutate(respuesta = as.numeric(as.character(respuesta))) |> 
  mutate(media =  respuesta * media,ee = respuesta*ee) |> 
  group_by(aspecto) |> 
  summarise(media = sum(media)) |> 
  left_join(dicc %>%
              select(aspecto = llaves, tema), by = "aspecto") |>
  mutate(sup =  0,
         inf = 0) |> 
  encuestar:::graficar_intervalo_numerica(escala = c(0,10))+
  scale_y_continuous(limits = c(0,10),breaks = c(0:10))+
  scale_x_discrete(limits = rev(c("Claudia Sheinbaum", 
                              "Delfina Gómez Álvarez", 
                              "Presidente Municipal")))+
  labs(caption = p_confia_per_tit)+
  encuestar::tema_morant()


# Aprueba trabajo presidente municipal

# p_aprueba_trabajo_pm_graf <- 
#   enc_neza$Resultados$Especial$candidatoOpinion(patron_inicial = "aprueba_trabajo", 
#                                                 aspectos = aspectos_aprueba_trabajo_pm, 
#                                                 ns_nc = "Ns/Nc", 
#                                                 regular = "", 
#                                                 grupo_positivo = c("Aprueba poco", "Aprueba mucho"), 
#                                                 grupo_negativo = c("Desaprueba poco", "Desaprueba mucho"), 
#                                                 colores_opinion = colores_evaluacion, 
#                                                 color_nsnc = color_nsnc, 
#                                                 orden_resp = c("Desaprueba poco", "Desaprueba mucho", "Aprueba poco", "Aprueba mucho"), 
#                                                 size_text_cat = 16, 
#                                                 size_pct = 16,
#                                                 salto = 35,
#                                                 #orden_cat = aspectos_aprueba_trabajo_pm,
#                                                 caption_opinion = p_aprueba_trabajo_pm_tit)


# # Proegreso Mexico
# 
# p_progeso_mex_graf <-
#   enc_neza$Resultados$Descriptiva$barras_categorica(codigo = "progeso_mex", 
#                                                     salto = 60, 
#                                                     pct_otros = 0.0,
#                                                     text_size = 10,
#                                                     orden_respuestas = rev(orden_progreso_mex)) +
#   scale_fill_manual(values = colores_progeso_mex) +
#   labs(caption = p_progeso_mex_tit) +
#   theme(axis.text.y = element_text(size = 16),
#         axis.text.x = element_text(size = 14),
#         legend.text = element_text(size = 14))
# 
# 
# # Proegreso Edomex
# 
# p_progeso_edomex_graf <-
#   enc_neza$Resultados$Descriptiva$barras_categorica(codigo = "progeso_edomex", 
#                                                     salto = 60, 
#                                                     pct_otros = 0.0,
#                                                     text_size = 10,
#                                                     orden_respuestas = rev(orden_progreso_edomex)) +
#   scale_fill_manual(values = colores_progeso_edomex) +
#   labs(caption = p_progeso_edomex_tit) +
#   theme(axis.text.y = element_text(size = 16),
#         axis.text.x = element_text(size = 14),
#         legend.text = element_text(size = 14))
# 
# 
# # Proegreso Municipio
# 
# p_progeso_municipio_graf <-
#   enc_neza$Resultados$Descriptiva$barras_categorica(codigo = "progeso_municipio", 
#                                                     salto = 60, 
#                                                     pct_otros = 0.0,
#                                                     text_size = 10,
#                                                     orden_respuestas = rev(orden_progreso_municipio)) +
#   scale_fill_manual(values = colores_progeso_municipio) +
#   labs(caption = p_progeso_municipio_tit) +
#   theme(axis.text.y = element_text(size = 16),
#         axis.text.x = element_text(size = 14),
#         legend.text = element_text(size = 14))

# Progreso general

progeso_general_graf <- 
  enc_neza$Resultados$Especial$candidatoOpinion(patron_inicial = "progeso", 
                                                aspectos = c("mex","edomex","municipio"), 
                                                ns_nc = "Ns/Nc", 
                                                regular = "Estancado", 
                                                grupo_positivo = c("Progresando"), 
                                                grupo_negativo = c("En retroceso"), 
                                                colores_opinion = colores_progreso, 
                                                color_nsnc = color_nsnc, 
                                                orden_resp = c("En retroceso","Estancado","Progresando"), 
                                                size_text_cat = 16, 
                                                size_pct = 16,
                                                salto = 35,
                                                orden_cat = c("mex","edomex","municipio"),
                                                caption_opinion = p_progeso_gen_tit )

