library(data4soil)
ex1 <- cfbp_fpjuliet$ng

m <- runif(1,5,11)
s <- runif(1,2.5,4.25)
ex2 <- rnorm(100,m,s)

a <- runif(1,-0.5,0.5)
b <- runif(1,15,17)
ex3 <- runif(100,a,b)

r <- mean(ex1)^2/var(ex1)
lambda <- mean(ex1)/var(ex1)
ex4 <- rgamma(100,r,lambda)

data <- as.data.frame(cbind(ex1,ex2,ex3,ex4))

# > m
# [1] 5.867095
# > s
# [1] 2.761066
# > a
# [1] -0.481684
# > b
# [1] 15.34898
# > r
# [1] 0.709823
# > lambda
# [1] 0.2542674
setwd("/Users/katjohnson/Documents/git/M119/script_how-to")
write.csv(data,'example_data.csv')


#rm(list=ls())
#setwd("/Users/katjohnson/Documents/git/M119/script_how-to")
#data <- read.csv('example_data')
  #Environment Tab (click "Import Dataset")

##Check##
mean(ex1)
var(ex1)
mean(ex2)
var(ex2)
mean(ex3)
var(ex3)
mean(ex4)
var(ex4)

# > mean(ex1)
# [1] 2.79164
# > var(ex1)
# [1] 10.97915
# > mean(ex2)
# [1] 5.657317
# > var(ex2)
# [1] 8.895359
# > mean(ex3)
# [1] 7.29543
# > var(ex3)
# [1] 23.06384
# > mean(ex4)
# [1] 2.897191
# > var(ex4)
# [1] 16.47285