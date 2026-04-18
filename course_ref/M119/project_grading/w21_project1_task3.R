s <- 0117



a0.0 <- 100

a0.1 <- 100
a1.1 <- 0.00003

a0.2 <- 100
a1.2 <-  0.001
a2.2 <- -0.0000002

a0.3 <- 100
a1.3 <- 0.5
a2.3 <- 0.00003

a0.4 <- 100
a1.4 <- -0.0009
a2.4 <- 1.4

a0.5 <- 100
a1.5 <- 0.01275
a2.5 <- 0.000101





f0 <- function(x,a0=1){
  rep(a0,length(x))
}
f1 <- function(x,a0=0,a1=1){
  a0 + a1*x
}
f2 <- function(x,a0=0,a1=0,a2=1){
  a0 + a1*x + a2*x^2
}
f3 <- function(x,a0=0,a1=1,a2=1){
  a0 + a1*exp(-a2*x)
}
f4 <- function(x,a0=0,a1=0.0001,a2=1){
  a0 + a1*x + a2*log(0.005*x + 1)
}
f5 <- function(x,a0=1,a1=0,a2=1){
  (a0 + a1*x)*exp(-a2*x)
}





library(data4led)
bulb <- led_bulb(1,seed=s)
bulb$percent_intensity <- bulb$percent_intensity * 100





x <- seq(-10,800001,2)



par(mfrow=c(1,2),mar=c(2.5,2.5,1,0.25))
plot(bulb$hours,bulb$percent_intensity,xlab="Hour ", ylab="Intensity(%) ", pch=16,main='f0')
lines(x,f0(x,a0=a0.0), col=2)
plot(bulb$hours,bulb$percent_intensity,xlab="Hour ", ylab="Intensity(%) ", pch=16, xlim = c(-10,80000),ylim = c(-10,120))
lines(x,f0(x,a0=a0.0), col=2)



par(mfrow=c(1,2),mar=c(2.5,2.5,1,0.25))
plot(bulb$hours,bulb$percent_intensity,xlab="Hour ", ylab="Intensity(%) ", pch=16,main='f1')
lines(x,f1(x,a0=a0.1,a1=a1.1),col=2)
plot(bulb$hours,bulb$percent_intensity,xlab="Hour ", ylab="Intensity(%) ", pch=16, xlim = c(-10,80000),ylim = c(-10,120))
lines(x,f1(x,a0=a0.1,a1=a1.1),col=2)



par(mfrow=c(1,2),mar=c(2.5,2.5,1,0.25))
plot(bulb$hours,bulb$percent_intensity,xlab="Hour ", ylab="Intensity(%) ", pch=16,main='f2')
lines(x,f2(x,a0=a0.2,a1=a1.2,a2=a2.2),col=2)
plot(bulb$hours,bulb$percent_intensity,xlab="Hour ", ylab="Intensity(%) ", pch=16, xlim = c(-10,80000),ylim = c(-10,120))
lines(x,f2(x,a0=a0.2,a1=a1.2,a2=a2.2),col=2)



par(mfrow=c(1,2),mar=c(2.5,2.5,1,0.25))
plot(bulb$hours,bulb$percent_intensity,xlab="Hour ", ylab="Intensity(%) ", pch=16,main='f3')
lines(x,f3(x,a0=a0.3,a1=a1.3,a2=a2.3),col=2)
plot(bulb$hours,bulb$percent_intensity,xlab="Hour ", ylab="Intensity(%) ", pch=16, xlim = c(-10,80000),ylim = c(-10,120))
lines(x,f3(x,a0=a0.3,a1=a1.3,a2=a2.3),col=2)



par(mfrow=c(1,2),mar=c(2.5,2.5,1,0.25))
plot(bulb$hours,bulb$percent_intensity,xlab="Hour ", ylab="Intensity(%) ", pch=16,main='f4')
lines(x,f4(x,a0=a0.4,a1=a1.4,a2=a2.4),col=2)
plot(bulb$hours,bulb$percent_intensity,xlab="Hour ", ylab="Intensity(%) ", pch=16, xlim = c(-10,80000),ylim = c(-10,120))
lines(x,f4(x,a0=a0.4,a1=a1.4,a2=a2.4),col=2)



par(mfrow=c(1,2),mar=c(2.5,2.5,1,0.25))
plot(bulb$hours,bulb$percent_intensity,xlab="Hour ", ylab="Intensity(%) ", pch=16,main='f5')
lines(x,f5(x,a0=a0.5,a1=a1.5,a2=a2.5),col=2)
plot(bulb$hours,bulb$percent_intensity,xlab="Hour ", ylab="Intensity(%) ", pch=16, xlim = c(-10,80000),ylim = c(-10,120))
lines(x,f5(x,a0=a0.5,a1=a1.5,a2=a2.5),col=2)



