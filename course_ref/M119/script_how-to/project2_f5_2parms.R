#install.packages('nleqslv')
#install.packages('RootSolve')

library(rootSolve)
library(nleqslv)
library(data4led)
bulb <- led_bulb(1,seed=0312)


t <- bulb$hours
y <- bulb$percent_intensity*100


f5 <- function(x,a1=0,a2=1){
  (100 + a1*x)*exp(-a2*x)
}



nSys <- function(a,t,y){
  y <- numeric(2)
  y[1] <- sum(t*exp(-a[2]*t)*(y - 100*exp(-a[2]*t) - a[1]*t*exp(-a[2]*t)))
  y[2] <- sum(-(y - 100*exp(-a[2]*t) - a[1]*t*exp(-a[2]*t))*(100*t*exp(-a[2]*t) + a[1]*t^2*exp(-a[2]*t)))
  
  y
}

astart <- c(0.01,0.0001)
A <- nleqslv(astart,nSys,t=t,y=y,control=list(allowSingular=TRUE))$x
a <- multiroot(f = nSys, start = astart, t=t, y=y)$root


x <- seq(-10,50000,0.5)
par(mfrow=c(2,2),mar=c(2.5,2.5,1,0.25))
plot(t,y,xlab="Hour ", ylab="Intensity(%) ", pch=16,main='f5')
lines(x,f5(x,a1=a[1],a2=a[2]),col=2)
plot(t,y,xlab="Hour ", ylab="Intensity(%) ", pch=16, xlim = c(-10,80000),ylim = c(-10,120))
lines(x,f5(x,a1=a[1],a2=a[2]),col=2)

