pacman::p_load(tidyverse)

setwd("/cloud/project/data")

x <- 1:6

#' 
#' Tibbles: Modern data frames 
#' Welcome to tidyverse
#' 
df <- tibble(x)
class(df)
names(df)

#' reading data from external sources--
#'  1. csv  -- read_csv  (package: readr)
#'  2. xls  -- read_xls  (package: readxl)
#'  3. xlsx -- read_xlsx (package: readxl)
#'  4. dta  -- read_dta (package: haven)
#'  5. json -- fromJSON (package: jsonlite)
#'  6. xml2 -- read_html (package: xml2)
#'  
g3 <- read_csv("gdp-growth.csv")

colombia <- read_xls("COL.xls")

batind <-  read_xlsx("odi_batting_ind.xlsx")

auto <- haven::read_dta("auto.dta")

cov19ind <- jsonlite::fromJSON("https://api.covid19india.org/v4/data-all.json",
                               flatten=T)
# NOTE: you need more work to convert cov19ind (a list) to
#        a data frame or a tibble.

SnP500 <- xml2::read_html("https://en.wikipedia.org/wiki/List_of_S%26P_500_companies")

# NOTE: you will need (a bit) more advanced tools to get
#       the final data.


#'=======================================================      
#'        Introduction to dplyr
#'=======================================================       
#'  - mutate(): create new columns
#'  - select(): select (or drop) columns
#'  - relocate(): reorder columns
#'  - filter(): filter rows
#'  - arrange(): sort by a given column or a set of columns
#'  - slice(): slice data for a fixed set of rows
#'  - distinct(): remove duplicates from the dataset.


# create new variables
# the function we are going to use is- mutate(arg1, arg2)
#                                      arg1 = tibble
#                                      arg2 = column(s)
mutate(df, x2 = x^2)

mutate(df, x2 = x^2, 
           x3 = x^3,
           x.m = mean(x))
# don't forget to save your tibble to either-
# a new object or
# the old object.
new_df <- mutate(df, x2 = x^2, 
                 x3 = x^3,
                 x.m = mean(x))
names(new_df)


# Exercise:
# 1. Load the package wooldridge into R
# 2. Load the dataset wage1 (the file is called wage1)
# 3. there's a variable called 
#    exper (representing experience level)
#    Use mutate to create a new column
#    called explevel which takes value "experienced"
#    when exper is at least 10 years
#    and "newbie" otherwise.
# 4. save the dataframe to a new object called w02

pacman::p_load(wooldridge, tidyverse)

w01 <- tibble(wage1)

# create new column
mutate(w01,explevel=ifelse(exper >= 10, 
                             "experienced",
                             "newbie"))
# save the step to a data frame.
w02 <- mutate(wage1,explevel=ifelse(exper >= 10, 
                                    "experienced",
                                    "newbie"))



# select a few columns
# we are going to use select(arg1, arg2)
#                     arg1 = tibble
#                     arg2 = column (or a set of columns)
select(new_df, x, x2)

# don't forget to save this operation!
new_df2 <- select(new_df, x, x2)

#reorder columns
schooldb <- tibble(name =c("A","B"),
             rollno = c(1,2),
             year = c(2018,2019))
# you want rollno to be the first column of the data
# we are going to use relocate(arg1, arg2)
#                     arg1 = tibble
#                     arg2 = column (or a set of columns)
relocate(schooldb, rollno)


# filter
filter(new_df, x2 > 10)
filter(new_df, x2 > 10 & x3 < 100)
filter(new_df, x2 < 8 | x3 > 100)

# slice
# syntax : slice(tibble,N) where N is an integer
slice(new_df,3)
slice(new_df, 3:5)


#sort
# syntax: arrange(tibble,column)
arrange(new_df, x2) #ascending
arrange(new_df, -x2) #descending
arrange(starwars, name, -height) #ascending followed by descending


#remove duplicates
# syntax: distinct(tibble)
a_df <- tibble(x = rep("apple",10),
               y = rep("coldplay",10))
distinct(a_df)