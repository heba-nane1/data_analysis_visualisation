## Workshop 5 - Tidy Data 

# 3 Basic Rules of Tidy Data - 1. Each row is an observation 2. Each column is a variable 3. Each value has its own cell 

beetles1 <- read.csv("beetles_v1.csv")
beetles1

beetles2 <- read.csv("beetles_v2.csv")
beetles2

beetles3 <- read.csv("beetles_v3.csv")
beetles3

##Beetles 4 is the tidiest so we should aim to table it like so
beetles4 <- read.csv("beetles_v4.csv")
beetles4

usites <- unique(beetles1$Site)
length(usites)

colnames(beetles1)[3:ncol(beetles1)]

usites <- unique(beetles3$spp)
length(usites)

## Ways to get an overview of the dataset
str(beetles4) 
summary(beetles4)
head(beetles4)
View(beetles4)   # <-- this one is in Rstudio only

#str() - shows character classes as well as some raw data; limited ability to see larger sets

#summary() - shows character classes and summaries / distributions of data,  does not show any raw data

#head() - simplest representation of raw data, shows very limited amount of  data, will not work well on wide tables

#View() - table representation in Rstudio, shows raw data without summaries,  good for browsing larger tables, can be slow, not working outside of Rstudio  is a major disadvantage

beetlesdf <- read.table("beetles_read_1.csv", sep=",",header=T)  # notice how we set the separator


read.table("beetles_read_2.txt", sep="\t",header=T)

read.table("beetles_read_3.txt", sep = "\t", header=T, skip = 1)

library(tidyr)

?fill

fill(beetlesdf,Site)  
beetlesdf <- fill(beetlesdf,Site)  #careful - this is a common source of errors

beetlesdf2 <- read.table("beetles_read_4.txt", header=T,sep="\t",na.strings="-")

fill(beetlesdf2,Site)

## Piping - allows you to do it in one line of code 
beetlesdf <- read.table("beetles_read_1.csv", sep=",",header=T) %>% fill(Site)

## Pivoting 

#pivot_longer is used to make sure column names become variables
pivot_longer(data=beetlesdf, cols = c("blue_beetle", "green_beetle", "purple_beetle", "red_beetle", "brown_beetle", "black_beetle", "orange_beetle", "white_beetle"),names_to="species")

# tidier way of writing it
pivot_longer(data=beetlesdf, cols = c(3:10),names_to="species")

pivot_longer(data=beetlesdf, cols = contains("blue") )
pivot_longer(data=beetlesdf, cols = matches("_") )

# changing value to count
pivot_longer(data=beetlesdf, cols = contains("_be"), values_to = "count")

#pivot_wider - addresses problem of multiple variables stored in one column, take values from the ‘method’ column, and spread them out as individual columns
casesdf <- read.table("WMR2022_reported_cases_1.txt",sep="\t")
casesdf

## using read table and fill to fix this code
casesdf <- read.table("WMR2022_reported_cases_1.txt",
                      sep="\t",
                      header=T,
                      na.strings=c("")) %>% 
  fill(country)
casesdf

pivot_wider(casesdf,names_from="method",values_from ="n")

## good practice is to save session output
sessionInfo()
