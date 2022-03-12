#### This script is for TidyTuesday 2022-03-08 ####
#### Created by: Vivian Vy Le ####
#### Updated on: 2022-03-10 ####

#### Load libraries ####
library(tidyverse)
library(here)
library(palettetown)
library(ggplot2)
library(ggthemes)

#### Load data ####
erasmus <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-03-08/erasmus.csv')

#### view data ####
glimpse(erasmus)
view(erasmus)

#### data analysis ####
french_participants_data <-erasmus %>%
  select(receiving_country_code, participants, participant_age, participant_gender, academic_year) %>%
  filter(receiving_country_code == "FR",
         participant_age < 40,
         participant_age > 16) %>%
  rename(country = receiving_country_code)
view(french_participants_data)

#### plotting data ####
french_participants_data %>%
  ggplot(aes(x = participant_gender, y = participant_age)) +
  geom_boxplot() +
  labs(title = "Students in Erasmus Program in France From 2014-2020",
       subtitle = "Students of Ages between 16 and 40",
       x = "Gender",
       y = "Age in Years",
       caption = "TidyTuesday of Week 2022-03-08") +
  scale_color_manual(values = pokepal(50)) +
  facet_wrap(~academic_year)
