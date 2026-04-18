f1 <- function(x){x^4 -10*x^2 +3*x}
f2  <- function(x){exp(2*x)-1}
f3 <- function(x){(x-1)^(1/3)}
f4 <- function(x){3*log(x-2)}
#f5  <- function(x){cos(x)}
#f6 <- function(x){abs(x)}


x <- seq(-5,5,1e-3)

#Linearization Intro
#f_1(x) at (3,0)
y1 <- f1(x)
par(mfrow=c(2,2),mar=c(2,2,0.25,0.25))
plot(x,y1,type='l',xlim=c(-4,4))
points(3,f1(3),pch=16,col=2)
plot(x,y1,type='l',xlim=c(2,4),ylim=c(-50,50))
points(3,f1(3),pch=16,col=2)
plot(x,y1,type='l',xlim=c(2.5,3.5),ylim=c(-50,50))
points(3,f1(3),pch=16,col=2)
plot(x,y1,type='l',xlim=c(2.9,3.1),ylim=c(-50,50))
points(3,f1(3),pch=16,col=2)


#f_2(x) at (0,0)
y2 <- f2(x)
par(mfrow=c(2,2),mar=c(2,2,0.25,0.25))
plot(x,y2,type='l',xlim=c(-5,5))
points(0,f2(0),pch=16,col=2)
plot(x,y2,type='l',xlim=c(-1,1),ylim=c(-5,5))
points(0,f2(0),pch=16,col=2)
plot(x,y2,type='l',xlim=c(-0.5,0.5),ylim=c(-1,1))
points(0,f2(0),pch=16,col=2)
plot(x,y2,type='l',xlim=c(-0.01,0.01),ylim=c(-0.25,0.25))
points(0,f2(0),pch=16,col=2)

#f_3(x) at (2,1)
x3 <- seq(0,5,1e-3)
y3 <- f3(x3)
par(mfrow=c(2,2),mar=c(2,2,0.25,0.25))
plot(x3,y3,type='l',xlim=c(-5,5))
points(2,f3(2),pch=16,col=2)
plot(x3,y3,type='l',xlim=c(1,3),ylim=c(0,2))
points(2,f3(2),pch=16,col=2)
plot(x3,y3,type='l',xlim=c(1.5,2.5),ylim=c(0,2))
points(2,f3(2),pch=16,col=2)
plot(x3,y3,type='l',xlim=c(1.99,2.01),ylim=c(0.99,1.01))
points(2,f3(2),pch=16,col=2)


#f_4(x) at (2.75,3*ln(0.75))
x4 <- seq(2,10,1e-3)
y4 <- f4(x4)
par(mfrow=c(2,2),mar=c(2,2,0.25,0.25))
plot(x4,y4,type='l',xlim=c(0,10))
points(2.75,f4(2.75),pch=16,col=2)
plot(x4,y4,type='l',xlim=c(1.75,3.75),ylim=c(-2,1))
points(2.75,f4(2.75),pch=16,col=2)
plot(x4,y4,type='l',xlim=c(2.5,3),ylim=c(-2,1))
points(2.75,f4(2.75),pch=16,col=2)
plot(x4,y4,type='l',xlim=c(2.7,2.8),ylim=c(-2,1))
points(2.75,f4(2.75),pch=16,col=2)

x <- c(2,2.5,2.9,2.99,2.999,3,3.001,3.01,3.1,3.5,4)
y <- f1(x)
x0 <- 3
y0 <- f1(3)
slopes <- (y-y0)/(x-x0)
slopes

ps.line <- function(x,x1,y1,m){m*(x-x1)+y1}
der.f1 <- function(x){4*x^3 - 20*x + 3}

x.in <- seq(-5,5,1e-3)
out <- f1(x.in)
par(mfrow=c(2,2),mar=c(2,2,0.25,0.25))
plot(x.in,out,type='l',xlim=c(1,5),ylim=c(-35,110))
lines(x.in,ps.line(x.in,x0,y0,slopes[1]),col='gray')
points(3,f1(3),pch=16,col=2)
points(x[1],f1(x[1]),pch=16,col=3)

plot(x.in,out,type='l',xlim=c(1,5),ylim=c(-35,110))
lines(x.in,ps.line(x.in,x0,y0,slopes[3]),col='gray')
points(3,f1(3),pch=16,col=2)
points(x[3],f1(x[3]),pch=16,col=4)

plot(x.in,out,type='l',xlim=c(1,5),ylim=c(-35,110))
lines(x.in,ps.line(x.in,x0,y0,slopes[11]),col='gray')
points(3,f1(3),pch=16,col=2)
points(x[11],f1(x[11]),pch=16,col=5)

plot(x.in,out,type='l',xlim=c(1,5),ylim=c(-35,110))
lines(x.in,ps.line(x.in,x0,y0,slopes[9]),col='gray')
points(3,f1(3),pch=16,col=2)
points(x[9],f1(x[9]),pch=16,col=6)


par(mfrow=c(1,2),mar=c(2,2,0.25,0.25))
plot(x.in,out,type='l',xlim=c(1,5),ylim=c(-35,110))
lines(x.in,ps.line(x.in,x0,y0,slopes[1]),col=3)
lines(x.in,ps.line(x.in,x0,y0,slopes[3]),col=4)
lines(x.in,ps.line(x.in,x0,y0,der.f1(x0)),col=2)
points(3,f1(3),pch=16,col=2)
points(x[1],f1(x[1]),pch=16,col=3)
points(x[3],f1(x[3]),pch=16,col=4)

plot(x.in,out,type='l',xlim=c(1,5),ylim=c(-35,110))
lines(x.in,ps.line(x.in,x0,y0,slopes[11]),col=5)
lines(x.in,ps.line(x.in,x0,y0,slopes[9]),col=6)
lines(x.in,ps.line(x.in,x0,y0,der.f1(x0)),col=2)
points(3,f1(3),pch=16,col=2)
points(x[11],f1(x[11]),pch=16,col=5)
points(x[9],f1(x[9]),pch=16,col=6)



par(mfrow=c(1,1),mar=c(2,2,0.25,0.25))
plot(x.in,out,type='l',xlim=c(1,5),ylim=c(-35,110))
lines(x.in,ps.line(x.in,x0,y0,der.f1(x0)),col='red')
points(3,f1(3),pch=16,col=2)


