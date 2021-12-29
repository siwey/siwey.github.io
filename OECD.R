rm(list=ls())

library(OECD)
library(tidyverse)
#a <- get_datasets()
dataset <- "STLABOUR"
#dstrut <- get_data_structure(dataset)
#str(dstruc, max.level = 1)
#browse_metadata("STLABOUR")
#b <- search_dataset("unemployment", data = a)
# this takes a while cause it lists all datasets, this line is also not really needed
# better to get an overview on the website
#datasets <- get_dataset("STLABOUR")
#head(datasets)

# labor market example for Switzerland
filt <- list(
  c("CHE","DEU","AUT","ITA","FRA"),
  "LRUN24TT",
  "STSA"
#  "A"
)
d <- get_dataset(dataset,filt)
sel <- d %>%
  filter(FREQUENCY == "A",
         obsTime >= 2000
 #        MEASURE == "STE"
         ) %>%
  # let's focus on cols location, time value, because none
  # of the other cols contain information, i.e., all their values
  # are the same
  select(obsTime, LOCATION, obsValue)

wide_out <- sel %>%
  pivot_wider(names_from = LOCATION,
              values_from = obsValue)


library(echarts4r)
library(dplyr)

wide_out |>
  e_charts(obsTime) |>
  e_bar(serie = CHE) |>
  e_line(serie = DEU) |>
  e_line(serie = AUT) |>
  e_line(serie = ITA) |>
  e_line(serie = FRA) |>
  e_tooltip(trigger = "axis")
  