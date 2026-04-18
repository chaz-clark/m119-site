set.seed(1102)
m <- runif(1,-5,5)
x <- runif(35,-5,5)
y <- m*x + runif(length(x),0,1)
par(mar=c(3,3,0.5,0.25))
plot(x,y,pch=16)

set.seed(1106)
m <- runif(1,-2,2)
x <- runif(35,-5,5)
y <- m*x + rnorm(length(x),0,1)
Use the following code to visualize the likelihood function and the loglikelihood function.
CODE
L <- function(m,x,y){prod((1/sqrt(2*pi))*exp(-(y-m*x)^2/2))}
logL <- function(m,x,y){log(prod((1/sqrt(2*pi))*exp(-(y-m*x)^2/2)))}
x.val <- seq(-5,6,0.01)
y.L <- as.vector(lapply(seq(-5,6,0.01),FUN=L,x=x,y=y))
y.logL <- as.vector(lapply(seq(-5,6,0.01),FUN=logL,x=x,y=y))
par(mfrow=c(1,2),mar=c(2.5,2.5,0.25,0.25))
plot(x.val,y.L,type='l')
plot(x.val,y.logL,type='l')
Use the following code to compute m.
CODE
m.best <- sum(x*y)/sum(x^2)
m.best
Use the following code to visualize the fit.
CODE
ex1.fun <- function(x,m=1){m*x}
par(mfrow=c(1,1),mar=c(2.5,2.5,0.25,0.25))
plot(x,y,type='p',pch=16)
lines(x.val,ex1.fun(x.val,m=m.best),col=3)













set.seed(1103)
a0 <- runif(1,-5,5)
a1 <- runif(1,1,3)
x <- runif(40,-5,5)
y <- a0 + a1*x + runif(length(x),0,1)
par(mfrow=c(1,1),mar=c(3,3,0.5,0.25))
plot(x,y,pch=16)
abline(v=0,lty=3,col='gray')
abline(h=0,lty=3,col='gray')

set.seed(1106)
a1 <- runif(1,-10,10)
a2 <- runif(1,-10,10)
x <- runif(300,-5,5)
y <- a1 + a2*x + rnorm(length(x),0,1)
Use the following code to compute a1 and a2.
CODE
a2.best <- (sum(x*y)-sum(x)*sum(y)/length(x))/(sum(x^2)-sum(x)^2/length(x))
a1.best <- (sum(y)-a2.best*sum(x))/length(x)
a1.best
a2.best
Use the following code to compute D to check that we found the location of a maximum.
CODE
D <- length(x)*sum(x^2) - sum(x)^2
D
Use the following code to visualize the fit.
CODE
ex2.fun <- function(x,a1=0,a2=1){a1 + a2*x}
par(mfrow=c(1,1),mar=c(2.5,2.5,0.25,0.25))
plot(x,y,type='p',pch=16)
lines(x.val,ex2.fun(x.val,a1=a1.best,a2=a2.best),col=3)




set.seed(1106)
a1 <- runif(1,75,150)
a2 <- runif(1,-10,0)
x <- runif(150,-5,5)
y <- a1 + a2*exp(-x) + rnorm(length(x),0,1)
Use the following code to compute a1 and a2.
CODE
a2.best <- (sum(exp(-x)*y)-sum(exp(-x))*sum(y)/length(x))/(sum(exp(-2*x))-sum(exp(-x))^2/length(x))
a1.best <- (sum(y)-a2.best*sum(exp(-x)))/length(x)
a1.best
a2.best
Use the following code to compute D to check that we found the location of a maximum.
CODE
D <- length(x)*sum(exp(-2*x)) - sum(exp(-x))^2
D
Use the following code to visualize the fit.
CODE
ex3.fun <- function(x,a1=0,a2=1){a1 + a2*exp(-x)}
x.val <- seq(-10,10,0.1)
par(mfrow=c(1,1),mar=c(2.5,2.5,0.25,0.25))
plot(x,y,type='p',pch=16)
lines(x.val,ex3.fun(x.val,a1=a1.best,a2=a2.best),col=3)