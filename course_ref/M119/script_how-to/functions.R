library(tidyverse)
library(mosaic)
# https://www.guru99.com/r-functions-programming.html
curve(1/x, from = -10, to = 10, main = "1/x")


ggplot(tibble(x = c(-10, 10)), aes(x)) + 
  stat_function(fun=function(x) sin(x) + log(x))

ggplot(tibble(x=c(-10, 10)), aes(x)) + 
  stat_function(fun=function(x) 1/x)
