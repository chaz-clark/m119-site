x.in <- seq(-2,5,0.1)


F <- function(x){
  out <- rep(7, length(x))
  out[(x < 0)] <- rep(0,length(x[x < 0]))
  out[(0 <= x) & (x < 1)] <- rep(0.5,length(x[(0 <= x) & (x < 1)]))
  out[(x >= 1)] <- rep(1,length(x[x >= 1]))
  return(out)
}

F.out <- F(x.in)
plot(x.in,F.out,type='l')





q.rug <- function(x){
  out <- rep(-1, length(x))
  out[(x < 0)] <- rep(0,length(x[x < 0]))
  out[(0 <= x) & (x <= 2)] <- 4-x[(0 <= x) & (x <= 2)]^2
  out[(x > 2)] <- rep(0,length(x[x > 2]))
  return(out)
}

rug4 <- function(x){
  out <- rep(-1, length(x))
  out[(x <= 0)] <- rep(0,length(x[x <= 0]))
  out[(0 < x) & (x <= 1)] <- rep(4,length(x[(0 < x) & (x <= 1)]))
  out[(1 < x) & (x <= 2)] <- rep(3,length(x[(1 < x) & (x <= 2)]))
  out[(x > 2)] <- rep(0,length(x[x > 2]))
  return(out) }
rug5 <- function(x){
  out <- rep(-1, length(x))
  out[(x <= 0)] <- rep(0,length(x[x <= 0]))
  out[(0 < x) & (x <= 1)] <- rep(3,length(x[(0 < x) & (x <= 1)]))
  out[(1 < x) & (x <= 2)] <- rep(0,length(x[(1 < x) & (x <= 2)]))
  out[(x > 2)] <- rep(0,length(x[x > 2]))
  return(out) }
rug6 <- function(x){
  out <- rep(-1, length(x))
  out[(x <= 0)] <- rep(0,length(x[x <= 0]))
  out[(0 < x) & (x <= 0.5)] <- rep(4,length(x[(0 < x) & (x <= 0.5)]))
  out[(0.5 < x) & (x <= 1)] <- rep(15/4,length(x[(0.5 < x) & (x <= 1)]))
  out[(1 < x) & (x <= 1.5)] <- rep(3,length(x[(1 < x) & (x <= 1.5)]))
  out[(1.5 < x) & (x <= 2)] <- rep(7/4,length(x[(1.5 < x) & (x <= 2)]))
  out[(x > 2)] <- rep(0,length(x[x > 2]))
  return(out) }
rug7 <- function(x){
  out <- rep(-1, length(x))
  out[(x <= 0)] <- rep(0,length(x[x <= 0]))
  out[(0 < x) & (x <= 0.5)] <- rep(15/4,length(x[(0 < x) & (x <= 0.5)]))
  out[(0.5 < x) & (x <= 1)] <- rep(3,length(x[(0.5 < x) & (x <= 1)]))
  out[(1 < x) & (x <= 1.5)] <- rep(7/4,length(x[(1 < x) & (x <= 1.5)]))
  out[(1.5 < x) & (x <= 2)] <- rep(0,length(x[(1.5 < x) & (x <= 2)]))
  out[(x > 2)] <- rep(0,length(x[x > 2]))
  return(out) }
x.vals <- seq(-2,10,0.1)

par(mfrow=c(2,2), mar=c(2.5,2.5,0.25,0.25))
plot(x.vals,rug4(x.vals),type='l',ylim=c(0,4.25))
lines(x.vals,q.rug(x.vals),col=2)
points(c(0,1),c(q.rug(0),q.rug(1)),pch=16,col=3)
plot(x.vals,rug5(x.vals),type='l',ylim=c(0,4.25))
lines(x.vals,q.rug(x.vals),col=2)
points(c(1,2),c(q.rug(1),q.rug(2)),pch=16,col=3)
plot(x.vals,rug6(x.vals),type='l',ylim=c(0,4.25))
lines(x.vals,q.rug(x.vals),col=2)
points(c(0,0.5,1,1.5),c(q.rug(0),q.rug(0.5),q.rug(1),q.rug(1.5)),pch=16,col=3)
plot(x.vals,rug7(x.vals),type='l',ylim=c(0,4.25))
lines(x.vals,q.rug(x.vals),col=2)
points(c(0.5,1,1.5,2),c(q.rug(0.5),q.rug(1),q.rug(1.5),q.rug(2)),pch=16,col=3)