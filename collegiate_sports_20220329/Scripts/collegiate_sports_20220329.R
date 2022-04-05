#### This script is for TidyTuesday 2022-03-29 ####
#### Created by: Vivian Vy Le ####
#### Updated on: 2022-04-04 ####

#### Load libraries ####
library(tidyverse)
library(here)
library(ggplot2)

#### load data ####
sports <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-03-29/sports.csv')

#### view data ####
view(sports)
