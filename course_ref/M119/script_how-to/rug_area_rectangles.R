par(mfrow=c(1,1), mar=c(2.5,2.5,0.25,0.25))
plot(seq(0,2,length=20),rep(0,20),type='l',ylim=c(0,4.5))
segments(c(0,1),c(4,3),c(1,2),c(4,3),lwd=2)
abline(v=0,lty=3,col='gray')
abline(v=1,lty=3,col='gray')
abline(v=2,lty=3,col='gray')


par(mfrow=c(1,1), mar=c(2.5,2.5,0.25,0.25))
plot(seq(0,2,length=20),rep(0,20),type='l',ylim=c(0,4.5))
segments(c(0,1),c(3,0),c(1,2),c(3,0),lwd=2)
abline(v=0,lty=3,col='gray')
abline(v=1,lty=3,col='gray')
abline(v=2,lty=3,col='gray')


par(mfrow=c(1,1), mar=c(2.5,2.5,0.25,0.25))
plot(seq(0,2,length=20),rep(0,20),type='l',ylim=c(0,4.5))
segments(c(0,0.5,1,1.5),c(4,15/4,3,7/4),c(0.5,1,1.5,2),c(4,15/4,3,7/4),lwd=2)
abline(v=0,lty=3,col='gray')
abline(v=0.5,lty=3,col='gray')
abline(v=1,lty=3,col='gray')
abline(v=1.5,lty=3,col='gray')
abline(v=2,lty=3,col='gray')


par(mfrow=c(1,1), mar=c(2.5,2.5,0.25,0.25))
plot(seq(0,2,length=20),rep(0,20),type='l',ylim=c(0,4.5))
segments(c(0,0.5,1,1.5),c(15/4,3,7/4,0),c(0.5,1,1.5,2),c(15/4,3,7/4,0),lwd=2)
abline(v=0,lty=3,col='gray')
abline(v=0.5,lty=3,col='gray')
abline(v=1,lty=3,col='gray')
abline(v=1.5,lty=3,col='gray')
abline(v=2,lty=3,col='gray')




f <- function(x){4-x^2}
x.vals <- seq(0,2,0.001)

par(mfrow=c(2,2), mar=c(2.5,2.5,0.25,0.25))
plot(seq(0,2,length=20),rep(0,20),type='l',ylim=c(0,4.5))
segments(c(0,1),c(4,3),c(1,2),c(4,3),lwd=2)
abline(v=0,lty=3,col='gray')
abline(v=1,lty=3,col='gray')
abline(v=2,lty=3,col='gray')
lines(x.vals,f(x.vals),col='gray',lwd=3)
points(c(0,1),c(4,3),pch=16,col=2)

plot(seq(0,2,length=20),rep(0,20),type='l',ylim=c(0,4.5))
segments(c(0,1),c(3,0),c(1,2),c(3,0),lwd=2)
abline(v=0,lty=3,col='gray')
abline(v=1,lty=3,col='gray')
abline(v=2,lty=3,col='gray')
lines(x.vals,f(x.vals),col='gray',lwd=3)
points(c(1,2),c(3,0),pch=16,col=3)

plot(seq(0,2,length=20),rep(0,20),type='l',ylim=c(0,4.5))
segments(c(0,0.5,1,1.5),c(4,15/4,3,7/4),c(0.5,1,1.5,2),c(4,15/4,3,7/4),lwd=2)
abline(v=0,lty=3,col='gray')
abline(v=0.5,lty=3,col='gray')
abline(v=1,lty=3,col='gray')
abline(v=1.5,lty=3,col='gray')
abline(v=2,lty=3,col='gray')
lines(x.vals,f(x.vals),col='gray',lwd=3)
points(c(0,0.5,1,1.5),c(4,15/4,3,7/4),pch=16,col=2)

plot(seq(0,2,length=20),rep(0,20),type='l',ylim=c(0,4.5))
segments(c(0,0.5,1,1.5),c(15/4,3,7/4,0),c(0.5,1,1.5,2),c(15/4,3,7/4,0),lwd=2)
abline(v=0,lty=3,col='gray')
abline(v=0.5,lty=3,col='gray')
abline(v=1,lty=3,col='gray')
abline(v=1.5,lty=3,col='gray')
abline(v=2,lty=3,col='gray')
lines(x.vals,f(x.vals),col='gray',lwd=3)
points(c(0.5,1,1.5,2),c(15/4,3,7/4,0),pch=16,col=3)