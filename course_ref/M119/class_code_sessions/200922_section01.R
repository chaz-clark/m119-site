#Clear your environment.
rm(list=ls())

#Define the function, f(x) = 5^x.
f <- function(x){5^x}

#We need the tidyverse package in order to use the ggplot() function.
#Use the following command to install the tidyverse package. 
  #install.packages("tidyverse")
#You must have the package installed to call the package into your session.
library(tidyverse)

#You need a data frame to use the ggplot() function.
#Let's create a generic data frame with the two columns.
  #x a list of numbers from -20 to 20 spaced by 0.01
  #y a list of numbers from -20 to 20 spaced by 0.01
plot.df <- as.data.frame(cbind(x=seq(-20,20,0.01),y=seq(-20,20,0.01)))
#Take a look at the top of the data frame.
head(plot.df)

#Create a graph of the function f(x) = 5^x using the ggplot() function.
  #gg in ggplot stands for grammar of graphics
  #The first line create the plot. The "+" tells R more is coming.
  #The second line adds the curve to the plot. (notice the "+" more is coming)
  #The third line sets the limits for the horizontal axis.
  #The fourth line sets the limits for the vertical axis.
ggplot(plot.df, aes(x,y))+
  geom_function(fun=f,color='blue')+
  xlim(-2,2)+
  ylim(-1,10)