library(pacman) #load this library
p_load(dplyr, foreign, plyr, readxl,
       tidyr, tidyverse, wooldridge)
set.seed(921)
setwd("/cloud/project/data")


#' In today's lecture, we discuss the following:
#' 1. LISTS (stores grouped data)
#' 2. MATRICES (rectangular form of data)
#' 3. ARRAYS (generalized matrices)
#' 4. DATAFRAMES (standard R data type)


#Creating a list in R
# - hold objects in R
# - group data into a one-dimensional set

#' 
#' In the following example, i create a list where I store
#' my name, the courses i teach next term, and the days
#' on which i have lectures.
#' 
aList <- list("Sumit", c("MAC", "IEM"), c("M", "W", "F"))

class(aList)
str(aList)

## example 2: store world cup 2019 information:
## 1. name of the tournament,
## 2. teams participating in the tournament,
## 3. stadiums,
## 4. number of matches.

wcc2019 <- list(tournament = c("World Cup 2019"), 
                teams = c("AFG", "AUS", "BAN",
                          "ENG", "IND", "NZ",
                          "PAK", "SA", "SL","WI"),
                stadiums = c(1:11),
                num_matches = 46
)

## example 3:
## Let's build the beatles catalog using
## the following information
## - album names (save them as a vector called album)
## - year
## 
catalog <- list(album = c("Please Please Me",
                          "With the Beatles",
                          "A Hard Day's Night"),
                year = c(1963, 1963, 1964))

print(catalog)
str(catalog)

#'
#' Matrices are rectangular data in R.
#' Any given matrix has M rows and N columns.
#' We create a matrix in R using matrix()
#' You will need to specify: 
#'   - data (in form of a vector)
#'   - M or N or both.
#' 
args(matrix)


## example--
die <- 1:6
### create a matrix with 6 rows
m1 <- matrix(die, nrow = 6)
print(m1)
str(m1)
class(m1)

### create a matrix with 2 rows
m2 <- matrix(die, nrow = 2)
print(m2)
str(m2)

### create a matrix with 2 columns
m3 <- matrix(die, ncol = 2)
print(m3)
str(m3)

### create a matrix with 3 rows and 2 columns
m4 <- matrix(die, nrow = 3, ncol = 2)
print(m4)
str(m4)

### you can name rows and columns using the argument
### dimnames = LIST OF NAMES
a_matrix = matrix(1:4,nrow = 2, ncol = 2, 
                  dimnames = list(c("R1", "R2"), 
                                  c("C1", "C2")))
print(a_matrix)

#'
#' Arrays in R:
#' Arrays are generalized forms of matrices.
#' so, you have M rows, N columns, and (let's say)
#' X matrices within an array.
#' you need to specify-
#'  - data
#'  - dimension(M,N,X)
#' 
args(array)
an_array <- array(c(1:5, 6:10), dim = c(2,5,2), 
                  dimnames = list(
                    c("one", "two"),
                    c("okati", "rendu", "mudu", "nalugu", "aidu")))


#'
#' Detour1: Factor objects
#' Factor objects contain categorical information
#' examples: Gender, class, caste, country, color, shape
#' Factor objects are stored as integers in R
## example--
gender <- c("female", "male", "transperson")
class(gender)
gender <- factor(c("female","male", "transperson"))
typeof(gender)
class(gender)
unclass(gender)


#' 
#' Detour2: Coercing objects
#' Converting string to a number
#' 
class.new <- c("ace", "hearts", 1)
class.num <- class.new[3]
class(class.num) #look carefully. this is not a number.
##we can change the type of the object too
class.num <- as.numeric(class.new[3])
class(class.num)


#' 
#' Dataframes: A spreadsheet in R!
#' we will use vectors to create dataframes
#' data.frame()
#' 

## example: Let's go back to the Beatles catalog

### Create three vectors 
album <- c("Please Please Me", 
           "Rubber Soul", 
           "Magical Mystery Tour")
year <- c(1963, 1965, 1967)
num.tracks <- c(14, 14, 11)

beatles.catalog <- data.frame(album, year, num.tracks)
View(beatles.catalog) #you can see what you just produced.

##alternatively
beatles.catalog <- data.frame(
  album = c("Please Please Me", 
            "Rubber Soul", 
            "Magical Mystery Tour"),
  year = c(1963, 1965, 1967),
  num.tracks = c(14, 14, 11))


#' Creating a new dataset (slightly complex)
#' we are going to use a new function called--
#' expand.grid()
#' Let's take an example. 
#' I have data for two students who take two courses, 
#' and I want to create a dataframe where I store
#' names, course name, and scores.
#' 
Name <- c("Piuli", "Sonali")
Course <- c("ITR", "MAC")
LetterGrade <- c("B+", "B+", "A", "A-")
## let's apply expand.grid to Name and Course 
df1 <- expand.grid(Name = Name, Course = Course)
stuData <- data.frame(df1, LetterGrade)


#' Consider another example--
#' we want to create a dataset with the
#' following information--
#' 3 countries (China, India, South Africa)
#' 3 years (1994-1996)
#' GDP per capita (generated using random numbers)
gdpData <- data.frame(
  expand.grid(country = c("China", 
                          "India", 
                          "South Africa"), 
              year = 1994:1996),
  gdp.pc = round(runif(9, 1000, 20000), 0)
)
View(gdpData)

#dimensions of a dataset
dim(gdpData)
#number of rows in a dataset
nrow(gdpData)
#number of columns in a dataset
ncol(gdpData)

#want a quick view of the dataset?
head(gdpData) #prints first six obs
tail(gdpData) #prints last six obs

#summarizing a dataset
summary(gdpData)
summary(beatles.catalog)
#tabulate a variable
table(beatles.catalog$year)
table(gdpData$year) 
prop.table(table(gdpData$year))


#extracting a specific row or column or even cell
##recall index? we are going use that
dim(gdpData)
gdpData[3,3] #specific cell
gdpData[3,] #specific row
gdpData[,3] #specific column

gdpData[, "country"]
gdpData$country
gdpData[,"gdp.pc"]

#datasets are created out of vectors
#so, all operations that you did for vectors apply here
##example--
mean(gdpData$gdp.pc)
mean(gdpData[,"gdp.pc"])
gdpData[gdpData$country=="India" 
                & gdpData$year == 1994,]


#reading data from external sources

global.gdp.growth <- read_csv("gdp-growth.csv")
dim(global.gdp.growth)
names(global.gdp.growth)
nrow(global.gdp.growth)
ncol(global.gdp.growth)
head(global.gdp.growth)
tail(global.gdp.growth)
summary(global.gdp.growth)


## Detour [Loading and Reading data from excel]
## What if your data was stored in a excel?
## there are packages that help you read excel data into R
## i use and recommend readxl
col <- read_xls("COL.xls") ##your dataset loaded in R
dim(col) 
names(col) ##inspect the data
class(col)
summary(col)
