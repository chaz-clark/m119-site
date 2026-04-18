rm(list=ls())
library(data4led)
bulb <- led_bulb(1,seed=0219)

t <- bulb$hours
y <- bulb$percent_intensity


A <- sum((y-100)*t)
A

B <- sum(t^2)
B

C <- sum(t^3)
C

D <- sum((y-100)*t^2)
D

E <- sum(t^4)
E