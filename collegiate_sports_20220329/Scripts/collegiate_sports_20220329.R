#### This script is for TidyTuesday 2022-03-29 ####
#### Created by: Vivian Vy Le ####
#### Updated on: 2022-04-07 ####

#### Load libraries ####
library(tidyverse)
library(here)
library(ggplot2)
library(patchwork)
library(LaCroixColoR)

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
  mutate(partic_total = (sum_partic_men + sum_partic_women)) %>% #added the participation for men and women
  drop_na() %>%
  relocate(partic_total, .after = sum_partic_women) #moving the participation total column to after women participation
view(sports_part)

hockey <- sports_part %>%
  filter(sports == "Ice Hockey", #filter out for hockey hihihi
         state_cd == "NY",
         year == 2019) %>% #filter for one year
  drop_na()
view(hockey)


#### plotting data ####
female_plot <- hockey %>%
  ggplot(aes(x = reorder(institution_name, sum_partic_women), y = sum_partic_women, fill = institution_name)) +
  geom_bar(stat = "identity") +
  labs(title = "Collegiate Ice Hockey in New York",
       subtitle = "Female Atheletes Participating in 2019",
       x = "Institution",
       y = "Count",
       caption = "Source: TidyTuesday 2022-03-29") +
  scale_fill_manual(values = lacroix_palette("CranRaspberry", 21, type = "continuous")) +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        axis.title = element_text(face = "bold")) +
  coord_flip() +
  guides(fill = FALSE)
ggsave(here("collegiate_sports_20220329", "Output", "female_hockey_NY.png"), width = 7, height = 5)


male_plot <- hockey %>%
  ggplot(aes(x = reorder(institution_name, sum_partic_men), y = sum_partic_men, fill = institution_name)) +
  geom_bar(stat = "identity") +
  labs(title = "Collegiate Ice Hockey in New York",
       subtitle = "Male Atheletes Participating in 2019",
       x = "Institution",
       y = "Count",
       caption = "Source: TidyTuesday 2022-03-29") +
  scale_fill_manual(values = lacroix_palette("MelonPomelo", 21, type = "continuous")) + #chose a different color palette
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        axis.title = element_text(face = "bold")) +
  coord_flip() +
  guides(fill = FALSE)
ggsave(here("collegiate_sports_20220329", "Output", "male_hockey_NY.png"), width = 7, height = 5)

female_plot/male_plot #patching the plots together
ggsave(here("collegiate_sports_20220329", "Output", "ice_hockey_NY.png"), width = 7, height = 5)
