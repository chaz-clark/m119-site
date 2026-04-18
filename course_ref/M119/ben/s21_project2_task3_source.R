fit.a1.1d <- function(C1,C2){
  C1/C2
}

fit.a2 <- function(C1,C2,C3,C4,C5){
  (C2*C4 - C3*C1)/(C2*C5 - C3^2)
}
fit.a1.2d <- function(C1,C2,C3,C4,C5,best.a2){
  (C1 - C3*best.a2)/C2
}

cramers.rule.2d <- function(a,b,c,d,e,f){
  #solves ax+by=c, dx+ey=f
  c(c*e-b*f,a*f-c*d)/(a*e-b*d)
}
cramers.rule.1d <- function(a,b){
  #solves ax=b
  #returns x
  b/a
}
cramers.rule.2d(1,2,3,4,5,6)
cramers.rule.2d(12,3,15,2,-3,13)
coef <- cramers.rule.2d(1,2,-11,-2,1,-13)
coef[1]
coef[2]



######################
###Fitting Model f1###
######################
C1.1 <- sum(t*(y-100))
C2.1 <- sum(t^2)

a1.1 <- fit.a1.1d(C1.1,C2.1)
coef.1 <- cramers.rule.1d(C2.1,C1.1)


######################
###Fitting Model f2###
######################
C1.2 <- sum((y-100)*t)
C2.2 <- sum(t^2)
C3.2 <- sum(t^3)
C4.2 <- sum((y-100)*t^2)
C5.2 <- sum(t^4)

a2.2 <- fit.a2(C1.2,C2.2,C3.2,C4.2,C5.2)
a1.2 <- fit.a1.2d(C1.2,C2.2,C3.2,C4.2,C5.2,a2.2)
coef.2 <- cramers.rule.2d(C2.2, C3.2, C1.2, C3.2, C5.2, C4.2)


######################
###Fitting Model f4###
######################
C1.4 <- sum(t*(y-100))
C2.4 <- sum(t^2)
C3.4 <- sum(t*log(0.005*t+1))
C4.4 <- sum((y-100)*log(0.005*t+1))
C5.4 <- sum((log(0.005*t+1))^2)

a2.4 <- fit.a2(C1.4,C2.4,C3.4,C4.4,C5.4)
a1.4 <- fit.a1.2d(C1.4,C2.4,C3.4,C4.4,C5.4,a2.4)
coef.4 <- cramers.rule.2d(C2.4,C3.4,C1.4,C3.4,C5.4,C4.4)
a2.4
a1.4
coef.4
######################
###Fitting Model f5###
######################
C1.5 <- sum(t*(y-100*exp(-0.00005*t))*exp(-0.00005*t))
C2.5 <- sum((t*exp(-0.00005*t))^2)

a1.5 <- fit.a1.1d(C1.5,C2.5)
coef.5 <- cramers.rule.1d(C2.5,C1.5)


######################
###Fitting Model f6###
######################
C1.6 <- sum((y-100)*t)
C2.6 <- sum(t^2)
C3.6 <- sum(t*(1-exp(-0.0003*t)))
C4.6 <- sum((y-100)*(1-exp(-0.0003*t)))
C5.6 <- sum((1-exp(-0.0003*t))^2)

a2.6 <- fit.a2(C1.6,C2.6,C3.6,C4.6,C5.6)
a1.6 <- fit.a1.2d(C1.6,C2.6,C3.6,C4.6,C5.6,a2.6)
coef.6 <- cramers.rule.2d(C2.6,C3.6,C1.6,C3.6,C5.6,C4.6)
a2.6
a1.6
coef.6



