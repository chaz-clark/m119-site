rm(list=ls())
setwd("/Users/katjohnson/Documents/git/M119/project_grading")
source("task4_functions.r")

###Checking Answers f0###
#No Solution



###Checking Answers f1###
a0.1 <- 100
a1.1 <- 4.5e-4
#Exact Answer f1=80
t1(a0.1,a1.1)
#Numeric Solution f1=80
l1.80 <- -100000
u1.80 <- 0
uniroot(g1,c(l1.80,u1.80),a0=a0.1,a1=a1.1)$root
# #Exact Answer f1=0
# t1.zero(a0.1,a1.1)   #Also the zero for f5.
# #Numeric Solution f1=0
# l1.0 <- 
# u1.0 <- 
# uniroot(f1,c(l1.0,u1.0),a0=a0.1,a1=a1.1)$root



###Checking Answers f2###
a0.2 <- 100
a1.2 <- 0.0012
a2.2 <- -1.7e-7
#Exact Answers f2=80
t2(a0.2,a1.2,a2.2)
#Numeric Solutions f2=80
l2.80 <- 10000
u2.80 <- 30000
uniroot(g2,c(l2.80,u2.80),a0=a0.2,a1=a1.2,a2=a2.2)$root
# #Exact Answers f2=0
# t2.zero(a0.2,a1.2,a2.2)
# #Numeric Solutions f2=0
# l2.0 <-
# u2.0 <-
# uniroot(f2,c(l2.0,u2.0),a0=a0.2,a1=a1.2,a2=a2.2)$root



###Checking Answers f3###
a0.3 <- 101.75
a1.3 <- 100 - a0.3
a2.3 <- 2e-3
#Exact Answer f3=80
t3(a0.3,a1.3,a2.3)
#Numeric Solution f3=80
l3.80 <- -3000
u3.80 <- -500
uniroot(g3,c(l3.80,u3.80),a0=a0.3,a1=a1.3,a2=a2.3)$root
# #Exact Answer f3=0
# t3.zero(a0.3,a1.3,a2.3)
# #Numeric Solution f3=0
# l3.0 <-
# u3.0 <-
# uniroot(f3,c(l3.0,u3.0),a0=a0.3,a1=a1.3,a2=a2.3)$root



###Checking Answers f4###
a0.4 <- 100
a1.4 <- -6e-4
a2.4 <- 1.4
#Exact Answer f4=80
#No Exact Answer
#Numeric Solution f4=80
l4.80 <- 1000
u4.80 <- 300000
uniroot(g4,c(l4.80,u4.80),a0=a0.4,a1=a1.4,a2=a2.4)$root
# #Exact Answers f4=0
#     #No Exact Answer
# #Numeric Solutions f4=0
# l4.0 <-
# u4.0 <-
# uniroot(f4,c(l4.0,u4.0),a0=a0.4,a1=a1.4,a2=a2.4)$root



###Checking Answers f5###
a0.5 <- 100
a1.5 <- 6.2e-3
a2.5 <- 5e-5
#Exact Answers f5=80
#No Exact Answers
#Numeric Solution f5=80
l5.80 <- 0
u5.80 <- 100000
uniroot(g5,c(l5.80,u5.80),a0=a0.5,a1=a1.5,a2=a2.5)$root
#I believe there are two solutions.
# #Exact Answers f5=0
# t1.zero(a0.5,a1.5)
# #Numeric Solutions f4=0
# l5.0 <- 
# u5.0 <- 
# uniroot(f5,c(l5.0,u5.0),a0=a0.5,a1=a1.5,a2=a2.5)$root
