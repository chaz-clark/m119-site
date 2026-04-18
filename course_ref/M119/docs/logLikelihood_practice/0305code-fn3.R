rm(list=ls())
data <- read.csv(url("https://byuistats.github.io/M119/logLikelihood_practice2.csv"))

x <- data$x
y1 <- data$y1

b.best <- sum(y1*exp(-x))/sum((exp(-x))^2)
b2 <- sum((y1-100)*exp(-x))/sum((exp(-x))^2)

D2l.cv <- -sum((exp(-x))^2)

f <- function(x,a=100,b=1){
  a + b*exp(-x)
}

#This is the function with a=0 fit to the data when a is around 100.
#This illustrates even the best fit model does a poor job of fitting the data if the deterministic function is wrong.
#The assumption of model matters!!
x.in <- seq(-10,10,0.01)
par(mfrow=c(1,1),mar=c(2.5,2.5,0.25,0.25))
plot(x,y1,type='p',pch=16)
lines(x.in,f(x.in,0,b=b.best),col=3)
abline(h=0,lty=3,col='gray')
abline(v=0,lty=3,col='gray')

#This is the function with a=100 fit to the data.
#This illustrates even the best fit model does a poor job of fitting the data if the deterministic function is wrong.
#The assumption of model matters!!
x.in <- seq(-10,10,0.01)
par(mfrow=c(1,1),mar=c(2.5,2.5,0.25,0.25))
plot(x,y1,type='p',pch=16)
lines(x.in,f(x.in,b=b2),col=3)
abline(h=0,lty=3,col='gray')
abline(v=0,lty=3,col='gray')