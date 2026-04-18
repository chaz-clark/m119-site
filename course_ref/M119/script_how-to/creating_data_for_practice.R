#x0 <- seq(0,20,length=30)
#x1 <- seq(-10,10,length=30)
xB <- runif(30,-10,10)
xC <- runif(30,-1,10)
x0 <- rnorm(30, mean = 10, sd = 0.1)
#default mean = 0 and sd = 1
x1 <- rexp(30, rate = 0.5)
#default rate = 1
x2 <- rbinom(30, size = 40, prob = 0.32)
#no default for size and prob
x3 <- rpois(30, lambda = 4)
#no default for lambda
n1 <- rnorm(30,mean=0,sd=runif(1,5,10))
out1 <- 3*xB - 7 + n1
out2 <- -2*(xB)^2 - 4*x1 + 1 + n1
out3 <- (1/5)*2^(xC-1) + n1
data <- as.data.frame(cbind(input1=xB,input2=xC,x1=x1,x2=x2,x3=x3,outputA=out1,outputB=out2,outputC=out3))

setwd("/Users/katjohnson/Documents/git/M119/script_how-to")
write.csv(data,'practice_data')


data <- read.csv('practice_data')
library(tidyverse)
ggplot(data,aes(x=input1,y=outputA))+
  geom_point()



