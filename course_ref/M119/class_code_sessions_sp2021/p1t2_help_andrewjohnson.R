#Clear the environment.
rm(list=ls())

#Define the function f3, name it f1.
  #input named x
  #parameters named a, b, c
f1 <- function(x,a,b,c){a+b*exp(-c*x)}

#Define the inputs.
x <- seq(-2000,8000,1)

#Select some parameter values
a0 <- 11
a1 <- -10
a2 <- -0.002

#Calculate the output values (this can be done inside or outside of the plot command).
y <- f1(x,a0,a1,a2) 
#Notice the order of the arguments matches their order when you defined the function.
#y <- f1(a=a0,b=a1,c=a2,x=x) will give you the same thing.
#Notice if you use another order you have to "label" the arguments in the function.

#Plot the the ordered pairs (x,y)
par(mfrow = c(1,1),mar=c(4,4,0.5,0.5)) #This is not necessary depending on your current plot settings.
plot(x,y,type='l')



#Select a second set of parameter values
a0.2 <- 35
a1.2 <- 10
a2.2 <- 0.002

#Calculate the output values (this can be done inside or outside of the plot command).
y2 <- f1(a=a0.2,b=a1.2,c=a2.2,x=x)

#Plot the ordered pairs (x,y2)
par(mfrow = c(1,1),mar=c(4,4,0.5,0.5)) #This is not necessary depending on your current plot settings.
plot(x,y2,type='l')


#You can also put both plots in the same figure if desired (this is not required).
par(mfrow = c(1,2),mar=c(4,4,0.5,0.5))
  #mfrow = c(1,2) means there will be 1 row and 2 columns of plots
plot(x,y,type='l') #plot in row 1 column 1
plot(x,y2,type='l') #plot in row 1 column 2




