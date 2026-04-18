my_seed<-123


f <- function(x,p0,p1,p2,type){
  switch (type,
    f0 = p0 + 0*x,
    f1 = p0 + p1*x,
    f2 = p0 + p1*x + p2*x^2,
    f3 = 100 - p1 + p1*exp(-p2*x),
    f4 = p0 + p1*x + p2*log(0.005*x+1),
    f5 =(p0 + p1*x)*exp(-p2*x),
  )
}
x<-seq(0,10,0.1)
plot(x, f(x,p0=100,p1=0.1,p2=0.005,type = "f5"),type="l")

#The following 10 function need to be defined in a script that is sourced.
f0 <- function(x,p0=100){p0 + 0*x}
f1 <- function(x,p0=100, p1=0.0005){p0 + p1*x}
f2 <- function(x,p0=100, p1=0.0014, p2=-2.23e-7){p0 + p1*x + p2*x^2}
f3 <- function(x, p1=-3, p2=0.00005){
  p0 = 100 - p1
  p0 + p1*exp(-p2*x)
}
f4 <- function(x,p0=100, p1=-0.00039, p2=1.1){p0 + p1*x + p2*log(0.005*x+1)}
f5 <- function(x, p0=100, p1=0.006, p2=0.0003){(p0 + p1*x)*exp(-p2*x)}

#Drop down with 6 functions to pick. 
#Use a0,a1, etc for parameter values they supply. 

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
f <- f4s
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
a0 <- 100
a1 <- -.0003206
a2 <- 1

#What is left-hand-side? (0 or 80)
L <- 80

#What is you answer?
#We will need something to deal with no solution (and no positive solution) cases.

# Did you get a solution from uniroot?  
# Toggle box (Yes/No) 
# If yes, they enter answer (positive or negative, and we tell them yes/no) 

#We want them to be able to check negative answers. 
t <- 81122.46
my_a <- t-1000 #Hopefully OK based on nature of nice functions. 
my_b <- t+1000

#This needs to be checked always.  If they entered a negative value, then tell them "check your domain". The instructions will specify non-negative domain. 
no_a <- 0
no_b <- 500000

#If they enter a negative answer that is correct for the wrong function domain, then let them know to check domain.  Otherwise, just return "Incorrect. Check your solution and your code. If you repeatedly get this error message, seek help." 

#Using the students answers we compute...
#The argument f2s needs to be made general...
ans <- uniroot(f,c(my_a,my_b),p0=a0,p1=a1,p2=a2,LHS=L)$root
ans <- uniroot(function(x){f(x,p0=a0,p1=a1,p2=a2,type = "f4")-L},c(my_a,my_b))$root
signif(ans,digits = 7)
#Script already fails on F2. 
?uniroot

check <- signif(ans,digits = 7)-t
#If check is zero (or within a small tolerance), we should return feedback ("answer correct") otherwise we should return feedback ("answer incorrect") or something like that...
check
epsilon <- 0.00001*t
epsilon
correct <- abs(check)<epsilon
correct


#We produce two plots for them. One with restricted domain to data, one with longer domain.  
devtools::install_github('byuidatascience/data4led')


f <- function(x,p0,p1,p2,type){
  switch (type,
          f0 = p0 + 0*x,
          f1 = p0 + p1*x,
          f2 = p0 + p1*x + p2*x^2,
          f3 = 100 - p1 + p1*exp(-p2*x),
          f4 = p0 + p1*x + p2*log(0.005*x+1),
          f5 =(p0 + p1*x)*exp(-p2*x),
  )
}
a0 <- 100
a1 <- -.0003206
a2 <- 1
L <- 80
t <- 81122.46
my_a <- t-1000 
my_b <- t+1000
ans <- uniroot(function(x){f(x,p0=a0,p1=a1,p2=a2,type = "f4")-L},c(my_a,my_b))$root
