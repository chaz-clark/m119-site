library(nleqslv)



###Example 1###
set.seed(1106)
m <- runif(1,-2,2)
x <- runif(35,-5,5)
y <- m*x + rnorm(length(x),0,1)
m.best <- sum(x*y)/sum(x^2)

ex1.fun <- function(m,x.data,y.data){
  length(x.data)*log(1/sqrt(2*pi)) + sum(-0.5*(y.data-m*x.data)^2)
}
ex1.der <- function(m,x.data,y.data){
  sum(x.data*y.data)-m*sum(x.data^2)}

uniroot(ex1.der,c(-10,10),x.data=x,y.data=y)$root
nleqslv(0,ex1.der,x.data=x,y.data=y)$x

optimize(ex1.fun,c(-10,10),x=x,y=y,maximum=TRUE)$maximum

m.best





###Example 2###
set.seed(1106)
a1 <- runif(1,-10,10)
a2 <- runif(1,-10,10)
x <- runif(300,-5,5)
y <- a1 + a2*x + rnorm(length(x),0,1)
a2.best <- (sum(x*y)-sum(x)*sum(y)/length(x))/(sum(x^2)-sum(x)^2/length(x))
a1.best <- (sum(y)-a2.best*sum(x))/length(x)

ex2.fun <- function(a,x.data,y.data){
  length(x.data)*log(1/sqrt(2*pi)) + sum(-0.5*(y.data-a[1]-a[2]*x.data)^2)
}
ex2.der <- function(a,x.data,y.data){
  out <- numeric(2)
  out[1] <- sum(y.data) - a[1]*length(x.data) - a[2]*sum(x.data)
  out[2] <- sum(x.data*y.data) - a[1]*sum(x.data) - a[2]*sum(x.data^2)
  return(out)
}

a0 <- c(-1,1)
nleqslv(a0,ex2.der,x.data=x,y.data=y)$x
multiroot(ex2.der,a0,x.data=x,y.data=y)$root

optim(a0, ex2.fun, x.data=x, y.data=y, control=list(fnscale=-1))$par
optim(a0, ex2.fun, x.data=x, y.data=y, control=list(fnscale=-1),method="BFGS")$par

a1.best
a2.best





###Example 3###
set.seed(1106)
a1 <- runif(1,75,150)
a2 <- runif(1,-10,0)
x <- runif(150,-5,5)
y <- a1 + a2*exp(-x) + rnorm(length(x),0,1)
a2.best <- (sum(exp(-x)*y)-sum(exp(-x))*sum(y)/length(x))/(sum(exp(-2*x))-sum(exp(-x))^2/length(x))
a1.best <- (sum(y)-a2.best*sum(exp(-x)))/length(x)

ex3.fun <- function(a,x.data,y.data){
  length(x.data)*log(1/sqrt(2*pi)) + sum(-0.5*(y.data-a[1]-a[2]*exp(-x.data))^2)
}
ex3.der <- function(a,x.data,y.data){
  out <- numeric(2)
  out[1] <- sum(y.data) - a[1]*length(x.data)-a[2]*sum(exp(-x.data))
  out[2] <- sum(y.data*exp(-x.data)) - a[1]*sum(exp(-x.data)) - a[2]*sum(exp(-2*x.data))
  return(out)
}

a0 <- c(-1,1)
nleqslv(a0,ex3.der,x.data=x,y.data=y)$x
multiroot(ex3.der,a0,x.data=x,y.data=y)$root

optim(a0, ex3.fun, x.data=x, y.data=y, control=list(fnscale=-1))$par
optim(a0, ex3.fun, x.data=x, y.data=y, control=list(fnscale=-1),method="BFGS")$par

a1.best
a2.best