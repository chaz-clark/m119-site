# run this line once in the console to get package
#devtools::install_github("byuidatascience/data4soils")

library(data4soils)

Ng <- cfbp_fpjuliet$ng

mean(Ng)
var(Ng)
# ?dunif
# ?runif
# ?dnorm
# ?rnorm
# ?dgamma
# ?rgamma
# ?dexp
# ?rexp

lambda <- 5 #Bad Choice
x = seq(0,20,0.1)
hist(Ng,freq = FALSE, breaks = 50,ylim=c(0,1))
lines(x,dexp(x,rate = lambda))

lambda <- 0.05 #Another Bad Choice?
x = seq(0,20,0.1)
hist(Ng,freq = FALSE, breaks = 50,ylim=c(0,1))
lines(x,dexp(x,rate = lambda))

#Some more bad choices. 
alpha <- 2
beta <- 0.5
x = seq(0,20,0.1)
hist(Ng,freq = FALSE, breaks = 50,ylim=c(0,1))
lines(x,dgamma(x,shape = alpha,rate = beta))

alpha <- 4
beta <- 0.5
x = seq(0,20,0.1)
hist(Ng,freq = FALSE, breaks = 50,ylim=c(0,1))
lines(x,dgamma(x,shape = alpha,rate = beta))

alpha <- 2
beta <- 0.1
x = seq(0,20,0.1)
hist(Ng,freq = FALSE, breaks = 50,ylim=c(0,1))
lines(x,dgamma(x,shape = alpha,rate = beta))

#Do we want the instructions to include information about adjusting the number of bins (chaning "breaks")?  Or do we just leave that off?  I found it extremely useful to adjust this value. 

#Words around "each" may need punctuation to properly parse. Perhaps just separate this into two blocks.  It's currently not parseable. 

my_sample_exp <- rexp(25000,rate = lambda)
my_sample_gamma <- rgamma(x,shape = alpha,rate = beta)
hist(my_sample_exp,breaks = 50)
hist(my_sample_gamma,breaks = 50)

#In the computations below, I just set all parameters equal to 1 (not the best choice) so that I could rapidly check things with the shiny app. 
alpha <- 1
beta <- 1
set.seed(20210)
tmp2 <- rgamma(25000, shape = alpha, rate = beta)
length(which(tmp2 > 10)) 
length(which(tmp2 > 10)) / 25000


lambda <- 1
set.seed(20210)
tmp3 <- rexp(25000, rate = lambda)
length(which(tmp3 > 10))
length(which(tmp3 > 10)) / 25000


#We need a shiny app to check computations?  
#Not doable unless you force them to use a seed.
#Do we want a range on viable options for alpha and beta. Seems arbitrary. Visually fitting is a mess. 
#Do we want to force them to use seed?


#Task 2
#I think the "check your work" section needs to change.  You gave them the solution in the last bullet. Have them use that. 

#Project 3 - Final Submission

#Compute probability that amount of explosive is between 0 and 5mg/kg for f0 and f3. 
#For f1 and f3, determine 99th percentile of distribution. 
#For all 4 models, calculuate probability that the amount of explosive will be more than 10mg/kg. 

#It appears we need 8 numbers. They can enter all 8.  The solutions are the SAME for everyone. So we just have to find them and code in the number.  We DON'T need shiny. We can use I-Learn for this one.  But we will use Shiny non-the-less. 


