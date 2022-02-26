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
  filter(country == "United Kingdom of Great Britain and Northern Ireland") %>% #filtering the list to narrow down to UK
  rename("Civil_Liberties" = CL, "Political_rights" = PR) %>% #renaming the titles of the columns 
  pivot_longer(cols= Civil_Liberties:Political_rights, #pivoting the two columns to make it longer
               names_to = "Variables",
               values_to = "Values") %>%
  select(country, year, Variables, Values) #selecting some of the columns so that the dataset is easier to look at
view(freedom_uk)

#### plotting the data ####
freedom_uk %>%
  ggplot(aes(x = year, y = Values, color = Values)) +
  geom_point() + #shows the data points on the plot
  geom_line() + #geom line helps connects the data points together
  facet_wrap(~Variables) + #facet because we are using more than 2 y variables
  labs(title = "Ratings of Civil Liberties and Political Rights in the Past 25 Years",
       subtitle = "Rating Asseessments from United Kingdom",
       caption = "Source: TidyTuesday of Week 2022-02-22",
       x = "Year",
       y = "Values") +
  theme(plot.title = element_text(hjust = 0.5),plot.subtitle = (element_text(hjust =0.5)),
        axis.text = element_text(size = 10)) + #centering the title and subtitle
  theme_minimal()+ #using a minimal theme to remove the gridded background
  scale_color_viridis_b() #using a color palette that works for continous data
ggsave(here("freedom_20220222","Output","Civil_Liberties_and_Political_Rights_in_UK.png"), width = 7, height = 6)
