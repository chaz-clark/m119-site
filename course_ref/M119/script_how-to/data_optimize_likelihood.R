m <- runif(1,-2,2)
b <- runif(1,-10,10)
#m
#[1] -0.5434625
#b
#[1] -2.294856
x <- runif(50,-5,5)
y1 <- m*x + rnorm(length(x),0,1)
y2 <- b + m*x + rnorm(length(x),0,1)

data <- cbind(x,y1,y2)
data <- as.data.frame(data)
write.csv(data,"logLikelihood_practice.csv")







L <- function(m,x,y){
  prod((1/sqrt(2*pi))*exp(-(y-m*x)^2/2))
}
logL <- function(m,x,y){
  log(prod((1/sqrt(2*pi))*exp(-(y-m*x)^2/2)))
}

x.val <- seq(-5,6,0.01)
y.L <- as.vector(lapply(seq(-5,6,0.01),FUN=L,x=x,y=y))
y.logL <- as.vector(lapply(seq(-5,6,0.01),FUN=logL,x=x,y=y))

par(mfrow=c(1,2))
par(mar=c(2.5,2.5,0.25,0.25))
plot(x.val,y.L,type='l')
plot(x.val,y.logL,type='l')

m.best <- sum(x*y1)/sum(x^2)
m.best
ex1.fun <- function(x,m=1){
  m*x
}
par(mfrow=c(1,1),mar=c(2.5,2.5,0.25,0.25))
plot(x,y1,type='p',pch=16,ylim=c(-5,10))
lines(x.val,ex1.fun(x.val,m=m.best),col=3)
abline(h=0,lty=3,col='gray')
abline(v=0,lty=3,col='gray')




m2.best <- (sum(x*y2)-sum(x)*sum(y2)/length(x))/(sum(x^2)-sum(x)^2/length(x))
b.best <- (sum(y2)-m2.best*sum(x))/length(x)
b.best
m2.best
m
b
D <- length(x)*sum(x^2) - sum(x)^2
D
ex2.fun <- function(x,b=0,m=1){
  b + m*x
}
par(mfrow=c(1,1),mar=c(2.5,2.5,0.25,0.25))
plot(x,y2,type='p',pch=16,ylim=c(-5,10))
lines(x.val,ex2.fun(x.val,b=b.best,m=m2.best),col=3)
abline(h=0,lty=3,col='gray')
abline(v=0,lty=3,col='gray')




a1 <- runif(1,75,150)
a2 <- runif(1,-10,0)
#a1
#[1] 100.0332
#a2
#[1] -3.232621e-05
x <- runif(150,-5,5)
y1 <- a1 + a2*exp(-x) + rnorm(length(x),0,1)
y2 <- a1 + a2*exp(-x) + rnorm(length(x),0,1)

data <- cbind(x,y1,y2)
data <- as.data.frame(data)
write.csv(data,"logLikelihood_practice2.csv")