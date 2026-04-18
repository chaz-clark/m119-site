rm(list=ls())
data <- read.csv(url("https://byuistats.github.io/M119/logLikelihood_practice2.csv"))

x <- data$x
y2 <- data$y2

c.11 <- 150
c.12 <- sum(exp(-x))
c.21 <- sum(exp(-x))
c.22 <- sum((exp(-x))^2)
b.1 <- sum(y2)
b.2 <- sum(y2*exp(-x))

best.b <- (c.11*b.2 - c.12*b.1)/(c.11*c.22 - c.12^2)
best.a <- (b.1 - c.12*best.b)/c.11

best.b
best.a

D <- (-c.11)*(-c.22) - (-c.12)^2
#The second partial with respect to a_1 both times is -c.11

D
-c.11

f <- function(x,a=0,b=1){
  a + b*exp(-x)
}

x.in <- seq(-10,10,0.01)
par(mfrow=c(1,1),mar=c(2.5,2.5,0.25,0.25))
plot(x,y2,type='p',pch=16)
lines(x.in,f(x.in,a=best.a, b=best.b),col=3)
abline(h=0,lty=3,col='gray')
abline(v=0,lty=3,col='gray')




#This is the same model fit to the y1 data.
x <- data$x
y1 <- data$y1

c.11 <- 150
c.12 <- sum(exp(-x))
c.21 <- sum(exp(-x))
c.22 <- sum((exp(-x))^2)
b.1 <- sum(y1)
b.2 <- sum(y1*exp(-x))

best.b <- (c.11*b.2 - c.12*b.1)/(c.11*c.22 - c.12^2)
best.a <- (b.1 - c.12*best.b)/c.11

best.b
best.a

D <- (-c.11)*(-c.22) - (-c.12)^2
#The second partial with respect to a_1 both times is -c.11

D
-c.11

f <- function(x,a=100,b=1){
  a + b*exp(-x)
}

x.in <- seq(-10,10,0.01)
par(mfrow=c(1,1),mar=c(2.5,2.5,0.25,0.25))
plot(x,y1,type='p',pch=16)
lines(x.in,f(x.in,a=best.a, b=best.b),col=3)
abline(h=0,lty=3,col='gray')
abline(v=0,lty=3,col='gray')



#This is the model with a=100 fit to the y2 data.
b2 <- sum((y2-100)*exp(-x))/sum((exp(-x))^2)
D2l.cv <- -sum((exp(-x))^2)
x.in <- seq(-10,10,0.01)
par(mfrow=c(1,1),mar=c(2.5,2.5,0.25,0.25))
plot(x,y2,type='p',pch=16)
lines(x.in,f(x.in,b=b2),col=3)
abline(h=0,lty=3,col='gray')
abline(v=0,lty=3,col='gray')


