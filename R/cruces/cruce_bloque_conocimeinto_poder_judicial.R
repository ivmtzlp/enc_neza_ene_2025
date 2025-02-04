#seguridad

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
  encuestar:::graficar_barras(text_size = 10)+
  scale_fill_manual(values = colores_eleccion_pjn_participacion)+
  facet_wrap(~temas_b)+
  tema_morant()
  






####







bd_aprueba_per_delfina_delincuencia_edomex<- 
  encuestar:::analizar_cruce(diseno = enc_neza$muestra$diseno,
                             variable_principal = "delincuencia_edomex",
                             variable_secundaria = "aprueba_per_delfina",
                             vartype = "cv",na_rm = T)|> 
  mutate(aspecto = case_match(delincuencia_edomex,
                              "Inseguro"~"cat_in",
                              "Seguro"~ "cat_seg",
                              "Ns/Nc"~"cat_ns")) |> 
  rename(tema = delincuencia_edomex, media = coef,respuesta = aprueba_per_delfina  )


bd_delincuencia_edomex_delf<- 
encuestar:::analizar_frecuencias(diseno = enc_neza$muestra$diseno,
                                 pregunta = "delincuencia_edomex") |> 
  rename(tema = respuesta)





aprueba_per_delfina_delincuencia_edomex_graf <-   
  bd_aprueba_per_delfina_delincuencia_edomex |> 
  encuestar:::graficar_candidato_opinion(patron_inicial = "cat", 
                                         
                                         #Grupos positivos
                                         grupo_positivo = c("Aprueba poco", "Aprueba mucho"), 
                                         grupo_negativo = c("Desaprueba poco", "Desaprueba mucho"),  
                                         colores = colores_evaluacion, 
                                         caption_opinion = paste0("¿Usted aprueba o desaprueba el trabajo de Delfina Gómez? ¿Mucho o poco?","\nCruce con percepción de seguridad"),
                                         orden_resp = c("Desaprueba poco", "Desaprueba mucho", "Aprueba poco", "Aprueba mucho"),
                                         
                                         # Regular
                                         regular = "", 
                                         
                                         # ns_nc
                                         ns_nc = "Ns/Nc", 
                                         color_nsnc = color_nsnc,
                                         
                                         # Burbuja
                                         burbuja =bd_delincuencia_edomex_delf,
                                         color_burbuja =  color_general,
                                         caption_burbuja = "Percepción\nseguridad", 
                                         
                                         
                                         # tamanos
                                         size_text_cat = 16, 
                                         size_pct = 16,
                                         size_caption_burbuja =12,
                                         size_caption_opinion = 14,
                                         salto = 35,
                                         orden_cat = c("seg","in","ns"),
                                         tema = tema_morant())







  