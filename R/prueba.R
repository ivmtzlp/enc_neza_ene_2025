enc_neza <- 
  Encuesta$new(respuestas = bd_respuestas_campo,
               muestra = diseno_neza,
               cuestionario = dicc, 
               auditoria_telefonica = bd_eliminadas,
               shp = shp_neza, 
               tipo_encuesta = "ine",
               mantener_falta_coordenadas = F, 
               quitar_vars = c(), 
               #auditar = c("voto_gb_27", "conoce_per1_cruz", "conoce_per1_andrea"),
               # vars_tendencias = c("voto_gb_27", "conoce_per1_andrea"),
               sin_peso = F,
               rake = T, ######### con postestratificacion
               patron = "\\(No leer\\)| \\(No leer\\)|\\(ROTAR\\)| \\(no leer)|\\(No leer)|:")


