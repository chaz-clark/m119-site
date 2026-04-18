#this is a comment
#This is how you clear your environment.
rm(list=ls())

#Graph (a representation of f(x) = sqrt(x))
#What does the computer need to know?
#The set of inputs.
#The set of outputs.
#How the outputs are connected to the inputs.
#Create a set of inputs.
input <- c(4,9,16,25,0,1,2)
#Create the set of corresponding outputs. 
#Using the same order is what will tell the computer how the outputs are connected to the inputs.
#The first input value will be paired up with the first output value.
#(input[1],output[1])
output <- c(2,3,4,5,0,1,sqrt(2))
#Make a graph with points. (This is a scatter plot.)
#type='p' is the command that tells the computer to plot points.
plot(input,output,type='p')

#Connect the points.
#type='l' is the command that tells the computer to plot points.
  #We need the points "in order" because R will connect points with a line in order.
input <- c(0,1,2,4,9,16,25)
output <- c(0,1,sqrt(2),2,3,4,5)
plot(input,output,type='l')

#Define the function f(x) = sqrt(x) in R.
f <- function(x){sqrt(x)}
#Now that the function is defined we can evaluate it. R is a calulator.
f(0)
f(7)

#A more complete graph of f.
#Create a more extensive list set of inputs.
x <- seq(0,30,length=100)
#look at the first few values in x
head(x)
#f(x) as the second argument in the plot command calculates but does not store the values.
#Make a graph with the 100 points and connect them.
plot(x,f(x),type='l')
  #Because we used more points the graph is smoother.


#Let's explore some transformations.
#multiplying by -1 in front flips over x-axis
plot(x,f(x),type='l',xlim=c(-10,10),ylim=c(-10,10))
lines(x,-f(x),col="blue")

#If we multiply by -1 inside before evaluating f, we change the implied domain.
  #Create a list of nonpositive values as inputs for the transformed function.
#multiplying by -1 inside the parent function flips over the y-axis
x.new <- -x
plot(x,f(x),type='l',xlim=c(-10,10),ylim=c(-10,10))
lines(x.new,f(-x.new),col="blue")

#multiplying by a constant in front scales the y-values
plot(x,f(x),type='l',xlim=c(-10,10),ylim=c(-10,10))
lines(x,4*f(x),col="blue")

#multiplying by a constant inside the parent function scales the x-values
plot(x,f(x),type='l',xlim=c(-10,10),ylim=c(-10,10))
lines(x,f(4*x),col="blue")