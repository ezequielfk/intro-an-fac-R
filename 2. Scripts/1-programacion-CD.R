    # ____________________________________________ #   
   #   PROGRAMA DE ESPECIALIZACIÓN EN PSICOMETRÍA #
  #      DR. PABLO EZEQUIEL FLORES KANTER        #
 #              Primera Parte                   #
# ____________________________________________ #


# Crear un Nuevo Projecto: ----
  # Es una buena práctica mantener conjuntos de datos, análisis y texto
# contenidos en una sola carpeta llamada directorio de trabajo (working directory). 
  # Todos los scripts dentro de esta carpeta pueden utilizar rutas relativas a los archivos.
  # Las rutas relativas indican dónde se encuentra un archivo dentro del proyecto 
# (a diferencia de las rutas absolutas, que señalan la ubicación de un archivo en 
# una computadora específica). Trabajar de esta manera facilita mucho mover el proyecto 
# dentro de tu equipo y compartirlo con otras personas sin tener que modificar directamente
# las rutas en cada script.
  # RStudio ofrece un conjunto útil de herramientas para esto a través de su interfaz de 
# “Proyectos”, que no solo crea un directorio de trabajo, sino que también recuerda su 
# ubicación (permitiendo acceder rápidamente a él).

  # File -->> New Project...

  # Utilizar una estructura de carpetas consistente en todos tus proyectos te ayudará a 
# mantener el orden y facilitará la localización y organización de archivos en el futuro. 
  # Esto resulta especialmente útil cuando trabajas con múltiples proyectos. 
  # En general, puedes crear directorios (carpetas) para scripts, datos y documentos.
  # Podemos crearlas utilizando la interfaz de RStudio haciendo clic en el botón 
# “New Folder” en el panel de archivos (Files), o directamente desde R escribiendo en 
# por ejemplo en la consola:

# dir.create("data")

   
# Personalizar R-Studio: ----
  # Tools -->> Global Options...
  # Allí se podrá cambiar apariencia y distribución de los paneles/ventanas, 
# así como seleccionar las pestañas que se visualizan en algunos de estos paneles.

# script, comentarios ----

  # Un script es un archivo tipo texto que contiene un listado secuencial de 
# lineas de codigo: instrucciones escritas en un lenguaje específico.
  # Un script debe estar ordenado.
  # Todo lo escrito luego de un simbolo hash (#) es leido por R como un comentario 
# y no será tenido en cuenta cuando se ejecute el código.
  # Para que un comentario sea considerado como sección se aplica tanto el hash 
# como los guiones (----).

# OPERADORES EN R. ----

## R como calculadora: operadores aritmeticos ----

5 + 2
2 / 3
5 ^ 2
((10-3)*(4 + 8)) ^ 3

## Operadores Relacionales ----

  # Los operadores relacionales son simbolos mediante los cuales podemos realizar 
# operaciones. 
  # Como resultado obtenemos objetos de clase logical, que pueden adoptar los valores 
# TRUE o FALSE

8 > 1 # TRUE (8 es mayor que 1?)
3 < 2 # FALSE (3 es menor que 2?)
3 == 2 # FALSE (3 es igual a 2?)
7 == 7 # TRUE (7 es igual a 7?)
5 != 5 # FALSE (5 es distinto de 5?)

# OBJETOS ----

## Variables u Objetos. Asignaciones (<-) ----

x <- 2
x

(x <- 2) # De esta manera, se imprime el valor del objeto en la consola.

  #! Siempre hay diferentes maneras de lograr el mismo resultado:

x = 3
x

4 -> x
x

assign("x",
       5) # aplicando la función assign()
x

  # Una función puede entenderse como un conjunto de operaciones sistematizadas.
  # La función necesita datos de entrada (argumentos) y devuelve una salida o conjunto 
# de salidas/resultados.

  #! Si tenemos dudas sobre los datos de entrada de la función podemos pedir ayuda con "?":

?assign

args(assign) # Otra manera de conocer los argumentos que se utilizan en la función.

  #! Los nombres de las variables/objetos pueden contener cualquier combinación de 
# caracteres alfanuméricos en conjunto con puntos y guiones bajos. 
  #  No pueden comenzar con números o guiones bajos.
  #  Los nombres de los objetos en R distinguen mayúsculas de minúscula:

x <- 5
X <- 6

x
X

  # Remover objetos:
x
rm(x)
x

## Tipo de datos que puede contener un Objeto ----

  # Los tipos de datos más comúnmente incluídos en los objetos son de tipo: 
# numeric, character (string), factor (categorical) y lógica (TRUE/FALSE)

### Datos numéricos: ----

x <- 5
x
class(x) # Función para chequear el tipo de dato que contiene el objeto.

### Datos de tipo character: ----

x <- "Aguante RStudio"
x
class(x)

### Datos de tipo factor (variables nominales y categóricas): ----

  # Primero creamos un vector

dias_v <- c("lunes", 
            "martes",
            "viernes",
            "miércoles", 
            "jueves", 
            "viernes", 
            "lunes", 
            "viernes") #! esto es un vector

dias_v # visualizo el objeto/variable

class(dias_v) # consulto la clase de objeto

summary(dias_v) # solicito un resumen de la información que contiente este objeto


  # Al transformar el vector en un factor se agrupan en niveles los valores dentro 
# del vector.  
  # Los niveles de un factor son los valores únicos contenidos en el vector.

  # Ejemplo de factor no ordenado (variable nominal):

dias_f1 <- factor(dias_v) 

class(dias_f1)

summary(dias_f1)

  # Ejemplo de factor ordenado (variable ordinal):

dias_f2 <- factor(dias_v, 
                 ordered = TRUE, # especifico que los valores tienen un orden.
                 levels = c("lunes", 
                            "martes", 
                            "miércoles", 
                            "jueves", 
                            "viernes")) # especifico el orden de los valores.
dias_f2

class(dias_f2)

summary(dias_f2)

# Otro ejemplo de variable nominal:

genero_v <- c("masculino", 
              "femenino", 
              "no binario",
              "masculino", 
              "femenino",
              "no binario",
              "masculino", 
              "femenino",
              "masculino", 
              "femenino")
genero_v

summary(genero_v)

genero_f <- factor(genero_v)

genero_f

class(genero_f)

summary(genero_f)

# TIPOS DE OBJETOS ----

## Vectores ----

# Colección de elementos, todos del mismo tipo (ejemplo, elementos numéricos o 
# de tipo character), y que mantienen un orden determinado.

vector <- c(2, 
            5, 
            6, 
            7, 
            2) # la función "c()" se utiliza para combinar los elementos en un vector. 
vector

vector2 <- -2:2 # atajo para crear un vector con valores consecutivos.

# Poner una etiqueta o nombre a cada elemento del vector, utilizando el par etiqueta-valor.

vector3 <- c(Sí = 1, 
             No = 0)
vector3

# Alternativamente con la función names():

vector3 <- c(1,
             0)

names(vector3) <- c("mujer", 
                    "varón")

vector3

# Para averiguar la longitud del vector (cantidad de elementos), usamos la función lenght():

length(vector)

length(vector2)

# Para acceder a los elementos individuales de un vector se usan los corchetes "[ ]":

vector # recordar los elementos del vector

vector[2] # el elemento del vector que está en el segundo lugar.
vector[1:2] # los primeros dos elementos.

vector[c(3,
         5)] # para elementos no consecutivos: el que está en tercer y quinto lugar. 

vector[c(3,
         6)]

### Operaciones con Vectores ----  

vector # recordar los elementos del vector

vector * 2 # al ser R un lenguaje vectorizado, la operación se realiza para 
# cada elemento del vector de manera automática sin necesidad de crear un loop o ciclo.

# Si tengo dos vectores de igual tamaño (o de distinto tamaño pero siendo el vector 
# de mayor tamaño múltiplo del de menor tamaño): 

vector # recordar los elementos del vector

vector2 # recordar los elementos del vector

vector + vector2


# Podemos utilizar la función c() para agregar otros elementos al vector:

(vector <- c(vector, 10:20)) # para agregar los nuevos elementos al final del vector

(vector <- c(6,6,6, vector)) # para agregar los nuevos elementos al inicio del vector

# Puedo también utilizar operaciones lógicas en los vectores:

vector <= 5

vector > vector2

all(vector <= 5) # probar si TODOS los elementos del vector son TRUE en la condición consultada.
any(vector <= 5) # probar si ALGUNO de los elementos del vector son TRUE en la condición consultada. 

  # Puedes combinar múltiples condiciones utilizando `&` (ambas condiciones son verdaderas, 
# AND) o `|` (al menos una de las condiciones es verdadera, OR):

(vector_red <- vector[vector <= 5 | vector > 10]) # al menos una condición verdadera 

(vector_red <- vector[vector <= 5 & vector > 2]) # ambas condiciones verdaderas

## Data Frame (DF) ----

  # Similar a una hoja de cálculo de excel en donde tenemos filas y columnas. 
  # En un data.frame, cada columna es un vector (variable) y estos vectores tienen 
# la misma longitud (cantidad de casos). 
  # Cada columna (vector) puede contener distintos tipos de datos; 
# pero dentro de cada columna todos los elementos deben ser del mismo tipo. 

### Creacion de un DF ----

  # creamos 4 vectores con 4 valores cada uno

v_id <- 1:20          
v_edad <- sample(18:65,
                 20)
?sample

v_edad

anyDuplicated(v_edad)

v_edad <- sample(18:65,
                 20,
                 replace = TRUE)

anyDuplicated(v_edad)


genero <- c("Masculino", 
            "Femenino", 
            "No Binario")

v_genero <- sample(genero, 
                   20,
                   replace = TRUE)

v_genero <- factor(v_genero)

summary(v_genero)


v_genero <- sample(genero, 
                   20,
                   prob = c(.45,
                            .45,
                            .10),
                   replace = TRUE)

v_genero <- factor(v_genero)

summary(v_genero)

datos <- data.frame(v_id, 
                    v_edad, 
                    v_genero)
datos

View(datos)

# Ejemplo de creación de DF con funciones de probabilidad:

# creamos 4 vectores (variables)

id <- 1:1000  # Variable de identificación: casos 1 al 1000        

edad <- sample(18:65,1000) # Variable edad. Utilizo la función "sample" para crear 1000 valores aleatorios entre los valores 18 y 65

edad <- sample(18:65, 1000, replace = TRUE) # Tengo que hacer un muestreo con reposición 

hist(edad) # Visualizar la distribución de la variable edad (distribución uniforme)

edad_2 <- runif(1000, min = 18, max = 65) # Manera alternativa de generar la variable edad a través de la función para generar distribuciones uniformes: "runif"

hist(edad_2)

edad_3 <- rnorm(1000, mean = 40, sd = 10) 

hist(edad_3)

genero <- factor(sample(c("Masculino","Femenino","No Binario"), 1000, replace = TRUE)) # Variable género

plot(genero)

genero_2 <- factor(sample(c("Masculino","Femenino","No Binario"), 1000, replace = TRUE,
                          prob = c(.45,.45,.10)))

plot(genero_2)


### Operaciones con el DF ----

datos <- data.frame(ID = v_id, 
                    Edad = v_edad, 
                    Genero = v_genero) # cambiar nombre a los vectores
datos

class(datos) # verifico la clase de objeto

str(datos) # miro estructura del conjunto de datos

summary(datos) # resumo la información de las respectivas variables

datos$Genero # selecciono la variable sexo del DF

summary(datos$Genero) # resumo solo la información de la variable género

plot(datos$Genero) # la función plot() me permite generar un gráfico de resumen

datos[,3] # otras maneras de acceder a los elementos del DF: 
# consulta por los elementos de la columna (vector) 3

datos[1,2] # Consulta por el elemento de la fila 1 columna 2

head(datos) # visualizar las primeras 6 observaciones del conjunto de datos

tail(datos) # visualizar las últimas 6 observaciones del conjunto de datos


## Lista ----

  # Contenedor o repositorio, que puede contener una serie de objetos arbitrarios 
# de distinto tipo. 

  # Para crear una lista se utiliza la función list():

milista <- list(numeros = 1:5,
                ciudades = c("Buenos Aires", "Rosario", "Neuquen"),
                ds = datos)
milista

# Se utiliza doble corchete [[]] para acceder a elementos de una lista (uno x vez), 
# especificando el número de elemento o el nombre:

length(milista)

summary(milista)

milista[[3]]

milista[["ds"]]

# Al acceder a un elemento, se lo trata como si se estuviera usando directamente el 
# elemento, permitiendo indexaciones (recuperaciones) anidadas:

milista[["ds"]]$Genero
milista[[3]]$Genero

milista[["ds"]][,"Genero", 
                drop = FALSE] # el drop = FALSE permite presentar los elementos 
# no como un vector horizontal sino vertical (con formato data.frame)  
milista[[3]][,3, 
                drop = FALSE]  

datos[, 3,
      drop = FALSE]


# Visualizar los datos de cada objeto en una lista, el signo $:

milista$ds$ID 

milista$ciudades

milista$ds

### Operaciones con Listas ----

# Modificar nombres de los elementos de la lista:

length(milista)

names(milista)

names(milista) <- c("Números", "Ciudades", "Data.Frame")

names(milista)

# Agregar elementos a la lista:


milista[["Nuevo Elemento"]] <- c(1:10)

length(milista)

milista$`Nuevo Elemento`


#_____________________#
### Fin del Script ### 
#_____________________#


