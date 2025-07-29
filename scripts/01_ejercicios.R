################# Matrices ----
x <- c(1, 2, 3)
y <- c(4, 5, 6)
z <- c(x, y)
zi <- x * y

# crear matriz ----
m <- matrix(data = y * z, nrow = 2, ncol = 3, byrow = TRUE)
y
z
m

# acceder ----
# al número 36 
m[2, 3] # filas, columnas
m[1, ] # todos los datos de la primer fila
m[ ,3] # todos los datos de la tercer columna

# función_dimnames ----
# establecer o consultar nombres de fila y columna de una matriz: para establecer los nombres, es necesario especificar los nombres de las filas y columnas (en ese orden) en una lista.
m
dimnames(m) <- list(c("Cris", "Ronar"), c("azul", "rojo", "verde"))
# acceder a los datos de los colores azul y verde
m[ , c("azul", "verde")]
# acceder datos de Ronar, correspondiente al color rojo y verde
m["Ronar", c("rojo", "verde")]
m

################# Listas ----
mi_vector <- 1:20
mi_matriz <- matrix(1:4, nrow = 2, byrow = TRUE)
mi_df     <- data.frame("numeros" = 1:3, "letras" = c("a", "b", "c"))

mi_lista <- list("un_vector" = mi_vector, 
                 "una_matriz" = mi_matriz, 
                 "un_df" = mi_df)

mi_lista

mi_lista[1] # primer elemento de mi lista
mi_lista$un_vector

#################  Marco de datos -----
df <- as.data.frame(m)
# Listas
x_lista <- list(a = "Ronar", b = 1:10, c = df)
x_lista[[3]] # acceder al tercer vector de mi lista
x_lista$c["Cris", c("rojo", "verde")] # acceder al df: primer fila, segunda y tercer columna 

################# Factores -----
perros <- c("boxer", "golden", "boxer", "golden")
perros
class(perros)
perros <- factor(x = perros, levels = c("golden", "boxer"))
perros
class(perros)
str(perros)
