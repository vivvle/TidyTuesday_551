#### This script is for TidyTuesday 2022-03-01 ####
#### Created by: Vivian Vy Le ####
#### Updated on: 2022-03-02 ####

#### load libraries ####
library(tidyverse)
library(here)
library(palettetown)
library(ggplot2)
library(ggthemes)

#### load data ####
stations <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-03-01/stations.csv')
mapdata<-map_data("state", region = "california") #using mapdata for the shape of California

#### view data ####
view(stations)

#### data analysis ####
fuel_data <-stations %>%
  filter(STATE == "CA", #filtering out for only stations in CA
         FUEL_TYPE_CODE != "ELEC") %>% #filtering out anything that is not electric
  select(LATITUDE, LONGITUDE, FUEL_TYPE_CODE, CITY, ZIP)
view(fuel_data)

### plotting and mapping data ###
ggplot() +
  geom_polygon(data = mapdata, #using the shape of CA
               aes(x = long, y = lat),
               fill = "grey", #fills inside the shape as grey
               color = "black") + #outlines the shape with a black border
  geom_point(data = fuel_data,
             aes(x = LONGITUDE,
                 y = LATITUDE,
                 color = FUEL_TYPE_CODE)) + #dots are color coded by fuel type
  coord_fixed(1.3) +
  labs(title = "Non-Electric Fuel Types Offered Throughout California",
       x = "Longitude",
       y = "Latitude",
       caption = "Source: TidyTuesday of Week 2022-03-01",
       color = "Fuel Type Code") +
  theme(plot.title = element_text(hjust = 0.5), #centers the title
        axis.text = element_text(size = 10)) + #changes the size of the axis titles
  scale_color_manual(values = pokepal(6)) #manually sets the colors of the dots
ggsave(here("fueling_stations_20220301", "Output", "NonElectric_Fuel.png"), width = 6, height = 5)


### plotting data with electric fuel ###
elec_data <-stations %>%
  filter(STATE == "CA", #filtering for only stations in CA
         ZIP > "90000") %>% #extra filtering for only CA, there are some points that are outside of CA but labelled as such
  select(LATITUDE, LONGITUDE, FUEL_TYPE_CODE, CITY, ZIP)
view(elec_data)

ggplot() +
  geom_polygon(data = mapdata, 
               aes(x = long, y = lat),
               fill = "grey",
               color = "black") + 
  geom_point(data = elec_data,
             aes(x = LONGITUDE,
                 y = LATITUDE,
                 color = FUEL_TYPE_CODE)) +
  coord_fixed(1.3) +
  labs(title = "Varying Fuel Types Offered Throughout California",
                         x = "Longitude",
                         y = "Latitude",
                         caption = "Source: TidyTuesday of Week 2022-03-01",
                         color = "Fuel Type Code") +
  theme(plot.title = element_text(hjust = 0.5),plot.subtitle = (element_text(hjust =0.5)),
        axis.text = element_text(size = 10)) +
  scale_color_manual(values = pokepal(155)) #choosing a different color to differeniate the two different maps
ggsave(here("fueling_stations_20220301", "Output", "all_fuel_types.png"), width = 6, height = 5)
