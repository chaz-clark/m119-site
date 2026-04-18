#Clear environment and install required libraries. 
  #We don't need to install any libraries for our work in this script.
rm(list=ls())

#Read in and name the practice_data. 
  #We used the "Import Dataset" button in the "Environment" tab.
  #This is the code from the Console.
#> data <- read.csv("~/Documents/git/M119/script_how-to/practice_data")
#>   View(data)

#Create a scatterplot of input2 vs. outputC from our practice_data
  #The par() is used to set the plot parameters.
  #The mar= argument is used to set the margin of the plot.
  #The order is bottom margin, left margin, top margin, right margin.
  #The type='p' argument specifies we are ploting points.
  #The pch= argument specifies the symbol used for the points.
par(mar=c(2.5,2.5,0.25,0.25))
plot(data$input2,data$outputC,type='p',pch=16)

#The scatterplot looks like there could be an exponential relationship.
  #Define a general exponential function.
  #We will select parameter values to select a specific model while looking for a visual fit.
f.exp <- function(x,a=1,b=2,c=0,d=0){a*b^(x+c)+d}

#Define a vector of input values.
x <- seq(-2,10,0.01)
#Use the lines() function to add a line (or curve) to the current plot.
  #Try the specific model with parameters a=2,b=2,c=-1,d=-0.5.
lines(x,f.exp(x,a=2,b=2,c=-1,d=-0.5),type='l',col=2)
  #Try the specific model with parameters a=0.25,b=2,c=-1,d=-0.5.
  #Change the color of the curve with the col=3 argument so we can tell the specific models apart.
lines(x,f.exp(x,a=0.25,b=2,c=-1,d=-0.5),type='l',col=3)
  #Try the specific model with parameters a=0.25,b=2,c=-3,d=-0.5
  #Change the color of the curve with the col=4 argument so we can tell the specific models apart.
lines(x,f.exp(x,a=0.25,b=2,c=-3,d=-0.5),type='l',col=4)


#Repeat the same exercise but with the data input1 vs. outputB.
par(mar=c(2.5,2.5,0.25,0.25))
plot(data$input1,data$outputB,type='p',pch=16)

#The scatterplot looks like there could be an quadratic relationship.
  #Define an general quadratic function.
f.quad <- function(x,a=1,b=1,c=1){
  a*x^2+b*x+c
}
#Define a vector of inputs.
#And select some specific models looking for a visual fit.
x <- seq(-10,10,0.01)
lines(x,f.exp(x,a=-2,b=0,c=0),type='l',col=2)
lines(x,f.exp(x,a=-2,b=0,c=-10),type='l',col=3)


#Let's create some measurement data using the Exponential distribution, our f_3 function.
  #Pick 1 random number between 0.000001 and 5 for the true parameter value.
  #Don't look at the value in the Environment tab yet!
l <- runif(1,0.000001,5)
#We create a random sample of 300 measurements from an Exponential distribution with lambda = l.
data.exp <- rexp(300,rate=l)
#Plot a density histogram of the data. 
  #We will always use density rather than count (or frequency) histograms.
  #The probability = TRUE argument is what tells the hist() function to create a density histogram.
par(mar=c(2.5,2.5,1,0.25))
hist(data.exp,probability = TRUE)
#Define a vector of input values.
  #Use the lines() function to plot the specific Exponential distribution on the histogram plot.
  #Change the value of the rate= argument in the dexp() function to identify specific models.
x <- seq(0,5,0.01)
  #lambda = 1.78 (rate = 1.78) looks like a decent visual fit.
lines(x,dexp(x,rate=1.78),type='l',col=2)
  #lambda = 0.2 (rate = 0.2) looks like a bad fit.
lines(x,dexp(x,rate=0.2),type='l',col=3)

#What was the value of lambda? 
  #Note: Because we randomly selected a number between 0.000001 and 5 when you run this code again you will get a differnent value for l.
  #We could have reproducable code if we set the seed, which means we would all be drawing the same random number between 0.000001 and 5.
l
#[1] 2.231842
  #Our guess of 1.78 was kind of close.
  #The model with lambda = l looks like a better fit than our good fit.
lines(x,dexp(x,rate=l),type='l',col=4)
