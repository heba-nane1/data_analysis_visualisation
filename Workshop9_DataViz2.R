library(palmerpenguins)
library(tidyverse)

## Annotating Data Points

# Subset penguins dataframe to the the five heaviest penguins
big_penguins <- penguins %>%
  filter(species == "Gentoo",!is.na(body_mass_g)) %>% 
  arrange(body_mass_g) %>% tail(n = 5L)

# Add a column with names to big_penguins
big_penguins$names <- c("Dwayne", "Hulk", "Giant", "Gwendoline", "Usain")

# Plot all Gentoo penguins and use big_penguins dataframe for labels
penguins %>% filter(species == "Gentoo") %>%
  ggplot(aes(x = body_mass_g, y = flipper_length_mm)) +
  geom_point(aes(colour = flipper_length_mm)) +
  geom_text(
    data = big_penguins,
    mapping = aes(label = names),
    nudge_x = -1.5,
    nudge_y = -0.5,
    colour = "red"
  ) +
  xlim(3900, 6400)

##Highlighting the home islands of Adelie penguins with flipper legnths over 200mm
penguins %>% filter(species == "Adelie") %>%
  ggplot(aes(x = body_mass_g, y = flipper_length_mm)) +
  geom_point() +
  geom_text(
    data = filter(penguins, species == "Adelie" &
                    flipper_length_mm > 200),
    aes(label = island),
    nudge_y = -0.7
  )

## Facets 

# Reading in data
modeltab <- read.table("wmr_modelling.txt",sep="\t",header=T)

# Subsetting to the first half or so for readability
modeltab_short <- head(modeltab, n = 506L)

# Plotting deaths in years 2019-2021 faceted by country
# dir controls direction of wrap
#ncol and nrow chooses number of rows and columns
modeltab_short %>% drop_na() %>% filter(year >2018) %>%
  ggplot(aes(x = year, y = deaths)) +
  geom_col(fill = "firebrick") +
  

#Seperating plots by two categorical variables 
  penguins %>% drop_na() %>% ggplot(aes(x = bill_depth_mm, y = bill_length_mm)) +
  geom_point() +
  facet_grid(sex ~ species)
facet_wrap( ~ country, ncol = 5, dir = "v")


p_plot <- penguins %>% drop_na() %>%
  ggplot(aes(x = bill_depth_mm, y = bill_length_mm)) +
  geom_point()


p_plot + facet_grid(. ~ species)

install.packages("patchwork")
library(patchwork)

##producing some plots
p1 <- penguins %>% drop_na() %>%
  ggplot(aes(x = bill_depth_mm, y = bill_length_mm, colour = species)) +
  geom_point() + facet_grid(. ~ species)

p2 <- penguins %>%  drop_na() %>%
  ggplot(aes(x = flipper_length_mm)) +
  geom_histogram(aes(fill = species), position = "identity")

p3 <- penguins %>% drop_na() %>% 
  ggplot(aes(x = species, y = body_mass_g)) +
  geom_violin(aes(fill = sex))


## stitching plots together use patchwork to make them panels like in figures
p1/(p2+p3)

## only one plot on left and other two stacked on the right
p2 | (p1/p3)

## adding annotations
p1/(p2+p3) + plot_annotation(tag_levels = "a",
                             title = "Plenty of penguin plots")

## aligning plots with the same x or y axis
p_deaths <- modeltab %>% filter(country %in% c("Angola", "Burkina Faso", "Chad")) %>% 
  ggplot(aes(x = year, y = deaths, colour = country)) +
  geom_point() +
  geom_line() +
  xlim(1999,2022)

p_pop <- modeltab %>% filter(country %in% c("Angola", "Burkina Faso", "Chad")) %>% 
  ggplot(aes(x = year, y = population, fill = country)) +
  geom_col(position = "dodge") +
  xlim(1999,2022)

p_deaths/p_pop

## Colours
s_counts <- penguins %>% ggplot(aes(x = species, fill = species)) +
  geom_bar()

s_counts + scale_fill_manual(values = c("yellow2", "magenta", "darkblue"))

install.packages("RColorBrewer")
library(RColorBrewer)
display.brewer.all()

brew_1 <- s_counts + scale_fill_brewer(palette = "Set1")
brew_2 <- s_counts + scale_fill_brewer(palette = "Dark2", direction = -1)

brew_1 + brew_2


## Viridis scales are colour blind friendly so use them in cwk!
viri_1 <- s_counts + scale_fill_viridis_d() #Uses default option viridis
viri_2 <- s_counts + scale_fill_viridis_d(option = "plasma")

viri_1 + viri_2

##continuous colour scales
con_plot_1 <- penguins %>% drop_na() %>%
  ggplot(aes(x = bill_depth_mm, y = bill_length_mm)) +
  geom_point(aes(size = body_mass_g, colour = body_mass_g))

con_plot_2 <- con_plot_1 + scale_colour_viridis_c(option = "magma")

con_plot_1 + con_plot_2

## Giving colours to NA values
penguins %>%
  ggplot(mapping = aes(x = species, y = body_mass_g)) +
  geom_violin(aes(fill = sex)) +
  scale_fill_brewer(palette = "Set2", na.value = "yellow2")

## Themes
con_plot_3 <- con_plot_1 + theme_classic()

con_plot_1 + con_plot_3 + plot_annotation(title = "Default theme on the left, theme_classic() on the right")

## Using 3 elements of a plot, line, text and rect

penguins %>% drop_na() %>%
  ggplot(aes(x = bill_depth_mm, y = bill_length_mm)) +
  geom_point(aes(colour = body_mass_g)) +
  labs(title = "My pretty plot") +
  scale_colour_viridis_c(option = "magma") +
  theme(legend.position = "bottom",
        axis.title.x = element_text(colour = "red", size = 14, hjust = 1),
        axis.title.y = element_blank(),
        axis.line.y = element_line(colour = "cornflowerblue", linewidth = 4),
        axis.text.y = element_text(size = 20, angle = 45),
        panel.background = element_rect(colour = "green", fill = "yellow", linewidth = 10),
        plot.title = element_text(face = "italic",  hjust = 0.5, size = 18))

## Adjusting positions of a legend
penguins %>%  drop_na() %>%
  ggplot(aes(x = flipper_length_mm)) +
  geom_histogram(aes(fill = species), position = "identity") +
  theme(legend.position = "inside",
        legend.position.inside = c(0.9,0.85),
        legend.background = element_blank())
