rm(list=ls())
library(data4led)
bulb <- led_bulb(202)

f2.fit <- function(id){
  #bulb <- led_bulb(1,seed=s)
  tmp <- which(bulb$id == id)
  data <- bulb[tmp,]
  t <- data$hours
  y <- data$percent_intensity 
  
  c.11 <- sum(t^2)
  c.12 <- sum(t^3)
  c.22 <- sum(t^4)
  b.1 <- sum((y-100)*t)
  b.2 <- sum((y-100)*t^2)
  
  best.y <- (c.11*b.2 - c.12*b.1)/(c.11*c.22 - c.12^2)
  best.x <- (b.1 - c.12*best.y)/c.11
  
  return(c(best.x,best.y))
}

fits <- t(matrix(unlist(lapply(1:202,FUN=f2.fit)), nrow = 2))

summary(fits[,1])             
summary(fits[,2])

par(mfrow=c(1,2),mar=c(4,4,1,0.5),oma=c(0.25,0.25,1,0.25))
hist(fits[,1],xlab="a1",main=NA,ylim=c(0,70))
hist(fits[,2],xlab="a2",main=NA,ylim=c(0,70))
title(main="Histogram Fitted Parameter Values",outer=TRUE)