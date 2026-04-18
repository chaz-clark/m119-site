rm(list = ls())

###Plotting Functions ggplot2###
f1 <- function(x){
  return( x^2 - x )
}

##Base Graphics##
#Method 1
curve(expr = f1, from = -5, to = 5)

#Method 2
plot(seq(-5, 5, by = 0.1), f1(seq(-5, 5, by = 0.1)), type = 'l')
  #plot(seq(-5, 5, by = 0.1), f1(seq(-5, 5, by = 0.1)), type = 'l', xlab = "x", ylab = "f1(x)")

#Method 3
a <- -5
b <- 5
dx <- 0.1
x <- seq(a, b, dx)
y <- f1(x)
plot(x, y, type = 'l')
  #plot(x, y, type = 'l', ylab = "f1(x)")
####


##ggplot2##
rm(list = ls(x))
library(tidyverse)
ggplot(data.frame(x = c(-5,5)), aes(x=x)) +
  stat_function(fun = f1)

f2 <- function (x){
  ifelse(x<0, -x, x)
}

ggplot(data.frame(x = c(-5,5)), aes(x=x)) +
  stat_function(fun = f2)

f3 <- function(x){
  return(x^3)
}
f4 <- function(x){
  return(4*x^2)
}
f5 <- function(x){
  10*x
}

four_curves <- ggplot(data.frame(x = c(-5,5)), aes(x = x)) +
  stat_function(fun = exp, color = "red", lwd = 1) +
  stat_function(fun = f3, color = "blue", lwd = 1) +
  stat_function(fun = f4, color = 'green', lwd = 1) +
  stat_function(fun = f5, color = "black", lwd = 1) +
  annotate(geom = "text", label = "Exponential", x = -4, y = 5, size = 5) +
  annotate(geom = "text", label = "Cubic", x = -4, y = -90, size = 5) +
  annotate(geom = "text", label = "Quadractic", x = -4, y = 95, size = 5) +
  annotate(geom = "text", label = "Linear", x = -4, y = -32, size = 5)



###What about functions with parameters?###
  ###I haven't figure out how to pass parameter values through ggplot yet...
qP.fun <- function(x,parms){
  with(as.list(c(parms)),{
    a*x^2 + b*x + c
  })
}

xL <- -10
xU <- 10
dx <- 0.1
x <- seq(xL, xU, dx)
y1 <- qP.fun(x, c(a = 1, b = 1, c = 1))
y2 <- qP.fun(x, c(a = 1, b = 0, c = 1))
y3 <- qP.fun(x, c(a = 1, b = -1, c = 1))
y4 <- qP.fun(x, c(a = 1, b = 2, c = 1))
y5 <- qP.fun(x, c(a = 1, b = 0, c = 1))
y6 <- qP.fun(x, c(a = 1, b = -2, c = 1))
y7 <- qP.fun(x, c(a = 1, b = 4, c = 1))
y8 <- qP.fun(x, c(a = 1, b = 0, c = 1))
y9 <- qP.fun(x, c(a = 1, b = -4, c = 1))

par(mfrow=c(3,3))
plot(x, y1, type = 'l')
plot(x, y2, type = 'l')
plot(x, y3, type = 'l')
plot(x, y4, type = 'l')
plot(x, y5, type = 'l')
plot(x, y6, type = 'l')
plot(x, y7, type = 'l')
plot(x, y8, type = 'l')
plot(x, y9, type = 'l')

par(mfrow=c(3,1))
plot(x, y1, type = 'l', col = "red")
lines(x, y2, col = "black")
lines(x, y3, col = "blue")
plot(x, y4, type = 'l', col = "red")
lines(x, y5, col = "black")
lines(x, y6, col = "blue")
plot(x, y7, type = 'l', col = "red")
lines(x, y8, col = "black")
lines(x, y9, col = "blue")


f6 <- function(x,parms){
  with(as.list(c(parms)),{
    (100 + b*x)*exp(-c*x)
  })
}

xL <- 0
xU <- 5000
dx <- 0.5
x <- seq(xL, xU, dx)
y1 <- f6(x, c(b = 0, c = 0.00001))
y2 <- f6(x, c(b = 0.1, c = 0.00001))
y3 <- f6(x, c(b = 1, c = 0.00001))
y4 <- f6(x, c(b = -0.1, c = 0.00001))
y5 <- f6(x, c(b = -1, c = 0.00001))

par(mfrow=c(3,2))
plot(x, y1, type = 'l')
plot(x, y1, type = 'l')
plot(x, y2, type = 'l')
plot(x, y4, type = 'l')
plot(x, y3, type = 'l')
plot(x, y5, type = 'l')

xL <- 0
xU <- 50000
dx <- 10
x <- seq(xL, xU, dx)
y1 <- f6(x, c(b = 0, c = 0.00001))
y2 <- f6(x, c(b = 0.00001, c = 0.00001))
y3 <- f6(x, c(b = 0.001, c = 0.00001))
y4 <- f6(x, c(b = -0.00001, c = 0.00001))
y5 <- f6(x, c(b = -0.001, c = 0.00001))
par(mfrow=c(3,2))
plot(x, y1, type = 'l')
plot(x, y1, type = 'l')
plot(x, y2, type = 'l')
plot(x, y4, type = 'l')
plot(x, y3, type = 'l')
plot(x, y5, type = 'l')