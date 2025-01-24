
# Bloque Conocimiento de personajes ---------------------------------------------------------------

# Conocimeinteo personajes secundarios 

p_conoce_per2_horacio_graf <- 
  enc_neza$Resultados$Descriptiva$gauge_categorica(codigo = 'conoce_per2_horacio',
                                                   filtro = 'respuesta == "Sí"',
                                                   color = color_general)+
  labs(title = paste0(p_conoce_per2_horacio_tit,'\nNota: Pregunta respondida por personas que contestaron "Sí"') )+
  encuestar::tema_transparente()


# Calificacion de personajes 

p_opinion_per2_graf <- 
  enc_neza$Resultados$Especial$candidatoOpinion(patron_inicial = "opinion_per2", 
                                                aspectos = aspectos_conocimiento_per2, 
                                                
                                                # Grupos positivos y negativos
                                                grupo_positivo = "Buena", 
                                                grupo_negativo = "Mala",
                                                orden_resp = c("Mala", 
                                                               "Regular",
                                                               "Buena"), 
                                                colores_opinion = colores_opinion_per2, 
                                                
                                                # Regula 
                                                regular = "Regular", 
                                                
                                                # No sabe no contesa
                                                ns_nc = "Ns/Nc",
                                                color_nsnc = color_nsnc,
                                                caption_nsnc = "Ns/Nc",
                                                
                                                # Seccion burbuja
                                                burbuja = T, 
                                                llave_burbuja = 'conoce_per2', 
                                                color_burbuja = color_general, 
                                                caption_burbuja = "Conocimiento",
                                                
                                                # Titulo
                                                caption_opinion =  p_conocimiento_per2_tit, 
                                                
                                                # Tamanios
                                                size_caption_opinion = 14, 
                                                size_caption_nsnc = 12, 
                                                size_caption_burbuja = 12, 
                                                size_text_cat = 16, 
                                                size_pct = 14, 
                                                salto = 38) 






