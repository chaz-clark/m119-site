data <- read.csv(url("https://byuistats.github.io/M119/logLikelihood_practice.csv"))

x <- data$x
y <- data$y1

c.11 <- sum(x^2)
c.12 <- sum(x)
c.21 <- sum(x)
c.22 <- 50
b.1 <- sum(x*y)
b.2 <- sum(y)

best.b <- (c.11*b.2 - c.12*b.1)/(c.11*c.22 - c.12^2)
best.m <- (b.1 - c.12*best.b)/c.11

best.m
best.b

D <- (-c.11)*(-c.22) - (-c.12)^2
#The second partial with respect to a_1 both times is -c.11

D
-c.11

h <- function(x,b=0,m=1){
  b + m*x
}

x.in <- seq(min(x),max(x),0.01)
par(mfrow=c(1,1),mar=c(2.5,2.5,0.25,0.25))
plot(x,y,type='p',pch=16)
lines(x.in,h(x.in,b=best.b, m=best.m),col=3)
abline(h=0,lty=3,col='gray')
abline(v=0,lty=3,col='gray')





c.11 <- sum(x^2)
c.12 <- sum(x)
c.21 <- sum(x)
c.22 <- 50
b.1 <- sum(x*y)
b.2 <- sum(y)

best.m2 <- (c.12*b.2 - c.22*b.1)/(c.12^2-c.11*c.22)
best.b2 <- (b.1 - c.11*best.m2)/c.12

best.m2
best.b2