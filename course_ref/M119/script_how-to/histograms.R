setwd("/Users/katjohnson/Documents/git/M119/script_how-to")

data <- read.csv("practice_data")
head(data)

library(tidyverse)
ggplot(data,aes(x=input1,y=outputA))+
  geom_point()

ggplot(data,aes(x=input1,y=outputA))+
  geom_point()+
  geom_function(fun=function(x){3.6*x-6.5},color='red')

ggplot(data,aes(x=x1))+
  geom_histogram(binwidth=0.5,aes(y=..density..))

ggplot(data,aes(x=x2))+
  geom_histogram(binwidth=1,aes(y=..density..))

ggplot(data,aes(x=x3))+
  geom_histogram(bins=7,aes(y=..density..))



ggplot(data,aes(x=x1))+
  geom_histogram(binwidth=0.5,aes(y=..density..))+
  stat_function(fun=dexp,arg=list(rate=1),color='red')




