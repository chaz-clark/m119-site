### Fitting f_6 ###
bulb <- led_bulb(1,seed=1004)
  #Make sure you set the seed.
x <- bulb$hours
y <- 100*bulb$percent_intensity

c1.6 <- sum(x*y) - 100*sum(x)
c2.6 <- sum(x^2)
c3.6 <- sum(x*(1-exp(-0.0003*x)))
c4.6 <- 100*sum(1-exp(-0.0003*x))-sum(y*(1-exp(-0.0003*x)))
c6.6 <- sum((1-exp(-0.0003*x))^2)

a2.best <- (c2.6*c4.6+c1.6*c3.6)/(c2.6*c6.6-c3.6^2)
a1.best <- (c1.6+c3.6*a2.best)/c2.6

a1.best
a2.best


### Fitting f_5 ###
bulb <- led_bulb(1,seed=1004)
  #Make sure you set the seed.
x <- bulb$hours
y <- 100*bulb$percent_intensity

a1.best <- (sum(x*y*exp( -0.00005*x ))-100*sum(x*exp( -0.0001*x )))/sum(x^2*exp( -0.0001*x ))

a1.best



