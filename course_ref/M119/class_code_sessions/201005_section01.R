#Install required libraries. 
#We need tidyverse in order to use the ggplot() function in R.
library(tidyverse)

#Define the function f_1(x).
  #factorial() is the built in R function for k!.
f1 <- function(x,n=20,p=0.45){
  factorial(n)/(factorial(x)*factorial(n-x))*p^x*(1-p)^(n-x)
}

#Create a vector of inputs.
x <- seq(0,20,1)
#Create a data frame with the two columns.
  #The first column is the inputs, x-values from the vector x.
  #The name of the first column is num.
  #The second column is the outputs.
  #The outputs are calculated using the f1() function we just defined.
df1 <- data_frame(num=x,prob=f1(x,n=20,p=0.5))
#Create a plot of the function f1().
  #This is a function with discrete domain because the nontrival domain is the number 0,1,2,...,n.
  #Since this is a discrete function we use the geom_bar() function to plot the funtion.
ggplot(df1,aes(x=num,y=prob))+
  geom_bar(stat="identity")

#When we change n from 20 to 10 the domain changes.
  #So we write over the previous assignment of x.
  #We create a new vector of inputs.
x <- seq(0,10,1)
#Since we have an new vector of inputs we create a new data frame with inputs and outputs.
  #We write over the previous data frame df1.
df1 <- data_frame(num=x,prob=f1(x,n=10,p=0.9))
#Create a plot of the function f1().
ggplot(df1,aes(x=num,y=prob))+
  geom_bar(stat="identity")


#Define the function f_3().
  #Make sure the number of outputs from the function matches the number of inputs of the function.
f3 = function(x, y = 1) {
  out <- rep(0,length(x))
  out[(x > 0)] <- y * exp(-y * x[(x >0)])
  return(out)
}

#f3() is a function with an interval domain.
  #Create a vector of inputs.
x <- seq(-1,10,0.01)
#Create a data frame with inputs and outputs.
df3 <- data_frame(val=x,out=f3(x,y=3))


ggplot(df3,aes(x=val,y=out))+
  +   geom_function(fun=f3,args=list(y=3))

#Make sure the number of outputs from the function with continuous domain matches the number of inputs of the function.
  #Notice this function, f.const(), always has one and only one output.
f.const <- function(x){
  10
}

  #Notice the number of output for this function, f.const2(), always has the same number of inputs and outputs.
f.const2 <- function(x){
  rep(10,length(x))
}


#To read in data from a csv file make sure your file is in the same folder where you are currently working.
  #One way to do this to find where you are working and save (or move) the file to that folder.
  #Another way to do this is to change the working directory in R.
  #Working directory means the folder where you are working.
#Use the getwd() command to show you the current working directory.
getwd()
#Use the setwd() function to change the current working directory.
setwd("/Users/katjohnson/Documents/git/M119/script_how-to")
#Use the read.csv() command to read in the data.
  #Here we choose to name the data "data".
data <- read.csv('practice_data')
#You can use the head command to view the top few rows of your data frame including the names of the columns.
head(data)

#Create a histogram plot.
  #Make sure it is a density histogram rather than a counts histogram.
  #Use the bin argument of the geom_histogram() function to set the number of bins.
  #The default number of bin for the geom_histogram() is 30.
ggplot(data,aes(x=x2))+
  geom_histogram(bins=10,aes(y=..density..))



