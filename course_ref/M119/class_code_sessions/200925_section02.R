#This is how you clear your environment.
rm(list=ls())

#The question mark before the function brings up the R documentation.
?log()

#Use R as a calculator to find a decimal approximation for the number, log base 16 of 67, log_16(67).
log(67,16)


#Define a function for the left hand side of the equation, f(x) = 16^x.
f.left <- function(x){
16^x
}
#Define a function for the right hand side of the equation, f(x) = 67.
f.right <- function(x){
rep(67,length(x))
}

#Graph the functions on the right and the left side of the equation to get an idea of the location of the solution (where the two function intersect).
#Call the tidyverse library so we can use the ggplot() function.
library(tidyverse)
#Create an initial data frame to use in the ggplot() function.
plot.df <- as.data.frame(cbind(x=seq(-10,10,0.01),y=seq(-10,10,0.1)))

#Create the plot.
ggplot(plot.df,aes(x,y))+
  geom_function(fun=f.left,color="red")+
  geom_function(fun=f.right,color="blue")
##The y-axis is too big to see anything interesting.

#Use ylim to limit the set plot for 0 to 100 on the y-axis.
ggplot(plot.df,aes(x,y))+
  geom_function(fun=f.left,color="red")+
  geom_function(fun=f.right,color="blue")+
  ylim(0,180)

#To solve numerically in R, use the uniroot() function.
#The uniroot() function looks for zeros of a function.
#So, first solve the equation so one of the sides is zero and then program the nonzero side as a function.
#Subtract 16^v from both sides of the equation 16^v=67 to get 0=67-16^v.
#Define the function f(v) = 67-16^v.
f <- function(v){67-16^v}
#The two argument in the uniroot function are the function, f, and the interval to look for the solution.
#We selected the interval 0 to 5 from the information we see in the graphs we created before.
uniroot(f,c(0,5))
#Notice the uniroot() function in R has several outputs.
  #We use the $root to extract the x-value from the output of the uniroot() function in R.
uniroot(f,c(0,5))$root
#Compare to the decimal approximation of the exact solution.
log(67,16)
