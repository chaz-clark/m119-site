rm(list=ls())

setwd("/Users/katjohnson/Documents/git/M119/Notes")
set.seed(7)
p <- runif(1,0,2)
data <- rexp(200,rate=p)
data <- as.data.frame(data)

write.csv(data,"test_data.csv")