rm(list=ls())
#Our function for the solution of a system of the form
#b.1 - c.11x - c.12y = 0
#b.2 - c.21x - c.22y = 0
#where c.12 = c.21.
cPts <- function(c.11,c.12,c.22,b.1,b.2){
  best.y <- (c.11*b.2 - c.12*b.1)/(c.11*c.22 - c.12^2)
  best.x <- (b.1 - c.12*best.y)/c.11
  
  return(c(best.x,best.y))
}

###Lightbulb Data
library(data4led)
bulb <- led_bulb(1,seed=2021)

t <- bulb$hours
y <- bulb$percent_intensity


##################
### Fitting f2 ###
##################
#Finding Critial Values
c.11 <- sum(t^2)
c.12 <- sum(t^3)
c.22 <- sum(t^4)
b.1 <- sum((y-100)*t)
b.2 <- sum((y-100)*t^2)
a <- cPts(c.11,c.12,c.22,b.1,b.2)

#R lm() function -- Fitting Linear Models Function
#Create a data frame with the variables in our model.
f2.data <- as.data.frame(cbind(x1=bulb$hours, x2=bulb$hours^2, y=y))
fit.f2 <- lm(I(y-100) ~ 0+ x1 + x2,f2.data)
A <- coefficients(fit.f2)

#Plots
f2 <- function(x,a0=0,a1=0,a2=1){
  a0 + a1*x + a2*x^2
}

x <- seq(-10,800001,2)
y.lik <- f2(x,100,a[1],a[2])
y.lm <- f2(x,100,A[1],A[2])

par(mfrow=c(1,2),mar=c(4,4,1,0.25))
plot(t,y,xlab="Hour ", ylab="Intensity(%) ", pch=16,main='f2')
lines(x,y.lik,col=5,lwd=4)
lines(x,y.lm,col=4)
plot(t,y,xlab="Hour ", ylab="Intensity(%) ", pch=16, xlim = c(-10,80000),ylim = c(-10,120))
lines(x,y.lik,col=5,lwd=4)
lines(x,y.lm,col=4)





##################
### Fitting f4 ###
##################
#Finding Critial Values
c.11 <- sum(t^2)
c.12 <- sum(t*log(0.005*t+1))
c.22 <- sum((log(0.005*t+1))^2)
b.1 <- sum((y-100)*t)
b.2 <- sum((y-100)*(log(0.005*t+1)))
a <- cPts(c.11,c.12,c.22,b.1,b.2)

#R lm() function -- Fitting Linear Models Function
#Create a data frame with the variables in our model.
f4.data <- as.data.frame(cbind(x1=bulb$hours, x2=log(0.005*bulb$hours+1), y=y))
fit.f4 <- lm(I(y-100) ~ 0+ x1 + x2,f4.data)
A <- coefficients(fit.f4)

#Plots
f4 <- function(x,a0=0,a1=0,a2=1){
  a0 + a1*x + a2*log(0.005*x + 1)
}

x <- seq(-10,800001,2)
y.lik <- f4(x,100,a[1],a[2])
y.lm <- f4(x,100,A[1],A[2])

par(mfrow=c(1,2),mar=c(4,4,1,0.25))
plot(t,y,xlab="Hour ", ylab="Intensity(%) ", pch=16,main='f4')
lines(x,y.lik,col=5,lwd=4)
lines(x,y.lm,col=4)
plot(t,y,xlab="Hour ", ylab="Intensity(%) ", pch=16, xlim = c(-10,80000),ylim = c(-10,120))
lines(x,y.lik,col=5,lwd=4)
lines(x,y.lm,col=4)





##################
### Fitting f6 ###
##################
#Finding Critial Values
c.11 <- sum(t^2)
c.12 <- sum(t*(1-exp(-0.0003*t)))
c.22 <- sum((1-exp(-0.0003*t))^2)
b.1 <- sum((y-100)*t)
b.2 <- sum((y-100)*(1-exp(-0.0003*t)))
a <- cPts(c.11,c.12,c.22,b.1,b.2)

#R lm() function -- Fitting Linear Models Function
#Create a data frame with the variables in our model.
f6.data <- as.data.frame(cbind(x1=bulb$hours, x2=1-exp(-0.0003*bulb$hours), y=y))
fit.f6 <- lm(I(y-100) ~ 0+ x1 + x2,f6.data)
A <- coefficients(fit.f6)

#Plots
f6 <- function(x,a0=100,a1=0,a2=1){
  a0 + a1*x + a2*(1-exp(-0.0003*x))
}

x <- seq(-10,800001,2)
y.lik <- f6(x,100,a[1],a[2])
y.lm <- f6(x,100,A[1],A[2])

par(mfrow=c(1,2),mar=c(4,4,1,0.25))
plot(t,y,xlab="Hour ", ylab="Intensity(%) ", pch=16,main='f6')
lines(x,y.lik,col=5,lwd=4)
lines(x,y.lm,col=4)
plot(t,y,xlab="Hour ", ylab="Intensity(%) ", pch=16, xlim = c(-10,80000),ylim = c(-10,120))
lines(x,y.lik,col=5,lwd=4)
lines(x,y.lm,col=4)





##########################
### Fitting y = b + mx ###
##########################
#Read in the data
data <- read.csv(url("https://byuistats.github.io/M119/data2_ls.csv"))
x.dat <- data$x
y.dat <- data$y

#Finding Critial Values
c.11 <- length(x.dat)
c.12 <- sum(x.dat)
c.22 <- sum(x.dat^2)
b.1 <- sum(y.dat)
b.2 <- sum(x.dat*y.dat)
parms <- cPts(c.11,c.12,c.22,b.1,b.2)


#R lm() function -- Fitting Linear Models Function
#Create a data frame with the variables in our model.
fit <- lm(y ~ x,data)
Parms <- coefficients(fit)



#Plots
f.line <- function(x,b=0,m=1){
  b + m*x
}

x <- seq(-10,10,0.1)
y.lik <- f.line(x,parms[1],parms[2])
y.lm <- f.line(x,Parms[1],Parms[2])

par(mfrow=c(1,2),mar=c(4,4,1,0.25))
plot(x.dat,y.dat,xlab="x", ylab="y", pch=16,main='Line')
lines(x,y.lik,col=5,lwd=4)
lines(x,y.lm,col=4)
abline(h=0,lty=3,col='gray')
abline(v=0,lty=3,col='gray')
plot(x.dat,y.dat,xlab="x", ylab="y", pch=16, xlim = c(-10,10),ylim=c(-75,75))
lines(x,y.lik,col=5,lwd=4)
lines(x,y.lm,col=4)
abline(h=0,lty=3,col='gray')
abline(v=0,lty=3,col='gray')




