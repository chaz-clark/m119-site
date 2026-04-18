library(tidyverse)
plot.df <- as.data.frame(cbind(x=seq(0,20,1),y=seq(0,1,length=21)))

d1 <- function(x,par=c(20,0.5)){
  n=par[1]
  p=par[2]
  
  factorial(n)/(factorial(x)*factorial(n-x))*p^x*(1-p)^(n-x)
  }

x <- seq(0,100,0.001)
y <- d1(x,c(100,0.75))
df <- as.data.frame(x=x,y=y)
ggplot(df,aes(x,y))+
  geom_function(fun=d1,args=list(par=c(100,0.75)),size=2)+
  geom_function(fun=dbinom,args=list(size = 100,prob=0.75),color='red')+
  ylim(0,1)

x <- seq(0,100,1)
y <- d1(x,c(100,0.75))
plot(x,y,type="l",lwd=3)
lines(x,dbinom(x,size=100,prob=0.75),col='red')
