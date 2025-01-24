

# Bloque Programas sociales ---------------------------------------------------------------

# Contar con programas sociales

p_prog_soc_graf <-  
  analizar_frecuencias_aspectos(diseno = enc_neza$muestra$diseno,
                                diccionario = enc_neza$cuestionario$diccionario,
                                patron_pregunta = "prog_soc",
                                aspectos = prog_soc_aspectos) |> 
  filter(!respuesta %in% c('No','Ns/Nc')) |> 
  left_join(enc_neza$cuestionario$diccionario |>  
              select(llaves,tema),
            by = c("aspecto"="llaves")) |> 
  ggplot(aes(x  = reorder(tema, media),
             y = media,
             fill = respuesta)) +
  ggchicklet::geom_chicklet(color = "transparent", width =.6, alpha =.9) +
  ggfittext::geom_fit_text(aes(label = scales::percent(media,accuracy = 1)),
                           size = 10,#size_pct
                           position = position_stack(.5, reverse = T),
                           vjust = .5,
                           contrast = T,
                           show.legend = F) +
  geom_hline(yintercept = 0, color = "#FFFFFF", size = .6) +
  geom_hline(yintercept = 0, color = "gray", size = .6) +
  coord_flip() +
  scale_fill_manual(values = colores_prog_soc,
                    labels = function(x) stringr::str_wrap(string = x, width = 30))+#salto categorias
  labs(x = NULL,
       y = NULL,
       fill = NULL,
       caption = p_prog_soc_tit) +
  scale_x_discrete(labels = function(x) stringr::str_wrap(x, width = 25)) + #salto_tema
  scale_y_continuous(labels = scales::percent_format(accuracy = 1),limits = c(0,.35)) +
  #lemon::scale_y_symmetric(labels = function(x) scales::percent(abs(x), accuracy = 1)) +
  theme_minimal() +
  tema_morant() +
  theme(legend.position = "bottom") +
  theme(axis.text.y = element_text(size = 14),#size_text_cat
        plot.caption = element_text(hjust = 0.5, 
                                    size = 12),  #size_caption
        legend.key.size = unit(1, units = "cm"),
        legend.text = element_text(size = 12)) #size_text_legend


# Principales programas sociales

p_programa_social_graf <- 
enc_neza$Resultados$Descriptiva$barras_multirespuesta(patron_inicial = "programa_social",
                                                      salto = 60,
                                                      porcentajes_fuera = F)+
  scale_fill_manual(values = colores_programa_social) +
  labs(caption = p_programa_social_tit) +
  theme(axis.text.y = element_text(size = 16),
        axis.text.x = element_text(size = 14),
        legend.text = element_text(size = 14))
