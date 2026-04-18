v <- c(3,5)
test.fun <- function(x,v){
  sum(exp(x*v)) - 10
}

check.fun <- function(x){
  exp(3*x)+exp(5*x) - 10
}
uniroot(test.fun,c(-10,10),v<-c(3,5))$root
uniroot(check.fun,c(-10,10))$root




Test.fun <- function(x,v){
  sum(exp(x*v))
}

Check.fun <- function(x){
  exp(3*x)+exp(5*x)
}
uniroot(function(x){Test.fun(x,v<-c(3,5))-10},c(-10,10))$root
uniroot(function(x){Check.fun(x)-10},c(-10,10))$root



#Linear Regression Check
x <- c(-2,1,3)
y <- c(-1,1,2)

#Analytic Solution
m <- (length(x)*sum(x*y) - sum(x)*sum(y))/(length(x)*sum(x^2) - (sum(x))^2)
b <- (sum(y) - m*sum(x))/length(x)

#Method 1 (Numerically)  
library(rootSolve)
model <- function(p,x=c(-2,1,3),y=c(-1,1,2)){
  L1 <- sum(x*y) - p[2]*sum(x^2) - p[1]*sum(x)
  L2 <- sum(y) - p[2]*sum(x) - length(x)*p[1]
  c(L1 = L1, L2 = L2)
}

sol1 <- multiroot(f = model, start = c(1,1))
sol1$root

#Method 2 (Numerically)
install.packages('nleqslv')
library(nleqslv)
model <- function(p,x=c(-2,1,3),y=c(-1,1,2)){
  L1 <- sum(x*y) - p[2]*sum(x^2) - p[1]*sum(x)
  L2 <- sum(y) - p[2]*sum(x) - length(x)*p[1]
  c(L1 = L1, L2 = L2)
}

xstart <- c(1,1)
sol2 <- nleqslv(xstart,model)
sol2$x



##Fit the Model (y = (100-a1) + a1*exp(-a2*t))
model <- function(p,x=c(-2,1,3),y=c(-1,1,2)){
  L1 <- sum(-1*(y-100+p[1]-p[1]*exp(-p[2]*x))*(1-exp(-p[2]*x)))
  L2 <- sum(-1*(y-100+p[1]-p[1]*exp(-p[2]*x))*(p[1]*x*exp(-p[2]*x)))
  c(L1 = L1, L2 = L2)
}

sol1 <- multiroot(f = model, start = c(20,0.00001))
sol1$root
#-9.707117e-12 -8.690875e-17
xstart <- c(20,0.00001)
sol2 <- nleqslv(xstart,model)
sol2$x
#3.819809e-12 -9.811951e-18

#Check
Lik.fun <- function(p,x=c(-2,1,3),y=c(-1,1,2)){
  length(x)*log(1/sqrt(2*pi)) - 0.5*sum((y-100+p[1]-p[1]*exp(-p[2]*x))^2)
}
Lik.fun(sol2$x)
  #[1] -14805.76
Lik.fun(sol1$root)
  #[1] -14805.76

set.seed(7)
#xstart <- matrix(runif(100,0,50),ncol=2)
xstart <- cbind(runif(50,0,35),runif(50,0,1))
Tmp <- searchZeros(xstart,model)
apply(Tmp$x,1,Lik.fun)
  #[1] -14805.76 -14805.76
Tmp$x
#[,1]         [,2]
#[1,] 1.523378e-11 1.070139e-14
#[2,] 9.390450e-14 3.043944e-01
#It appear that this particular function may have a fairly flat logLikelihood function for the given data and has many pairs of parameters with the same maximum logLikelihood.
#It might be worthwhile to plot a heat map (or contour plot) of the logLikelihood function for a1 from (0,1) and a2 from (0,35).