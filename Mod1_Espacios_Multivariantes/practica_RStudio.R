iris <- data.frame(iris)

write.csv(iris,"iris.csv")

####################

dim(iris)

ncol_iris <- dim(iris)[2]
nrow_iris <- dim(iris)[1]

####################

######### BOXPLOTS

par(mfrow=c(1,1))
boxplot(iris[,1:4],main="Iris",xlab="",col="blue")

#########


cajas <- function(j){
  boxplot(iris[,j],main=colnames(iris)[j],xlab="",col="blue")
}

par(mfrow=c(2,2))
sapply(c(1:4),cajas)

######## BOXPLOTS por especie

cajas_especies <- function(j){
  boxplot(iris[,j]~iris[,5],main=colnames(iris)[j],xlab="",col="blue")
}

par(mfrow=c(2,2))
sapply(c(1:4),cajas_especies)

######## BAGPLOTS

install.packages("aplpack")
library(aplpack)

par(mfrow=c(1,1))
bagplot(iris$Sepal.Length,iris$Sepal.Width,xlab="Longitud S�palo",ylab="Ancho S�palo",main="Bagplot")

######## HISTOGRAMAS

par(mfrow=c(1,1))
hist(iris[,2],main = "Ejemplo de histograma",
     xlab="",
     col="blue",
     breaks = "Sturges")

########

histos <- function(x){
  hist(iris[,x],main = colnames(iris)[x],
       xlab="",
       col="blue",
       breaks = "Sturges")
}

par(mfrow=c(2,2))
sapply(1:4,histos)

########

summary(iris$Species)

setosa <- iris[iris$Species == "setosa",]
versicolor <- iris[iris$Species == "versicolor",]
virginica <- iris[iris$Species == "virginica",]

par(mfrow=c(1,3))
hist(setosa[,1],main = "Setosa (sl)", xlab="",col="blue",breaks = "Sturges")
hist(versicolor[,1],main = "Versicolor (sl)", xlab="",col="red",breaks = "Sturges")
hist(virginica[,1],main = "Virginicia (sl)", xlab="",col="green",breaks = "Sturges")

######## DENSIDADES KERNEL

den_ker <- function(x){
  plot(density(iris[,x],kernel = "gaussian"),main = colnames(iris)[x],xlab="",col="blue",lwd=2)
}

par(mfrow=c(2,2))
sapply(1:4,den_ker)

########

install.packages("sm")
library(sm)

cyl.f <- factor(iris$Species,
                labels = unique(iris$Species))

par(mfrow=c(1,1))
sm.density.compare(iris$Sepal.Length,iris$Species)

colfill<-c(2:(2+length(levels(cyl.f))))
legend(locator(1), levels(cyl.f),fill=colfill)

####### SCATTERPLOT

library(ggplot2)

ggplot(data = iris) +
  geom_point(mapping = aes(x=Sepal.Length,y=Petal.Length,color = Species),size=5,alpha=0.5)+theme_bw()


######## Scatterplot 3d

install.packages("scatterplot3d")
library(scatterplot3d)


scatterplot3d(iris$Sepal.Length,iris$Petal.Length,iris$Petal.Width,pch=19,color=c("blue","green","orange")[iris[,5]])
scatterplot3d(iris$Sepal.Length,iris$Petal.Length,iris$Petal.Width,pch=19,color=c("blue","green","orange")[iris[,5]],type="h")

######## scatter matrix

pairs(iris[,1:4],pch=19,col=c("blue","green","orange")[iris[,5]])

####### COORDENADAS PARALELAS

install.packages("MASS")
library(MASS)

parcoord(iris[,1:4],col=c("blue","green","orange")[iris[,5]])

###############################################
###############################################
######## Medidas descriptivas
###############################################
###############################################

medias <- colMeans(iris[,1:4])

### Mediana

install.packages("Gmedian")
library(Gmedian)

Gmedian(iris[,1:4])
medias

Gmedian(iris[,c(1,2)])

par(mfrow=c(1,1))
plot(iris$Sepal.Length,iris$Sepal.Width,xlab="long s�palo",ylab="ancho s�palo",pch=19,col=c("blue","green","orange")[iris[,5]])
points(Gmedian(iris[,c(1,2)])[1],Gmedian(iris[,c(1,2)])[2],pch=19,col="red",lwd=10)

##############################################

mediana_setosa <- Gmedian(setosa[,c(1,2)])
mediana_versicolor <- Gmedian(versicolor[,c(1,2)])
mediana_virginicia <- Gmedian(virginica[,c(1,2)])



par(mfrow=c(1,1))
plot(iris$Sepal.Length,iris$Sepal.Width,xlab="long s�palo",ylab="ancho s�palo",pch=19,col=c("blue","green","orange")[iris[,5]])
points(Gmedian(iris[,c(1,2)])[1],Gmedian(iris[,c(1,2)])[2],pch=19,col="yellow",lwd=10)
points(Gmedian(setosa[,c(1,2)])[1],Gmedian(setosa[,c(1,2)])[2],pch=19,col="blue",lwd=10)
points(Gmedian(versicolor[,c(1,2)])[1],Gmedian(versicolor[,c(1,2)])[2],pch=19,col="green",lwd=10)
points(Gmedian(virginica[,c(1,2)])[1],Gmedian(virginica[,c(1,2)])[2],pch=19,col="red",lwd=10)


############################################# MATRIZ DE COVARIANZA

Cov_iris <- cov(iris[,1:4])
Corr_iris <- cor(iris[,1:4])


install.packages("reshape2")
library(reshape2)

Corr_iris_arreglada <- melt(Corr_iris)
Cov_iris_arreglada <- melt(Cov_iris)

ggplot(data=Corr_iris_arreglada) +
  geom_tile(mapping = aes(x=Var2,y=Var1,fill=value))

ggplot(data=Cov_iris_arreglada) +
  geom_tile(mapping = aes(x=Var1,y=Var2,fill=value))

############################################


########## Referencia �til: 
## https://rua.ua.es/dspace/bitstream/10045/69767/1/Modulo_4_-_Graficos_avanzados_con_ggplot2.pdf

