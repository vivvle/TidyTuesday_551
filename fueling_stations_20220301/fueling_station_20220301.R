#### This script is for TidyTuesday 2022-03-01 ####
#### Created by: Vivian Vy Le ####
#### Updated on: 2022-03-01 ####

#### load libraries ####
library(tidyverse)
library(here)
library(palettetown)
library(ggplot2)

#### load data ####
stations <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-03-01/stations.csv')
mapdata<-map_data("usa")

#### view data ####
view(stations)

#### data analysis ####
fuel_data <-stations %>%
  filter(COUNTRY == "US") %>%
  select(X, Y, CITY, FUEL_TYPE_CODE, STATE) %>%
  rename(long = X, lat = Y) %>%
  add_count(FUEL_TYPE_CODE, sort = TRUE)
view(fuel_data)

### plotting data ###
map<-map_data("usa")
fuel_data %>%
  ggplot(aes(fill=FUEL_TYPE_CODE)) +
  geom_polygon(aes(x = long, y = lat, fill = STATE, group = STATE)) + 
  coord_fixed(2.0) +
  guides(fill = "none")
