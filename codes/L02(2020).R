## simple math operation
a <- 1 #define an object called a which takes value equals 1
b <- 3
a + b #adds b to a
b - a #subtract a from b
c <- 5
b*c #product of b and c


sum <- a + b + c #define a new object using existing objects
print(sum)



#logical test
a - b == c # difference between a and b equals c
a*b > b*c
a*b < sum 
a*b*c < sum
a*b < b*c
a == beatles.song

#collection of numbers
die <- 1:6 #set of integers
print(die)
one.plus.one <- 1 + 1
print(one.plus.one)

##Class, Structure, and Type
class(die)
class(a)
class(beatles.song)
class(one.plus.one)
class(a-b)
str(one.plus.one)
typeof(one.plus.one)


##caution while creating an object in R
1night@callcenter <- "chetan bhagat novel" #name CANNOT start with a number or
# a special character

##R is case sensitive when you name an object
## die is NOT the same as Die
## Let's create an object with integers from 1 to 6 (save as die)
## and then create an object with integers from 1 to 10 (save as Die)
die <- 1:6
Die <- 1:10

## CAUTION:
##R overwrites names already taken
die <- 1:6
print(die)
die <- 1:10
print(die)

my.favourite.song <- "tujhe dekha toh yeh jana sanam" #year 1995
print(my.favourite.song)
my.favourite.song <- "a day in the life"              #year 2009
print(my.favourite.song)

#listing all the names you have used in R is painless
#just use ls()
ls()

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
