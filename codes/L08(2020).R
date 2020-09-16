library(pacman)
p_load(tidyverse, readxl)
set.seed(921)


#What do we learn today?
#1- Use of pipe
#1- grouped summary[group_by(), summarize()]
#2- merge datasets [merge()]
#3- reshape datasets [pivot_longer(), pivot_wider()]
#4- split and merge columns [separate(), unite()]

#############################################
#      Introduction to pipe operator %>%
#############################################
#' 
#' Think of the following task
#' Step 1: Generate numbers from 1 to 100 
#'        (call it nums)
#' Step 2: sample 10 random numbers 
#'         from the vector 
#'         (call this our_sample)
#' Step 3: compute average and round it off 
#'         (call this ave_num)
#' 
nums <- 1:100
our_sample <- sample(nums,10)
ave_num <- round(mean(our_sample))

# we can do this in one go
nums <- 1:100
m.num <- nums %>% 
  sample(10) %>% #sample 10 numbers
  mean() %>%  # calculate average
  round() # round it off
print(m.num)





#############################################
#      Grouped Summary in R
#############################################

#' 
#' Dataset: starwars
#' function 1: group_by()
#'             whose arguments will be
#'             group columns
#' function 2: summarize()
#' summarize is very much like mutate!
#' summarize(NEW COL = function(OLD COL))
#' 
# we will try to get average height, and
# average mass by species and gender
#

starwars %>% 
  group_by(species, sex) %>%
  dplyr::summarize(ht.m = mean(height),
                   mass.m = mean(mass))

# Take the wage1 data from wooldridge package
# and compute the average, median, min, and max
# wage by gender (column: female) 
#     and race (column: nonwhite).
wage1 %>% 
  group_by(female, nonwhite) %>%
  dplyr::summarize(ave.wage = mean(wage, na.rm = T),
                   median.wage = median(wage),
                   min.wage = min(wage),
                   max.wage = max(wage))

#############################################
#      Merging two files in R
#############################################
#         join(x,y, by = "key")
#      x: data frame 1
#      y: data frame 2
#    key: column on which x and y will be matched
# inner_join(): matched rows
# left_join(): all rows from x
# right_join(): all rows from y
# full_join(): all rows from x and y
# semi_join(): matching values, but columns from x.


# we create two variables x and y
x <- c("x1", "x2", "x3", "x4", "x5")
y <- c("y1","y2","y3","y4")

# we create two data frames df and df2
# both these datasets contain a common column (key) called
# ID 
df <- tibble(ID = 1:5, x)
df
df2 <- tibble(ID = c(2,4,6,8), 
              y)
df2

# We will first find the matched observations
# from the two data frames.
# To do this, we will use inner_join()
inner_join(df,df2, by = "ID")

# We will retain all observations from df
# and match with df2
left_join(df,df2, by = "ID")

# We will retain all observations from df2
# and match with df
right_join(df,df2, by = "ID")

# We want to create a superset with all
# the information from the two datasets
full_join(df,df2, by = "ID")



# Reshaping dataset
# pivot_longer(dataset, names_to = , values_to = )
# pivot_wider(dataset, names_from = , values_from = )

# create a tibble:
classDB <- tibble(name = c("Jaya", "Sushma", 
                           "Arun", "Uruj"),
                  test1 = c(12,20,14,16),
                  test2 = c(20,15,19,18),
                  midterm = c(40,47,48,50),
                  endterm = c(30,24,29,28))

# This data is wide (in the sense that one obs per person)
# What if we want the data to have one obs per assessment type
# pivot_longer() will help us:
classDB_long <- classDB %>%
  pivot_longer(test1:endterm, 
               names_to = "assessment", 
               values_to = "score") %>%
  relocate(assessment, name) %>%
  arrange(assessment,name)


# Another example: 
# Consider that you have stock price data for two stocks
# for six 
stocks <- tibble(
  day = as.Date('2020-08-01') + 1:10,
  X = abs(rnorm(10)*100),
  Y = abs(rnorm(10)*100)
)

# inspect the data
head(stocks)

# Let's bring this data into the following format:
# day, name (of stock), and price
stocks %>% pivot_longer(c(X,Y),
                        values_to = "price",
                        names_to = "stock")
# save the step
stocks_long <- stocks %>% 
  pivot_longer(c(X,Y), 
               values_to = "price",
               names_to = "stock")


# we can restore our original datasets using
# pivot_wider()
# the main arguments of this function are-
#  names_from = THE COLUMN THAT CONTAINS VARIABLE NAMES.
#  values_from = THE COLUMN THAT CONTAINS ROWS TO BE FILLED.
classDB_long %>%
  pivot_wider(names_from = assessment,
               values_from = score) %>%
  relocate(name,test1, test2, midterm, endterm)

stocks_long %>%
  pivot_wider(names_from = stock,
              values_from = price)

stocks_long %>%
  pivot_wider(names_from = day,
               values_from = price) %>%
  janitor::clean_names()



# you can also create columns using multiple variables
# EXAMPLE: us_rent_income data
head(us_rent_income)
us_rent_income %>%
  pivot_wider(names_from = c("variable"),
              values_from = c("estimate", "moe"))



# 
# Let's try to convert the Billboards top 100 songs for 2000 
# data into a long form of data
names(billboard)
head(billboard)

# We want all the columns starting wk1 until wk76
# to be populated into rows in one column:
billboard %>% pivot_longer(wk1:wk76,
                           names_to = "week",
                           values_to = "rank")

# we can see that there are many NAs in rank
# let's invoke an argument in pivot_longer()
# to clean the process
billboard %>% pivot_longer(wk1:wk76,
                           names_to = "week",
                           values_to = "rank",
                           values_drop_na = T)

# What if we want to read week as numbers?
# We can use gsub() to clean up the variable.
billboard %>% pivot_longer(wk1:wk76,
                           names_to = "week",
                           values_to = "rank",
                           values_drop_na = T)  %>%
  mutate(week = as.numeric(gsub("wk","",week)))



# Splitting and merging columns to create new columns

# separate()
# Arguments of separate()
#  - data
#  - col = (the column name)
#  - into = fill in the new column names
#  - sep = "[^[:alnum:]]+", 
#  - remove = TRUE (will remove the column by default) 
#  - convert = FALSE (will preserve the column type)

# Use any column to create new columns
itr_stu <- tibble(name = c("Gunjan Agarwal", 
                           "Rehan Asdaque",
                           "Simran Heerekar"),
                  rollno = c("062",
                             "087",
                             "156"))
# we want two separate columns (one with first name, 
#                               and the other with last name)
itrDB <- itr_stu %>% 
  separate(name, into = c("first.name", "last.name"))


# you can also use separate to clean up rows:
profileDB <- 
  tibble(
  name = c("Amittu", "Nandu"),
  description = c("Wanderlust,Ambivert", 
                  "Rockstar,Foodie,Sapiosexual") 
  ) 
profileDB

# I want descriptions to be read in different rows.
# we can use separate_rows()
profileDB %>% separate_rows(description)

# Combining columns to create a column: unite()
itrDB %>% unite(name,c(first.name,last.name))


# The rest of the code has some more
# examples that you can work on.

# Merge two datasets
# Dataset 1: GDP data from the World Bank
# Dataset 2: Ease of doing business data

# read the first dataset
wbdata <- read_xlsx("worldbank_gdpdata.xlsx")

# choose the required columns
wbdata17 <- wbdata %>%
  select(countryname, countrycode, 
         region, gdppcap2017)

# look at the attributes of the data
names(wbdata17)
dim(wbdata17)
head(wbdata17)

# read the second dataset
eodbdata <- tibble(read_xlsx("eodb2017.xlsx"))
# inspect the column names, dimension, etc.
names(eodbdata)
dim(eodbdata)
head(eodbdata)

# merge this new file with the GDP data
# we will use the column called countrycode
merged.wb.data <- inner_join(wbdata17, eodbdata, by = "countrycode")

# Exercise: Remove one of the two columns:
#           countryname.x/countryname.y and 
#           rename the remaining one
#           with the name "countryname"

#inspect the dimensions of all datasets
dim(wbdata17)
dim(eodbdata)
dim(merged.wb.data)


# how about merging two datasets by more than one variable?
# there are two example datafiles stored in the Data folder
# datafile1_m, datafile2_m
# load the two files
citydata1 <- read_xlsx("datafile1_m.xlsx")
names(citydata1)
dim(citydata1)
head(citydata1)

citydata2 <- read_xlsx("datafile2_m.xlsx")
names(citydata2)
dim(citydata2)
head(citydata2)

# we will merge the two data frames
# citydata1 and citydata2
# by using two columns:
# city, year
citydata <- inner_join(citydata1, 
                  citydata2, 
                  by = c("city", "year"))
print(citydata)

# notice that when you merged the files
# there is no data for Allahabad.
# how do we add that row to our merged file?
# Think what type of join might come handy.
# I will use left_join.

citydata <- left_join(citydata1,citydata2, 
                  by = c("city", "year"))

# One to many merge
# Let's load another file with info on cities..
# and regions that they belong to
citydata3 <- read_xlsx("datafile3_m.xlsx")
names(citydata3)
dim(citydata3)
head(citydata3)

# We will add the region column to citydata
# using left_join again!
# This time the key that we use will be city
cdatafinal <- left_join(citydata, citydata3, 
                  by = "city")
dim(cdatafinal)
head(cdatafinal)


# EXAMPLE: Reshape Data

# Google mobility data
#-------------------------------------#
#  read raw google mobility data
#------------------------------------#

# load raw google mobility data
gmraw <- read_csv("https://www.gstatic.com/covid19/mobility/Global_Mobility_Report.csv")
# check what's inside
head(gmraw)
names(gmraw)

gmind <- gmraw %>%
  # keep data for India
  filter(country_region == "India" & is.na(sub_region_1) == T) %>%
  # rename long variable names to short names
  dplyr::rename(
    gmr_retail = retail_and_recreation_percent_change_from_baseline,
    gmr_grocery = grocery_and_pharmacy_percent_change_from_baseline,
    gmr_parks = parks_percent_change_from_baseline,
    gmr_transit = transit_stations_percent_change_from_baseline,
    gmr_workplaces = workplaces_percent_change_from_baseline,
    gmr_residential = residential_percent_change_from_baseline
  ) %>%
  # keep relevant variables
  select(date, 
         starts_with("gmr_"))

head(gmind)

# we will try to reshape the data such that each mobility type
# (retail, grocery, transit) can be transposed into rows
# we will use pivot_longer()
# the arguments of this function are:
#           1- cols = c(NAMES OF COLUMNS or INDEX OF COLUMNS)
#           2- names_to = names of current columns will be
#                          stored as rows.
#           3- values_to = values from all the columns that you
#                          transpose will be stored in this column.

gmind %>%
  # reshape data to long by mobility type
  pivot_longer(cols = c(2:7), 
               names_to = "measure", 
               values_to = "value",
               values_drop_na = TRUE)

# let's save this as an object
gmind_long <- gmind %>%
  # reshape data to long by mobility type
  pivot_longer(cols = c(2:7), 
               names_to = "measure", 
               values_to = "value",
               values_drop_na = TRUE)

# What if we want the gmind_wide data to be restored into
# 'long' form?
# We can achieve this using pivot_wider()
# There are two arguments to this function
#        1: values_from = ROWS to be filled
#        2: names_from = COLUMNS to be created
gmind_long %>%
  pivot_wider(names_from = measure, 
              values_from = value)

gmind_wide <- gmind_long %>%
  pivot_wider(names_from = measure,
              values_from = value)