#Descargamos las librerias necesarias y elegimo el directorio correcto
setwd("C:/Users/mgarc/OneDrive/Escritorio/9no Semestre/Bedu_Modulo_II/Sesion_3/")
library(dplyr)
library(ggplot2)

#Necesitamos utilizar el último dataframe obtenido en el postwork
#de la sesión 2. El archivo csv de esa dataframe ya ha sido descargado
#y guardado en el directorio actual, con lo cual, sólo falta leerlo.

lista_temps <- read.csv("Tabla1")

#Con el último data frame obtenido en el postwork de la sesión 2, 
#elabora tablas de frecuencias relativas para estimar las siguientes probabilidades:

#La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x=0,1,2,):
table(lista_temps$FTHG)/nrow(lista_temps)

#La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y=0,1,2,)
table(lista_temps$FTAG)/nrow(lista_temps)

#Asumiendo que las variables aleatorias que denotan el número de goles anotados
#por el que juega en casa y visitante son independientes, entonces podemos estimar
#la probabilidad conjunta a través de la multiplicación de las probabilidades marginales

probas_casa   <- as.list(table(lista_temps$FTHG)/nrow(lista_temps))
probas_visita <- as.list(table(lista_temps$FTAG)/nrow(lista_temps))

#Para lo que vamos a hacer a continucación será conveniente que ambas listas tengan el mismo
#número de entradas. Dado que la lista probas_visita tiene dos entradas menos, voy a agregarle
#manuelamente dos entradas

probas_visita[["7"]] <- 0
probas_visita[["8"]] <- 0

probas_casa   <- unlist(probas_casa, use.names = FALSE)
probas_visita <- unlist(probas_visita, use.names = FALSE)

#Creamos un dataframe con estos datos
tabla_frecuencias <- data.frame(Goles = 0:8, FrecuenciaLocal = probas_casa, FrecuenciaVisitante = probas_visita)
#Creamos una matriz de 9 por 9 para almacenar las probabilidades
probas_conjuntas <- matrix(rep(0, 81), nrow = 9, ncol = 9)

#Llenamos las entradas de la matriz probas_conjuntas de acuerdo al siguiente criterio:
#La entrada (i,j) de la matriz será llenanda con la probabilidad conjunta de que el
#local anote i-1 goles y el visitante anote j-1 goles.
for(i in 1:9){
  for(j in 1:9){
    probas_conjuntas[i,j] <- probas_casa[i]*probas_visita[j]
  }
}

print(probas_conjuntas)

#Un grafico de barras para las probabilidades marginales estimadas
#del número de goles que anota el equipo local
plot1 <- ggplot(tabla_frecuencias, aes(x = Goles, y = FrecuenciaLocal))+
  geom_bar(stat = "identity")

plot1
#Un grafico de barras para las probabilidades marginales estimadas
#del número de goles que anota el equipo visitante
plot2 <- ggplot(tabla_frecuencias, aes(x = Goles, y = FrecuenciaVisitante))+
  geom_bar(stat = "identity")

plot2
#Un HeatMap para las probabilidades conjuntas estimadas del número
#de goles que anotan el equipod de casa y visitante en un partido
heatmap(probas_conjuntas)
