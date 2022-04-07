#### This script is for TidyTuesday 2022-03-29 ####
#### Created by: Vivian Vy Le ####
#### Updated on: 2022-04-07 ####

#### Load libraries ####
library(tidyverse)
library(here)
library(ggplot2)
library(palettetown)

#### load data ####
sports <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-03-29/sports.csv')

#### view data ####
view(sports)
glimpse(sports)

#### data analysis ####
sports_data <- sports %>%
  select(year, sports, institution_name, state_cd, sum_partic_men, sum_partic_women, exp_men, exp_women, total_exp_menwomen)
view(sports_data)

sports_part <- sports_data %>%
  group_by(year, sports, institution_name, state_cd) %>%
  mutate(partic_total = (sum_partic_men + sum_partic_women)) %>%
  drop_na() %>%
  relocate(partic_total, .after = sum_partic_women)
view(sports_part)

hockey <- sports_part %>%
  filter(sports == "Ice Hockey",
         state_cd == "NY",
         year == 2019) %>%
  drop_na()
view(hockey)


#### plotting data ####
hockey %>%
  ggplot(aes(x = reorder(institution_name, sum_partic_women), y = sum_partic_women)) +
  geom_bar(stat = "identity") +
  labs(title = "Collegiate Atheletes Pariticpating in Ice Hockey in New York",
       subtitle = "Atheletes Participating in 2019",
       x = "Institution",
       y = "Count",
       caption = "Source: TidyTuesday 2022-03-29") +
  scale_fill_viridis_d() +
  coord_flip()
ggsave(here("collegiate_sports_20220329", "Output", "female_hockey_NY.png"), width = 6, height = 5)
