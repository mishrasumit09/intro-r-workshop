#'
#' IN-CLASS EXERCISE--
#' FORM GROUPS OF 2 to do the following.
#' 1.Use functions in R to transform the following vectors-- 
#'    i. the vector x <- c(2, "a", "b") into "2ab".
## SOLUTION: you can use--
##          paste0()
##          paste()
x <- c(2,"a", "b")
x1 <- paste0(x[1], x[2], x[3])
x2 <- paste(x, sep="", collapse = "")
print(c(x1,x2))

#'    
#'   ii. y <- c(100,82,61,103) sorted in descending order.
## SOLUTION: you can use--
##           sort()
##           order()
y <- c(100,82,61,103)
y1 <- sort(y, decreasing = T)
y2 <- y[order(y, decreasing=T)]
print(c(y1, "||", y2))

#' 2. Count how many multiples of 7 exist between 124 and 2389.
#' 3. Create a sequences starting with 3 
#'    with a gap of 4 for first eight numbers, 
#'    and 6 for next 12 numbers.
z <- 124:2389
a_seq1 <- seq(3,by=4, length.out=8)
a_seq2 <- seq(a_seq1[8], by=6, length.out=13)
## There are two options--
##  1. combine the two sequences and omit the repeated
##     object (31).
## 2. use unique() to remove the duplicate.
a_seq <- c(a_seq1, a_seq2[2:length(a_seq2)])
a_seq <- unique(c(a_seq1, a_seq2))
print(a_seq)