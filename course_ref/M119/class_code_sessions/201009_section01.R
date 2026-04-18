#Clear environment and install required libraries. 
  #We don't need to install any libraries for our work in this script.
rm(list=ls())

#The IVT is used by the uniroot() function in R.
#Define the constant function f(x) = 7.
const.fun <- function(x){
  rep(7,length(x))
}

#Graph f(x) = 7.
x<-seq(-1,5,0.01)
plot(x,const.fun(x),type='l')

#The uniroot() function looks for zeros of the function.
  #The following command is trying to solve the equation f(x) = 0.
  #It is trying to solve the equation 7 = 0. This equation is never zero, so there is no solution.
uniroot(const.fun,c(-100,4))$root
#Error in uniroot(const.fun, c(-100, 4)) : 
#  f() values at end points not of opposite sign
  #This error shows that the uniroot() function is using the IVT as an initial check.
  #If f(a) and f(b) do not have opposite signs, then zero is not in between f(a) and f(b).
  #The assumptions for the IVT are not satisfied so we do not have a guarantee that the equation f(x) = 0 has a solution on the interval [a,b].
  #Since we don't have the guarantee of a solution, uniroot() does not look for a solution.


#What is the chance we would observe 3 out of 10 heads given the coin were a fair coin (p=0.5 known)?
  #Parameter values known (the parameter values are FIXED) and the data is unknown (can vary).
  #This is a "probability model" question.
dbinom(3,size=10,prob=0.5)
#[1] 0.1171875

#How likely is it that p=0.4 given we have observed 3 out of 10 heads (x=3 known)?
  #Data known (data values are FIXED) and the parameter values are unknown (can vary).
  #This is a "likelihood function" question.
dbinom(3,size=10,prob=0.4)
#[1] 0.2149908

#A more common likelihood question is:
  #What is the most likely value for the parameter p given we have observed 3 out of 10 heads?
  #This is the model fit or parameter selection question.
#Let's visualize this idea.
  #The parameter p is unknown, so we consider all possible values for the parameter.
  #Define a vector with the values the parameter can be.
p <- seq(0,1,0.01)
#Plot the likelihood function. The likelihood function is a function of the parameter p.
  #p values are the horizontal axis values.
  #likelihood for each value of p are the output values.
par(mar=c(2.5,2.5,0.25,0.25))
plot(p,dbinom(3,size=10,prob=p),type='l')
  #From the graph we can see a largest likelihood value, when p is approximately 0.3. 
  #Next week we are going to be starting the derivatives and optimization unit where we will learn how to answer this type of likelihood questions.
  

