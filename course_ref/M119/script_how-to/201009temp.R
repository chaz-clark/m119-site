f1 <- function(x,n=20,p=0.5){
  factorial(n)/(factorial(x)*factorial(n-x))*p^x*(1-p)^(n-x)
}

dbinom(3,size=10,prob=0.5)
f1(x=3,n=10,p=0.5)

dbinom(3,size=10,prob=0.4)
f1(x=3,n=10,p=0.4)

p <- seq(0,1,0.01)
par(mar=c(2.5,2.5,0.25,0.25))
plot(p,dbinom(3,size=10,prob=p),type='l')

l.true <- runif(1,1,2)
x <- rexp(1000,rate=l.true)
par(mar=c(2.5,2.5,0.25,0.25))
hist(x,probability = TRUE)

f3 <- function(lambda,data){
  prod(lambda*exp(-lambda*data))
}

lik1 <- function(l,x){
  apply(as.matrix(l),MARGIN=1,FUN=f3, data=x)
}


l.obs <- seq(0,3,0.001)
par(mar=c(2.5,2.5,1,0.25))
plot(l.obs,lik1(l.obs,x),type='l')

l.true
abline(v=l.true,col=2)

