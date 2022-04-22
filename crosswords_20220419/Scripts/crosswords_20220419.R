#### This script is for TidyTuesday 2022-04-19 ####
#### Created by: Vivian Vy Le ####
#### Updated on: 2022-04-22 ####

#### Load libraries ####
library(tidyverse)
library(here)
library(ggplot2)
library(LaCroixColoR)


#### load data ####
big_dave <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-04-19/big_dave.csv')
times <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-04-19/times.csv')


#### view data ####
view(big_dave)
view(times)


#### data analysis ####
