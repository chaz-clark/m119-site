set.seed(1102)
m <- runif(1,-5,5)
x <- runif(35,-5,5)
y <- m*x + runif(length(x),0,1)


L <- function(m,x,y){
  #This is the likelihood function for the relationship model y=mx. 
    #Assuming the errors follow the probability model f(r) = (1/sqrt(2*pi))*exp(-(r)^2/2)
    #Assuming the errors are independent
  
  #x is a vector of data, the first coordinate, the independent (explanatory or input) variable
  #y is a vector of data, the second coordinate, the dependent (response or output) variable
  
  #m is a parameter, a number
    #This likelihood function is a function of m.
  prod((1/sqrt(2*pi))*exp(-(y-m*x)^2/2))
}

logL <- function(m,x,y){
  #This is the loglikelihood function for the relationship model y=mx. 
    #Assuming the errors follow the probability model f(r) = (1/sqrt(2*pi))*exp(-(r)^2/2)
    #Assuming the errors are independent
  
  #x is a vector of data, the first coordinate, the independent (explanatory or input) variable
  #y is a vector of data, the second coordinate, the dependent (response or output) variable
  
  #m is a parameter, a number
    #This likelihood function is a function of m.
  log(prod((1/sqrt(2*pi))*exp(-(y-m*x)^2/2)))
}


x.val <- seq(-5,6,0.01)
y.L <- as.vector(lapply(seq(-5,6,0.01),FUN=L,x=x,y=y))
y.logL <- as.vector(lapply(seq(-5,6,0.01),FUN=logL,x=x,y=y))


par(mfrow=c(1,2))
par(mar=c(2.5,2.5,0.25,0.25))
plot(x.val,y.L,type='l')
plot(x.val,y.logL,type='l')






set.seed(1102)
a0 <- runif(1,-5,5)
a0 <- runif(1,-5,5)
x <- runif(35,-5,5)
y <- a0 + a1*x + runif(length(x),0,1)



L <- function(a0,a1,x,y){
  #This is the likelihood function for the relationship model y=mx. 
  #Assuming the errors follow the probability model f(r) = (1/sqrt(2*pi))*exp(-(r)^2/2)
  #Assuming the errors are independent
  
  #x is a vector of data, the first coordinate, the independent (explanatory or input) variable
  #y is a vector of data, the second coordinate, the dependent (response or output) variable
  
  #m is a parameter, a number
  #This likelihood function is a function of m.
  prod((1/sqrt(2*pi))*exp(-(y-a0-a1*x)^2/2))
}

logL <- function(a0,a1,x,y){
  #This is the loglikelihood function for the relationship model y=mx. 
  #Assuming the errors follow the probability model f(r) = (1/sqrt(2*pi))*exp(-(r)^2/2)
  #Assuming the errors are independent
  
  #x is a vector of data, the first coordinate, the independent (explanatory or input) variable
  #y is a vector of data, the second coordinate, the dependent (response or output) variable
  
  #m is a parameter, a number
  #This likelihood function is a function of m.
  log(prod((1/sqrt(2*pi))*exp(-(y-a0-a1*x)^2/2)))
}


x.val <- seq(-5,6,0.01)
y.L <- as.vector(lapply(seq(-5,6,0.01),FUN=L,x=x,y=y))
y.logL <- as.vector(lapply(seq(-5,6,0.01),FUN=logL,x=x,y=y))


par(mfrow=c(1,2))
par(mar=c(2.5,2.5,0.25,0.25))
plot(x.val,y.L,type='l')
plot(x.val,y.logL,type='l')