#----------------------------------------------#
#   PROGRAMA DE ESPECIALIZACIÓN EN PSICOMETRÍA #
#     DR. PABLO EZEQUIEL FLORES KANTER         #
#              Segunda Parte                   #
#----------------------------------------------#

# IMPORTAR DATOS ----

## Exportar primero: ----

# Primero creamos una base de datos ficticia:

id <- 1:1000   # Variable de identificación: casos 1 al 1000         

edad <- rnorm(1000, mean = 40, sd = 10) 

genero <- factor(sample(c("Masculino","Femenino","No Binario"), 1000, replace = TRUE,
                          prob = c(.45,.45,.10)))


datos <- data.frame(id,
                    edad,
                    genero) # indico las variables a incorporar en la base 
                     

  # Para esto primero exportemos nuestro data frame en distintos formatos para luego 
# volver a importarlo.
  # Instalaremos primero el paquete "here" que facilita el trabajo dentro de un proyecto
# en R.

# install.packages("here")

  # Instalaremos también el paquete Tidyverse, que es una colección de paquetes de R 
# diseñados para facilitar todos los procesos involucurados en el análisis de datos.

# install.packages("tidyverse")

tidyverse::tidyverse_packages() # Para visualizar los paquetes que se incluyen.

  # Recordar que cuando aparece el nombre de la función con 2 dos # puntos consecutivos, 
# como en tidyverse:: lo que hacemos es llamar a una función específica del paquete sin 
# necesidad de activar todas las funciones del paquete.

### Exportación en .csv: ----

readr::write_csv(datos, here::here("3. Base-de-datos", "datos.csv"))

### Exportación en .xlsx: ----

# install.packages("writexl")

writexl::write_xlsx(datos, here::here("3. Base-de-datos", "datos.xlsx"))

### Exportación en .sav: ----

haven::write_sav(datos, here::here("3. Base-de-datos", "datos.sav"))

## Importar, ahora sí: ----

### Archivos .csv: ----
ds_csv <- readr::read_csv(here::here("3. Base-de-datos", "datos.csv"))

ds_csv

  # `read_csv()` asume que los campos están delimitados por comas. Sin embargo, 
# en varios países la coma se utiliza como separador decimal y el punto y coma (;) 
# se usa como delimitador de campos. Si deseas leer este tipo de archivos en R, 
# puedes utilizar la función `read_csv2`. Esta funciona exactamente igual que `read_csv`, 
# pero usa parámetros diferentes para el separador decimal y el separador de campos.
  # Si trabajas con otro formato, ambos separadores pueden ser especificados por el usuario.
# Puedes consultar la ayuda de `read_csv()` escribiendo `?read_csv` para obtener más 
# información. También existe `read_tsv()` para archivos de datos separados por 
# tabulaciones, y `read_delim()` permite especificar con mayor detalle la estructura de tu 
# archivo.

### Archivos .xlsx: ----

ds_xlsx <- readxl::read_xlsx(here::here("3. Base-de-datos", "datos.xlsx"))

ds_xlsx

### Archivos .sav: ----

ds_sav <- haven::read_sav((here::here("3. Base-de-datos", "datos.sav")))

ds_sav

  # Podemos lograr todo esto cliqueando también, siempre y cuando se tenga los paquetes 
# instalados (similar a como trabaja JASP o JAMOVI). Sin embargo, esto puede afectar la
# reproducibilidad si no se tiene adeacuadamente reportado en el script este proceso.

## Trabajar con data sets incorporadas en R u otros paquetes ----

### El paquete Rdatasets: ----
# Rdatasets es una colección de 3485 bases de datos que se encuentran directamente en R 
# o en algunos de sus paquetes complementarios (https://vincentarelbundock.github.io/Rdatasets/articles/data.html).

  # install.packages("Rdatasets")

Rdatasets::rdsearch("emo") # Rastrear base de datos por algún termino clave.
Rdatasets::rddocs("Harman.5") # Conocer más sobre una determinada base de datos.

### Bases de datos dentro de paquetes específicos: ----

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

  # También hicimos algunas conversion de tipo de datos en el DF, cuando transformamos
# variables a tipo factor.
# Otros tipos de transformaciones:

# as.numeric - Convierte a tipo numerico
# as.integer - Convierte a tipo entero
# as.character - Convierte a tipo caracter
# as.logical - Convierte a tipo logico o booleano
# as.factor - Convierte a tipo factor
# as.ordered - Convierte a tipo factor ordenado

## Mediante el paquete Tydiverse ----

### Dplyr ----

# Las funciones del paquete:

  # seleccionar --> select(): devuelve un conjunto de columnas (variables)
  # renombrar --> rename(): renombra variables en una conjunto de datos
  # filtrar --> filter(): devuelve un conjunto de filas  segÃºn una o varias condiciones lógicas
  # ordenar filas --> arrange(): reordena filas de un conjunto de datos
  # agregar variables/columnas --> mutate(): añade nuevas variables/columnas o transforma 
# variables existentes
  # resumir --> summarise() / summarize(): genera resumenes estadisticos de diferentes 
# variables en el conjunto de datos.
  # agrupar --> group_by(): agrupa un conjunto de filas seleccionado, en un conjunto de filas 
# de resumen de acuerdo con los valores de una o mÃ¡s columnas o expresiones.


#### Ejemplo 1: Mutate, Select, rename ----

# La importancia del encadenando de operaciones con el operador pipe |> 
  # Se utiliza el |> para encadenar una secuencia de acciones donde el output del paso anterior 
# es el input del actual.
# Hace más eficiente/simple (más corto y directo) el código

ds_bfi <- ds_bfi |>  
  mutate(gender = factor(gender, levels = c(1,2), labels = c("masculino", "femenino"))) |> 
  rename(Genero = gender)

# En lugar de:

ds_bfi_paso_1 <- dplyr::mutate(ds_bfi, gender = factor(gender, levels = c(1,2), labels = c("masculino", "femenino")))

ds_bfi_paso_2 <- dplyr::rename(ds_bfi_paso_1, Genero = gender)

ds_bfi <- ds_bfi_paso_2


# Otro ejemplo:

ds_bfi |> 
  dplyr::select(Genero) |>  
  str()


#### Ejemplo 2: Group_by, Select, Summarise ----

ds_bfi |>  
  dplyr::group_by(Genero) |>  
  dplyr::select(A1:A5) |> 
  dplyr::summarise(m_A1 = mean(A1), sd_A1 = sd(A1)) # "NA" Indica que hay datos ausentes

# na.rm para poder obtener el estadístico omitiendo los casos ausentes.
  # na.rm = TRUE calcula el estadístico eliminando el caso ausente 
# (listwise deletion/complete-case)

ds_bfi |>  
  dplyr::group_by(Genero) |>  
  dplyr::select(A1:A5) |> 
  dplyr::summarise(m_A1 = mean(A1, na.rm = TRUE), sd_A1 = sd(A1, na.rm = TRUE))

# Otro ejemplo:

ds_bfi |> 
  group_by(Genero) |> 
  select(A1:A5) |> 
  summarise(n = sum(n()),
            m_A1 = mean(A1, na.rm = TRUE), 
            sd_A1 = sd(A1, na.rm = TRUE),
            min_A1 = min(A1, na.rm = TRUE),
            max_A1 = max(A1, na.rm = TRUE),
            na_A1 = sum(is.na(A1))
              )

#### Ejemplo 3: filter ----
 
ds_bfi |> 
  filter(Genero == "masculino") |> 
  select(A1) |> 
  summary()

ds_bfi |> 
  filter(Genero == "femenino") |> 
  select(A1) |> 
  summary()


#### Ejemplo 4: select, correlación y descriptivos ----

ds_bfi |> 
  select(A1:A5) |> 
  cor() # Indica que hay datos ausentes

ds_bfi |> 
  select(A1:A5) |> 
  cor(use = "pairwise.complete.obs") # Trabajo solo con los pares de valores que tienen datos. Otra opción es ""

ds_bfi |> 
  select(A1:A5) |> 
  psych::describeBy(group = ds_bfi$Genero)

table_1 <- ds_bfi |> # Guardo en un objeto llamado table_1
  select(A1:A5) |> 
  psych::describeBy(group = ds_bfi$Genero) # Esto genera una lista con dos data frames, 
# donde se muestran los análisis descriptivos en función del género.

table_1

  # Se utiliza doble corchete [[]] para acceder a elementos de una lista (uno x vez), 
# especificando el número de elemento o el nombre:

table_mas <- table_1[["masculino"]]
table_fem <- table_1[[2]]


# ¡Ahora nos mudamos a QUARTO! ----
