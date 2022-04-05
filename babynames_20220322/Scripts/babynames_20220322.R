#### This script is for TidyTuesday 2022-03-22 ####
#### Created by: Vivian Vy Le ####
#### Updated on: 2022-04-04 ####

#### Load libraries ####
library(tidyverse)
library(here)
library(ggplot2)
library(LaCroixColoR)


#### load data ####
babynames <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-03-22/babynames.csv')

#### view data ####
view(babynames)

#### data anaylsis ####
at1990 <- babynames %>%
  filter(year == 1990, #filter to a specific year
         n > 10) #filter for names used more than 10 times
view(at1990)

popular_f <- at1990 %>%
  filter(n > 10000, #filter for the most popular names
         sex == "F") #filter for only female names, narrowed it down to n = 31
view(popular_f)


#### plotting data ####
popular_f %>%
  ggplot() +
  geom_bar(aes(x = reorder(name, n), y = n, fill = name), stat = "identity") + #reorder the graph so that the values reflect descending data
  labs(title = "Popular Names for Female Babies in 1990",
       x = "Names",
       y = "Counts",
       caption = "Source: TidyTuesday for Week 2022-03-22") +
  theme(plot.title = element_text(hjust = 0.5),
        axis.title = element_text(face = "bold"),
        axis.text = element_text(size = 8), #change the size of the text so that the words are not overlapping each other
        axis.text.x = element_text(color = "#000000"), #change the color of the title texts to black so that it is easier to read
        axis.text.y = element_text(color = "#000000"),
        panel.grid.major.y = element_blank()) + #only shows the major grid lines on the graph
  scale_fill_manual(values = lacroix_palette("PassionFruit", n = 31, type = "continuous")) + 
  coord_flip() +
  guides(fill = FALSE)
ggsave(here("babynames_20220322", "Output", "female_babynames.png"), width = 6, height = 5)
