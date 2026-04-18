library(data4led)
prep.data <- led_bulb(1,seed=1110)

x <- prep.data$hours
y <- 100*prep.data$percent_intensity

#f_6(t)
f6 <- function(x,a1,a2){
  100 + a1*x - a2*(1-exp(-0.0003*x))
}
f6_90 <- function(x,a1,a2){
  f6(x,a1,a2) - 90
}

c1.6 <- sum(x*y) - 100*sum(x)
c2.6 <- sum(x^2)
c3.6 <- sum(x*(1-exp(-0.0003*x)))
c4.6 <- 100*sum(1-exp(-0.0003*x))-sum(y*(1-exp(-0.0003*x)))
c6.6 <- sum((1-exp(-0.0003*x))^2)

a2.best <- (c2.6*c4.6+c1.6*c3.6)/(c2.6*c6.6-c3.6^2)
a1.best <- (c1.6+c3.6*a2.best)/c2.6

x.val <- seq(-10,50000,10)
par(mfrow=c(1,2),mar=c(2.5,2.5,0.25,0.25))
plot(x,y,pch=16,xlim=c(0,5000),ylim=c(95,105))
lines(x.val,f6(x.val,a1.best,a2.best),col=3)
plot(x,y,pch=16,xlim=c(0,30000),ylim=c(80,105))
lines(x.val,f6(x.val,a1.best,a2.best),col=3)

uniroot(f6_90,c(0,50000),a1=a1.best,a2=a2.best)$root



#f_2(t)
f2 <- function(x,a2){
  100 + a2*x
}
f2_90 <- function(x,a2){
  f2(x,a2) - 90
}

a2.best <- (sum(x*y)-100*sum(x))/sum(x^2)

x.val <- seq(-10,50000,10)
par(mfrow=c(1,2),mar=c(2.5,2.5,0.25,0.25))
plot(x,y,pch=16,xlim=c(0,5000),ylim=c(95,105))
lines(x.val,f2(x.val,a2.best),col=3)
plot(x,y,pch=16,xlim=c(0,30000),ylim=c(80,105))
lines(x.val,f2(x.val,a2.best),col=3)

uniroot(f2_90,c(-20000,10000),a2=a2.best)$root



#f_4(t)
f4 <- function(x,a1,a2){
  100 + a1*x + a2*log(x+1)
}

c1.4 <- sum(x*y) - 100*sum(x)
c2.4 <- sum(x^2)
c3.4 <- sum(x*log(x+1))
c4.4 <- sum(y*log(x+1)) - 100*sum(log(x+1))
c6.4 <- sum(log(x+1)^2)

a2.best <- (c2.4*c4.4-c1.4*c3.4)/(c2.4*c6.4-c3.4^2)
a1.best <- (c1.4-c3.4*a2.best)/c2.4

x.val <- seq(0,50000,10)
par(mfrow=c(1,2),mar=c(2.5,2.5,0.25,0.25))
plot(x,y,pch=16,xlim=c(0,5000),ylim=c(95,105))
lines(x.val,f4(x.val,a1.best,a2.best),col=3)
plot(x,y,pch=16,xlim=c(0,30000),ylim=c(80,105))
lines(x.val,f4(x.val,a1.best,a2.best),col=3)

uniroot(f4,c(-50000,50000),a1=a1.best,a2=a2.best)$root



#f_0(t)
f0 <- function(x,a1,a2){
  a1 + a2*x
}

c1.0 <- sum(y)
c2.0 <- sum(x)
c3.0 <- sum(x*y)
c4.0 <- sum(x^2)

a2.best <- (44*c3.0 - c1.0*c2.0)/(44*c4.0 - c2.0^2)
a1.best <- (c1.0 - c2.0*a2.best)/44

x.val <- seq(0,50000,10)
par(mfrow=c(1,2),mar=c(2.5,2.5,0.25,0.25))
plot(x,y,pch=16,xlim=c(0,5000),ylim=c(95,105))
lines(x.val,f0(x.val,a1.best,a2.best),col=3)
plot(x,y,pch=16,xlim=c(0,30000),ylim=c(80,105))
lines(x.val,f0(x.val,a1.best,a2.best),col=3)

uniroot(f0,c(-5e7,1000),a1=a1.best,a2=a2.best)$root


#f_5(t)
f5 <- function(x,a1){
  (100 + a1*x)*exp(-0.00005*x)
}
f5_87 <- function(x,a1,a2){
  f5(x,a1) - 87
}

a1.best <- (sum(x*y*exp(-0.00005*x))-100*sum(x*exp(-0.0001*x)))/sum(x^2*exp(-0.0001*x))

x.val <- seq(0,50000,10)
par(mfrow=c(1,2),mar=c(2.5,2.5,0.25,0.25))
plot(x,y,pch=16,xlim=c(0,5000),ylim=c(95,105))
lines(x.val,f5(x.val,a1.best),col=3)
plot(x,y,pch=16,xlim=c(0,30000),ylim=c(80,105))
lines(x.val,f5(x.val,a1.best),col=3)

uniroot(f5_87,c(0,50000),a1=a1.best)$root
