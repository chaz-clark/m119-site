library(webnotebook)

# calculates a Mallows Cp-like statistic for loess fits
cploess <- function (lo, sigmasq = 1) {
    df <- lo$enp
    cp <- sum(resid(lo)^2)/sigmasq - lo$one.delta + lo$enp
    cp1 <- sum(resid(lo)^2)
    cp2 <- -lo$one.delta + lo$enp
    return(data.frame(df = df, cp = cp, cp1 = cp1, cp2 = cp2, 
        sigmahat = lo$s, degree = lo$pars$degree, span = lo$pars$span))
}

############################################################################
### read in data
############################################################################

load("/Users/d3m793/work/Small or Old Projects/LEDpresentation/HafenWork/LPrizeData.RData")

# 202 distinct IDs - same as Sheet
# 17 distinct rows

xyplot(NI ~ Hours, data=dat)
# xyplot(NI ~ jitter(Hours, 100), data=dat)
xyplot(Intensity ~ Hours, data=dat)

xyplot(NI ~ Hours | Row, data=dat)

xyplot(NI ~ Hours | Sheet, data=dat)

xyplot(NI ~ Hours | Sheet, data=dat, subset=Row=="A")

############################################################################
### plot raw data, add loess fit, find max, etc.
############################################################################

p <- xyplot(NI*100 ~ Hours, data=dat, type=c("p", "g"),
   panel=function(x, y, ...) {
      panel.xyplot(x, y, ...)
      x2 <- floor(x)
      mx <- unique(x2)
      my <- sapply(unique(x2), function(a) {
         mean(y[x2==a])
      })
      # panel.loess(mx, my, span=0.5, degree=2, family="symmetric", col="red")
      panel.points(mx, my, col="black", pch=19)
      ll <- loess(y ~ x, degree=2, span=0.5, family="symmetric")
      ss <- seq(min(x), max(x), length=200)
      pp <- predict(ll, newdata=ss, se=TRUE)
      ind <- which.max(pp$fit)
      upper <- pp$fit + qnorm(0.99)*pp$se
      yy1 <- 0
      yy2 <- pp$fit[ind]
      xx2 <- ss[ind]
      xx1 <- min(ss[upper > pp$fit[ind]])
      cat(xx1, "\n")
      cat(xx2)
      # panel.rect(xx1, yy1, xx2, yy2, col="orange", border=NA, alpha=0.4)
      panel.lines(ss, pp$fit, col="blue", lwd=2)
      # panel.lines(ss, upper, col="blue", lty=2)
      panel.points(ss[ind], pp$fit[ind], pch=4, cex=3, col="blue")
   },
   col="darkgray",
   aspect=1,
	xlab="Run Hours",
	ylab="Normalized Lumen Maintenance (%)"
)


#### Hathaway add to get high res pictures to kelly  ###  7/31/12 

jpeg(filename="Figure42.jpg",unit="in",width=8,heigh=8,pointsize=126,res=150,quality=100)
p
dev.off()


########

vdb.plot(p, name="alldata_loess5", height=8)

p <- xyplot(NI*100 ~ Hours, data=dat, type=c("p", "g"),
   panel=function(x, y, ...) {
      panel.xyplot(x, y, ...)
      x2 <- floor(x)
      sapply(unique(x2), function(a) {
         panel.points(a, mean(y[x2==a]), col="black", pch=19)
      })
      ll <- loess(y ~ x, degree=2, span=0.5, family="symmetric")
      ss <- seq(min(x), max(x), length=200)
      pp <- predict(ll, newdata=ss, se=TRUE)
      ind <- which.max(pp$fit)
      upper <- pp$fit + qnorm(0.99)*pp$se
      yy1 <- 0
      yy2 <- pp$fit[ind]
      xx2 <- ss[ind]
      xx1 <- min(ss[upper > pp$fit[ind]])
      panel.rect(xx1, yy1, xx2, yy2, col="orange", border=NA, alpha=0.4)
      panel.lines(ss, pp$fit, col="blue", lwd=2)
      panel.lines(ss, upper, col="blue", lty=2)
      panel.points(ss[ind], pp$fit[ind], pch=4, cex=3, col="blue")
   },
   col="darkgray",
   aspect=1,
   ylim=c(100.5, 102),
	xlab="Run Hours",
	ylab="Normalized Lumen Maintenance (%)"
)

#### Hathaway add to get high res pictures to kelly  ###  7/31/12 
jpeg(filename="Figure44.jpg",unit="in",width=8,heigh=8,pointsize=126,res=150,quality=100)
p
dev.off()



vdb.plot(p, name="alldata_loess5_zoom", height=8)

# diagnostics
dat$lofit <- fitted(loess(NI ~ Hours, data=dat, degree=2, span=0.5))
dat$loresid <- dat$NI - dat$lofit

p <- xyplot(loresid*100 ~ Hours, data=dat, type=c("p", "g"),
   panel=function(x, y, ...) {
      panel.xyplot(x, y, ...)
      panel.abline(h=0, col="black", lty=2)
      panel.loess(x, y, evaluation=200, span=0.15, degree=1, col="black", lwd=2)
   },
	xlab="Run Hours",
   ylab="Loess Residuals",
   col="darkgray",
   aspect=1
)

#### Hathaway add to get high res pictures to kelly  ###  7/31/12 
jpeg(filename="Figure43.jpg",unit="in",width=8,heigh=8,pointsize=126,res=150,quality=100)
p
dev.off()


########



vdb.plot(p, name="alldata_loess5_resid", width=9)

p <- qqmath(dat$loresid[dat$Hours > 500]*100, xlab="Normal Quantiles", ylab="Sample Quantiles", type=c("p", "g"),
   panel=function(x, ...) {
      panel.qqmath(x, ...)
      panel.qqmathline(x, col="black")
   }
)
vdb.plot(p, name="alldata_loess5_qqnorm", width=9)

############################################################################
### try bootstrap resampling
############################################################################

bmax <- rep(0, 3000)
lmax <- rep(0,3000)
ss <- seq(min(dat$Hours), max(dat$Hours), length=200)
for(i in seq_along(bmax)) {
   cat(i, "\n")
   ind <- sample(1:nrow(dat), nrow(dat), replace=TRUE)
   xx <- dat$Hours[ind]
   yy <- dat$NI[ind]
   lfit <- predict(loess(yy ~ xx, degree=2, span=0.5, family="symmetric"), newdata=ss)
   bmax[i] <- ss[which.max(lfit)]
   lmax[i] <- max(lfit,na.rm=T) 
}

save(bmax,lmax,file="bootsrap_Lprizepeak.Rdata")

#### need to load ggplot2 and my BaseThem_report function
qplot(x=bmax,y=lmax,size=I(3))+BaseTheme_report(25)+scale_x_continuous("Run Hour at which max was attained",formatter="comma") + scale_y_continuous("Max normalized lumen output at peak",formatter="percent")#+geom_vline(xintercept=c(2100,2400,2750))
ggsave("peakScatter.jpg")
#Saving 9.66" x 6.33" image

qplot(x=bmax,geom="histogram",binwidth=25,colour=I("white"))+scale_x_continuous("Run Hour at which max was attained",formatter="comma") + 
scale_y_continuous("Percent of Total Runs (2,000)",formatter=function(x) paste(100*(x/3000),"%"))+BaseTheme_report(25)
ggsave("PeakHistogram.jpg")

############################################################################
### look at location of max and "earliest max" for each
############################################################################
library(plyr)
tmp <- ddply(dat, .(Sheet), function(dd) {
   x <- dd$Hours
   y <- dd$NI
   ll <- loess(y ~ x, degree=2, span=0.5, family="symmetric")
   ss <- seq(min(x), max(x), length=300)
   pp <- predict(ll, newdata=ss, se=TRUE)
   upper <- pp$fit + qt(0.99, df=pp$df)*pp$se
   ind <- which.max(pp$fit)
   data.frame(max1=ss[ind], max2=min(ss[upper > pp$fit[ind]]))
})

tmp2 <- make.groups(max1=tmp$max1, max2=tmp$max2)

densityplot(~ data, groups=which, data=tmp2, n=200,
   panel=function(x, y, ...) {
      panel.grid(h=-1, v=-1)
      panel.superpose(x, ...)
   },
   panel.groups=function(x, ...) {
      panel.densityplot(x, ...)
      panel.abline(v=median(x), ...)
      cat(median(x), "\n")
   },
   auto.key=TRUE
)

histogram(~ data | which, data=tmp2, breaks=20, col="darkgray", border="white",
   panel=function(x, ...) {
      panel.grid(h=-1, v=-1)
      panel.histogram(x, ...)
      panel.abline(v=median(x), col="black", lwd=3)
      cat(median(x), "\n")
   },
   between=list(x=0.5),
   aspect=1
)





############################################################################
### try a order 8 polynomial
############################################################################

lm13 <- lm(NI ~ Hours + I(Hours^2) + I(Hours^3) + I(Hours^4) + I(Hours^5) + I(Hours^6) + I(Hours^7) + I(Hours^8) + I(Hours^9) + I(Hours^10) + I(Hours^11) + I(Hours^12) + I(Hours^13), data=dat)
summary(lm13)

ss <- seq(min(dat$Hours), max(dat$Hours), length=200)
pp <- predict(lm13, newdata=data.frame(Hours=ss, ss^2, ss^3, ss^4, ss^5, ss^6, ss^7, ss^8, ss^9, ss^10, ss^11, ss^12, ss^13))

plot(dat$Hours, dat$NI, col="gray") #, ylim=c(1.005, 1.02))
lines(ss, pp)

lm8 <- lm(NI ~ Hours + I(Hours^2) + I(Hours^3) + I(Hours^4) + I(Hours^5) + I(Hours^6) + I(Hours^7) + I(Hours^8), data=dat)
summary(lm8)

ss <- seq(min(dat$Hours), max(dat$Hours), length=200)
pp <- predict(lm8, newdata=data.frame(Hours=ss, ss^2, ss^3, ss^4, ss^5, ss^6, ss^7, ss^8))

plot(dat$Hours, dat$NI, col="gray") #, ylim=c(1.005, 1.02))
lines(ss, pp)


############################################################################
### look at each ID individually
### this makes a plot of NI vs Hours with a fitted loess line
### and a 99% confidence interval about the mean
### a black dot is plotted for a max, and then an orange rectangle
### showing the range at which the maximum could have occurred
############################################################################

p <- xyplot(NI*100 ~ Hours | Sheet, data=dat, as.table=TRUE, type=c("p", "g"),
   panel=function(x, y, ...) {
      panel.xyplot(x, y, ...)
      ll <- loess(y ~ x, degree=2, span=0.5, family="symmetric")
      ss <- seq(min(x), max(x), length=300)
      pp <- predict(ll, newdata=ss, se=TRUE)
      upper <- pp$fit + qt(0.99, df=pp$df)*pp$se
      ind <- which.max(pp$fit)
      yy1 <- 0
      yy2 <- pp$fit[ind]
      xx2 <- ss[ind]
      xx1 <- min(ss[upper > pp$fit[ind]])
      panel.rect(xx1, yy1, xx2, yy2, col="orange", border=NA, alpha=0.4)
      panel.lines(ss, pp$fit, col="black")
      panel.lines(ss, upper, col="black", lty=2)
      panel.points(xx2, yy2, pch=19, col="black")
   },
   aspect=1,
   # subset=ID==1,
   layout=c(1, 1),
	xlab="Run Hours",
	ylab="Normalized Lumen Maintenance (%)"
)

vdb.plot(p, name="perID_loess_max")

p <- xyplot(NI ~ Hours, data=dat, groups=Sheet, 
   panel=function(x, y, ...) {
      panel.superpose(x, y, ...)
   },
   panel.groups=function(x, y, ...) {
      panel.loess(x, y, degree=2, span=0.5, ...)
   },
	xlab="Run Hours",
	ylab="Normalized Lumen Maintenance (%)",
	aspect=1
)

vdb.plot(p, name="perID_loess_all", width=6)


############################################################################
### try Cp statistics for loess parameter selection...
############################################################################

exp(-c(1:20)/5)
library(foreach)
res <- foreach(span=seq(0.5, 2, length=20), .combine=rbind) %dopar% {
   ll <- loess(NI ~ hours3, dat=subset(dat, Hours > 500), degree=2, span=span)
   cploess(ll)   
}

xyplot((cp1/min(res$sigmahat, na.rm=TRUE) + cp2) ~ df, data=res)
xyplot((cp1/0.065 + cp2) ~ df, data=res)

xyplot(sigmahat ~ df, data=res)

# doesn't work

############################################################################
### small simulation study
############################################################################








# old
simdat1 <- lapply(1:10, function(x) rnorm(200, mean=x))
simdat2 <- data.frame(x=1:10, y=sapply(simdat1, mean))
simdat1 <- data.frame(x=rep(1:10, each=200), y=do.call(c, simdat1))

xyplot(y ~ x, data=simdat1)
xyplot(y ~ x, data=simdat2)

lm1 <- lm(y ~ x, data=simdat1)
lm2 <- lm(y ~ x, data=simdat2)

summary(lm1)
summary(lm2)



