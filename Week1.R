# BIO319 Worksheet 1 Script
# Heba Nane
# 26/01/2026

1 + 3 * 10

## Creating Variables 
# the <- symbol. This assigns the values on the right of the <- to the name on the left

x <- 10
y <- 20
z <- 'thirty'
z <- "thirty" #using " vs ' produces the same thing, good practice to stick to one

x * y
x/z

## Data Classes
# Variables in R can take the form of several classes: ‘numeric’ and ‘character’ 
# check whether your variable is numeric using the is.numeric()
# use the class() function on any variable to check what class the data are
is.numeric("x")
is.numeric(x)
is.numeric(thirty)
is.numeric(z)

class(x)
class(z)

#You can create a logical variable using either TRUE or FALSE.

a <- TRUE
b <- FALSE
1 < 2

# < and > are types of logical operator. Other important operaters are:
# <= is less than or equal to, >= is greater than or equal to, == is equal to, != is not equal to
#  make complex logical expressions using the & and | symbols. & symbols = ‘and’, | symbol means ‘or’

1 < 2 & 1 > 0 
1 < 2 | 1 > 0 

7 >= 6

x <- 12 / 3 > 3 & 5 ^ 2 < 25
y <- 12 / 3 > 3 | 5 ^ 2 < 25 | 1 == 2
z <- FALSE
z == TRUE

x <- "The cake"
y <- "A lie"
x == y

nchar("Heba")

"Heba" >= 6 

nchar("Heba") >=6 



nchar("Heba") >= 3 & "Heba" != "Heba"


nchar("Heba") >= 3 & "Heba" != "James"

nchar("Heba") >= 3 & "Heba" != "Heba"

"Heba" != "Heba"

nchar("Heba") >= 3

##Scalars, Vectors and Matrices

#Scalars contain a single value (e.g. x <- 1 or cheese <- 'delicious'). 
#Vectors, on the other hand, contain multiple values in a single object.

x <- c(1,2,3,4)
y <- c(FALSE, TRUE, FALSE, TRUE, FALSE)
z <- c('I', 'got', 'the', 'right', 'temperature', 'to', 'shelter', 'you', 'from', 'the', 'storm')

class(x)
class(y)
class(z)

# rep() function will repeat a vector or scalar multiple times to create a vector.

rep(x = c(1,2,3), times = 3)

rep(x = c("I", "will", "not", "tell", "lies"), times = 20)

x <- c("a", "b", "c")

# each repeats separate parts of the vector separately 
rep(x, each=5) 

# seq() create a series of numbers between two values, separated by as many divisions as you specify

seq(from = 1, to = 10)

seq(from = -10, to = -2)

seq(from = 1, to = 101, by = 10)

seq(from = 10, to = 15, by = 0.5)

seq(from = 0, to = 15, by = 0.1)

## subscripting
#The final shorthand way to create a sequence of numbers in R is to use the : symbol. This creates a sequence of the integers between the values specified.

1:3
3:9
12:-2

x <- c('a','b','c', 'd', 'e', 'f', 'g', 'h')
x[1]
x[3]
x[3:5]
x[5:3]

x[seq(from = 1, to = 5, by = 2)]

x <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 8, 7, 6, 5, 4, 3, 2, 1)
x > 5

y <- x[x > 5]
print(y)

x <- c(2,3,4,5,6,7,8,9,10,11,12,13,14,15)
y <- x[x <= 7]
print(y)

#result of the %% operator is the REMAINDER of a division

y <- x[x %% 3 == 0] #this is how you know it is a multiple of 3 as you want it divide completely into 3 with a remainder of 0
print(y)

## Matrices
#By increasing the dimensionality of our object one more time we move a linear vector, to a two-dimensional matrix (or matrices if plural)
#create matrices using the the matrix() function

mat1.data <- c(1,2,3,4,5,6,7,8,9)
mat1 <- matrix(mat1.data,
               nrow = 3,
               ncol = 3,
               byrow = TRUE) # true makes it go across a row
mat1

mat1 <- matrix(mat1.data,
               nrow = 3,
               ncol = 3,
               byrow = FALSE) # False makes it go down by column
mat1

mat2.data <- c('a','b','c','d','e','f','g','h','i','j','k','l')

mat2 <- matrix(mat2.data,
               nrow =3,
               ncol = 4,
               byrow = FALSE)
mat2

# You can subscript matrices, have to use 2 numbers, 1st is the row, 2nd is the column
# e.g. mat1[1,3] would give you the first element of the third column.

mat2[3,4] #3rd element of the 4th column of your alphabet matrix

mat2 [2:3 , 1] # 2nd AND 3rd rows of the 1st column of your alphabet matrix.

mat2 [2:3, 1:4] # return all the elements EXCEPT those in the 1st row of your alphabet matrix.

## Dataframe
#In a matrix, all the data are of one class, meaning that you cannot have one column of logical data (TRUE or FALSE), with another of numeric data. In a dataframe, on the other hand, our columns can all be different classes.

read.csv("NYTBestsellers.csv")
df <- read.csv('NYTBestsellers.csv')

#check structure of a dataframe
str(df)

df[1:3, 2:5]

df[3,] # only row 3 and all columns

df[1:5, 'title']

#An additional way to refer to columns in a dataframe is using the $ symbol

hist(df$total_weeks)

df$title[1:5] # df[1:5, 'title'] will produce the same output as running df$title[1:5]

df$personal_rating <- rep('brilliant', times = nrow(df)) 

df$number_of_pages <- rep(x = c(100,200,300,400,500), each=20) #creating your own new column called ‘number_of_pages’ that creates a column with 100 for the first 20 books, 200 for the next 20 and so on until the last 20 books are 500.

x <- 1:12 # this is an integer
w <- 'melanogaster'## this is a character
y <- FALSE ## logical
z <- x + 1 ## numeric

##Question Time 2
