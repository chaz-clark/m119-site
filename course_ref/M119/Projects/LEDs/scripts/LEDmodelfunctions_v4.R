
  ## Model 1 ##  Linear
linear.f <- function(y,x1,pred.space=NULL)
{
x <-x1
temp <- lsfit(x, y)[[1]]
    a.0 <- temp[1]
    b.0 <- temp[2]
    Linear.grad <- function(X,a,b) {
    # logged linear model with gradient #
      temp <- a + b*X
      linr <- log(temp)
      attr(linr, "gradient") <- cbind(a = 1/temp, b = X/temp)
      linr
    }
    fit1 <- nls(log(y) ~ Linear.grad(x, a, b), start=list(a=a.0, b=b.0),
        control=nls.control(maxiter = 500, warnOnly=T) )

    a.1 <- coef(fit1)[1] #sum.nls$parameters[1,1]
    b.1 <- coef(fit1)[2] #sum.nls$parameters[2,1]
    SSE.1 <- fit1$m$deviance() #sum.nls$sigma
    R2.1 <- 1 - SSE.1 / ((length(x)-1)*var(log(y)))
    L70.1  <- (.70 - a.1) / b.1   # L70 predictions
    L50.1  <- (.50 - a.1) / b.1   # L70 predictions
    ys <- rev(seq(.5,1,by=.02))
    Llist <- (ys - a.1) / b.1   
  
ifelse(is.null(pred.space),pred.space <- sort(c(seq(1000,15000,by=1000),seq(16000,50000,by=2000),75000),na.last=T),pred.space)
pred1 <- exp(predict(fit1,data.frame(x=pred.space)))
  
extra1 <- c(Llist,ys,a.1, b.1, SSE.1, R2.1, L70.1,pred.space,pred1)
names(extra1) <- c(rep("xrange",length(ys)),rep("Ys",length(ys)),"a","b","SSE","R2","L70",rep("Pred.x",length(pred.space)),rep("Pred.y",length(pred.space)))
extra1
}



exp.f <- function(y,x1,pred.space=NULL)
{
x <-x1
fit2.p <- lm(log(y)~x)
fit2 <- lsfit(x,log(y))
    #fit2.d <- ls.diag(fit2)
    a.1 <- exp(fit2[[1]][1])
    b.1 <- fit2[[1]][2]
    SSE.1 <- sum(fit2$resid^2) # 5*(as.numeric(ls.print(fit2, print.it=F)$summary[1])^2) #
    R2.1 <- 1 - SSE.1 / ((length(y)-1)*var(log(y)))
    L70.1 <- log(.7/a.1) / b.1
    ys <- rev(seq(.5,1,by=.02))
    Llist <- log(ys/a.1)/b.1
ifelse(is.null(pred.space),pred.space <- sort(c(seq(1000,15000,by=1000),seq(16000,50000,by=2000),75000),na.last=T),pred.space)
pred1 <- exp(predict(fit2.p,data.frame(x=pred.space)))

    

extra1 <- c(Llist,ys,a.1, b.1, SSE.1, R2.1, L70.1,pred.space,pred1)
names(extra1) <- c(rep("xrange",length(ys)),rep("Ys",length(ys)),"a","b","SSE","R2","L70",rep("Pred.x",length(pred.space)),rep("Pred.y",length(pred.space)))
extra1    
    
    
}


linear_exp.f <- function(y,x1,pred.space=NULL)
{
    x <-x1
    fit2 <- lsfit(x,log(y))
    a.1 <- exp(fit2[[1]][1])
    b.1 <- fit2[[1]][2]
    
fit3 <- nls(log(y) ~ log(a*exp(b*x) - cc),
        start=list(a=a.1, b=b.1, cc=0),
        control=nls.control(maxiter = 500, warnOnly=T) )
    a.1 <- coef(fit3)[1] #sum.nls$parameters[1]
    b.1 <- coef(fit3)[2] #sum.nls$parameters[2]
    c.1 <- coef(fit3)[3] #sum.nls$parameters[3]
    SSE.1 <- fit3$m$deviance() #sum.nls$sigma
    R2.1 <- 1 - SSE.1 / ((length(y)-1)*var(log(y)))
    Lmin.check <- abs(c.1)
    ys <- rev(seq(.5,1,by=.02))
    ys[ys<Lmin.check] <- NA
    Lmin <- log((Lmin.check + c.1) / a.1) / b.1
    L70.1 <- NA;
    if(Lmin.check<.7){L70.1 <- log((.7 + c.1) / a.1) / b.1}
    Llist <- log((ys + c.1) / a.1) / b.1

ifelse(is.null(pred.space),pred.space <- sort(c(seq(1000,15000,by=1000),seq(16000,50000,by=2000),75000),na.last=T),pred.space)
pred1 <- exp(predict(fit3,data.frame(x=pred.space)))

extra1 <- c(Llist,ys,a.1, b.1, c.1, SSE.1, R2.1, L70.1,pred.space,pred1)
names(extra1) <- c(rep("xrange",length(ys)),rep("Ys",length(ys)),"a","b","c","SSE","R2","L70",rep("Pred.x",length(pred.space)),rep("Pred.y",length(pred.space)))
extra1    
    

    
}


log.f <- function(y,x1,pred.space=NULL)

{
    x <-x1
    A <- matrix(c(1, 1, -log(x[1]), -log(tail(x,1))), 2, 2)
    init.guess <- solve(A, c(y[1], tail(y,1)))

    fit4 <- nls(log(y) ~ log(a - b*log(x)),
        start=list(a=init.guess[1], b=init.guess[2]),
        control=nls.control(tol=1e-07, minFactor=2e-11, maxiter=500, warnOnly=T))
    
    a.1 <- coef(fit4)[1] #sum.nls4$parameters[1,1]
    b.1 <- coef(fit4)[2] #sum.nls4$parameters[2,1]
    SSE.1 <- fit4$m$deviance() #sum.nls4$sigma
    R2.1 <- 1 - SSE.1 / ((length(y)-1)*var(log(y)))
    
    L70.1 <- exp((a.1 - .7) / b.1)
    L50.1 <- exp((a.1 - .5) / b.1)
    ys <- rev(seq(.5,1,by=.02))
    Llist <- exp((a.1-ys)/b.1)
    
ifelse(is.null(pred.space),pred.space <- sort(c(seq(1000,15000,by=1000),seq(16000,50000,by=2000),75000),na.last=T),pred.space)
pred1 <- exp(predict(fit4,data.frame(x=pred.space)))

extra1 <- c(Llist,ys,a.1, b.1, SSE.1, R2.1, L70.1,pred.space,pred1)
names(extra1) <- c(rep("xrange",length(ys)),rep("Ys",length(ys)),"a","b","SSE","R2","L70",rep("Pred.x",length(pred.space)),rep("Pred.y",length(pred.space)))
extra1    

    
}



linear_log.f <- function(y,x1,pred.space=NULL)
{
    x <-x1
    temp <- lsfit(cbind(x, log(x)), y)[[1]]
    a.0 <- temp[1]
    b.0 <- temp[2]
    c.0 <- temp[3]
    LinLog.grad <- function(X, a, b, cc) {
    # logged linear model with gradient #
      temp <- a + b*X + cc*log(X)
      linlogr <- log(temp)
      attr(linlogr, "gradient") <- cbind(a = 1/temp, b = X/temp, cc = log(X)/temp)
      linlogr
    }

    fit5 <- nls(log(y) ~ LinLog.grad(x, a, b, cc),
        start=list(a=a.0, b=b.0, cc=c.0),
        control=nls.control(maxiter = 500, warnOnly=T) )
    #sum.nls5 <- summary(fit5)
    a.1 <- coef(fit5)[1] #sum.nls5$parameters[1,1]
    b.1 <- coef(fit5)[2] #sum.nls5$parameters[2,1]
    c.1 <- coef(fit5)[3] #sum.nls5$parameters[3,1]
    SSE.1 <- fit5$m$deviance() #sum.nls5$sigma
    R2.1 <- 1 - SSE.1 / ((length(y)-1)*var(log(y)))
    ys <- rev(seq(.5,1,by=.02))

    if (b.1 <= 0 ) {
  
  fff <- function(X, a, b, cc,ys ) { a + b*X + cc*log(X) - ys }   #  L70 can vary.
    
  fff.list <- function(x,a.2=a.1,b.2=b.1,c.2=c.1)
  {
    low <- 5000
    temp <- fff(X=low, a=a.2, b=b.2, cc=c.2,ys=x)
    hi <- low
    while(temp > 0) {
      hi <- hi + 5000
      temp <- fff(X=hi, a=a.2, b=b.2, cc=c.2,ys=x)
      if(hi==1e10) temp <- -5
    }
    low <- hi - 5000
    if(temp == -5) {
      L70.1 <- NA
    } else {
      L70.1 <- try(uniroot(fff, interval=c(low, hi),
          a=a.2, b=b.2, cc=c.2,ys=x)$root,silent=T)
    }
    if(is.character(L70.1) ) L70.1<-NA
    L70.1
  }
  
Llist <- apply(t(ys),2,fff.list)
L70.1 <- fff.list(x=.7)
    
   
ifelse(is.null(pred.space),pred.space <- sort(c(seq(1000,15000,by=1000),seq(16000,50000,by=2000),75000),na.last=T),pred.space)
pred1 <- exp(predict(fit5,data.frame(x=pred.space)))

    
                                } # End if statement
    
    if (!(b.1 <= 0  )){
        L70.1 <- NA
        pred.space <- sort(c(seq(1000,15000,by=1000),seq(16000,50000,by=2000),75000))
        pred.space <- rep(NA,length(pred.space))
        Llist <- rep(NA,length(ys))
        pred1 <- rep(NA,length(pred.space))
    }


extra1 <- c(Llist,ys,a.1, b.1,c.1, SSE.1, R2.1, L70.1,pred.space,pred1)
names(extra1) <- c(rep("xrange",length(ys)),rep("Ys",length(ys)),"a","b","c","SSE","R2","L70",rep("Pred.x",length(pred.space)),rep("Pred.y",length(pred.space)))
extra1    

    }



##############  Simulation Functions  ##########

  modelfits <- function(simmat,x)
  {
    library(snowfall)
    linear.d1 <- sfApply(simmat,2,linear.f,x1=x)
    exp.d1    <- sfApply(simmat,2,exp.f,x1=x)
    linear_exp.d1 <-sfApply(simmat,2,linear_exp.f,x1=x)
    log.d1 <- sfApply(simmat,2,log.f,x1=x)
    linear_log.d1 <- sfApply(simmat,2,linear_log.f,x1=x)
    d1 <- list(linear=linear.d1,exp=exp.d1,linear_exp=linear_exp.d1,log=log.d1,linear_log=linear_log.d1)
    d1    
  }

noise.mat.f  <- function(truth,noise=0.005,iters=2000)
            {
            rows <- length(truth)
            temp <- matrix(rnorm(iters*rows,mean=truth,sd=truth*noise), ncol=iters, nrow=rows)
            temp <- cbind(truth,temp)
            colnames(temp) <- c("truth",paste(rep("sim",ncol(temp)-1),1:(ncol(temp)-1),sep="_"))
            temp
            }


sim.summary <- function(d3,nout=34,fout=26)
    {
 
    d3.l70 <- unlist(lapply(d3,function(x) x["L70",]))
    d3.SSE <- unlist(lapply(d3,function(x) x["SSE",]))
    
    d3.names <- unlist(strsplit(names(d3.l70),"\\."))[seq(1,2*length(d3.l70),by=2)]
          
    
    d3p.l70 <- data.frame(d3.names,d3.l70,d3.SSE,stringsAsFactors=F)
    colnames(d3p.l70) <- c("Type","L70","SSE")
    d3p.l70$Type <- factor(d3p.l70$Type,levels=c("linear","exp","linear_exp","log","linear_log"))
    
    d3.xpred <- matrix(unlist(lapply(d3,function(x) x[(nrow(x)-(2*nout-1)):(nrow(x)-nout),])),nrow=nout,byrow=F) 
    d3.ypred <- matrix(unlist(lapply(d3,function(x) x[(nrow(x)-(nout-1)):nrow(x),])),nrow=nout,byrow=F)
    
    xrange <- matrix(unlist(lapply(d3,function(x) x[1:fout,])),nrow=fout,byrow=F) 
    ys <- matrix(unlist(lapply(d3,function(x) x[(fout+1):(2*fout),])),nrow=fout,byrow=F)
    
    
    reps <- table(d3.names)
    
    d3.colnames <-paste(d3.names,1:reps[1],sep=".")
    colnames(d3.xpred)<-colnames(d3.ypred)<- colnames(xrange)<-colnames(ys) <- d3.colnames
    
    
    d3.xpred.m <- melt(d3.xpred)
    d3.ypred.m <- melt(d3.ypred)
    
    d3.pred <- data.frame(d3.ypred.m,d3.xpred.m[,3])
    colnames(d3.pred)<-c("number","group","ypred","xpred")

    d3.pred$Type <- factor(rep(d3.names,each=nout))
        
    
    xpred.m <- melt(xrange)
    ypred.m <- melt(ys)
    
    pred <- data.frame(ypred.m,xpred.m[,3])
    colnames(pred)<-c("number","group","ypred","xpred")

    pred$Type <- factor(rep(d3.names,each=fout))    
        
        
        
     list(predplot=d3.pred,predsum=d3p.l70,predplot2=pred)   
    }



#########  Plot Functions   #########


### Creates a set of boxplots of the SSE top and the l70s on the bottom ###
vplayout <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y)



bp.summary <- function(pdata,extraboxplots=T,noplot=NA,sse.remove=50000,ydistort="sqrt",jitterpoints=F)
{
    
    pdata <- pdata[!pdata$Type%in%noplot,]
    pdata <- subset(pdata,SSE < sse.remove)
    pdata$Type <- factor(levels(pdata$Type)[pdata$Type],levels=levels(pdata$Type)[!levels(pdata$Type)%in%noplot])
## look into putting the percent of runs that returned l70 values in the top corner of the plot ###

     library(ggplot2)
     missings <- tapply(pdata$L70,pdata$Type,function(x) sum(is.na(x)))  ## This tells me how many times an L70 was even attained.
     totals   <- tapply(pdata$L70,pdata$Type,function(x) length(x))
     percents <- missings/totals
     cat("Percent Missing L70s \n")
     print(percents)
    bp.sse <- ggplot(pdata,aes(Type,SSE))
    bp.l70 <- ggplot(pdata,aes(Type,L70))
    vplayout <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y)
   
    grid.newpage()

    if(jitterpoints==T){
   aa <-bp.sse +geom_jitter(alpha=.5,colour="blue")+ geom_boxplot(alpha=.85) +coord_trans(y=ydistort)  
   bb <- bp.l70 +geom_jitter(alpha=.5,colour="blue")+ geom_boxplot(alpha=.85) +coord_trans(y=ydistort)
    }
    if(jitterpoints==F){
   aa <-bp.sse + geom_boxplot() +coord_trans(y=ydistort)  
   bb <- bp.l70 +geom_boxplot() +coord_trans(y=ydistort)
    }
    pushViewport(viewport(layout=grid.layout(2,1),name="vpbox"))

        pushViewport(viewport(layout.pos.row=1,layout=grid.layout(1,2),name="vpbplots"))
        print(aa, vp = vplayout(1,1))
        print(bb , vp = vplayout(1,2))

   upViewport(1) 
  if(extraboxplots==T){
   pushViewport(viewport(layout.pos.row=2,layout=grid.layout(1,5),name="vpl70sep"))
    
        
        print(bp.l70 + geom_boxplot(data=subset(pdata,Type=="linear"),aes(x="linear")), vp = vplayout(1,1))
        print(bp.l70 + geom_boxplot(data=subset(pdata,Type=="log"),aes(x="log")) , vp = vplayout(1,4))
        print(bp.l70 + geom_boxplot(data=subset(pdata,Type=="linear_log"),aes(x="linear_log")) , vp = vplayout(1,5))
        print(bp.l70 + geom_boxplot(data=subset(pdata,Type=="exp"),aes(x="exp")) , vp = vplayout(1,2))
        print(bp.l70 + geom_boxplot(data=subset(pdata,Type=="linear_exp"),aes(x="linear_exp")) , vp = vplayout(1,3))
                        } # end if statement
}


timepred.plot <- function(pdata,tdata,xtime=1000*1:6,minterval=.05,noplot=NA,fout=26,titles="")
{

tbreaks <-paste(pdata$Type,pdata$ypred,sep="-")
sdpreds<-tapply(pdata$xpred,tbreaks,sd,na.rm=T)
pred.types <- unlist(strsplit(names(sdpreds),"-"))[seq(1,2*length(sdpreds),by=2)]
pred.ys<- as.numeric(unlist(strsplit(names(sdpreds),"-"))[seq(2,2*length(sdpreds),by=2)])

mpreds <-tapply(pdata$xpred,tbreaks,mean,na.rm=T)
mpreds.05 <- tapply(pdata$xpred,tbreaks,mean,na.rm=T,trim=.05)
p1preds <- tapply(pdata$xpred,tbreaks,quantile,probs=c(minterval),na.rm=T)
p99preds <-tapply(pdata$xpred,tbreaks,quantile,probs=c(1-minterval),na.rm=T)
#p25preds <- tapply(pdata$xpred,tbreaks,quantile,probs=c(.25),na.rm=T)
#p75preds <- tapply(pdata$xpred,tbreaks,quantile,probs=c(.75),na.rm=T)

pdata1 <- pdata[seq(16,nrow(pdata),by=fout),]
missings <- tapply(pdata1$xpred,pdata1$Type,function(x) sum(is.na(x)))
totals   <- tapply(pdata1$xpred,pdata1$Type,function(x) length(x))
percents <- missings/totals

cat("Percent Missing L70s \n")
print(percents)
cat("\n  ------------- \n  Number observed at each Level \n ")
print(tapply(pdata$xpred,paste(pdata$Type,pdata$ypred,sep="-"),length))

preds.out <-data.frame(pred.types,pred.ys,sdpreds,mpreds,mpreds.05,p1preds,p99preds)
preds.out <- preds.out[order(preds.out$pred.types,preds.out$pred.ys),]

plot.stuff <- subset(preds.out,pred.ys==.70 & !pred.types%in%noplot)
xmax <- max(plot.stuff$p99preds)


pointsd <- data.frame(xtime,tdata[,"truth"],apply(tdata,1,quantile,probs=c(minterval)),apply(tdata,1,quantile,probs=c(1-minterval)))
                      
colnames(pointsd) <- c("x1","y1","ymax1","ymin1")


    a1<-qplot(y=pred.ys,x=mpreds.05,data=subset(preds.out,!pred.types%in%noplot),colour=pred.types,geom="line",xlim=c(0,xmax),ylim=c(.69,1.1),
              xlab="Time",ylab="Normalized Intensity",main=titles) +
    geom_errorbarh(aes(xmin=p1preds,xmax=p99preds))+
    geom_pointrange(aes(x=x1,y=y1,colour="black",ymax=ymax1,ymin=ymin1),data=pointsd,colour="black")
    a1
}



########  old plot functions  #######


timepred.plot.old <- function(pdata,tdata,xtime=1000*1:6)
{


sdpreds<-tapply(pdata$xpred,paste(pdata$Type,pdata$ypred,sep="-"),sd,na.rm=T)
pred.types <- unlist(strsplit(names(sdpreds),"-"))[seq(1,2*length(sdpreds),by=2)]
pred.ys<- as.numeric(unlist(strsplit(names(sdpreds),"-"))[seq(2,2*length(sdpreds),by=2)])

mpreds <-tapply(pdata$xpred,paste(pdata$Type,pdata$ypred,sep="-"),mean,na.rm=T)
p1preds <- tapply(pdata$xpred,paste(pdata$Type,pdata$ypred,sep="-"),quantile,probs=c(.01),na.rm=T)
p99preds <-tapply(pdata$xpred,paste(pdata$Type,pdata$ypred,sep="-"),quantile,probs=c(.99),na.rm=T)
print(tapply(pdata$xpred,paste(pdata$Type,pdata$ypred,sep="-"),function(x) sum(is.na(x))))
cat("\n")
cat("-------------")
cat("\n")
print(tapply(pdata$xpred,paste(pdata$Type,pdata$ypred,sep="-"),length))

preds.out <-data.frame(pred.types,pred.ys,sdpreds,mpreds,p1preds,p99preds)
preds.out <- preds.out[order(preds.out$pred.types,preds.out$pred.ys),]

pointsd <- data.frame(xtime,tdata[,"truth"],apply(tdata,1,quantile,probs=c(.01)),apply(tdata,1,quantile,probs=c(.99)))
colnames(pointsd) <- c("x1","y1","ymax1","ymin1")


    vplayout <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y)
    grid.newpage()
    a<-ggplot(aes(y=pred.ys,x=mpreds),data=subset(preds.out,pred.types!="linear_exp"),colour=pred.types)
    pushViewport(viewport(layout=grid.layout(3,1),name="vpbox"))
    a1<-qplot(y=pred.ys,x=mpreds,data=subset(preds.out,pred.types!="linear_exp"),colour=pred.types,geom="line",xlim=c(0,75000),ylim=c(.5,1.1)) +geom_errorbarh(aes(xmin=p1preds,xmax=p99preds))+
    geom_pointrange(aes(x=x1,y=y1,colour="black",ymax=ymax1,ymin=ymin1),data=pointsd,colour="black")
    a2<-qplot(y=pred.ys,x=mpreds,data=subset(preds.out,pred.types!="linear_exp"),colour=pred.types,geom="line",xlim=c(0,25000),ylim=c(.5,1.1)) +geom_errorbarh(aes(xmin=p1preds,xmax=p99preds))+
    geom_pointrange(aes(x=x1,y=y1,colour="black",ymax=ymax1,ymin=ymin1),data=pointsd,colour="black")
    a3<-qplot(y=pred.ys,x=mpreds,data=subset(preds.out,pred.types!="linear_exp"),colour=pred.types,geom="line",xlim=c(0,15000),ylim=c(.5,1.1)) +geom_errorbarh(aes(xmin=p1preds,xmax=p99preds))+
    geom_pointrange(aes(x=x1,y=y1,colour="black",ymax=ymax1,ymin=ymin1),data=pointsd,colour="black")
 print(a1  , vp = vplayout(1,1))
 print(a2  , vp = vplayout(2,1))
 print(a3  , vp = vplayout(3,1))
    
}

bp.summary.old <- function(pdata)
{
## look into putting the percent of runs that returned l70 values in the top corner of the plot ###
     library(ggplot2)
     print(tapply(pdata$L70,pdata$Type,function(x) table(is.na(x))) ) ### This tells me how many times an L70 was even attained.

    bp.sse <- ggplot(pdata,aes(Type,SSE))
    bp.l70 <- ggplot(pdata,aes(Type,L70))
    vplayout <- function(x, y) viewport(layout.pos.row = x, layout.pos.col = y)
    
    grid.newpage()
    
    pushViewport(viewport(layout=grid.layout(2,1),name="vpbox"))
        print(bp.sse + geom_boxplot() +coord_flip()  , vp = vplayout(1,1))
    pushViewport(viewport(layout.pos.row=2,layout=grid.layout(1,2,widths=unit(c(1,2),c("null","null"))),name="vpl70s"))
    
        print(bp.l70 + geom_boxplot()  + opts(axis.text.x=theme_text(angle=45,hjust=1))   , vp = vplayout(1,1))
    pushViewport(viewport(layout.pos.col=2,layout=grid.layout(1,5),name="vpl70sep"))
    
        print(bp.l70 + geom_boxplot(data=subset(pdata,Type=="linear"),aes(x="linear")), vp = vplayout(1,1))
        print(bp.l70 + geom_boxplot(data=subset(pdata,Type=="exp"),aes(x="exp")) , vp = vplayout(1,2))
        print(bp.l70 + geom_boxplot(data=subset(pdata,Type=="log"),aes(x="log")) , vp = vplayout(1,4))
        print(bp.l70 + geom_boxplot(data=subset(pdata,Type=="linear_log"),aes(x="linear_log")) , vp = vplayout(1,5))
        print(bp.l70 + geom_boxplot(data=subset(pdata,Type=="linear_exp"),aes(x="linear_exp")) , vp = vplayout(1,3))

}

