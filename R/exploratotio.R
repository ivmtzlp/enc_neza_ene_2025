auditoria_telefonica %>% mutate(SbjNum = readr::parse_double(SbjNum))

nrow(self$base)

self$base |> mutate(SbjNum = as.numeric(SbjNum)) %>% inner_join(auditoria_telefonica, by = "SbjNum")


# confirmar municipios ---------------------------------------------------------------
enc_neza$muestra$diseno$variables |> 
  distinct(municipio)


# confirmar respuestas satisfacccion ---------------------------------------------------------------
enc_neza$muestra$diseno$variables |> 
  distinct(satisfacion_agua)
