#your very first code in R 

# In this lecture, you learn how to:
# a) navigate through R Studio
# b) create an object in R 
# c) do simple math operations in R

# R as a calculator
1 + 2

# I will write my favourite Beatles song and expect R to save it.
strawberry fields forever
# oops, i ran into trouble. i see the following error
#* Error: unexpected symbol in "strawberry fields" *

#'
#' To have R save my favourite Beatles song, 
#' i will create something that R understands.
#' And, that something is an R object.
#'  NOTE: the way to create an object is to write
#'  object <- value
#'  Let's do that.
beatles.song <- "strawberry fields forever"


print(beatles.song) #prints an object

## Class Example (23 July 2020)
age.sumit <- 40
age.shruti <- 20
age.sumit + age.shruti
print(age.sumit + age.shruti) # Thanks to Rahul K.


## simple math operation
a <- 1 #define an object called a which takes value equals 1
b <- 3
a + b #adds b to a
b - a #subtract a from b
c <- 5
b*c #product of b and c


sum <- a + b + c #define a new object using existing objects
print(sum)