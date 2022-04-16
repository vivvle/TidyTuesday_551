#### This script is for TidyTuesday 2022-04-05 ####
#### Created by: Vivian Vy Le ####
#### Updated on: 2022-04-15 ####

#### Load libraries ####
library(tidyverse)
library(here)
library(ggplot2)
library(patchwork)
library(LaCroixColoR)

#### load data ####
news_orgs <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-04-05/news_orgs.csv')


#### view data ####
view(news_orgs)

#### data analysis ####
newsorgs_clean <- news_orgs %>%
  select(publication_name, year_founded, distribution, coverage_topics, underrepresented_communities, country) %>%
  drop_na() %>%
  filter(country == "United States")
view(newsorgs_clean)

communities <- newsorgs_clean %>%
  rowwise() %>%
  mutate(community = str_split(underrepresented_communities, pattern = ", ")) %>%
  ungroup() %>%
  unnest(community)
view(communities)

data_communities <- communities %>%
  count(community) %>%
  arrange(desc(n))
view(data_communities)


#### plotting data ####
data_communities %>%
  ggplot() +
  geom_col(aes(x = reorder(community, -n), y = n, fill = community)) +
  labs(title = "Number of News Organizations that Serve Underrepresented Communities",
       subtitle = "Data provided by new organizations or publicly available data",
       x = "Communities",
       y = "Counts",
       fill = "Community",
       caption = "Source: TidyTuesday for Week 2022-04-05") +
  theme(axis.text.x = element_text(size = 8,
                                   angle = 90)) +
  guides(fill = FALSE)
