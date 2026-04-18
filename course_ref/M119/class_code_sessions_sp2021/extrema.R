########################
###f(x) = x*exp(-x)
########################
f <- function(x){x*exp(-x)}
Df <- function(x){1*exp(-x) - x*(exp(-x))}
D2f <- function(x){-2*exp(-x) + x*exp(-x)}

uniroot(Df,c(-10,10))$root
cv <- uniroot(Df,c(-10,10))$root
Df(cv)
Df(1)

D2f(1)
D2f(cv)
#OR
-2*exp(-1) + 1*exp(-1)

x <- seq(-10,10,0.001)
par(mar=c(2.5,2.5,0.25,0.25))
plot(x,f(x),type = "l")

x <- seq(-1,10,0.001)
par(mar=c(2.5,2.5,0.25,0.25))
plot(x,f(x),type = "l",xlim=c(-1,10),ylim=c(-3,1))

x <- seq(0,10,0.001)
par(mar=c(2.5,2.5,0.25,0.25))
plot(x,f(x),type = "l",xlim=c(0,10),ylim=c(0,0.5))

my_plot <- function(f,left_bound,right_bound,gap = (right_bound-left_bound)/100, mar = c(2.5,2.5,0.25,0.25), type = "l",... ){
  x <- seq(left_bound,right_bound,gap)
  par(mar=mar)
  plot(x,f(x),type = type,...)
}
my_lines <- function(f,left_bound,right_bound,gap = (right_bound-left_bound)/100, type = "l",... ){
  x <- seq(left_bound,right_bound,gap)
  lines(x,f(x),type = type,...)
}

par(mfrow=c(2,3))
my_plot(f,-10,10,0.001) #We specify plotting another point every 0.0001. 
my_plot(f,-10,10) #The default in our custom function uses 101 points. 
my_plot(f,-10,10,2) #We specify plotting another point every 2. 
my_plot(f,-1,10)
my_plot(f,-1,10,ylim=c(-3,1))
my_plot(f,0,10,ylim=c(0,0.5))

a<-0
b<-10
par(mfrow=c(1,1))
my_plot(f,a,b,ylim=c(-0.5,0.5))
my_lines(Df,a,b,col = "red")
abline(h=0, lty = 2)
my_lines(D2f,a,b, col = "green")
abline(v=cv,col="blue",lty = 2)
points(cv,f(cv))
points(cv,Df(cv),col="red")
points(cv,D2f(cv),col="green")





########################
###g(x) = x(1-x)
########################
#approximate zeros
dg <- function(x){1-2*x}
uniroot(dg,c(-10,10))$root
cv <- uniroot(dg,c(-10,10))$root

#use R as a calculator
#second derivative at critical values
g.2d <- function(x){rep(-2,length(x))}
g.2d(1/2)
g.2d(cv)


#use R to graph g
g <- function(x){x*(1-x)}
x <- seq(-0.5,1.5,0.001)
par(mar=c(2.5,2.5,0.25,0.25))
plot(x,g(x),type = "l")





########################
###h(x) = x^3 - x
########################
#approximate zeros
dh <- function(x){3*x^2-1}
cv <- uniroot(dh,c(-10,10))$root
cv.1 <- uniroot(dh,c(-10,0))$root
cv.2 <- uniroot(dh,c(0,10))$root

cv.1
-sqrt(1/3)
cv.2
sqrt(1/3)

#use R as a calculator
#second derivative at critical values
h.2d <- function(x){6*x}
h.2d(-sqrt(1/3))
h.2d(cv.1)
h.2d(sqrt(1/3))
h.2d(cv.2)

#use R to graph h
h <- function(x){x^3-x}
x <- seq(-2,2,0.001)
par(mar=c(2.5,2.5,0.25,0.25))
plot(x,h(x),type = "l")


#use R to graph h on the interval [-1,2]
h <- function(x){x^3-x}
x <- seq(-1,2,0.001)
par(mar=c(2.5,2.5,0.25,0.25))
plot(x,h(x),type = "l")

h(-1)
h(-sqrt(1/3))
h(cv.1)
h(sqrt(1/3))
h(cv.2)
h(2)