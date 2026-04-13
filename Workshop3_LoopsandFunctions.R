## 1 LOOPS loop over something many sets of times, so basically repeat code 

##2 BASIC LOOPS 
for (i in 1:5) {  # create a for loop that runs 5 times (1 to 5)
  print(i)        # each time the for loop runs, print the value of i
}
## i is what we called the iterable and its value is determined in each loop by the vector we specified (1:5). That is to say, the first time the for loop runs, i is 1, the second time i is 2, the third i is 3, and so on until i is 5 in the final loop.

x <- 0 #making a new scalar called x with the value of 0

for (i in 1:10) {
x <- x + i 
}
print(x) # x that has a value of 0. x then has the value of i added to it each time the loop runs, meaning that the value of x becomes 55 from 0 (0 + 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9 + 10)


for (i in 10:20) {
  x <-i*i
  print(x)
  }
# if you want it to print each number put the print command in the loop

shrek_quote <- c('What', 'are', 'you', 'doing', 'in', 'my', 'swamp')
for (word in shrek_quote) {
  print(toupper(word))  
}
##in this case the i is now word

for (donkey in 1:length(shrek_quote)) {
  print(toupper(shrek_quote[donkey]))  #toupper makes it uppercase
}

## 3. SAVING OUTPUTS
output <- vector() # creates an empty vector that we can fill with values
input <- c('red', 'yellow', 'green', 'blue', 'purple')
for (i in 1:length(input)) {
  output[i] <- nchar(input[i])
}
print(output)

output <- vector() 
input <- c('apple', 'tangerine', 'kiwi', 'banana')
for (i in input) {
  output[which(input==i)] <- (paste(i, nchar(i), sep = "_"))
}
print(output)
output

## 4 CONDITIONAL STATEMENTS
numbers <- c(1, 4, 7, 33, 12.1, 180000,-20.5)
for(i in numbers){
  if(i > 5){
    print(i)
  }
}

numbers <- c(1, 4, 7, 33, 12.1, 180000,-20.5)
for(i in numbers){
  if(i < 5 & i %% 1 == 0){
    print(paste(i, ' is less than five and an integer.', sep = ''))
  }
}

## using if()
nums <- c(11, 22, 33, -0.01, 25, 100000, 7.2, 0.3, -2000, 20, 17, -11, 0)
for(i in nums){
  if(i < 55 & i %% 2 == 0){
    print(paste(i, 'is an even number', sep = ' '))
  }
}

## adding else()
numbers <- c(1, 4, 7, 33, 12.1, 180000,-20.5)
for(i in numbers){
  if(i < 5 & i %% 1 == 0){
    print(paste(i, ' is less than five and an integer.', sep = ''))
  } else {
    print(paste(i, ' is not less than five or is not an integer (or both!).', sep = ''))
  }}
  
##using else if()
  numbers <- c(1, 4, 7, 33, 12.1, 180000,-20.5)
  for(i in numbers){
    if(i < 5 & i %% 1 == 0){
      print(paste(i, ' is less than five and an integer.', sep = ''))
    } else if(i < 5 & i %% 1 != 0){
      print(paste(i, ' is not an integer.', sep = ''))
    } else if(i >= 5 & i %% 1 == 0){
      print(paste(i, ' is not less than five.', sep = ''))
    } else {
      print(paste(i, ' is not less than five and is not an integer.', sep = ''))
    }
  }

## 5. WHILE LOOPS 
#  Instead of giving loops an object to iterate over (usually a vector), while loops will instead take a conditional statement. They continue to loop over the statement while the statement is TRUE.

  x <- 0
  while(x < 5){
    x <- x + 1
    print(paste('The number is now ', x, sep = ''))
  }

#create a loop that finds the lowest number that is a factor of 5, 6, 7 and 8
  x <- 1
  while(x %% 5 != 0 | x %% 6 != 0 | x %% 7 != 0){
    x <- x + 1
  }
  print(paste('The lowest number that is a factor of 5, 6, 7 and 8 is ', x, sep = ''))
  
#code  would not work if x starts as 0
  
x <- 0.999 
while(x >= 0.5){
  x <- x ^ 2
  print(paste('The number more than or equal to than 0.5 is ', x, sep =''))  
}

## 6. FUNCTIONS

powers <- function(x){
  y <- x ^ 2
  return(y)
}
powers(1)
powers(4)

powers <- function(x){
  y <- x ^ 2
  z <- x ^ 3
  return(c( y, z))
}
powers(1)

powers(2)

powers <- function(x){
  if(x == 'Bird'){
    return(paste(x, " is the word", sep=''))
  } else {
    return(paste(x, " is not the word", sep = ''))
  }
}
powers('Bird')
powers('Fox')
