rm(list=ls())

#Two ways to program
  #f(x)=x^2+2x+1

#Method 1
  #pros: Easy to define.
  #con: This is a one function definition.
f1 <- function(x){x^2+2*x+1}

#Method 2
  #pros: This function is really a general quadratic function.
    #This is a multi-use function.
  #con: It takes more thinking to write this function.
f2 <- function(x,a=c(1,2,1)){
  var <- c(x^2,x,x^0)
  sum(a*var)
}

#Run theses pieces of code to help understand what R is doing inside f2.
a <- c(1,2,3)
vec <- c(5^2,5,1)

a*vec
#The output for a*vec is c(a[1]*vec[1],a[2]*vec[2],a[3]*vec[3]).
#[1] 25 10  3
  #a*vec[1] = 1*25 = 25
  #a*vec[2] = 2*5 = 10
  #a*vec[3] = 3*1 = 3

sum(c(1,2,3))
  #[1] 6
  #The sum() function in R adds the components of the vector. 
    #In this example, sum(c(1,2,3)) = 1+2+3 = 6.

#To access the documentation (read more about the sum() function) type the following in your console.
?sum()


#Notice the function f1 and f2 are the same for the default settings of f2.
f1(0)
f2(0)

f1(21)
f2(21)

f1(-2)
f2(-2)
  #At this point we have only checked a few values. 
  #We could graph the function to further confirm they are the same.

#Notice also that f2 is a different function when we change the default parameters of the quadratic.
f2(0,a=c(-3,1,1))
f2(21,a=c(-3,1,1))
f2(-2,a=c(-3,1,1))




