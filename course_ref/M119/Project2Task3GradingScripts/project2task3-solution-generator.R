#First set the working directory to the directory containing this file. Then run each line. 
  #You can use the following menu commands to set your working directory.
  #Session > Set Working Directory > To Source File Location
#Use the Session menu, Set Working Directory, To Source File Location options to set your working directory.
source("project2task3-solution-generator-source.R")

#install.packages("googlesheets4")
#install.packages("readr")
  #the package with the write_csv() function
#install.packages("dplyr")
  #the package with the glimpse() function
library(googlesheets4)
library(lubridate)
library(readr)

#Head to this URL and paste the seeds into the seed column. 
  #This google sheet is in the Math_119 shared drive.
  #It is called "Class Seeds".
sheetURL <- "https://docs.google.com/spreadsheets/d/1nZdjWGhzgQs9QoyPrEwlNsvw-EzQa_BdJ6xXVv7-NmI/edit?usp=sharing"

my_sheet <- read_sheet(sheetURL)
my_seeds <- my_sheet$Seed

filename <- paste(today(),"student_solutions.csv",sep = "-")
student_solutions(my_seeds) %>% 
  glimpse() %>% 
  write_csv(filename)
#The CSV will output in the same directory. Take the data wherever you want. 
