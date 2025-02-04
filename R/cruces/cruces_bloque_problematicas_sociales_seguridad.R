


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
                                         burbuja =NULL, 
                                         
                                         
                                         # tamanos
                                         size_text_cat = 16, 
                                         size_pct = 16,
                                         salto = 35,
                                         orden_cat = c("seg","in","ns"),
                                         tema = tema_morant())