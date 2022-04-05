#### This script is for TidyTuesday 2022-03-29 ####
#### Created by: Vivian Vy Le ####
#### Updated on: 2022-04-04 ####

#### Load libraries ####
library(tidyverse)
library(here)
library(ggplot2)

#### load data ####
sports <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-03-29/sports.csv')

#### view data ####
view(sports)
glimpse(sports)

#### data analysis ####
sports_data <- sports %>%
  select(year, sports, sum_partic_men, sum_partic_women, exp_men, exp_women, total_exp_menwomen)
view(sports_data)

sports_part <- sports_data %>%
  group_by(year, sports) %>%
  mutate(partic_total = (sum_partic_men + sum_partic_women)) %>%
  drop_na() %>%
  relocate(partic_total, .after = sum_partic_women)
view(sports_part)

#### plotting data ####
