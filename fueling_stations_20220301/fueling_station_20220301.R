#### This script is for TidyTuesday 2022-03-01 ####
#### Created by: Vivian Vy Le ####
#### Updated on: 2022-03-01 ####

#### load libraries ####
library(tidyverse)
library(here)
library(palettetown)
library(ggplot2)
library(ggthemes)

#### load data ####
stations <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-03-01/stations.csv')
mapdata<-map_data("state", region = "california")

#### view data ####
view(stations)

#### data analysis ####
fuel_data <-stations %>%
  filter(STATE == "CA") %>%
  select(CITY, LATITUDE, LONGITUDE, FUEL_TYPE_CODE)
view(fuel_data)

### plotting and mapping data ###
ca_map<-ggplot() +
  geom_polygon(data = mapdata, 
               aes(x = long, y = lat),
               fill = "grey",
               color = "black") + 
  geom_point(data = fuel_data,
             aes(x = LONGITUDE,
                 y = LATITUDE,
                 color = FUEL_TYPE_CODE)) +
  labs(title = "Varying Fuel Types Offered Throughout California",
       x = "Longitude",
       y = "Latitude",
       caption = "Source: TidyTuesday 2022-03-01",
       color = "Fuel Type Code") +
  theme(plot.title = element_text(hjust = 0.5),plot.subtitle = (element_text(hjust =0.5)),
        axis.text = element_text(size = 10)) +
  scale_color_manual(values = pokepal(6))


