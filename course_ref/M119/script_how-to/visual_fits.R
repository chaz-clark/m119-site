setwd("/Users/katjohnson/Documents/git/M119/script_how-to")
data <- read.csv("practice_data")

par(mar=c(2.5,2.5,0.25,0.25))
plot(data$input1,data$outputB,type='p',pch=16)

quad <- function(x,a,b,c){
  a*x^2+b*x+c
}
x <- seq(-10,10,0.01)
lines(x,quad(x,a=-10,b=0,c=3),col="red")
lines(x,quad(x,a=-1/4,b=0,c=3),col="red")
lines(x,quad(x,a=-2,b=0,c=3),col="red")

par(mar=c(2.5,2.5,0.25,0.25))
plot(data$input2,data$outputC,type='p',pch=16)

expnt <- function(x,a,b,c,d){
  a*b^(x+c) +d
}
x <- seq(-1,10,0.01)
lines(x,expnt(x,a=3,b=2,c=-4,d=1),col="red")
lines(x,expnt(x,a=1,b=2,c=-4,d=1),col="blue")
lines(x,expnt(x,a=1/3,b=2,c=-2,d=0),col="gray")
