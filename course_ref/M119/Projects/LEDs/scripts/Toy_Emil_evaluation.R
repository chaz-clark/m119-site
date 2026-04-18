#################################################
#####   Data Sets from Emil and Trenton #########
#####  Trenton formatted the data sets  #########
#####                                   #########
#####   V.1    2/25/2009                #########
#####  Requires LEDmodelfunction_v2.R   #########
#################################################


library(ggplot2)
library(reshape)
library(snowfall)

source("/Users/d3m793/work/Small or Old Projects/LED/LEDmodelfunctions_v4.R")

#### Read in Data sets #####

toydata <- read.csv("/Users/d3m793/work/Small or Old Projects/LED/LED-7scenarios-20100226.csv")

###  data sets are not measured at the thousand hours  ########
e6000raw <-read.csv("/Users/d3m793/work/Small or Old Projects/LED/LED-EmilsDatasets-upto6000hours-20100225.csv")
e6data <- e6000raw[,seq(2,ncol(e6000raw),by=2)]
e6data.x <- e6000raw[,seq(1,ncol(e6000raw),by=2)]


load("/Users/d3m793/work/Small or Old Projects/LED/LED-EmilsDatasets-20100225.Rdata")


#######  Create MC data sets for model fitting #############













sfInit(parallel=T,cpu=7)
sfSource("/Users/d3m793/work/Small or Old Projects/LED/LEDmodelfunctions_v4.R")

#### fits the model to each simulated data set for all 5 models. modelfits.  #####

xtime <- c(1000,2000,3000,4000,5000,6000)
simmat.cc <- noise.mat.f(toydata[,"Candy.Cane"])
cc <-modelfits(simmat.cc,x=xtime)
cc.sum   <-sim.summary(cc)

xtime <- c(1000,2000,3000,4000,5000,6000)
simmat.lin <- noise.mat.f(toydata[,"Linear"])
lin <- modelfits(simmat.lin,x=xtime)
lin.sum  <-sim.summary(lin)

xtime <- c(1000,2000,3000,4000,5000,6000)
simmat.linc <- noise.mat.f(toydata[,"Linear.to.Curve"])
linc <- modelfits(simmat.linc,x=xtime)
linc.sum <-sim.summary(linc)

xtime <- c(1000,2000,3000,4000,5000,6000)
simmat.as <- noise.mat.f(toydata[,"Asymptotic"])
ass  <- modelfits(simmat.as,x=xtime)
ass.sum  <-sim.summary(ass)

xtime <- c(1000,2000,3000,4000,5000,6000)
simmat.U <- noise.mat.f(toydata[,"U.shaped"])
U    <- modelfits(simmat.U,x=xtime)
u.sum    <-sim.summary(U)

xtime <- c(1000,2000,3000,4000,5000,6000)
simmat.Acc <- noise.mat.f(toydata[,"Accelerated.Decay"])
Acc  <- modelfits(simmat.Acc,x=xtime)
acc.sum  <-sim.summary(Acc)

xtime <- c(1000,2000,3000,4000,5000,6000)
simmat.flat <- noise.mat.f(toydata[,"Flat"])
flat <- modelfits(simmat.flat,x=xtime)
flat.sum <-sim.summary(flat)


###### PLots

pdf(file="ToyExamples.pdf",width=11,height=9)
# Candy Cane
bp.summary(cc.sum$predsum,extra=F,ydistort="identity")
print(timepred.plot(cc.sum$predplot2,simmat.cc,xtime=xtime,titles="Candy Cane Raw"),vp=vplayout(2,1))

### cleaned up  ###
bp.summary(cc.sum$predsum,extra=F,noplot="log",ydistort="log10")
print(timepred.plot(cc.sum$predplot2,simmat.cc,xtime=xtime,noplot="log",titles="Candy Cane"),vp=vplayout(2,1))


# Linear
bp.summary(lin.sum$predsum,extra=F,ydistort="identity")
print(timepred.plot(lin.sum$predplot2,simmat.lin,xtime=xtime,titles="Linear Raw"),vp=vplayout(2,1))

### cleaned up  ##
bp.summary(lin.sum$predsum,extra=F,sse.remove=.02,noplot="log",ydistort="sqrt")
print(timepred.plot(lin.sum$predplot2,simmat.lin,xtime=xtime,noplot="log",titles="Linear"),vp=vplayout(2,1))


# linear curve
bp.summary(linc.sum$predsum,extra=F)
print(timepred.plot(linc.sum$predplot2,simmat.linc,xtime=xtime,titles="Curve Linear Raw"),vp=vplayout(2,1))

### Cleaned up  ###
bp.summary(linc.sum$predsum,extra=F,noplot="log")
print(timepred.plot(linc.sum$predplot2,simmat.linc,xtime=xtime,noplot="log",titles="Curve Linear"),vp=vplayout(2,1))


# assymptote
# linear_log and linear_exp only have l70 values 2% and 44% of the time.  The plots don't represent reality
# because most of the linear_log and linear_exp would have values over the l70 for the whole time.
bp.summary(ass.sum$predsum,extra=F,ydistort="log10")
print(timepred.plot(ass.sum$predplot2,simmat.as,xtime=xtime,titles="Asymptotic Raw"),vp=vplayout(2,1))

## Cleaned-Up  ###
bp.summary(ass.sum$predsum,extra=F,ydistort="log10",noplot="log",jitterpoints=T)
print(timepred.plot(ass.sum$predplot2,simmat.as,xtime=xtime,noplot="log",titles="Asymptotic"),vp=vplayout(2,1))



# Accelerated

bp.summary(acc.sum$predsum,extra=F)
print(timepred.plot(acc.sum$predplot2,simmat.Acc,xtime=xtime,titles="Accelerated Raw"),vp=vplayout(2,1))

### Cleaned-up  ####
bp.summary(acc.sum$predsum,extra=F,sse.remove=0.02,noplot="log",jitterpoints=T)
print(timepred.plot(acc.sum$predplot2,simmat.Acc,xtime=xtime,noplot="log",titles="Accelerated"),vp=vplayout(2,1))

dev.off()
 



#
#grid.newpage()
#vplayout <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y)
#
#pushViewport(viewport(layout=grid.layout(1,2),name="vpmain"))
#
#prp <-qplot(x=xpred,y=ypred,group=group,geom="line",aes(alpha=.2), data=subset(pdata$predplot,!Type%in%c("log","linear_exp")),colour=Type,xlim=c(0,maxtimeplot),ylim=c(minyplot,1.1))+
#geom_pointrange(aes(x=xtime,y=tdata[,"truth"],ymax=apply(tdata,1,quantile,probs=c(.01)),ymin=apply(tdata,1,quantile,probs=c(.99))),colour="black")
#
#print(prp , vp = vplayout(1,1))
#
#pushViewport(viewport(layout.pos.col=2,layout=grid.layout(2,1),name="vpbox"))
#print(bp.sse + geom_boxplot() +coord_flip()  , vp = vplayout(1,1))
#pushViewport(viewport(layout.pos.row=2,layout=grid.layout(1,6),name="vpl70"))
#print(bp.l70 + geom_boxplot()  + opts(axis.text.x=theme_text(angle=45,hjust=1))   , vp = vplayout(1,1))
#print(bp.l70 + geom_boxplot(data=subset(pdata$predsum,Type=="linear"),aes(x="linear")), vp = vplayout(1,2))
#print(bp.l70 + geom_boxplot(data=subset(pdata$predsum,Type=="exp"),aes(x="exp")) , vp = vplayout(1,3))
#print(bp.l70 + geom_boxplot(data=subset(pdata$predsum,Type=="linear_exp"),aes(x="linear_exp")) , vp = vplayout(1,4))
#print(bp.l70 + geom_boxplot(data=subset(pdata$predsum,Type=="log"),aes(x="log")) , vp = vplayout(1,5))
#print(bp.l70 + geom_boxplot(data=subset(pdata$predsum,Type=="linear_log"),aes(x="linear_log")) , vp = vplayout(1,6))


#
#sdpreds<-tapply(pdata$predplot$ypred,paste(pdata$predplot$Type,pdata$predplot$xpred,sep="-"),sd,na.rm=T)
#pred.types <- unlist(strsplit(names(sdpreds),"-"))[seq(1,2*length(sdpreds),by=2)]
#pred.xs<- as.numeric(unlist(strsplit(names(sdpreds),"-"))[seq(2,2*length(sdpreds),by=2)])
#
#mpreds <-tapply(pdata$predplot$ypred,paste(pdata$predplot$Type,pdata$predplot$xpred,sep="-"),mean,na.rm=T)
#p1preds <- tapply(pdata$predplot$ypred,paste(pdata$predplot$Type,pdata$predplot$xpred,sep="-"),quantile,probs=c(.01),na.rm=T)
#p99preds <-tapply(pdata$predplot$ypred,paste(pdata$predplot$Type,pdata$predplot$xpred,sep="-"),quantile,probs=c(.99),na.rm=T)
#
#preds.out <-data.frame(pred.types,pred.xs,sdpreds,mpreds,p1preds,p99preds)
#preds.out <- preds.out[order(preds.out$pred.types,preds.out$pred.xs),]
#

