
# Bloque Datos Sociodemograficos --------------------------------------------------------------

p_lengua_indigena_tit <- 
  dicc |> 
  filter(llaves == "indigena") |> 
  pull(pregunta) |> 
  stringr::str_wrap(width = 40)


# colores_estudios <-   
#   enc_neza$muestra$diseno$variables |> 
#   as_tibble() |> 
#   distinct(estudios) |> 
#   asignar_colores()

# Estudios

p_estudios_tit <- 
  dicc |> 
  filter(llaves == "estudios") |> 
  pull(pregunta) |> 
  stringr::str_wrap(width = 60)

colores_estudios <-   
  enc_neza$muestra$diseno$variables |> 
  as_tibble() |> 
  distinct(estudios) |> 
  asignar_colores()

# Ocupacion

p_ocupacion_tit <- 
  dicc |> 
  filter(llaves == "ocupacion") |> 
  pull(pregunta) |> 
  stringr::str_wrap(width = 60)

colores_ocupacion <- 
  enc_neza$muestra$diseno$variables |> 
  as_tibble() |> 
  distinct(ocupacion) |> 
  asignar_colores()

# Salario

p_salario_tit <- 
  dicc |> 
  filter(llaves == "salario") |> 
  pull(pregunta) |> 
  stringr::str_wrap(width = 60)

colores_salario <- 
  enc_neza$muestra$diseno$variables |> 
  as_tibble() |> 
  distinct(salario) |> 
  asignar_colores()

