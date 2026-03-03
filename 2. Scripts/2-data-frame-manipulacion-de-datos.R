#----------------------------------------------#
#   PROGRAMA DE ESPECIALIZACIÓN EN PSICOMETRÍA #
#     DR. PABLO EZEQUIEL FLORES KANTER         #
#              Segunda Parte                   #
#----------------------------------------------#

# IMPORTAR DATOS ----

## Exportar primero: ----

# Primero creamos una base de datos ficticia:

id <- 1:1000  # Variable de identificación: casos 1 al 1000        

edad <- rnorm(1000, mean = 40, sd = 10) 


genero <- factor(sample(c("Masculino","Femenino","No Binario"), 1000, replace = TRUE,
                          prob = c(.45,.45,.10)))



datos <- data.frame(id,
                    edad,
                    genero) # indico las variables a incorporar en la base 
                     


  # Para esto primero exportemos nuestro data frame en distintos formatos para luego 
# volver a importarlo

write.csv(datos, "datos.csv", row.names = FALSE)# Exporto un archivo .csv (delimitado por comas)

# install.packages("xlsx")
# library(xlsx)
# write.xlsx(datos, "datos.xlsx", row.names = FALSE)# Exporto un archivo .xlsx 

xlsx::write.xlsx(datos, "datos.xlsx", row.names = FALSE)# Atajo para exportar el archivo .xlsx sin necesidad de activar de manera general el paquete

# install.packages("haven")
# library(haven)
# write_sav(datos, "datos.sav")# Exporto un archivo .sav

haven::write_sav(datos, "datos.sav")

## Importar, ahora sí: ----

### Archivos .csv: ----
ds_csv <- read.csv("datos.csv", sep = ",", dec=",", header = TRUE)

str(ds_csv)# Chequear

summary(ds_csv)

ds_csv <- read.csv("datos.csv", sep = ",", dec=".", header = TRUE)

str(ds_csv)# Chequear

summary(ds_csv)

str(ds_csv)# Chequear

summary(ds_csv)

### Archivos .xlsx: ----

ds_xlsx <- xlsx::read.xlsx("datos.xlsx", sheetIndex = 1)
  # Otro modo si tenemos activada el paquete "xlsx" es directamente aplicando la función:
# read.xlsx("datos.xlsx", sheetIndex = 1)
  # Recordar que cuando aparece el nombre de la función con 2 dos puntos consecutivos, 
# como en xlsx:: lo que hacemos es llamar a una función específica del paquete sin necesidad de activar todas las funciones del paquete.

str(ds_xlsx)# Chequear

summary(ds_xlsx)

### Archivos .sav: ----

ds_sav <- haven::read_sav("datos.sav")

str(ds_sav)# Chequear

summary(ds_sav)

ds_sav$Genero <- factor(ds_sav$Genero, labels = c("femenino", "masculino", "no binario"))

str(ds_sav)# Chequear

summary(ds_sav)

  # Podemos lograr todo esto cliqueando también, siempre y cuando se tenga los paquetes 
# instalados (similar a como trabaja JASP o JAMOVI)

## Trabajar con data sets incorporadas en R u otros paquetes ----

# install.packages("psych")

# install.packages("psychTools")

data(package = "psychTools") # Para visualizar las bases de datos que están disponibles.

?bfi # Consultar mayor información sobre esta base de datos.

ds_bfi <- psychTools::bfi # Creo el objeto data frame 

str(ds_bfi) # Reviso la estructura de la base de datos.

dicc_bfi <- psychTools::bfi.dictionary # Creo una data frame para visualizar el diccionario. 

View(dicc_bfi) # Visualizo el diccionario o lo abro desde el entorno de trabajo

key_bfi <- psychTools::bfi.keys # Creo una lista con 5 vectores que me muestran qué ítems
# corresponden con cual factor (así como la dirección de estos indicadores -ítems inversos-).

key_bfi # Visualizo.

# Otro ejemplo de base de datos:

ds_epi <- psychTools::epi

str(ds_epi)

dicc_epi <- psychTools::epi.dictionary

View(dicc_epi)

keys_epi <- psychTools::epi.keys

keys_epi$E

mtx_cattell <- psychTools::cattell

View(mtx_cattell)

# OPERACIONES CON EL DATA FRAME (DF) ----

## Básicas ----

# str() para ver las variables y la clase de variable incluída
# summary() para obtener un análisis de resumen inicial

  # También hicimos algunas conversion de tipo de datos en el DF, cuando arriba transformamos
# la variable a un factor.
# Otros tipos de transformaciones:

# as.numeric - Convierte a tipo numerico
# as.integer - Convierte a tipo entero
# as.character - Convierte a tipo caracter
# as.logical - Convierte a tipo logico o booleano
# as.factor - Convierte a tipo factor
# as.ordered - Convierte a tipo factor ordenado

## Mediante el paquete Tydiverse ----

# Tidyverse es una colección de paquetes de R diseñados para el análisis de datos.

# install.packages("tidyverse")

library(tidyverse)

tidyverse_packages() # conocer los paquetes incluídos

## Piping |> ----

  # Se utiliza |> para encadenar una secuencia de acciones donde el output del paso anterior 
# es el input del actual.
# Hace más eficiente/simple (más corto y directo) el código

## Dplyr ----

# Las funciones del paquete:

# seleccionar --> select(): devuelve un conjunto de columnas (variables)
# renombrar --> rename(): renombra variables en una conjunto de datos
# filtrar --> filter(): devuelve un conjunto de filas  segÃºn una o varias condiciones lógicas
# ordenar filas --> arrange(): reordena filas de un conjunto de datos
# agregar variables/columnas --> mutate(): añade nuevas variables/columnas o transforma variables existentes
# resumir --> summarise() / summarize(): genera resumenes estadisticos de diferentes variables en el conjunto de datos.
# agrupar --> group_by(): agrupa un conjunto de filas seleccionado, en un conjunto de filas de resumen de acuerdo con los valores de una o mÃ¡s columnas o expresiones.


### Ejemplo 1: Mutate, Select, rename ----

ds_bfi <- ds_bfi |>  
  mutate(gender = factor(gender, levels = c(1,2), labels = c("masculino", "femenino"))) |> 
  rename(Genero = gender)


ds_bfi |> 
  select(Genero) |>  
  str()



### Ejemplo 2: Group_by, Select, Summarise ----

ds_bfi |>  
  group_by(Genero) |>  
  select(A1:A5) |> 
  summarise(m_A1 = mean(A1), sd_A1 = sd(A1)) # Indica que hay datos ausentes

ds_bfi |> 
  group_by(Genero) |> 
  select(A1:A5) |> 
  summarise(n = sum(n()),
            m_A1 = mean(A1, na.rm = TRUE), # na.rm = TRUE calcula la media eliminando el caso ausente (listwise deletion/complete-case)
            sd_A1 = sd(A1, na.rm = TRUE),
            min_A1 = min(A1, na.rm = TRUE),
            max_A1 = max(A1, na.rm = TRUE),
            na_A1 = sum(is.na(A1))
              )

### Ejemplo 3: filter ----
 
ds_bfi |> 
  filter(Genero == "masculino") |> 
  select(A1) |> 
  summary()

ds_bfi |> 
  filter(Genero == "femenino") |> 
  select(A1) |> 
  summary()


### Ejemplo 4: select, correlación y descriptivos ----

ds_bfi |> 
  select(A1:A5) |> 
  cor() # Indica que hay datos ausentes

ds_bfi |> 
  select(A1:A5) |> 
  cor(use = "pairwise.complete.obs") # Trabajo solo con los pares de valores que tienen datos. Otra opción es ""

ds_bfi |> 
  select(A1:A5) |> 
  psych::describeBy(group = ds_bfi$Genero)

table_1 <- ds_bfi |> 
  select(A1:A5) |> 
  psych::describeBy(group = ds_bfi$Genero) # Esto genera una lista con dos data frames, 
# donde se muestran los análisis descriptivos en función del género.

table_1

  # Se utiliza doble corchete [[]] para acceder a elementos de una lista (uno x vez), 
# especificando el número de elemento o el nombre:

table_mas <- table_1[["masculino"]]
table_fem <- table_1[[2]]


# ¡Ahora nos mudamos a QUARTO! ----
