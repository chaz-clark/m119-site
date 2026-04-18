library(data4led)
library(tidyverse)
library(dplyr)
library(ggplot2)

bulb <- led_bulb(1,seed=0126)

bulb <- led_bulb(1,seed=0919)
new_bulb <- bulb %>% 
  mutate(percent_intensity = percent_intensity*100) 



f0 <- function(x,a0=0,a1=1,a2=1){
  #This function can be evaluated at any value of x.
  a0 + a1*x
}
x <- seq(-10,800001)
par(mfrow=c(1,2),mar=c(2.5,2.5,1,0.25))
plot(percent_intensity ~ hours,data= new_bulb, main="Graph 1",
     xlab="Hour ", ylab="Intensity(%) ", pch=19)
lines(x,f0(x,a0=101.4,a1=0), col=2)
plot(percent_intensity ~ hours,data= new_bulb, main="Graph 1",
     xlab="Hour ", ylab="Intensity(%) ", pch=19,xlim = c(-10,80000),ylim = c(-10,120))
lines(x,f0(x,a0=101.4,a1=0), col=2)



f1 <- function(x,a0=0,a1=1,a2=1){
  #This function can be evaluated at any value of x.
  a0 + a1*x
}
x <- seq(-10,800001)
par(mfrow=c(1,2),mar=c(2.5,2.5,1,0.25))
plot(percent_intensity ~ hours,data= new_bulb, main="Graph 2",
     xlab="Hour ", ylab="Intensity(%) ", pch=19)
lines(x,f1(x,a0=101.25,a1=.00001),col=2)
plot(percent_intensity ~ hours,data= new_bulb, main="Graph 2",
     xlab="Hour ", ylab="Intensity(%) ", pch=19,xlim = c(-10,80000),ylim = c(-10,120))
lines(x,f1(x,a0=101.25,a1=.00001),col=2)



#This is a very poor visual fit. With the right parameter values f2 is capable of increasing and then decreasing like your data does.
f2 <- function(x,a0=1,a1=1,a2=1){
  #This function can be evaluated at any value of x.
  a0 + a1*x+ a2*x^2
}
x <- seq(-10,800001)
par(mfrow=c(1,2),mar=c(2.5,2.5,1,0.25))
plot(percent_intensity ~ hours,data= new_bulb, main="Graph 3",
     xlab="Hour ", ylab="Intensity(%) ", pch=19)
lines(x,f2(x,a0=102.5,a1=-0.00001,a2=-0.0000000000000000001),col=2)
plot(percent_intensity ~ hours,data= new_bulb, main="Graph 3",
     xlab="Hour ", ylab="Intensity(%) ", pch=19,xlim = c(-10,80000),ylim = c(-10,120))
lines(x,f2(x,a0=102.5,a1=-0.00001,a2=-0.0000000000000000001),col=2)



#This is a poor visual fit. 
f3 <- function(x,a0=1,a1=1,a2=1){
  #This function can be evaluated at any value of x.
  a0 + a1*exp(-a2*x)
}
x <- seq(-10,800001)
par(mfrow=c(1,2),mar=c(2.5,2.5,1,0.25))
plot(percent_intensity ~ hours,data= new_bulb, main="Graph 4",
     xlab="Hour ", ylab="Intensity(%) ", pch=19)
lines(x,f3(x,a0=101,a1=-.005,a2=-.00001),col=2)
plot(percent_intensity ~ hours,data= new_bulb, main="Graph 4",
     xlab="Hour ", ylab="Intensity(%) ", pch=19,xlim = c(-10,80000),ylim = c(-10,120))
lines(x,f3(x,a0=101,a1=-.005,a2=-.00001),col=2)



#This is not a very good visual fit.
f4 <- function(x,a0=0,a1=1,a2=1){
  #This function can be evaluated at any value of x.
  a0 + a1*x+a2*log(.005*x+1)
}
x <- seq(-10,800001)
par(mfrow=c(1,2),mar=c(2.5,2.5,1,0.25))
plot(percent_intensity ~ hours,data= new_bulb, main="Graph 5",
     xlab="Hour ", ylab="Intensity(%) ", pch=19)
lines(x,f4(x,a0=100,a1=-.000056,a2=1.2),col=2)
plot(percent_intensity ~ hours,data= new_bulb, main="Graph 5",
     xlab="Hour ", ylab="Intensity(%) ", pch=19,xlim = c(-10,80000),ylim = c(-10,120))
lines(x,f4(x,a0=100,a1=-.000056,a2=1.2),col=2)



#This is a poor visual fit. With the right parameter values f5 is capable of increasing and then decreasing like your data does.
f5 <- function(x,a0=0,a1=1,a2=1){
  #This function can be evaluated at any value of x.
  (a0 + a1*x)*exp(-a2*x)
}
x <- seq(-10,800001)
par(mfrow=c(1,2),mar=c(2.5,2.5,1,0.25))
plot(percent_intensity ~ hours,data= new_bulb, main="Graph 6",
     xlab="Hour ", ylab="Intensity(%) ", pch=19)
lines(x,f5(x,a0=101.25,a1=0.0003,a2=0.000003),col=2)
plot(percent_intensity ~ hours,data= new_bulb, main="Graph 6",
     xlab="Hour ", ylab="Intensity(%) ", pch=19,xlim = c(-10,80000),ylim = c(-10,120))
lines(x,f5(x,a0=101.25,a1=0.0003,a2=0.000003),col=2)



