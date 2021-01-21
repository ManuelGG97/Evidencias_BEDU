library(ggplot2)
library(dplyr)
setwd("C:/Users/mgarc/OneDrive/Escritorio/9no Semestre/Bedu_Modulo_II/Sesion_3/")
View(mtcars)
names(mtcars)
#De la base de datos graficamos en el eje x cyl en el y hp
ggplot(mtcars, aes(x = cyl, y = hp, colour = mpg))+
  geom_point()

#Agregando características de tema y facewrap
ggplot(mtcars, aes(x = cyl, y = hp, colour = mpg))+
  geom_point(shape = 16)+
  theme_grey()+
  facet_wrap("cyl")

#Agregando nombres a los ejes x, y
ggplot(mtcars, aes(x = cyl, y = hp, colour = mpg))+
  geom_point(shape = 16)+
  theme_grey()+
  xlab("Núm de cilindros")+
  ylab("Caballos de fuerza")

#Ajustamos una linea de tendencia
my_scatplot <- ggplot(mtcars, aes(x = wt, y = mpg, col = cyl)) +
  geom_point(shape = 16)+
  theme_grey()+
  geom_smooth(method = "lm", se = T)+
  labs(x = "Weight", y = "Miles per Gallon")

#Boxplots y outliers
data2 <- read.csv("https://raw.githubusercontent.com/ManuelGG97/Programacion-con-R-Santander/master/Sesion-03/Data/boxp.csv")
head(data2)
names(data2)

#Multiplica la columna Mediciones por 1.23
data2 <- mutate(data2, Mediciones = Mediciones*1.23)
head(data2)
summary(data2)

#Quitamos los NA's de la base de datos
test1 <- na.omit(data2)
bien  <- complete.cases(data2)
data2 <- data2[bien,]

#¿Qué necesidad hay de convertir los campos de "Categoría" y "Grupo" a factor?
data2 <- mutate(data2, Categoria = factor(Categoria), Grupo = factor(Grupo))
ggplot(data2, aes(x = Categoria, y = Mediciones, fill = Grupo))+
  geom_boxplot()+
  scale_fill_discrete(name = "Dos Gps", labels = c("G1","G2"))+
  labs(x = "Categorias", y = "Mediciones", title = "Boxplots")

#Histogramas
hist(data2$Mediciones, breaks = (seq(0,360,20)),
     main = "Histograma de Mediciones",
     xlab = "Mediciones",
     ylab = "Frecuencia")

ggplot(data2, aes(x = Mediciones))+
  geom_histogram(binwidth = 10)+
  labs(x = "Mediciones", y = "Frecuencia", title = "Histograma con GGPLOT")+
  theme_light()

#Graficos de Tendencias
url1 <- "https://data.humdata.org/hxlproxy/data/download/time_series_covid19_confirmed_global_narrow.csv?dest=data_edit&filter01=explode&explode-header-att01=date&explode-value-att01=value&filter02=rename&rename-oldtag02=%23affected%2Bdate&rename-newtag02=%23date&rename-header02=Date&filter03=rename&rename-oldtag03=%23affected%2Bvalue&rename-newtag03=%23affected%2Binfected%2Bvalue%2Bnum&rename-header03=Value&filter04=clean&clean-date-tags04=%23date&filter05=sort&sort-tags05=%23date&sort-reverse05=on&filter06=sort&sort-tags06=%23country%2Bname%2C%23adm1%2Bname&tagger-match-all=on&tagger-default-tag=%23affected%2Blabel&tagger-01-header=province%2Fstate&tagger-01-tag=%23adm1%2Bname&tagger-02-header=country%2Fregion&tagger-02-tag=%23country%2Bname&tagger-03-header=lat&tagger-03-tag=%23geo%2Blat&tagger-04-header=long&tagger-04-tag=%23geo%2Blon&header-row=1&url=https%3A%2F%2Fraw.githubusercontent.com%2FCSSEGISandData%2FCOVID-19%2Fmaster%2Fcsse_covid_19_data%2Fcsse_covid_19_time_series%2Ftime_series_covid19_confirmed_global.csv"
url2 <- "https://data.humdata.org/hxlproxy/data/download/time_series_covid19_deaths_global_narrow.csv?dest=data_edit&filter01=explode&explode-header-att01=date&explode-value-att01=value&filter02=rename&rename-oldtag02=%23affected%2Bdate&rename-newtag02=%23date&rename-header02=Date&filter03=rename&rename-oldtag03=%23affected%2Bvalue&rename-newtag03=%23affected%2Binfected%2Bvalue%2Bnum&rename-header03=Value&filter04=clean&clean-date-tags04=%23date&filter05=sort&sort-tags05=%23date&sort-reverse05=on&filter06=sort&sort-tags06=%23country%2Bname%2C%23adm1%2Bname&tagger-match-all=on&tagger-default-tag=%23affected%2Blabel&tagger-01-header=province%2Fstate&tagger-01-tag=%23adm1%2Bname&tagger-02-header=country%2Fregion&tagger-02-tag=%23country%2Bname&tagger-03-header=lat&tagger-03-tag=%23geo%2Blat&tagger-04-header=long&tagger-04-tag=%23geo%2Blon&header-row=1&url=https%3A%2F%2Fraw.githubusercontent.com%2FCSSEGISandData%2FCOVID-19%2Fmaster%2Fcsse_covid_19_data%2Fcsse_covid_19_time_series%2Ftime_series_covid19_deaths_global.csv"

download.file(url = url1, destfile = "st19ncov-confirmados.csv", mode = "wb")
download.file(url = url2, destfile = "st19ncov-muertes.csv", mode = "wb")

#Una vez descargaos los dos archivos los leemos
Sconf <- read.csv("st19ncov-confirmados.csv")
Smur  <- read.csv("st19ncov-muertes.csv")
#Eliminamos la primera fila de ambos data frames
Sconf <- Sconf[-1,]
Smur  <- Smur[-1,]
#Seleccionamos los campos de Country.Region, Date y Value en ambas dataframes
Sconf <- select(Sconf, Country.Region, Date, Value)
Smur  <- select(Smur, Country.Region, Date, Value)
#Cambiamos el nombre de las columnas
Sconf <- rename(Sconf, Country = Country.Region, Infected = Value)
Smur  <- rename(Smur, Country = Country.Region, Deaths = Value)
#Casteamos las columnas de Date, Infected y Deaths
Sconf <- mutate(Sconf, Date = as.Date(Date, "%Y-%m-%d"), Infected = as.numeric(Infected))
Smur  <- mutate(Smur, Date = as.Date(Date, "%Y-%m-%d"), Deaths = as.numeric(Deaths))
#Hacer una JOIN de ambas bases de datos
Sjoin <- merge(Sconf,Smur)
#Seleccionar sólo los datos de México
mex   <- filter(Sjoin, Country == "Mexico")
#Seleccionar los datos con al menos 1 infectado
mex   <- filter(mex, Infected != 0)
#Añadir columna NI i.e nuevos infectados ese día
mex   <- mutate(mex, NI = c(1, diff(Infected)), NM = c(0, diff(Deaths)))
#Añadir columna Letalidad redondeada a un decimal
mex   <- mutate(mex, Letalidad = round(Deaths/Infected*100,1))
#Añadir columnas IDA y MDA
mex   <- mutate(mex, IDA = lag(Infected), MDA = lag(Deaths))
#Añadir columnas FCI y FCM
mex   <- mutate(mex, FCI = Infected/IDA, FCM = Deaths/MDA)
#Añadir una columna que indique el dia
mex   <- mutate(mex, Days = 1:dim(mex)[1])

#Escribimos un archivo csv con el nombre "C19Mexico.csv"
write.csv(mex, "C19Mexico.csv")
#Cargamos los paquetes ggplot2 y scales
library(ggplot2)
library(scales)
#Borramos todas las variables y volvemos a leer el archivo en mex
mex <- read.csv("C19Mexico.csv")
#Asegurate de que el campo Date sea Date
mex <- mutate(mex, Date = as.Date(Date, "%Y-%m-%d"))
#Grafica el acumulado de casos confirmados con puntos
plot_1 <- ggplot(mex, aes(x = Date, y = Infected))+
  geom_point(shape = 16, size = 0.01)+
  geom_line(color = "blue")+
  labs(x = "Fecha",
       y = "Acumulado de casos confirmados",
       title = paste("Confirmados de COVID-19 en México:", 
                     format(Sys.time(), 
                            tz="America/Mexico_City", 
                            usetz=TRUE)))+
  theme(plot.title = element_text(size = 12))+
  theme(axis.text.x = element_text(face = "bold", color="#993333" , 
                                   size = 10, angle = 45, 
                                   hjust = 1),
        axis.text.y = element_text(face = "bold", color="#993333" , 
                                    size = 10, angle = 45, 
                                    hjust = 1))+
  scale_x_date(labels = date_format("%d-%m-%Y"))

print(plot_1)
#Graficar los nuevos casos por día con linea

plot_2 <- ggplot(mex, aes(x = Date, y = NI))+
  geom_point(shape = 16, size = 0.1)+
  geom_line(color = "red")+
  labs(x = "Fecha", y = "Nuevos Casos", title = "Casos Diarios en México")+
  theme(plot.title = element_text(size = 12))+
  theme(axis.text.x = element_text(face = "bold", color = "#993333",
                                   size = 10, angle = 45, hjust = 1 ),
        axis.text.y = element_text(face = "bold", color = "#993333",
                                   size = 10, angle = 45, hjust = 1))+
  scale_x_date(labels = date_format("%d-%m-%Y"))

print(plot_2)
#Graficar las muertes acumuladas con puntos



plot_3 <- ggplot(mex, aes(x = Date, y = Deaths))+
  geom_point(shape = 16, size = 0.1)+
  geom_line(color = "Blue")+
  labs(x = "Fechas", y = "Muertes Acumuladas", title = "Muertes Acumuladas México")+
  theme(plot.title = element_text(size = 12))+
  theme(axis.text.x = element_text(face = "bold", color = "blue",
                                   size = 10, angle = 45, hjust = 1),
        axis.text.y = element_text(face = "bold", color = "blue",
                                   size = 10, angle = 45, hjust = 1))+
  scale_x_date(labels = date_format("%d-%m-%Y"))

print(plot_3)
#Graficar las nuevas muertes por día con linea

#-->Definir si es punto o linea
#-->Definir las etiquetas
#-->Editar el fuente del título
#-->Editar el fuente de los ejes
#-->Dar fromato de fecha al eje x
plot_4 <- ggplot(mex, aes(x = Date, y = NM))+
  geom_point(shape = 16, size = 0.1)+
  geom_line(color = "red")+
  labs(x = "Fecha", y = "Muertes Hoy", title = "Muertes Diarias México")+
  theme(plot.title = element_text(size = 12))+
  theme(axis.text.x = element_text(face = "bold", size = 10,
                                   color = "red", angle = 45, hjust = 1),
        axis.text.y = element_text(face = "bold", size = 10,
                                    color = "blue", angle = 45, hjust = 1))+
  scale_x_date(labels = date_format("%d-%m%Y"))

print(plot_4)
  
#Graficar acumulado de casos confirmados y muertes con punto y linea respecctivamente
#Graficar la tasa de letalidad con una linea
#Graficar ambos factores de crecimeinto con lineas

#SERIES DE TIEMPO Y DESCOMPOSICIÓN
library(dplyr)
w.brazil <- read.csv("https://raw.githubusercontent.com/ManuelGG97/Programacion-con-R-Santander/master/Sesion-03/Ejemplo-06/station_fortaleza.csv")
w.brazil <- w.brazil[,-c(1,14:18)]
tail(w.brazil)
class(w.brazil)

#Hace un scatter plot de cada una de las columnas con las otras
plot(w.brazil)

#Quitamos los valores que sean mayores a 50
w.brazil <- w.brazil %>% filter(JAN<50,FEB<50,	MAR<50,	APR<50,	MAY<50,	JUN<50,	JUL<50,	AUG<50,	SEP<50,	OCT<50,	NOV<50,	DEC<50)
#Para cinvertir el data frame a u vector numérico
bras <- apply(w.brazil,2,c)
class(bras)
bra1 <- as.vector(t(bras))

#Convertimos los datos a serie de tiempo con el comando t
tsb <- ts(bra1, start = c(1950,01), frequency = 12)
class(tsb)
summary(tsb)
start(tsb)
end(tsb)
frequency(tsb)

#Graficando la serie de tiempo
plot(tsb, main = "Serie de timepo", ylab = "Temp", xlab = "Año")
tsbd <- decompose(tsb, type = "additive")
plot(tsbd$trend)
plot(tsbd$seasonal)

#Ultimos temas de series de tiempo
#Descomposición aditiva
#Descomposición multiplicativa