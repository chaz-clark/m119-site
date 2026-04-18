rm(list=ls())

#Read in Libraries
library(tidyverse)

#Using help
?log()

#e in R
exp(1)

###Example 1
#Use a GRAPH to get an idea of the solution
  #Set up the backgroud data frame for ggplot
plot.df <- as.data.frame(cbind(x=seq(-10,10,0.001),y=seq(-10,10,0.001)))

#Method 1
f.left <- function(x){16^x}
f.right <- function(x){rep(67,length(x))}

ggplot(plot.df,aes(x,y))+
  geom_function(fun=f.left,color='blue')+
  geom_function(fun=f.right,color="red")+
  ylim(0,100)+
  geom_point(aes(x=log(67,16),y=67),color='black')

#Method 2
f <- function(x){16^x - 67}
ggplot(plot.df,aes(x,y))+
  geom_function(fun=f,color='black')+
  ylim(-100,100)+
  geom_point(aes(x=log(67,16),y=0),color='red')


#To numerically SOLVE the equation 16^x=67. 
  #First solve by hand so one side of the equation is zero.
  #Program the nonzero side and use the uniroot function.
uniroot(f,c(-2,2))
uniroot(f,c(-2,2))$root
#For more details look at the details for the uniroot() function.


###Example 2
f.left <- function(x){1+log(-9*x,5)}
  #Note the domain for this function is x<0.
f.right <- function(x){rep(4,length(x))}
ggplot(plot.df,aes(x,y))+
  geom_function(fun=f.left,color='blue')+
  geom_function(fun=f.right,color="red")+
  xlim(-20,0)+
  geom_point(aes(x=-125/9,y=4),color='black')

f <- function(x){log(-9*x,5)-3}
sol <- uniroot(f,c(-20,-10))$root

ggplot(plot.df,aes(x,y))+
  geom_function(fun=f.left,color='blue')+
  geom_function(fun=f.right,color="red")+
  xlim(-20,0)+
  geom_point(aes(x=sol,y=4),color='gray')


  
###Example 3
g <- function(x){exp(x-1)-10}
ggplot(plot.df,aes(x,y))+
  geom_function(fun=g,color='black')+
  xlim(-5,5)+
  geom_point(aes(x=1+log(10),y=0),color='green')

sol.g <- uniroot(g,c(-5,5))$root
sol.g
ggplot(plot.df,aes(x,y))+
  geom_function(fun=g,color='black')+
  xlim(-5,5)+
  geom_point(aes(x=sol.g,y=0),color='red')



###Example 4
h <- function(x){log((-32-3*x)/(x^2+9*x),14)}
  #Note the domain for this function is x<-32/3.
uniroot(h,c(-50,-32/3-0.01))$root
uniroot(h,c(-500,-32/3-0.0001))$root

ggplot(plot.df,aes(x,y))+
  geom_function(fun=h,color='black')+
  xlim(-50,-32/3)

ggplot(plot.df,aes(x,y))+
  geom_function(fun=h,color='black')+
  xlim(-500,-32/3)+
  ylim(-5,0)

ggplot(plot.df,aes(x,y))+
  geom_function(fun=h,color='black')+
  xlim(-5000,-32/3)+
  ylim(-5,0)

