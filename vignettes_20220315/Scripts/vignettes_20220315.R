#### This script is for TidyTuesday 2022-03-15 ####
#### Created by: Vivian Vy Le ####
#### Updated on: 2022-03-15 ####

#### Load libraries ####
library(tidyverse)
library(here)
library(ggplot2)
library(lubridate)

#### Load data ####
bioc <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-03-15/bioc.csv')
cran <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-03-15/cran.csv')

#### view data ####
glimpse(bioc)
glimpse(cran)
view(bioc)
view(cran)

#### data analysis ####
cranpack_rnw <- cran %>%
  select(package, version, rnw) %>%
  filter(package %in% c("pla", "catdata", "HSAUR3", "HSAUR2", "Zelig", "HSAUR"), #picked out the pacakges with the high rnw counts
         rnw != 0) #removes any zero counts for each package
view(cranpack_rnw)

cranpack_rmd <- cran %>%
  select(package, version, rmd) %>%
  filter(package %in% c("fastai", "keras", "canprot", "tigerstats","ggstatsplot"),
         rmd != 0,
         rmd > 10)
view(cranpack_rmd)

#### plotting data ####
#creating a lollipop plot, great for numerical and categorical data
plot1<- cranpack_rnw %>%
  ggplot(aes(x = package,
                   y = rnw)) +
  geom_point(color = "darkgreen", size = 5) + #creates the top of the lollipop, change the dot size
  geom_segment(aes(x = package, #creates the "stem" of the lollipop
                   xend = package, 
                   y = 0, #starts the stem at 0 of the y axis
                   yend = rnw), #end of the stem is the count value for each package
               color = "black",
               size = 1) +
  labs(title = "Commonly used RNW-based vignette packages in CRAN",
       x = "Packages",
       y = "RNW Counts",
       caption = "TidyTuesday for Week 2022-03-15") +
  theme_light() +
  theme(plot.title = element_text(hjust = 0.5),
        axis.title = element_text(face = "bold"), #change the axis titles to be bold
        axis.text = element_text(size = 10),
        axis.text.x = element_text(color = "#000000", #change the color of the x labels
                                   angle = 90), #change the angle of the text
        axis.text.y = element_text(color = "#000000"),
        plot.subtitle = element_text(hjust = 0.5),
        panel.grid.major.x = element_blank())
ggsave(here("vignettes_20220315", "Output", "rnw_counts.png"), width = 6, height = 5)
