#devtools::install_github("byuidatascience/data4led")
library(data4led)
library(tidyverse)

###################################################
#These functions return the coefficients from MLE. 
#They use Cramer's rule for ease of parsing the code.
#These functions can be sources in a separate file. 
#They require passing both t and y, so no global variables are stored. 
###################################################
cramers.rule.2d <- function(a,b,c,d,e,f){
  #solves ax+by=c, dx+ey=f, 
  #returns c(x,y)
  c(c*e-b*f,a*f-c*d)/(a*e-b*d)
}
cramers.rule.1d <- function(a,b){
  #solves ax=b,  
  #returns x
  b/a
}
fit.1 <- function(t,y){
  C1.1 <- sum(t*(y-100))
  C2.1 <- sum(t^2)
  cramers.rule.1d(C2.1,C1.1)
}
fit.2 <- function(t,y){
  C1.2 <- sum((y-100)*t)
  C2.2 <- sum(t^2)
  C3.2 <- sum(t^3)
  C4.2 <- sum((y-100)*t^2)
  C5.2 <- sum(t^4)
  cramers.rule.2d(C2.2, C3.2, C1.2, C3.2, C5.2, C4.2)
}
fit.4 <- function(t,y){
  C1.4 <- sum(t*(y-100))
  C2.4 <- sum(t^2)
  C3.4 <- sum(t*log(0.005*t+1))
  C4.4 <- sum((y-100)*log(0.005*t+1))
  C5.4 <- sum((log(0.005*t+1))^2)
  cramers.rule.2d(C2.4,C3.4,C1.4,C3.4,C5.4,C4.4)
}
fit.5 <- function(t,y){
  C1.5 <- sum(t*(y-100*exp(-0.00005*t))*exp(-0.00005*t))
  C2.5 <- sum((t*exp(-0.00005*t))^2)
  cramers.rule.1d(C2.5,C1.5)
}
fit.6 <- function(t,y){
  C1.6 <- sum((y-100)*t)
  C2.6 <- sum(t^2)
  C3.6 <- sum(t*(1-exp(-0.0003*t)))
  C4.6 <- sum((y-100)*(1-exp(-0.0003*t)))
  C5.6 <- sum((1-exp(-0.0003*t))^2)
  cramers.rule.2d(C2.6,C3.6,C1.6,C3.6,C5.6,C4.6)
}

##############################################
# Now we can just specify what we wish to fit
##############################################
coef_from_seed <- function(seed = 2021){
  bulb <- led_bulb(1,seed=seed)
  
  t <- bulb$hours
  y <- bulb$percent_intensity
  
  values <- c()
  values[1]<-fit.1(t,y)
  values[2:3]<-fit.2(t,y)
  values[4:5]<-fit.4(t,y)
  values[6]<-fit.5(t,y)
  values[7:8]<-fit.6(t,y)
  data.frame("coef"=c("a1 in f1", "a1 in f2", "a2 in f2", "a1 in f4", "a2 in f4", "a1 in f5", "a1 in f6", "a2 in f6"),"value"=values)
}

student_solutions <- function(seeds){
  tibble(
    seed = seeds,
  ) %>% 
    mutate(coeffs = map(seed,coef_from_seed)) %>%
    mutate(id = row_number()) %>%
    unnest(cols = c(coeffs)) %>% 
    pivot_wider(names_from = coef, values_from = value)
}