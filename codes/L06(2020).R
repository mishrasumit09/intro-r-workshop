pacman::p_load(tidyverse)

setwd("/cloud/project/data")

x <- 1:6

# you can create list using list()
a_list <- list(x,
               c("Martha", "Jonas", "Eva", "Adam"),
               seq(5,25,length.out = 5))

# objects within a list can be gleaned using
# double square brackets
a_list[[1]]
# objects within an object within a list can be called
# using single square bracket
# Let's say we want to extract Eva from a_list
a_list[[2]][3]
a_list[[2]][1:2]


# matrices
# we use function called matrix()
# arguments:
#  1- data
#  2- nrow (number of rows)
#  3- ncol (number of columns)
#  4- byrows = F (fill columnwise)
#  5- dimnames (names assigned to rows and columns)
# let's use the object x and convert it into a matrix
# with number of rows = 2
my_mat1 <- matrix(x, nrow = 2)
print(my_mat1)
# create a matrix with 2 columns and fill the numbers from
# object x row-wise.
my_mat2 <- matrix(x, ncol = 2, byrow = T)
print(my_mat2)


# arrays
# Arrays are generalized form of matrices
# The arguments of array() function are
#  - data = INPUT DATA
#  - dim  = c(ROWS,COLUMS,NUMBER OF MATRICES)
#  - dimnames = LABEL EACH CELL.
ar1 <- array(1:8, dim = c(2,2,2))


# Data frames
# Spreadsheet-like datasets in R
# Create three vectors 
album <- c("Please Please Me", "Rubber Soul", "Magical Mystery Tour")
year <- c(1963, 1965, 1967)
num.tracks <- c(14, 14, 11)

beatles.catalog <- data.frame(album, year, num.tracks)
print(beatles.catalog)

#' 
#' Any data frame is of the following form
#' DATA FRAME[M,N] where M = number of rows, and N = number of columns
#' We can print a row (or rows) by substituting M
#' and a column (or columns) by inputing values for N.
#' 
beatles.catalog[1,] #prints the first row
beatles.catalog[1:2,] #prints first two rows
#********************************************
beatles.catalog[,1] #prints the first column
beatles.catalog[,1:2] #prints first two columns

# Columns can also be called using their names
beatles.catalog[,"album"]
beatles.catalog[,c("album", "year")]

#********************************************
#' We can explore a dataset using functions
#'  - dim(): dimension of a data frame
#'  - nrow(): number of rows
#'  - ncol(): number of columns
#'  - names(): names of columns
#'  - head(): prints first 6 rows
#'  - tail(): prints last 6 rows
#'  - summary(): summarizes an object/a data frame
#'  - table(): frequency table for a variable
#'  
# We will use mtcars dataset for this exercise
#********************************************
dim(mtcars) # dimension
nrow(mtcars) # number of rows
ncol(mtcars) # number of columns
names(mtcars) # column names
head(mtcars)  # first six rows
tail(mtcars)  # last six rows
summary(mtcars) # summarize data
table(mtcars$cyl) #frequency table

