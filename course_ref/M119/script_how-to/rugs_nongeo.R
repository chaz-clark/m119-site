f1 <- function(x){
  25-x^2
}

n <- 100
x <- seq(0,5,length=(n+1))
height.l <- f1(x[1:n])
height.r <- f1(x[2:(n+1)])
width <- rep(x[2]-x[1],n)
area.l <- height.l*width
area.r <- height.r*width
A.left <- sum(area.l)
A.right <- sum(area.r)
A.left
A.right



f2 <- function(x){
  1/(x+1)
}

n <- 100
x <- seq(0,8,length=(n+1))
height.l <- f2(x[1:n])
height.r <- f2(x[2:(n+1)])
width <- rep(x[2]-x[1],n)
area.l <- height.l*width
area.r <- height.r*width
A.left <- sum(area.l)
A.right <- sum(area.r)
A.left
A.right



f3 <- function(x){
  x^2 - 10*x + 25
}

n <- 100
x <- seq(0,5,length=(n+1))
height.l <- f3(x[1:n])
height.r <- f3(x[2:(n+1)])
width <- rep(x[2]-x[1],n)
area.l <- height.l*width
area.r <- height.r*width
A.left <- sum(area.l)
A.right <- sum(area.r)
A.left
A.right