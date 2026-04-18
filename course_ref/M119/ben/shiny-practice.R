#https://deanattali.com/blog/building-shiny-apps-tutorial/
#install.packages("shiny")
library(shiny)
runExample("01_hello")


my_tryCatch <- function(expr){
  tryCatch(expr,
           error = function(e){
             message("An error occurred:", e)
           },
           warning = function(w){
             message("A warning occured:", w)
           },
           finally = {})
}

my_tryCatch <- function(expr){
  tryCatch(expr,
           error = function(e){},
           warning = function(w){},
           finally = {})
}

later <- my_tryCatch(2+2)
later <- my_tryCatch("two" + 2)
later <- my_tryCatch(as.numeric(c(1, "two", 3)))
later
#Note that later takes on the value NULL when an error or warning is thrown. That's useful. 
#If I get a NULL value, then something is wrong.  Display an error message. 
#If I don't get a null value, then display the results. Fun times. 

fn <- function(x,p0,p1,p2,type){
  switch (type,
          f0 = p0 + 0*x,
          f1 = p0 + p1*x,
          f2 = p0 + p1*x + p2*x^2,
          f3 = 100 - p1 + p1*exp(-p2*x),
          f4 = p0 + p1*x + p2*log(0.005*x+1),
          f5 =(p0 + p01*x)*exp(-p2*x),
  )
}


my_type <- "f0"
my_seed<-"1234"
bulb <- led_bulb(1,seed=as.integer(my_seed))
a0 <- 100
a1 <- 0
a2 <- 0
plot_t <- bulb$hours
plot_y<- bulb$percent_intensity
plot_x <- seq(0,80000,5)
par(mfrow=c(1,2),mar=c(2.5,2.5,1,0.25))
plot(plot_t,plot_y,xlab="Hour ", ylab="Intensity(%) ", pch=16,main=my_type)
lines(plot_x,fn(plot_x,p0=a0,p1=a1,p2=a2,type = my_type), col=2)
plot(plot_t,plot_y,xlab="Hour ", ylab="Intensity(%) ", pch=16, xlim = c(0,80000),ylim = c(-10,120))
lines(plot_x,fn(plot_x,p0=a0,p1=a1,p2=a2,type = my_type), col=2)

