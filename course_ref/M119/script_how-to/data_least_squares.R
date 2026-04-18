rm(list=ls())
set.seed(2021)
p1 <- runif(1,1,3)
p2 <- runif(1,5,7)
p3 <- runif(1,8,13)
p4 <- runif(1,2,5)
p5 <- runif(1,0.5,4)
#p1
#[1] 1.902535
#p2
#[1] 6.56756
#p3
#[1] 11.54841
#p4
#[1] 3.145233
#p5
#[1] 2.727133



x <- runif(60,-5,5)
y1 <- p5*x + rnorm(length(x),0,1)
data1 <- cbind(x=x,y=y1)
data1 <- as.data.frame(data1)
write.csv(data1,"data1_ls.csv")

y2 <- p2*x + rnorm(length(x),0,2) + p4
data2 <- cbind(x=x,y=y2)
data2 <- as.data.frame(data2)
write.csv(data2,"data2_ls.csv")

x3 <- runif(60,-2,4)
y3 <- p1*exp(-x3) + rnorm(length(x3),0,1)
data3 <- cbind(x=x3,y=y3)
data3 <- as.data.frame(data3)
write.csv(data3,"data3_ls.csv")

x4 <- runif(60,-4,2)
y4 <- p4*exp(x4) + rnorm(length(x4),0,1)
data4 <- cbind(x=x4,y=y4)
data4 <- as.data.frame(data4)
write.csv(data4,"data4_ls.csv")

x2 <- runif(60,1e-15,5)
y5 <- p3*log(x2) + rnorm(length(x2),0,2)
data5 <- cbind(x=x2,y=y5)
data5 <- as.data.frame(data5)
write.csv(data5,"data5_ls.csv")