#'
#' Introduction to R: Lecture 3
#' Make sure that you run the code for 
#' the last class before you start
#' working on this code
#' Today we learn the following--
#' 1. MANIPULATE AN OBJECT
#' 2. PACKAGES
#' 3. FUNCTIONS
#' 4. DIRECTORY & FILES

#manipulate one of the objects we have created
die <- 1:6
die - 1
die/2
die*die
die/die


die <- 1:6
another.die <- 1:3
die.another.day <- 1:360
die + another.die
die + die.another.day
die*another.die
##does ordering matter?
another.die*die
die.another.day + die


#' Operations in R are usually dependent upon
#' packages in R. 
#' How do you know which package to install?
#' Well, google/stackoverflow is the answer!
#' Let's try to install a package.
#' Since we are performing an operation, we need to 
#' know the correction function.
#' To install a new package into R, you need to use:
#' the following syntax--
#' install.packages("PACKAGE NAME HERE", OPTIONS)
#' 
install.packages("pacman", dependencies = TRUE) #installs one package at a time
library(pacman) #loads an existing package

pacman::p_load(dplyr, plyr, 
               tidyr, tidyverse) #installs + loads many packages together


#' Some basic functions in R
#' Each function has two parts--
#' name and arguments.
#' arguments go inside the bracket. 
#' round()-- rounds off a number or a set of numbers.
#' mean()-- calculates the arithmetic average.
#' factorial()-- performs the factorial operation.
#' sample()-- draws a random sample from a set of numbers.
#' 

round(1.96124) # rounds off a number

#' let's say that you want to round off the 
#' same number, but upto two decimal places
#' We need an argument which tells R to do this.
#' This is where args() comes handy
#' TYPE ON YOUR CONSOLE/SCRIPT--
args(round)
#' The first argument is the number itself (x).
#' The second argument specifies the number of decimal places.
round(1.96124, digits = 2)

factorial(6)
mean(1:6) # calculate average for a set of numbers
mean(1:360)
mean(die) # calculate average for an object!
mean(die.another.day)
mean(beatles.song) 

#' The cool thing about R is that you combine functions
#' So, let's say you want to calculate average of the object
#' die, but you want to suppress the decimal places.
#' This can be achieved by nesting mean function into 
#' round function
#' The structure should be--
#' FUNCTION1(FUNCTION2(ARGUMENTS))
round(mean(die))

sample(1:6)
sample(1:10)
sample(die)
sample(die, 2)
sample(die, 1)
sample(die, size = 2, 
       replace = TRUE) ##sample with replacement

#'
#'  MISCELLANEOUS: Google R Code Style Sheet
#' https://google.github.io/styleguide/Rguide.xml
#' 

#listing all the names you have used in R is painless
#just use ls()
ls()
#search for stuff within R
?mean



#' You want to list all the packages installed in R?
#' (Thanks: Shruti)
#' 
installed.packages()

#' 
#' All our data is stored into directories or folders 
#' in our machines. We can tell R to use the folder 
#' where all our data is stored!
#' We will learn few basic commands to do this--
#' setwd(): Sets the working folder for your work
#' getwd(): prints and tells you the current working folder
#' dir() OR list.files: 
#'        lists the files in the current working directory
#' 

## Working Directory in R
setwd("/cloud/project/data")

## finding the current directory
getwd()

##move up one folder
setwd("..")
getwd()

##move to default folder
setwd("~")
getwd()

##inspect the folder
dir()
list.files()

## ADVANCED: 
## What if I just want to see list of xlsfiles in R?
args(list.files)
list.files(pattern =  "*.xls")
