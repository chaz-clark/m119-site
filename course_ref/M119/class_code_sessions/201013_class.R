#Clear environment and install required libraries. 
  #We don't need to install any libraries for our work in this script.
rm(list=ls())
  #This is the file path where this script is saved.
#setwd("/Users/katjohnson/Documents/git/M119/class_code_sessions")

#####################
###Example 2 Table###
#Define the function.
f1 <- function(x){x^4 -10*x^2 +3*x}

#Define the poine of interest.
x0 <- 3
y0 <- f1(3)

#Define a vector of input values (x-values), "column 1".
x.vals <- c(2,2.5,2.9,2.99,2.999,3,3.001,3.01,3.1,3.5,4)
#Compute the output values (y-values), "column 2".
y.vals <- f1(x.vals)
#Compute the slopes, "column 3". 
  #Slope formula computes the differences of the y's divided by the difference of the x's.
slopes <- (y.vals-y0)/(x.vals-x0)

#Create the table by combining the columns into a data frame.
table1 <- as.data.frame(cbind('x'=x.vals,'y=f1(x)'=y.vals,'slope between (3,0) and (x,y)'=slopes))

#View the table.
print(table1)
#Another command you can use to view the table is View().
#View(table1)
#####################


#####################
###Example 2 Table###
#Define the function.
f2 <- function(x){exp(2*x)-1}

#Define the poine of interest.
x0 <- 0
y0 <- f2(0)

#Define a vector of input values (x-values), "column 1".
x.vals <- c(-1,-0.5,-0.01,-0.001,0,0.001,0.01,0.5,1)
#Compute the output values (y-values), "column 2".
y.vals <- f2(x.vals)
#Compute the slopes, "column 3". 
#Slope formula computes the differences of the y's divided by the difference of the x's.
slopes <- (y.vals-y0)/(x.vals-x0)

#Create the table by combining the columns into a data frame.
table2 <- as.data.frame(cbind('x'=x.vals,'y=f2(x)'=y.vals,'slope between (0,0) and (x,y)'=slopes))

#View the table.
print(table2)
#####################


#####################
###Example 3 Table###
#Define the function.
f3 <- function(x){sign(x-1)*(abs(x-1))^(1/3)}

#Define the poine of interest.
x0 <- 2
y0 <- f3(2)

#Define a vector of input values (x-values), "column 1".
x.vals <- c(1,1.5,1.99,1.999,2,2.001,2.01,2.5,3)
#Compute the output values (y-values), "column 2".
y.vals <- f3(x.vals)
#Compute the slopes, "column 3". 
#Slope formula computes the differences of the y's divided by the difference of the x's.
slopes <- (y.vals-y0)/(x.vals-x0)

#Create the table by combining the columns into a data frame.
table3 <- as.data.frame(cbind('x'=x.vals,'y=f3(x)'=y.vals,'slope between (2,1) and (x,y)'=slopes))

#View the table.
print(table3)
#####################


#####################
###Example 4 Table###
#Define the function.
f4 <- function(x){3*log(x-2)}

#Define the poine of interest.
x0 <- 2.75
y0 <- f4(2.75)
  #The exact value for y0 is 3ln(0.75). You can check that these values are the same have R comput 3ln(0.75).
#3log(0.75)

#Define a vector of input values (x-values), "column 1".
x.vals <- c(2.5,2.7,2.74,2.749,2.75,2.751,2.76,2.8,3)
#Compute the output values (y-values), "column 2".
y.vals <- f4(x.vals)
#Compute the slopes, "column 3". 
#Slope formula computes the differences of the y's divided by the difference of the x's.
slopes <- (y.vals-y0)/(x.vals-x0)

#Create the table by combining the columns into a data frame.
table4 <- as.data.frame(cbind('x'=x.vals,'y=f4(x)'=y.vals,'slope between (2.75,-0.863) and (x,y)'=slopes))

#View the table.
print(table4)
#####################
