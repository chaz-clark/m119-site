rm(list = ls())

x <- c(0,1,4,9,16,25)
y <- c(0,1,2,3,4,5)
plot(x,y,type="p")
plot(x,y,type="p",xlim=c(0,30),ylim=c(0,10))
plot(x,y,type="l",xlim=c(0,30),ylim=c(0,10))


f <- function(x){sqrt(x)}
f(9)
f(3)
sqrt(3)

x <- seq(0,25,length=100)
head(x)

x <- seq(0,25,by=0.1)
head(x)
length(x)

plot(x,f(x),type='l',xlim=c(0,30),ylim=c(0,10))



##Summatation and Polynomials
quad.f1 <- function(x){
  x^2 + 2*x + 1
}

quad.f2 <- function(x,a=c(1,2,1)){
  var <- c(x^2,x,x^0)
  sum(a*var)
}
###Adapt this for any degree.