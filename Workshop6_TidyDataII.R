## Workshop 6 - Tidy Data II


install.packages("tidyr")
install.packages("dplyr")
library(tidyr)
library(dplyr)

dataX <- read.table("dataset_X.csv", sep=",",header=T)
dataX

##Select
dataX %>% select(1:11)

## same as select 1:11 but uses matches function
dataX %>% select(c(Site, Month, matches("_")))

#select everything apart from month
dataX %>% select(!Month)

##Filter 
# Allows you to  select subsets of rows based on specific criteria

# remove rows that were found to have less than 9 of cat 3
dataX %>% 
  filter(Cat_3 > 9)

dataX %>% 
  filter(Cat_3 > 9  & Dog_3 > 2)

dataX %>% filter(Cat_3 > 7 & Month == "January")

dataX %>% filter(Cat_3 > 7 &
                   Month == "January" | Month == "November")

## Rename

fixNamesDogs <- function(x) {gsub("ag","og",x)}
fixNamesCats <- function(x) {gsub("ap","at",x)}

# add ignore.case to ignore capitals, double check if True or False
dataX %>%
  rename_with(fixNamesDogs, matches("dag", ignore.case = TRUE)) %>%
  rename_with(fixNamesCats, matches ("cap", ignore.case = TRUE)) 

## making them all lowercase

dataX %>%
  rename_with(fixNamesDogs, matches("dag", ignore.case = TRUE)) %>%
  rename_with(fixNamesCats, matches ("cap", ignore.case = TRUE)) %>%
  rename_with(tolower, everything())

## The first pivot

?pivot_longer

dataClean <- dataX %>% select(c(Site, Month, matches("_"))) %>%
  rename_with(fixNamesDogs, matches("dag", ignore.case = TRUE)) %>%
  rename_with(fixNamesCats, matches ("cap", ignore.case = TRUE)) %>%
  rename_with(tolower, everything()) %>%
  pivot_longer(matches("_"), values_to = "Count", names_to = "Species") 


## Seperate

dataClean <- dataClean %>% separate_wider_delim("Species", "_", names = c("animal", "number"))
dataClean

## Mutate
# instead of separating dog_1 we could just mutate to get rid of the _

dataX %>% mutate("spp"=gsub("_"," ",spp))

casesdf <- read.table("WMR2022_reported_cases_3.txt",
                      sep="\t",
                      header=T,
                      na.strings=c("")) %>% 
  fill(country) %>% 
  pivot_longer(cols=c(3:14),
               names_to="year",
               values_to="cases") %>%
  pivot_wider(names_from = method,
              values_from = cases)

casesdf <- read.table("WMR2022_reported_cases_3.txt",
                      sep="\t",
                      header=T,
                      na.strings=c("")) %>% 
  fill(country) %>% 
  pivot_longer(cols=c(3:14),
               names_to="year",
               values_to="cases") %>%
  pivot_wider(names_from = method,
              values_from = cases)

## to rename column headings
casesdf <- casesdf %>% rename(c("suspected" = "Suspected cases",
                                "examined" = "Microscopy examined",
                                "positive" = "Microscopy positive"))


## str to help see table structure
str(casesdf)

head(casesdf)

## to remove X from years

casesdf <- casesdf %>% mutate(year=gsub("X","",year))
str(casesdf)

## make the year a numeric vector
casesdf <- casesdf %>% mutate(year=as.numeric(gsub("X","",year)))
str(casesdf)

## to check for typos in chaaracter columns use unique
unique(casesdf$country)
unique(casesdf$suspected)
unique(casesdf$positive)


## getting rid of extra numbers in country column

casesdf<-casesdf %>%
  mutate("country"=gsub("[0-9]","",country)) 

casesdf %>% mutate("suspected"=gsub("[^0-9]","",suspected)) 
casesdf %>% mutate("suspected"=as.numeric(gsub("[^0-9]","",suspected))) 


## making it a function to make clean numbers
clean_number <- function(x) {as.numeric(gsub("[^0-9]","",x))}


## do the same clean number but across other columns

casesdf %>% mutate(across(c(suspected,examined,positive),clean_number))
casesdf %>% mutate(across(!country,clean_number)) 

##make a new column for test posiitivity rounded to 2 sig fig and add to table
casesdf<-casesdf %>% 
  mutate(across(!country,clean_number)) %>%
  mutate(test_positivity = round(positive / examined,2)) 

## Factors are designed for categorical data, effectively a set of integers with names attached. This is more efficient in memory, but also enables us to do some useful things like defining an order for them that is not just alphanumeric.

## convert country to factor
casesdf <- casesdf %>% mutate(country = as.factor(country)) 
levels(casesdf$country)

casesdf <- casesdf %>% 
  mutate(country = gsub("Eritrae",
                        "Eritrea",
                        country)) %>%
  mutate(country = as.factor(country)) 

## Use write.table to output your clean table with the following format:

#plain text
#tab delimited
#with a header line
#no quotation marks
#no row names

write.table(casesdf, "WMR2022_reported_cases_clean.txt",
            sep="\t",
            col.names = T,
            row.names = F,
            quote = F)
sessionInfo()
