#Install required libraries. 
  #We need tidyverse in order to use the ggplot() function in R.
library(tidyverse)

#To solve the equation log_14(-32-3n) = log_14(n^2+9n).
  #First write the equation with zero on one side.
    #log_14(-32-3n) - log_14(n^2+9n) = 0
#Define the a function from the nonzero side of this rewritten equation.
f <- function(x){
  log(-32-3*x,14)-log(x^2+9*x,14)
}

#The uniroot() function in R look for the root (or zero) of a function.
  #A zero of a function is where the function equal zero.
#We must specify an interval to look for  the zero. 
  #Remember that logarithmic functions have restrictions on the domain. 
  #Find the domain to help you know where to look for a solution.
#uniroot()$root with return the "x-value" for the solution.
uniroot(f,c(-50,-32/3-0.0001))$root
uniroot(f,c(-500,-32/3-0.0001))$root
uniroot(f,c(-50000,-32/3-0.0001))$root

#After several unsuccessful attempts to find a solution using different search intervals, maybe we need more information.
  #Let's look at a graph to gather more information about f.
plot.df <- as.data.frame(cbind(x=seq(-50,-10,0.01),y=seq(-50,-10,0.01)))
ggplot(plot.df,aes(x,y))+
  geom_function(fun=f)

ggplot(plot.df,aes(x,y))+
  geom_function(fun=f)+
  xlim(-5000,-32/3)
#From these graph, it appears there is no solution.
#In this case, we can verify this analytically.