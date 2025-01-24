asignar_colores = function(tb_respuestas, partidos = T){
  tb_respuestas |>
    mutate(color = dplyr::case_when(grepl(pattern = "por MORENA, ", x = !!rlang::sym(names(tb_respuestas)[1])) ~ color_morena,
                                    grepl(pattern = "Astiazarán", x = !!rlang::sym(names(tb_respuestas)[1])) ~ color_pri,
                                    grepl(pattern = "por PAN, ", x = !!rlang::sym(names(tb_respuestas)[1])) ~ color_pan,
                                    grepl(pattern = "por Movimiento Ciudadano, ", x = !!rlang::sym(names(tb_respuestas)[1])) ~ color_mc,
                                    grepl(pattern = "MORENA", x = !!rlang::sym(names(tb_respuestas)[1])) ~ color_morena,
                                    grepl(pattern = "Morena", x = !!rlang::sym(names(tb_respuestas)[1])) ~ color_morena,
                                    grepl(pattern = "PAN", x = !!rlang::sym(names(tb_respuestas)[1])) ~ color_pan,
                                    grepl(pattern = "PRI", x = !!rlang::sym(names(tb_respuestas)[1])) ~ color_pri,
                                    grepl(pattern = "PRD", x = !!rlang::sym(names(tb_respuestas)[1])) ~ color_prd,
                                    grepl(pattern = "PT", x = !!rlang::sym(names(tb_respuestas)[1])) ~ color_pt,
                                    grepl(pattern = "PES", x = !!rlang::sym(names(tb_respuestas)[1])) ~ color_pes,
                                    grepl(pattern = "Partido Verde", x = !!rlang::sym(names(tb_respuestas)[1])) ~ color_pvem,
                                    grepl(pattern = "PVEM", x = !!rlang::sym(names(tb_respuestas)[1])) ~ color_pvem,
                                    grepl(pattern = "Movimiento Ciudadano|MC", x = !!rlang::sym(names(tb_respuestas)[1])) ~ color_mc,
                                    grepl(pattern = "Fuerza por", x = !!rlang::sym(names(tb_respuestas)[1])) ~ color_fuerzaxmexico,
                                    grepl(pattern = "Otro", x = !!rlang::sym(names(tb_respuestas)[1])) ~ color_otro,
                                    grepl(pattern = "Ninguno", x = !!rlang::sym(names(tb_respuestas)[1])) ~ color_ninguno,
                                    grepl(pattern = "Candidato independiente", x = !!rlang::sym(names(tb_respuestas)[1])) ~ color_otro,
                                    grepl(pattern = "no registrado", x = !!rlang::sym(names(tb_respuestas)[1])) ~ color_otro,
                                    grepl(pattern = "No iré a votar", x = !!rlang::sym(names(tb_respuestas)[1])) ~ color_ninguno,
                                    grepl(pattern = "Anular", x = !!rlang::sym(names(tb_respuestas)[1])) ~ color_ninguno,
                                    grepl(pattern = "No sabe", x = !!rlang::sym(names(tb_respuestas)[1])) ~ color_nsnc,
                                    grepl(pattern = "No contesta", x = !!rlang::sym(names(tb_respuestas)[1])) ~ color_nsnc,
                                    grepl(pattern = "Ns/Nc", x = !!rlang::sym(names(tb_respuestas)[1])) ~ color_nsnc,
                                    grepl(pattern = "Chiapas Unido", x = !!rlang::sym(names(tb_respuestas)[1])) ~ color_chisunido,
                                    grepl(pattern = "Encuentro Solidario", x = !!rlang::sym(names(tb_respuestas)[1])) ~ color_pencsolchis,
                                    grepl(pattern = "Mover a Chiapas", x = !!rlang::sym(names(tb_respuestas)[1])) ~ color_pmchis,
                                    T ~ color_general)) |>
    pull(color) |>
    purrr::set_names(tb_respuestas |>
                       pull())
}

copiar_archivos_con_nombre_modificado <- function(origen, destino, string_agregar) {
  # Verifica si el directorio de destino existe, si no, lo crea
  if (!dir.exists(destino)) {
    dir.create(destino, recursive = TRUE)
  }
  
  # Obtiene la lista de archivos en el directorio de origen
  archivos <- list.files(origen, full.names = TRUE)
  
  # Itera sobre cada archivo
  for (archivo in archivos) {
    # Extrae el nombre base del archivo
    nombre_base <- basename(archivo)
    
    # Crea el nuevo nombre agregando el string
    nuevo_nombre <- paste0(string_agregar, "_", nombre_base)
    
    # Define la ruta de destino
    ruta_destino <- file.path(destino, nuevo_nombre)
    
    # Copia el archivo al nuevo destino con el nombre modificado
    file.copy(archivo, ruta_destino)
  }
  
  # Mensaje de confirmación
  message("Archivos copiados y renombrados correctamente.")
}

copiar_archivos_con_nombre_modificado <- function(origen, destino, string_agregar) {
  # Verifica si el directorio de destino existe, si no, lo crea
  if (!dir.exists(destino)) {
    dir.create(destino, recursive = TRUE)
  }
  
  # Obtiene la lista de archivos en el directorio de origen
  archivos <- list.files(origen, full.names = TRUE)
  
  # Itera sobre cada archivo
  for (archivo in archivos) {
    # Extrae el nombre base del archivo
    nombre_base <- basename(archivo)
    
    # Divide el nombre y la extensión
    nombre_sin_ext <- tools::file_path_sans_ext(nombre_base)
    extension <- tools::file_ext(nombre_base)
    
    # Crea el nuevo nombre agregando el string antes de la extensión
    nuevo_nombre <- paste0(nombre_sin_ext, "_", string_agregar, ".", extension)
    
    # Define la ruta de destino
    ruta_destino <- file.path(destino, nuevo_nombre)
    
    # Copia el archivo al nuevo destino con el nombre modificado
    file.copy(archivo, ruta_destino, overwrite = TRUE)
  }
  
  # Mensaje de confirmación
  message("Archivos copiados y renombrados correctamente.")
}


copiar_archivo_a_varias_ubicaciones <- function(ubicacion_origen, nombre_archivo, directorios_destino, sobrescribir = TRUE) {
  # Ruta completa del archivo de origen
  archivo_origen <- file.path(ubicacion_origen, nombre_archivo)
  
  # Verificar si el archivo de origen existe
  if (!file.exists(archivo_origen)) {
    stop("El archivo de origen no existe.")
  }
  
  # Iterar sobre los directorios de destino
  for (directorio in directorios_destino) {
    # Crear el directorio de destino si no existe
    if (!dir.exists(directorio)) {
      dir.create(directorio, recursive = TRUE)
    }
    
    # Crear la ruta completa del archivo de destino
    archivo_destino <- file.path(directorio, nombre_archivo)
    
    # Copiar el archivo al destino con la opción de sobrescribir
    resultado <- file.copy(from = archivo_origen, to = archivo_destino, overwrite = sobrescribir)
    
    # Mostrar un mensaje sobre el resultado
    if (resultado) {
      message(paste("Archivo copiado a:", archivo_destino))
    } else {
      message(paste("No se pudo copiar el archivo a:", archivo_destino))
    }
  }
}

