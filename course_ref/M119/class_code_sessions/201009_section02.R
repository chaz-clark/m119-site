#Clear environment and install required libraries. 
#We don't need to install any libraries for our work in this script.
rm(list=ls())

#The IVT is used by the uniroot() function in R.
  #Define the function h(x) = f(x) - 4.
h <- function(x){
  exp(-x)-6
}

#The uniroot() function looks for zeros of the function.
  #The following command is trying to solve the equation h(x) = 0.
  #It is trying to solve the equation e^(-x) -6 = 0. This equation is never zero, in the interval [0,10].
uniroot(h,c(0,10))$root
#Error in uniroot(h, c(0, 10)) : 
#  f() values at end points not of opposite sign
  #This error shows that the uniroot() function is using the IVT as an initial check.
  #If h(a) and h(b) do not have opposite signs, then zero is not in between h(a) and h(b).
  #The assumptions for the IVT are not satisfied so we do not have a guarantee that the equation h(x) = 0 has a solution on the interval [a,b].
  #Since we don't have the guarantee of a solution, uniroot() does not look for a solution.

#Let's try a different interval since we solved this equation and know there is a solution.
  #The exact solution for the equation h(x) = 0 is x=-ln(6).
-log(6)
#[1] -1.791759
  #Notice uniroot() is able to find this solution.
uniroot(h,c(-100,10))$root
#[1] -1.791759

#Let's check the assumptions of the IVT.
  #h(x) is a continuous function on the interval [-100,10].
    #Yes, exponential functions are continuous on the whole real line.
  #h(a) is not equal to h(b)
    #Yes, h(a) is a large positive number and h(b) is close to -6.
  #The y-value y=0 is between h(a) and h(b).
    #Yes, h(b) < 0 < h(a).
h(-100)
#[1] 2.688117e+43
h(10)
#[1] -5.999955
  #Since 0 is between h(a) and h(b) the IVT guarantees there is an x-value in the interval [-100,10] so that h(x) = 0.
  #Since we know a solution exists because of the IVT, then  the uniroot() will look for that solution.
  #And it finds the solution.





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


