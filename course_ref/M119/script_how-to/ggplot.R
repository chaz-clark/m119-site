rm(list = ls())
#Use a hashtag to make a comment in R.

####################################
###Plotting Functions in ggplot2.###
####################################

#Load the needed libraries
  #install.packages("tidyverse")
library(tidyverse)

###Step 1: Create the function in R.
f1 <- function(x){
  return( x^2 - x )
}

f2 <- function(x){
  sqrt(x+1)
}

###Step 2: Calculate your inputs and outputs in a data frame.
x <- seq(-20,20,0.01)
plot.dat <- as.data.frame(cbind(x,f1(x)))
names(plot.dat) <- c("x","y")

###Step 3: Graph the curve.
ggplot(plot.dat, aes(x,y)) + 
  geom_function(fun = f1, color = "red")

#Notice did not have to define the input vector, x.
ggplot(plot.dat, aes(x,y)) + 
  geom_function(fun = f2, color = "blue")
  #Notice the warning, that is because when (x+1) is negative the function is undefined.

x_new <- seq(-1,20,0.01)
plot.dat <- as.data.frame(cbind(x_new,f2(x_new)))
names(plot.dat) <- c("x","y")
ggplot(plot.dat, aes(x,y)) + 
  geom_function(fun = f2, color = "blue")
  #Notice we did not get the warning this time.

###We can plot two curves on the same graph.
x <- seq(-20,20,0.01)
plot.dat <- as.data.frame(cbind(x,f1(x)))
names(plot.dat) <- c("x","y")
ggplot(plot.dat, aes(x,y)) + 
  geom_function(fun = f1, color = "red") +
  geom_function(fun = f2, color = "blue")
  #Notice the y-axis is to big to see much of what is going on with the square root fuction.

ggplot(plot.dat, aes(x,y)) + 
  xlim(-10,15) +
  ylim(-2,15) +
  geom_function(fun = f1, color = "red") +
  geom_function(fun = f2, color = "blue")


###CONSTANT function.
#This function is suprisingly tricky to program.

const.fun1 <- function(t){rep(100,length(t))}
const.fun2 <- function(t){100*t/t}

##Are they they same?
##Is one "better"?

#> const.fun1(0)
#[1] 100
#> const.fun2(0)
#[1] NaN

#> const.fun1(seq(-1,1,0.1))
#[1] 100 100 100 100 100 100 100 100 100 100 100 100 100 100 100 100 100 100 100 100
#[21] 100
#> const.fun2(seq(-1,1,0.1))
#[1] 100 100 100 100 100 100 100 100 100 100 NaN 100 100 100 100 100 100 100 100 100
#[21] 100


##Scatterplot
table.dat <- as.data.frame(cbind(x=c(0,1,4,9,16,25),y=c(0,1,2,3,4,5)))
ggplot(table.dat, aes(x, y)) +
  geom_point()
  
  
##Getting a Plot Started requires a data frame.
plot.df <-as.data.frame(cbind(x=seq(-20,20,0.01),y=seq(-20,20,0.01)))

f <- function(x){4^x}
ggplot(plot.df,aes(x,y))+
	geom_function(fun=f,color="red") +
	xlim(-2,2) +
	ylim(-1,8)
	
	
#CHALLENGE: Can you figure out how to plot a constant function in R?