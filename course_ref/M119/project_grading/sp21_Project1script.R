#The following 10 functions need to be defined in a script that is sourced.
f0 <- function(x,p0=100){p0 + 0*x}
f1 <- function(x,p0=100, p1=0.0005){p0 + p1*x}
f2 <- function(x,p0=100, p1=0.0014, p2=-2.23e-7){p0 + p1*x + p2*x^2}
f3 <- function(x, p1=-3, p2=0.00005){
  p0 = 100 - p1
  p0 + p1*exp(-p2*x)
  }
f4 <- function(x,p0=100, p1=-0.00039, p2=1.1){p0 + p1*x + p2*log(0.005*x+1)}
f5 <- function(x, p0=100, p1=0.006, p2=0.0003){(p0 + p1*x)*exp(-p2*x)}


f0s <- function(x,p0,LHS=80){f0(x,p0) - LHS} 
  #But we don't really need f0.80, because f0(t) is never equal to 80.
f1s <- function(x,p0,p1,LHS=80){f1(x,p0,p1) - LHS}
f2s <- function(x,p0,p1,p2,LHS=80){f2(x,p0,p1,p2) - LHS}
f3s <- function(x,p1,p2,LHS=80){f3(x,p1,p2) - LHS}
f4s <- function(x,p0,p1,p2,LHS=80){f4(x,p0,p1,p2) - LHS}
f5s <- function(x,p0,p1,p2,LHS=80){f5(x,p0,p1,p2) - LHS}


#To check approximate solutions (numeric solutions) to f_i(t)=80 and f_i(t)=0
#Student will need to provide the following information:
  
#Which function f0, f1, ...
f <- 
  #Need to pick f1s, f2s, ... given students value/choice of f.
  #I think defining a function names vector would work.
  #We could then used the students choice as an index to identify the index for the function name.
  
#Visual fit parameter values
    # For f0 only a0. 
      #But I'm not sure we should have students enter a0 for f0 since it must be 100 and the f0(t) = 80 has no solution.
    # For f1 only a0 and a1.
    # For f3 only a1 and a2 (since 100=a0+a1).
    # We could just define all the functions with p0, p1, p2 but not use all the argument in the function rules for f0, f1, and f3.
# We may want to think about programming a check on their visual parameters, if f_i(0)=100.
a0 <- 
a1 <- 
a2 <- 

#What is left-hand-side? (0 or 80)
L <- 

#What is you answer?
  #We will need something to deal with no solution (and no positive solution) cases.
t <- 
a <- t - 1000
b <- t + 1000

#Using the students answers we compute...
  #The argument f2s needs to be made general...
ans <- uniroot(f2s,c(a,b),p0=a0,p1=a1,p2=a2)$root

check <- ans-t
  #If check is zero (or within a small tolerance), we should return feedback ("answer correct") otherwise we should return feedback ("answer incorrect") or something like that...


