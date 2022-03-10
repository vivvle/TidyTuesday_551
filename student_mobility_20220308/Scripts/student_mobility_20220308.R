#### This script is for TidyTuesday 2022-03-08 ####
#### Created by: Vivian Vy Le ####
#### Updated on: 2022-03-08 ####

#### Load libraries ####
library(tidyverse)
library(here)
library(palettetown)
library(ggplot2)

#### Load data ####
erasmus <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-03-08/erasmus.csv')

#### view data ####
glimpse(erasmus)
view(erasmus)

#### Data analysis ####
erasmus_data <- erasmus %>%
  select(academic_year, participant_gender, participant_age, participant_nationality, sending_country_code, receiving_country_code) %>%
  drop_na() %>%
  filter(participant_age > 16,
         participant_age < 50,
         participant_nationality %in% c("FR","UK","DE","PL","ES", "LT", "IT"))
view(erasmus_data)


#### plot data ####
erasmus_data %>%
  ggplot(aes(x = participant_age,
         y = participant_nationality,
         fill = participant_gender)) +
  geom_bar(stat = "identity", width = .5) +
  theme(axis.ticks = element_blank()) +
  labs(title = "Erasmus Students from Top Countries",
       x = "Age",
       y = "Nationality",
       caption = "Source: TidyTuesday from Week 2022-03-08") +
  coord_flip() +
  scale_fill_manual(values = pokepal(94))