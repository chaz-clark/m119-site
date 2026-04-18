rm(list=ls())

### Read in the data
library(data4led)
bulb <- led_bulb(1,seed = 2021)

t <- bulb$hours
y1 <- bulb$percent_intensity

### Define the model we want to fit to the data
f2 <- function(x,a0=0,a1=0,a2=1){
  a0 + a1*x + a2*x^2
}

### Fit the Model
a0 <- 100 
  #This is true which ever method we used to fit because of how we are normalizing bulb intensity.

# Visual Fit Method
v.a1 <- 0.00043
v.a2 <- -4.7e-08

x <- seq(0,100000,5)
v.y <- f2(x,a0,v.a1,v.a2)

par(mfrow=c(1,2),mar=c(4,4,1,0.25))
plot(t,y1,xlab="Hour", ylab="Intensity(%) ", pch=16)
lines(x,v.y,col=2)
plot(t,y1,xlab="Hour", ylab="Intensity(%) ", pch=16, xlim = c(0,80000),ylim = c(-10,120))
lines(x,v.y,col=2)


# Maximum Likelihood Fit Method
c.11 <- sum(t^2)
c.12 <- sum(t^3)
c.22 <- sum(t^4)
b.1 <- sum((y1-100)*t)
b.2 <- sum((y1-100)*t^2)
cPts <- function(c.11,c.12,c.22,b.1,b.2){
  best.y <- (c.11*b.2 - c.12*b.1)/(c.11*c.22 - c.12^2)
  best.x <- (b.1 - c.12*best.y)/c.11
  
  return(c(best.x,best.y))
}

a.fit <- cPts(c.11,c.12,c.22,b.1,b.2)
l.a1 <- a.fit[1]
l.a2 <- a.fit[2]

l.y <- f2(x,a0,l.a1,l.a2)

par(mfrow=c(1,2),mar=c(4,4,1,0.25))
plot(t,y1,xlab="Hour", ylab="Intensity(%) ", pch=16)
lines(x,l.y,col=2)
plot(t,y1,xlab="Hour", ylab="Intensity(%) ", pch=16, xlim = c(0,80000),ylim = c(-10,120))
lines(x,l.y,col=2)


### Let's compare our fitted models
#Plot on the fitted models
par(mfrow=c(1,2),mar=c(4,4,1,0.25))
plot(t,y1,xlab="Hour", ylab="Intensity(%) ", pch=16)
lines(x,l.y,col=4)
lines(x,v.y,col=5)
plot(x,l.y,xlab="Hour", ylab="Intensity(%) ", pch=16, xlim = c(0,80000),ylim = c(-10,120),col=4,type='l')
lines(x,v.y,col=5)

#Solve f2(t) = 80 to find out when the model says the bulb will "burn out".
#Visual Fit; f2(t) = 80 when t=50927.3
uniroot(f2,c(40000,60000),a0=a0,a1=v.a1,a2=v.a2)$root
#Visual Fit; f2(t) = 80 when t=45789.84
uniroot(f2,c(40000,60000),a0=a0,a1=l.a1,a2=l.a2)$root
