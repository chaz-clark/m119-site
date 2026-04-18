f1 <- function(x,n=20,p=0.5){
  factorial(n)/(factorial(x)*factorial(n-x))*p^x*(1-p)^(n-x)
}

f2 <- function(x,lambda=2){
  (lambda^x/factorial(x))*exp(-lambda)
}

f3 <- function(x,lambda=1/2){
  lambda*exp(-lambda*x)
}
f3.m2 <- function(x,lambda=1/2){
  
  out <- rep(0,length(x))
  out[(x >=0)] <- lambda*exp(-lambda*x[(x >= 0)])
  
  return(out)
}

f4 <- function(x,mu=0,s=1){
  (1/sqrt(2*pi*s^2))*exp(-(x-mu)^2/(2*s^2))
}

f5 <- function(x,lambda=1){
  1 - exp(-lambda*x)
}
f5.m2 <- function(x,lambda=1){
  
  out <- rep(0,length(x))
  out[(x > 0)] <- 1 - exp(-lambda*x[(x > 0)])
  
  return(out)
}

f6 <- function(x,a=0,b=1){
  
  out <- rep(0,length(x))
  out[(a <= x) & (x <= b)] <- (x[(a <= x) & (x <= b)]-a)/(b-a)
  out[(x > b)] <- 1

  return(out)
}