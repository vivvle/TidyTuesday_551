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
  rowwise() %>% #looks at rows one at a time, can commute data with it
  mutate(community = str_split(underrepresented_communities, pattern = ", ")) %>% #splitting into a new column
  ungroup() %>% #removes grouping
  unnest(community) #creates a list for all of community
view(communities)

data_communities <- communities %>%
  count(community) %>% #counts the different types in the column
  arrange(desc(n))
view(data_communities)


#### plotting data ####
data_communities %>%
  ggplot() +
  geom_col(aes(x = reorder(community, -n), y = n, fill = community)) +
  labs(title = "Number of News Organizations that Serve Underrepresented Communities",
       subtitle = "Information provided by news organizations or is publicly available",
       x = "Communities",
       y = "Counts",
       caption = "Source: TidyTuesday for Week 2022-04-05") +
  theme(plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5),
        axis.title = element_text(face = "bold"),
        axis.text.x = element_text(size = 8,
                                   angle = 90),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) + 
  scale_fill_manual(values = lacroix_palette("MurePepino", n = 7, type = "continuous")) +
  guides(fill = FALSE)
ggsave(here("digital_pub_20220405", "Output", "community.png"), width = 8, height = 6)
