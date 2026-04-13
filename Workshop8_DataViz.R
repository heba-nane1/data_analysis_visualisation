install.packages("palmerpenguins")
install.packages("tidyverse")
library(palmerpenguins)
library(tidyverse)

head(penguins)


## a plot looking at a correlation between body mass and bill length
ggplot(data = penguins) +
  geom_point(mapping = aes(x = bill_length_mm, y = body_mass_g))

## adding species as a colour
ggplot(data = penguins) +
  geom_point(mapping = aes(x = bill_length_mm, y = body_mass_g, colour = species))

## adding in island to see if there is also a correlation
ggplot(data = penguins) +
  geom_point(mapping = aes(x = bill_length_mm, y = body_mass_g, colour = island))

## add additional layers by specifying additional geoms
ggplot(data = penguins) +
  geom_point(mapping = aes(x = bill_length_mm, y = body_mass_g)) +
  geom_smooth(mapping = aes(x = bill_length_mm, y = body_mass_g))

## tidier version of this code !!! use in cwk
ggplot(data = penguins, mapping = aes(x = bill_length_mm, y = body_mass_g)) +
  geom_point() +
  geom_smooth()

ggplot(data = penguins, mapping = aes(x = bill_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(colour = species)) +
  geom_smooth()


##Giving each species its own fitted curve
ggplot(data = penguins, mapping = aes(x = bill_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(colour = species)) +
  geom_smooth(mapping = aes(colour = species))

# or 

ggplot(data = penguins, mapping = aes(x = bill_length_mm, 
                                      y = body_mass_g, 
                                      colour = species)) +
  geom_point() +
  geom_smooth()


## to make it linear
ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(mapping = aes(colour = species, shape = species)) +
  geom_smooth(mapping = aes(colour = species),
              method = "lm",
              se = FALSE)

## saving plots using ggsave

ggplot(data = penguins,
       mapping = aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(mapping = aes(colour = species, shape = species)) +
  geom_smooth(mapping = aes(colour = species),
              method = "lm",
              se = FALSE)

ggsave("penguin_plot_3.png",width=300,height=200,units="mm")

ggplot(data = penguins,
       mapping = aes(x = species, y = body_mass_g)) +
  geom_boxplot(mapping = aes(colour = species))

##to fill the boxes in
ggplot(data = penguins,
       mapping = aes(x = species, y = body_mass_g)) +
  geom_boxplot(mapping = aes(fill = species))

## Categorical variables that have a defined and known set of values, for example the three species in penguins, can be defined as factors. Factors have levels which are essentially rank positions for each unique value. By default, levels are in alphanumerical order, that’s why the three species appear in alphabetical order in the plot above.
df_days <-
  data.frame(day = c("Mon", "Tues", "Wed", "Thu"),
             counts = c(3, 8, 10, 5))
df_days$day <- as.factor(df_days$day)
str(df_days)

ggplot(data = df_days, mapping = aes(x = day, y = counts)) +
  geom_col()
df_days$day <- factor(df_days$day, levels = c("Mon", "Tues", "Wed", "Thu"))
str(df_days)

## changing order from alphabetical to normal
ggplot(data = df_days, mapping = aes(x = day, y = counts)) +
  geom_col()

# Make copy of dataset and change factor levels of species
penguins_2 <- penguins
penguins_2$species <-
  factor(penguins_2$species, levels = c("Chinstrap", "Gentoo", "Adelie"))

ggplot(data = penguins_2,
       mapping = aes(x = species, y = body_mass_g)) +
  geom_violin(mapping = aes(fill = island))


ggplot(data = penguins) +
  geom_bar(mapping = aes(x = species)) +
  coord_flip()

## geom_bar() → counts data for you, geom_col() → uses precomputed values you supply, coord_flip() Swaps the x and y axes.
penguins %>% filter(!species == "Chinstrap") %>%
  ggplot(mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point(mapping = aes(colour = species, shape = island))

penguins %>% # filter(!is.na(sex)) %>% 
  ggplot(mapping = aes(x = species, y = body_mass_g)) +
  geom_violin(aes(fill = sex))

## arrange() which allows you to sort rows by values in one or more columns.

## Adding labels 
penguins %>%
  ggplot(mapping = aes(x = species, y = body_mass_g)) +
  geom_violin(aes(fill = sex)) +
  labs(title = "Weight distribution among penguins",
       subtitle = "Gentoo penguins are the heaviest",
       x = "Species",
       y = "Weight in g",
       fill = "Sex",
       caption = "Data from Palmer Penguins package\nhttps://allisonhorst.github.io/palmerpenguins/"
  )

## changing colours
penguins %>%
  ggplot(mapping = aes(x = species, y = body_mass_g)) +
  geom_violin(aes(fill = sex)) +
  labs(title = "Weight distribution among penguins",
       subtitle = "Gentoo penguins are the heaviest",
       x = "Species",
       y = "Weight in g",
       caption = "Data from Palmer Penguins package\nhttps://allisonhorst.github.io/palmerpenguins/"
  ) +
  scale_fill_discrete(name = "Sex", # the legend title can be changed here or in labs()
                      labels = c("Female", "Male", "Unknown"),
                      type = c("yellow3", "magenta4", "grey"))


## Example graph using world malaria report
#Reading in file
modeltab <- read.table("wmr_modelling.txt",sep="\t",header=T)

#Filter for 2020 and reorder in deaths order
modeltab20 <- modeltab %>% filter(year == 2020) %>% arrange(deaths)

#Make countries factors in the order of deaths
deathorder20 <- modeltab20$country
modeltab20$country <- factor(modeltab20$country, levels = deathorder20)

#Plot data
ggplot(modeltab20, aes(x = country, y = deaths)) +
  geom_col() +
  coord_flip() +
  labs(title = "Malaria Deaths in 2020")


##editing transparency
ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm)) +
  geom_histogram(aes(fill = species), position = "identity", alpha = 0.5) #change position to "stack" for plot on right

# Solution to QMPlus challenge
# Year needs to be a factor when used as a categorical variable in boxplots

# Make another copy of penguin dataset and set year as factor
penguins_3 <- penguins
penguins_3$year <- as.factor(penguins_3$year)

# Boxplots with jittered data points
ggplot(penguins_3, mapping = aes(x = species, y = body_mass_g, colour = year)) +
  geom_boxplot() +
  geom_point(position = position_jitterdodge()) +
  labs(title = "Penguin weight over the years",
       x = "Species",
       y = "Weight in grams",
       colour = "Year")
