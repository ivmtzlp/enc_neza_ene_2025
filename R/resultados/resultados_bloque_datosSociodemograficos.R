source(file = "./R/constantes_bloque07_datosSociodemograficos.R")

# Bloque Datos Sociodemograficos --------------------------------------------------------------

# Lenguas indigenas

p9.0_graf <- 
enc_neza$Resultados$Descriptiva$gauge_categorica(codigo = 'indigena',
                                                 filtro = 'respuesta == "Sí"',
                                                 color = color_general)+
  labs(title = p_lengua_indigena_tit, caption = 'Nota: Pregunta respondida por personas que contestaron "Sí"')+
  encuestar::tema_transparente()





bd_edad_sexo <- 
  srvyr::as_survey_design(enc_neza$muestra$diseno)

#Edad y sexo
p9.1_graf <-
  bd_edad_sexo %>%
  mutate(edad = as.integer(edad)) |>
  filter(edad < 100,  edad >= 18) %>%
  mutate(sexo = case_when(sexo == "F" ~ "Mujer",
                          sexo == "M" ~ "Hombre")) %>%
  mutate(edad = ifelse(test = edad >= 18 & edad <= 20, yes = "18 a 20", no = (5*ceiling(edad/5)))) %>%
  group_by(sexo,edad) %>%
  summarise(srvyr::survey_total(na.rm=T, vartype=NULL)) %>%
  ungroup() %>%
  mutate(tot=sum(coef, na.rm=T),
         coef=coef/tot) %>%
  mutate(coef = case_when(sexo == "Hombre" ~ -coef,
                          T  ~ coef)) %>%
  mutate(rango = case_when(edad == 25 ~ "21-25",
                           edad == 30 ~ "26-30",
                           edad == 35 ~ "31-35",
                           edad == 40 ~ "36-40",
                           edad == 45 ~ "41-45",
                           edad == 50 ~ "46-50",
                           edad == 55 ~ "51-55",
                           edad == 60 ~ "56-60",
                           edad == 65 ~ "61-65",
                           edad == 70 ~ "66-70",
                           edad == 75 ~ "71-75",
                           edad == 80 ~ "76-80",
                           edad == 85 ~ "81-85",
                           edad == 90 ~ "86-90",
                           edad == 95 ~ "91-95",
                           T ~ edad)) %>%
  ggplot(aes(x = rango, y = coef, fill = sexo, label = scales::percent(abs(coef), 1))) +
  ggchicklet::geom_chicklet(alpha = 0.9) +
  coord_flip() +
  scale_fill_manual(values = c(color_h, color_m)) +
  ggfittext::geom_bar_text(contrast = TRUE) +
  lemon::scale_y_symmetric(labels = function(x) scales::percent(abs(x), accuracy = 1)) +
  encuestar:::tema_morant() +
  theme(legend.title = element_blank(),
        axis.title.y = element_text(family = font_family, colour = font_color, size = 18),
        legend.text = element_text(size = 16),
        plot.background = element_rect(color = "transparent",fill = "transparent"),
        panel.background = element_rect(color = "transparent",fill = "transparent")) +
  labs(x = "Rango de edad",y=NULL)

## Gráfico de grados de estudios
p9.2_bd <-
  encuestar:::analizar_frecuencias(diseno = enc_neza$muestra$diseno,
                                  pregunta = "estudios") |>
  select(respuesta, media)

p9.2_graf <-
  p9.2_bd |>
  ggplot(aes(x = factor(respuesta, levels = rev(c("No estudió",
                                                  "Primaria incompleta",
                                                  "Primaria completa",
                                                  "Secundaria incompleta",
                                                  "Secundaria completa",
                                                  "Preparatoria incompleta",
                                                  "Preparatoria completa",
                                                  "Licenciatura incompleta",
                                                  "Licenciatura completa",
                                                  "Diplomado o maestría",
                                                  "Doctorado",
                                                  "No contesta"))),
             y = media,
             fill = respuesta)) +
  ggchicklet::geom_chicklet(width = 0.6, alpha = 0.9) +
  ggfittext::geom_bar_text(aes(label = scales::percent(media, accuracy = 1.)), contrast = T) +
  coord_flip() +
  scale_y_continuous(labels = scales::percent) +
  scale_fill_manual(values = colores_estudios) +
  encuestar:::tema_morant() +
  labs(caption = p_estudios_tit, x = NULL, y = NULL) +
  theme(legend.position = "none",
        plot.caption = element_text(family = font_family, colour = font_color, size = 14),
        axis.text.x = element_text(family = font_family, colour = font_color, size = 14),
        axis.text.y = element_text(family = font_family, colour = font_color, size = 14),
        plot.background = element_rect(color = "transparent",fill = "transparent"),
        panel.background = element_rect(color = "transparent",fill = "transparent"))

# # INFLUENCIA VS REGION
# bd_estudios_voto_pm_24 <-
#   srvyr::as_survey_design(enc_neza$muestra$diseno) %>%
#   group_by(estudios_grupo, voto_pm_24) |>
#   summarise(srvyr::survey_mean(na.rm = TRUE, vartype = "cv")) |> 
#   na.omit() |> 
#   mutate(coef = coef/sum(coef)) |> 
#   rename(var_x = estudios_grupo,
#          var_y = voto_pm_24,
#          media = coef)
# 
# # p_region_influencia_voto_pm_24_graf <-
# estudios_voto_pm_24_graf <-
#   bd_estudios_voto_pm_24 |>
#   filter(grepl(pattern = "Antonio|María", x = var_y)) |> 
#   ungroup() |> 
#   graficar_cruce_lineas(orden_var_x = c("No estudió",
#                                         "Primaria",
#                                         "Secundaria",
#                                         "Preparatoria",
#                                         "Licenciatura",
#                                         "Posgrado",
#                                         "No contesta"), 
#                         colores = colores_voto_pm_24, 
#                         salto_x = 11, 
#                         salto_legend = 45, 
#                         limits = c(0, 0.8), 
#                         text_nudge_y = 0.10) +
#   theme(axis.text.x = element_text(size = 12, angle = 45, vjust = 0.5))

## Gráfico de principal ocupación
p8.3_graf <- 
  enc_neza$Resultados$Descriptiva$barras_categorica(codigo = "ocupacion",
                                                             salto = 30,
                                                             pct_otros = 0.01) +
  scale_fill_manual(values = colores_ocupacion) +
  labs(caption = p_ocupacion_tit) +
  encuestar:::tema_morant()+
  theme(legend.position = "none",
        plot.title = element_blank(),
        plot.caption = element_text(size = 16),
        axis.text.y = element_text(size = 14),
        plot.background = element_rect(color = "transparent",fill = "transparent"),
        panel.background = element_rect(color = "transparent",fill = "transparent"))

## Gráfico de salario
p8.4_bd <- 
  encuestar:::analizar_frecuencias(diseno = srvyr::as_survey_design(enc_neza$muestra$diseno),
                                  pregunta = "salario") |>
  select(respuesta, media) |> 
  mutate(respuesta = gsub(' \\(no leer\\)',"",x =respuesta))

p8.4_graf <- 
  p8.4_bd |>
  ggplot(aes(x = factor(respuesta, levels = rev(c("De 0 a 2,500",
                                                  "De 2,501 a 5,000",
                                                  "De 5,001 a 7,500",
                                                  "De 7,501 a 10,000",
                                                  "De 10,001 a 12,500",
                                                  "De 12,501 a 15,000",
                                                  "Más de 15,001",
                                                  "No contesta"))),
             y = media,
             fill = respuesta)) +
  ggchicklet::geom_chicklet(width = 0.6, alpha = 0.9) +
  ggfittext::geom_bar_text(aes(label = scales::percent(media, accuracy = 1.)), contrast = T) +
  coord_flip() +
  scale_y_continuous(labels = scales::percent) +
  scale_fill_manual(values = colores_salario) +
  encuestar:::tema_morant() +
  labs(caption = p_salario_tit, x = NULL, y = NULL) +
  theme(legend.position = "none",
        plot.caption = element_text(family = font_family, colour = font_color, size = 14),
        axis.text.x = element_text(family = font_family, colour = font_color, size = 14),
        axis.text.y = element_text(family = font_family, colour = font_color, size = 14),
        plot.background = element_rect(color = "transparent",fill = "transparent"),
        panel.background = element_rect(color = "transparent",fill = "transparent"))

# bd_salario_voto_pm_24 <-
#   srvyr::as_survey_design(enc_neza$muestra$diseno) %>%
#   group_by(salario, voto_pm_24) |>
#   summarise(srvyr::survey_mean(na.rm = TRUE, vartype = "cv")) |> 
#   na.omit() |> 
#   mutate(coef = coef/sum(coef)) |> 
#   rename(var_x = salario,
#          var_y = voto_pm_24,
#          media = coef)
# 
# # p_region_influencia_voto_pm_24_graf <-
# salario_voto_pm_24_graf <-
#   bd_salario_voto_pm_24 |>
#   filter(grepl(pattern = "Antonio|María", x = var_y)) |> 
#   ungroup() |> 
#   graficar_cruce_lineas(orden_var_x = c("De 0 a 3,000",
#                                         "De 3,001 a 6,000",
#                                         "De 6,001 a 9,000",
#                                         "De 9,001 a 12,000",
#                                         "De 12,001 a 15,000",
#                                         "De 15,001 a 18,000",
#                                         "Más de 18,001",
#                                         "No contesta"), 
#                         colores = colores_voto_pm_24, 
#                         salto_x = 15, 
#                         salto_legend = 45, 
#                         limits = c(0, 0.8), 
#                         size_text = 6)



# # VOTO PM X OCUPACION
# 
# base_hermosillo<-enc_neza$respuestas$base |>
#   mutate(peso = stats::weights(enc_neza$muestra$diseno))
# 
# 
# orden_ocupacion_pm <-encuestar:::analizar_frecuencias(diseno = enc_neza$muestra$diseno, 
#                                                       pregunta = 'ocupacion') |>
#   mutate(respuesta = forcats::fct_lump_min(f = respuesta, min = 0.01, w = media, other_level = "Otros"),
#          respuesta = dplyr::if_else(condition = respuesta == "Otro", true = "Otros", false = respuesta)) %>%
#   group_by(respuesta) |>
#   summarise(media = sum(media)) |>ungroup()|>
#   pull(respuesta)
# 
# bd_ocupacion_pm <-base_hermosillo|>
#   filter(!is.na(voto_pm_24))|>
#   filter(!voto_pm_24 %in% c('No recuerda','No contesta')  )|>
#   mutate(ocupacion =   ifelse(ocupacion %in%  orden_ocupacion_pm, ocupacion,'Otros'))|>
#   #filter(!is.na(ocupacion))|>
#   count(ocupacion,voto_pm_24,wt = peso)|>
#   group_by(ocupacion)|>
#   mutate(media=n/sum(n))|>
#   ungroup()
# 
# 
# ocupacion_voto_pm_24_graf<-bd_ocupacion_pm|>  
#   tidyr::complete(ocupacion, 
#                   tidyr::nesting(voto_pm_24),
#                   fill = list(media = 0)) |> 
#   ggplot(aes(y = factor(voto_pm_24, levels = rev(c("Antonio Astiazarán por PAN-PRI-PRD",
#                                                    "María Dolores del Río por MORENA-PT-Partido Verde- Nueva Alianza y PES",
#                                                    "Natalia Rivera Grijalva por Movimiento Ciudadano",
#                                                    "Juan Eduardo Ruiz por Partido Sonorense",
#                                                    "Anulé mi voto",
#                                                    "Otro"))),
#              x = factor(ocupacion, levels = orden_ocupacion_pm), 
#              fill = media)) +
#   geom_tile() +
#   geom_text(aes(label = scales::percent(x = media, accuracy = 1.0)), 
#             size = 6) +
#   labs(x = "", y = "", 
#        caption = advertir(string = p_voto_pm_24_tit, 
#                           complemento = "a quienes afirmaron haber votado el pasado 2 de junio")) +
#   scale_x_discrete(position = "top", 
#                    labels = function(x) stringr::str_wrap(string = x, width = 15)) +
#   scale_y_discrete(labels = function(x) stringr::str_wrap(string = x, width = 25)) +
#   scale_fill_gradient(low = "white", 
#                       high = color_buena) +
#   theme_minimal() +
#   theme(text = element_text(family = "Poppins"), 
#         legend.position = "none",
#         axis.text.x = element_text(size = 8),
#         axis.text.y = element_text(size = 10), 
#         plot.caption = element_text(size = 14),
#         plot.subtitle = element_text(size = 16))






