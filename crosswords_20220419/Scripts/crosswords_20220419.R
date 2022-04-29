#### This script is for TidyTuesday 2022-04-19 ####
#### Created by: Vivian Vy Le ####
#### Updated on: 2022-04-22 ####

#### Load libraries ####
library(tidyverse)
library(here)
library(ggplot2)
library(LaCroixColoR)
library(patchwork)

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
#creating a color palette
pal_b <- lacroix_palette("Berry", 21, type = "continuous")
pal_o <- lacroix_palette("Orange", 21, type = "continuous")

#first plot
p1 <- times_data %>%
  ggplot(aes(x = reorder(answer, n), y = n, fill = answer)) + #reorder the answers so that it is descending
  geom_col() +
  labs(title = "Words Used as Answers Multiple Times in Times Crossword",
       x = "Answers",
       y = "Counts",
       caption = "Source: TidyTuesday for Week 2022-04-19") +
  theme(plot.title = element_text(hjust= 0.5,
                                  size = 10,
                                  face = "bold"),
        axis.title = element_text(face = "bold"),
        panel.background = element_blank()) + #removed the background and grids
  scale_fill_manual(values = pal_b) + #used berry color palette
  coord_flip() +
  guides(fill = FALSE)
ggsave(here("crosswords_20220419", "Output", "times_words.png"), width = 6, height = 5)

#second plot
p2 <-dave_data %>%
  ggplot(aes(x = reorder(answer, n), y = n, fill = answer)) +
  geom_col() +
  labs(title = "Words Used as Answers Multiple Times in Big Dave Crossword",
       x = "Answers",
       y = "Counts",
       caption = "Source: TidyTuesday for Week 2022-04-19") +
  theme(plot.title = element_text(hjust= 0.5,
                                  size = 10,
                                  face = "bold"),
        axis.title = element_text(face = "bold"),
        panel.background = element_blank()) + #remove background and grids
  scale_fill_manual(values = pal_o) + #used orange color palette 
  coord_flip() +
  guides(fill = FALSE)
ggsave(here("crosswords_20220419", "Output", "big_dave_words.png"), width = 6, height = 5)


#patch both plots together, times plot on top of big dave plot
p1/p2
ggsave(here("crosswords_20220419", "Output", "combined_plots.png"), width = 9, height = 10)
