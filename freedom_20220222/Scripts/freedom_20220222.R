#### This script is for TidyTuesday 2022-02-22 ####
#### Created by: Vivian Vy Le ####
#### Updated on: 2022-02-24 ####

#### load libraries ####
library(tidyverse)
library(here)
library(beyonce)

#### load data ####
freedom <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-02-22/freedom.csv')
  
#### view data ####
view(freedom)

### data analysis###
freedom_uk <- freedom %>%
  filter(country == "United Kingdom of Great Britain and Northern Ireland") %>%
  rename("Civil_Liberties" = CL, "Political_rights" = PR) %>%
  pivot_longer(cols= Civil_Liberties:Political_rights,
               names_to = "Variables",
               values_to = "Values") %>%
  select(country, year, Variables, Values)
view(freedom_uk)

#### plotting the data ####
freedom_uk %>%
  ggplot(aes(x = year, y = Values, color = Values)) +
  geom_point() +
  geom_line() +
  facet_wrap(~Variables) +
  labs(title = "Ratings of Civil Liberties and Political Rights in the Past 25 Years",
       subtitle = "Rating Asseessments from United Kingdom",
       caption = "Source: TidyTuesday of Week 2022-02-22",
       x = "Year",
       y = "Values") +
  theme(plot.title = element_text(hjust = 0.5),plot.subtitle = (element_text(hjust =0.5)),
        axis.text = element_text(size = 10)) +
  theme_minimal()+
  scale_color_viridis_b()
ggsave(here("freedom_20220222","Output","Civil_Liberties_and_Political_Rights_in_UK.png"), width = 7, height = 6)
