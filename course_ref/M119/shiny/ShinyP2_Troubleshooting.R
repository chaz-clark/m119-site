##The Shiny App for Project 2 will not work for some seeds because f4 is an increaing function.
##This code is a check by hand until we fix the Shiny App.
##OR if we decide not to change the Shiny App, we can filter out the "bad" seeds when we assigning seeds at the beginning of the semester.

rm(list=ls())
library(data4led)

f1 <- function(x,a1,   LHS=0){100 + a1*x - LHS}
f2 <- function(x,a1,a2,LHS=0){100 + a1*x + a2*x^2 - LHS}
f4 <- function(x,a1,a2,LHS=0){100 + a1*x + a2*log(0.005*x + 1) - LHS}
f5 <- function(x,a1,   LHS=0){(100 + a1*x)*exp(-0.00005*x) - LHS}
f6 <- function(x,a1,a2,LHS=0){100 + a1*x + a2*(1 - exp(-0.0003*x)) - LHS}

###################################################
#These functions return the coefficients from MLE. 
#They use Cramer's rule for ease of parsing the code.
#These functions can be sources in a separate file. 
#They require passing both t and y, so no global variables are stored. 
###################################################
cramers.rule.2d <- function(a,b,c,d,e,f){
  #solves ax+by=c, dx+ey=f, 
  #returns c(x,y)
  c(c*e-b*f,a*f-c*d)/(a*e-b*d)
}
cramers.rule.1d <- function(a,b){
  #solves ax=b,  
  #returns x
  b/a
}
fit.1 <- function(t,y){
  C1.1 <- sum(t*(y-100))
  C2.1 <- sum(t^2)
  cramers.rule.1d(C2.1,C1.1)
}
fit.2 <- function(t,y){
  C1.2 <- sum((y-100)*t)
  C2.2 <- sum(t^2)
  C3.2 <- sum(t^3)
  C4.2 <- sum((y-100)*t^2)
  C5.2 <- sum(t^4)
  cramers.rule.2d(C2.2, C3.2, C1.2, C3.2, C5.2, C4.2)
}
fit.4 <- function(t,y){
  C1.4 <- sum(t*(y-100))
  C2.4 <- sum(t^2)
  C3.4 <- sum(t*log(0.005*t+1))
  C4.4 <- sum((y-100)*log(0.005*t+1))
  C5.4 <- sum((log(0.005*t+1))^2)
  cramers.rule.2d(C2.4,C3.4,C1.4,C3.4,C5.4,C4.4)
}
fit.5 <- function(t,y){
  C1.5 <- sum(t*(y-100*exp(-0.00005*t))*exp(-0.00005*t))
  C2.5 <- sum((t*exp(-0.00005*t))^2)
  cramers.rule.1d(C2.5,C1.5)
}
fit.6 <- function(t,y){
  C1.6 <- sum((y-100)*t)
  C2.6 <- sum(t^2)
  C3.6 <- sum(t*(1-exp(-0.0003*t)))
  C4.6 <- sum((y-100)*(1-exp(-0.0003*t)))
  C5.6 <- sum((1-exp(-0.0003*t))^2)
  cramers.rule.2d(C2.6,C3.6,C1.6,C3.6,C5.6,C4.6)
}

coef_from_seed <- function(seed = 2021){
  bulb <- led_bulb(1,seed=seed)
  
  t <- bulb$hours
  y <- bulb$percent_intensity
  
  values <- c()
  values[1]<-fit.1(t,y)
  values[2:3]<-fit.2(t,y)
  values[4:5]<-fit.4(t,y)
  values[6]<-fit.5(t,y)
  values[7:8]<-fit.6(t,y)
  data.frame("coef"=c("a1 in f1", "a1 in f2", "a2 in f2", "a1 in f4", "a2 in f4", "a1 in f5", "a1 in f6", "a2 in f6"),"value"=values)
}

sol <- coef_from_seed(123)
a1.f1 <- sol$value[1]
a1.f2 <- sol$value[2]
a2.f2 <- sol$value[3]
a1.f4 <- sol$value[4]
a2.f4 <- sol$value[5]
a1.f5 <- sol$value[6]
a1.f6 <- sol$value[7]
a2.f6 <- sol$value[8]

sol <- c(
  f1(25000,a1.f1)      ,
  f2(25000,a1.f2,a2.f2),uniroot(f2,c(0,10000000),a1.f2,a2.f2,LHS=80)$root,
  f4(25000,a1.f4,a2.f4),#uniroot(f4,c(0,10000000),a1.f4,a2.f4,LHS=80)$root,
  f5(25000,a1.f5      ),uniroot(f5,c(0,10000000),a1.f5,      LHS=80)$root,
  f6(25000,a1.f6,a2.f6),uniroot(f6,c(0,10000000),a1.f6,a2.f6,LHS=80)$root
)

sol[1]

sol[2]
sol[3]

sol[4]
#sol[5]

sol[5]
sol[6]
#sol[6]
#sol[7]

#sol[8]
#sol[9]
sol[7]
sol[8]

bulb <- led_bulb(1,seed=123)
t <- bulb$hours
y <- bulb$percent_intensity
x <- seq(-10,80001,2)
par(mfrow=c(1,2),mar=c(2.5,2.5,1,0.25))
plot(t,y,xlab="Hour ", ylab="Intensity(%) ", pch=16,main='f4')
lines(x,f4(x,a1.f4,a2.f4),col=2)
plot(t,y,xlab="Hour ", ylab="Intensity(%) ", pch=16, xlim = c(-10,80000),ylim = c(-10,120))
lines(x,f4(x,a1.f4,a2.f4),col=2)