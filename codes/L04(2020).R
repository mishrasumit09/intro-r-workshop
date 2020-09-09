#This code introduces a key object in R: vectors. 
#Vectors have one dimension that represents some concept 
# or fact about the world. 
#Examples include age, GDP, profits, etc. 
#This code will explains how to :
#                         a) create different types of vectors, 
#                         b) how to subset them, 
#                         c) how to modify them, and 
#                         d) how to summarize them.

#Start off creating vectors

## Numeric Vectors
nv.first <- 800 # you are already familiar with this
nv.second <- c(800, 1000, 2000, 5000) ##c refers to concatenate

## Character Vectors
cv.first <- "please please me"
cv.second <- c("please please me", 
               "with the beatles", 
               "a hard day's night")

##Logical Vectors
lv.first <- TRUE
lv.second <- c(FALSE, TRUE, FALSE)


#'there are multiple ways in R to 
#'  combine multiple objects and
#'  create vectors:
#'   c(), seq(), rep(). 
#' you already know about c()
#' let's see how we can create vectors using seq and rep
#' seq(): refers to sequence and is only applied to numbers.
#' rep(): refers to repetition, and can be used for numbers
#'        as well as characters.

### Example-- seq()
#### Create a set with numbers from 2 to 30
#### with a gap of 4 between consecutive numbers.
even.set1 <- seq(from = 2, to = 30, by = 4)

#### Create another set with 8 numbers from 2 to 30
even.set2 <- seq(from = 2, to = 30, length.out = 8)

even.set3 <- seq(2,30,4)



###let's see how rep() works
rep("bye", 3)  
##' 
##' the first argument is the object that 
##' you want to be repeated
##' the second argument is the number of times 
##' first argument repeats
rep(100, 5)
##' does this also work for logical vectors?
rep(FALSE, 10)

#You already know that you can nest functions
##let's do this. we learnt rep() and c(). 
##let's combine these two.
rep(c(800, 1000, 2000, 5000), 3)
##does this also work for characters?
rep(c("red", "blue", "green", "yellow"), 2)

##let's increase the level of `complexity`
###' we will repeat two different words--
###'  (i) coldplay
###'  (ii) yellow
###' ten times each. 
c(rep("coldplay",10), rep("yellow", 10))

random.vect <- c(rep("coldplay", 5), seq(0,10,1))


#Subsetting vectors
beatles.albums <- c("please please me", "twist and shout")
#' The way to subset a vector is to use square bracket.
#' VECTOR[DO SOMETHING HERE]
#' There are many ways to subset a vector.
#' In this example, we will learn how to use logical
#' vector to subset another vector.

beatles.albums[c(TRUE, FALSE)]

beatles.songs <- c("twist and shout", "norwegian wood",
                   "mr.moonlight")
##' 
##' let's subset this list by including only those songs
##' that I like.
##' The songs that I like are twist and shout, 
##' and norwegian wood.
##' 
songs.like <- beatles.songs == "twist and shout" | 
  beatles.songs == "norwegian wood" 
##' recall that == resolves to equality condition in R
##' in plain English, whenever you want to find out an
##' exact match, you use ==
songs.like <- beatles.songs!= "mr.moonlight"
##' in R, the exclamation sign (!) followed by = sign
##' represents NOT equal to condition.
songs.like <- beatles.songs %in%
  c("twist and shout", "norwegian wood")
##' 
##' If you want to figure out if a particular vector is 
##' present in another vector you should use the pipe operator
##' 

##let's try learning subsetting a vector
##' subsetting requires you to use the square bracket
##' so the syntax should always be (I repeat)
##' OBJECT[OPERATION]
##' 
beatles.songs[songs.like]


##let's try this out with numeric vectors
ap <- seq(2, 56, 6)

ap[ap < 10] # subset where ap is less than 10
ap[ap > 10] # subset where ap is greater than 10
##' subsetting by multiple conditions can also be done
##' let's say that we want numbers in the vector ap
##' which are greater than 10 AND less than 50
ap[ap > 10 & ap < 50]
##' you want to extract numbers greater than equal to 10
##' and those which are less than 40
ap[ap >= 10 & ap < 40]

##' you want to extract numbers excluding 50
ap[ap != 50]

##' the OR condition can operationalized using
##' pipe or vertical bar |
ap[ap < 10 | ap > 50]
ap[ap > 56] ##in this step, look at the output carefully



#Let's assign year to each Beatles song
beatles.songs <- c("please please me", "Magical Mystery Tour", "norwegian wood")
year <- c(1963, 1967, 1965)
names(year) <- beatles.songs
year[beatles.songs[1]]
year[year > 1964]

#Modifying a vector
##suppose someone messed up norwegian wood's year
beatles.songs <- c("please please me", 
                   "magical mystery tour", 
                   "norwegian wood")
year <- c(1963, 1967, 1963)
names(year) <- beatles.songs
year[3] <- 1965
year["norwegian wood"] <- 1965


#Just like a book has an index, all objects in R have index.
#let's go back to the list of beatles songs
beatles.songs <- c("please please me", 
                   "twist and shout", 
                   "norwegian wood")
beatles.songs[1]
beatles.songs[1:2]
beatles.songs[2:3]


#Summarizing Vectors
ap <- seq(2,56,6)

class(ap)  #check class

length(ap) #check length

max(ap) #check maximum value inside this vector

min(ap) #check min

sum(ap) #computes the sum of the AP

mean(ap) #average of the sequence

var(ap) #variance of the sequence

quantile(ap) #quantiles of the vector (default is quartile)

quantile(ap, probs = seq(0, 1, 0.1)) #percentiles

summary(ap)

#All set to write a general code?
beatles.albums <- c("Please Please Me", "With the Beatles",
                    "A Hard Day's Night", "Beatles for Sale",
                    "Help!", "Rubber Soul", "Revolver",
                    "Sgt. Pepper's Lonely Hearts Club Band",
                    "Magical Mystery Tour", "The White Album",
                    "Yellow Submarine", "Abbey Road",
                    "Let It Be")
n <- length(beatles.albums) #store the result of length() in an object 
n
random.sample.albums <- 
  beatles.albums[sample(1:length(beatles.albums), size = 5)]
random.sample.albums