f <- function(x){x*exp(-x)}
x <- seq(-10,10,0.1)
par(mar=c(2.5,2.5,0.25,0.25))
plot(x,f(x),type = "l")

x <- seq(-1,10,0.1)
par(mar=c(2.5,2.5,0.25,0.25))
plot(x,f(x),type = "l")

x <- seq(0,10,0.1)
par(mar=c(2.5,2.5,0.25,0.25))
plot(x,f(x),type = "l")



g <- function(x){x*(1-x)}
x <- seq(-0.5,1.5,0.1)
par(mar=c(2.5,2.5,0.25,0.25))
plot(x,g(x),type = "l")



cFun <- function(x){x^3-x}
x <- seq(-1,2,0.1)
par(mar=c(2.5,2.5,0.25,0.25))
plot(x,cFun(x),type = "l")

x <- seq(-1.5,2,0.1)
par(mar=c(2.5,2.5,0.25,0.25))
plot(x,cFun(x),type = "l")
abline(v=-1,col='gray')

x <- seq(-1,2.2,0.1)
par(mar=c(2.5,2.5,0.25,0.25))
plot(x,cFun(x),type = "l")
abline(v=2,col='gray')

x <- seq(-1.2,2.3,0.1)
par(mar=c(2.5,2.5,0.25,0.25))
plot(x,cFun(x),type = "l")
abline(v=-1,col='gray')
abline(v=2,col='gray')



h <- function(x){
out <- rep(0,length(x))
out[x == 0]<- 7
out[x != 0] <- 1/x[x != 0]
out
}

x <- seq(-1,1,0.001)
par(mar=c(2.5,2.5,0.25,0.25))
plot(x,h(x),type = "l")

h(0)
par(mar=c(2.5,2.5,0.25,0.25))
plot(x,h(x),type = "l",ylim=c(-10,10))
points(0,h(0),pch=16)

b <- function(x){105*x^2*(1-x)^{13}}
x <- seq(0,1,0.001)
plot(x,b(x),type = "l")
