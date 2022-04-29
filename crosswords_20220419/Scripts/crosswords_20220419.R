#### This script is for TidyTuesday 2022-04-19 ####
#### Created by: Vivian Vy Le ####
#### Updated on: 2022-04-22 ####

#### Load libraries ####
library(tidyverse)
library(here)
library(ggplot2)
library(LaCroixColoR)


#### load data ####
big_dave <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-04-19/big_dave.csv')
times <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-04-19/times.csv')


#### view data ####
view(big_dave)
view(times)


#### data analysis ####
times_data <- times %>%
  filter(!is.na(answer)) %>% #filtering out na's from data
  mutate(answer = str_to_lower(answer)) %>% #changed words to lower case
  count(answer, sort=TRUE) %>% #counting answers
  mutate(answer = factor(answer)) %>% #changing characters to factors
  filter(n > 25)
view(times_data)

dave_data <- big_dave %>%
  filter(!is.na(answer)) %>% #filtering out na's from data 
  mutate(answer = str_to_lower(answer)) %>% #changed words to lower case
  count(answer, sort = TRUE) %>% #counting answers
  mutate(answer = factor(answer)) %>% #changing characters to factors
  filter(n > 58) 
view(dave_data)


#### plotting data 
pal_b <- lacroix_palette("Berry", 21, type = "continuous")
pal_o <- lacroix_palette("Orange", 21, type = "continuous")


p1 <- times_data %>%
  ggplot(aes(x = reorder(answer, n), y = n, fill = answer)) +
  geom_col() +
  labs(title = "Words Used as Answers Multiple Times in Times Crossword",
       x = "Answers",
       y = "Counts",
       caption = "Source: TidyTuesday for Week 2022-04-19") +
  theme(plot.title = element_text(hjust= 0.5,
                                  size = 10),
        axis.title = element_text(face = "bold")) +
  scale_fill_manual(values = pal_b) +
  coord_flip() +
  guides(fill = FALSE)

