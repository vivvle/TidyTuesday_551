#### This script is for TidyTuesday 2022-03-08 ####
#### Created by: Vivian Vy Le ####
#### Updated on: 2022-03-11 ####

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

#### data analysis ####
french_participants_data <-erasmus %>%
  select(receiving_country_code, participants, participant_age, participant_gender, academic_year) %>% #picking out columns
  filter(receiving_country_code == "FR", #filtering the country code to France
         participant_age < 40, #filtering out participants to be under 40yo, there are multiple ages above 100?!?
         participant_age > 16) %>% #filtering out participants to be over 16, again there are negative ages?!?
  rename(country = receiving_country_code) #renaming the columns to be country, easier to reference back
view(french_participants_data)

#### plotting data ####
french_participants_data %>%
  ggplot(aes(x = participant_gender, y = participant_age)) +
  geom_boxplot(aes(fill = participant_gender)) + #filling the box plot by gender
  labs(title = "Students in Erasmus Program Going to France From 2014-2020",
       subtitle = "Students of Ages between 16 and 40",
       x = "Gender",
       y = "Age in Years",
       fill = "Gender",
       caption = "TidyTuesday of Week 2022-03-08") +
  scale_fill_manual(values = pokepal(151)) + #using mew as a color palette for the boxplot
  theme(plot.title = element_text(hjust = 0.5),
        axis.title = element_text(face = "bold"), #change the axis titles to be bold
        axis.text = element_text(size = 10),
        axis.text.x = element_text(color = "#000000", #change the color of the x labels
                                   angle = 90), #change the angle of the text
        axis.text.y = element_text(color = "#000000"),
        plot.subtitle = element_text(hjust = 0.5)) +
  facet_wrap(~academic_year) #allows to look at all academic years from the data
ggsave(here("student_mobility_20220308", "Output","erasmus_france.png"), width = 6, height = 5)
