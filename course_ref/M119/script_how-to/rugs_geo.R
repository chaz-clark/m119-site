R1 <- function(x){
  out <- rep(-1, length(x))
  out[(x <= 0)] <- rep(0,length(x[x <= 0]))
  out[(0 < x) & (x < 5)] <- -x[(0 < x) & (x < 5)] + 5
  out[(x >= 5)] <- rep(0,length(x[x >= 5]))
  return(out)
}

#R1 <- function(x){-x+5}

x.vals <- seq(0,5,0.001)
par(mfrow=c(1,1),mar=c(2.5,2.5,0.25,0.25))
plot(x.vals,R1(x.vals),type='l',xlim=c(0,5))
abline(h=0,lty=2,col='gray')
abline(v=0,lty=2,col='gray')

F1 <- function(x){
  out <- rep(-1, length(x))
  out[(x <= 0)] <- rep(0,length(x[x <= 0]))
  out[(0 < x) & (x < 5)] <- (1/25)*(10*x[(0 < x) & (x < 5)]-x[(0 < x) & (x < 5)]^2)
  out[(x >= 5)] <- rep(1,length(x[x >= 5]))
  return(out) }
x.tmp <- seq(-2,10,0.1)
par(mfrow=c(1,2),mar=c(2.5,2.5,0.25,0.25))
plot(x.vals,R1(x.vals),type='l')
plot(x.tmp,F1(x.tmp),type='l')





R2 <- function(x){
  out <- rep(-1, length(x))
  out[(x <= 0)] <- rep(0,length(x[x <= 0]))
  out[(0 < x) & (x < 3)] <- rep(2,length(x[x <= 0]))
  out[(3 <= x) & (x < 5)] <- 5 -x[(3 <= x) & (x < 5)]
  out[(x >= 5)] <- rep(0,length(x[x >= 5]))
  return(out)
}
x.vals <- seq(0,5,0.001)
par(mfrow=c(1,1),mar=c(2.5,2.5,0.25,0.25))
plot(x.vals,R2(x.vals),type='l',xlim=c(0,5))
abline(h=0,lty=2,col='gray')
abline(v=0,lty=2,col='gray')

F2 <- function(x){
  out <- rep(-1, length(x))
  out[(x <= 0)] <- rep(0,length(x[x <= 0]))
  out[(0 < x) & (x < 3)] <- (1/4)*x[(0 < x) & (x < 3)]
  out[(3 <= x) & (x < 5)] <- (-1/16)*x[(3 <= x) & (x < 5)]^2+(5/8)*x[(3 <= x) & (x < 5)]-9/16
  out[(x >= 5)] <- rep(1,length(x[x >= 5]))
  return(out) }
x.tmp <- seq(-2,10,0.1)
par(mfrow=c(1,2),mar=c(2.5,2.5,0.25,0.25))
plot(x.vals,R2(x.vals),type='l')
plot(x.tmp,F2(x.tmp),type='l')





R3 <- function(x){
  out <- rep(-1, length(x))
  out[(x <= 0)] <- rep(0,length(x[x <= 0]))
  out[(0 < x) & (x < 5/2)] <- 2/5 - 4/25*x[(0 < x) & (x < 5/2)]
  out[(5/2 <= x) & (x < 5)] <- 4/25*x[(5/2 <= x) & (x < 5)] - 2/5
  out[(x >= 5)] <- rep(0,length(x[x >= 5]))
  return(out)
}
x.vals <- seq(0,5,0.001)
par(mfrow=c(1,1),mar=c(2.5,2.5,0.25,0.25))
plot(x.vals,R3(x.vals),type='l',xlim=c(0,5))
abline(h=0,lty=2,col='gray')
abline(v=0,lty=2,col='gray')

F3 <- function(x){
  out <- rep(-1, length(x))
  out[(x <= 0)] <- rep(0,length(x[x <= 0]))
  out[(0 < x) & (x < 5/2)] <- (2/5)*x[(0 < x) & (x < 5/2)] - (2/25)*x[(0 < x) & (x < 5/2)]^2
  out[(5/2 <= x) & (x < 5)] <- (2/25)*x[(5/2 <= x) & (x < 5)]^2 - (2/5)*x[(5/2 <= x) & (x < 5)] + 1
  out[(x >= 5)] <- rep(1,length(x[x >= 5]))
  return(out) }
x.tmp <- seq(-2,10,0.1)
par(mfrow=c(1,2),mar=c(2.5,2.5,0.25,0.25))
plot(x.vals,R3(x.vals),type='l')
plot(x.tmp,F3(x.tmp),type='l')





par(mfrow=c(1,1),mar=c(2.5,2.5,0.25,0.25))
plot(x.tmp,F1(x.tmp),type='l')
lines(x.tmp,F2(x.tmp),col=2)
lines(x.tmp,F3(x.tmp),col=3)