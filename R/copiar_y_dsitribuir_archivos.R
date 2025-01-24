


# Ejemplo de uso
ubicacion_origen <- "./Insumos"
nombre_archivo <- "plantilla_general_09_12_24.pptx"


directorios_destino<- c("../enc_toluca_ene_2025/Insumos", # Toluca
"../enc_ecatepec_ene_2025/Insumos", #ecatepec
"../enc_nauc_ene_2025/Insumos", # naucalpan
"../enc_texcoco_ene_2025/Insumos", # texcoco
"../enc_tulti_ene_2025/Insumos", # tultitlan
"../enc_rest_edomex_ene_2025/Insumos", #resto edomex
"../enc_cuatli_ene_2025/Insumos", # cuatitlan
"../enc_atizapan_ene_2025/Insumos", # atizapan
"../enc_chimal_ene_2025/Insumos") # chimalg¿huacan

#"../enc_toluca_ene_2025/Insumos",

copiar_archivo_a_varias_ubicaciones(ubicacion_origen, nombre_archivo, directorios_destino)




