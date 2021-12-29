rm(list=ls())

library(OECD)
library(tidyverse)
#a <- get_datasets()

#Average annual hours actually worked per worker

dataset <- "ANHRS"
dstrut <- get_data_structure(dataset)
#str(dstruc, max.level = 1)
#browse_metadata("STLABOUR")
#b <- search_dataset("unemployment", data = a)
# this takes a while cause it lists all datasets, this line is also not really needed
# better to get an overview on the website
#datasets <- get_dataset("STLABOUR")
#head(datasets)

# labor market example for Switzerland
filt <- list(
  c("CHE","DEU","AUT","ITA","FRA","USA"),
  "TE"
#  "A"
)


d <- get_dataset(dataset,filt)
sel <- d %>%
  filter(obsTime >= 2010
         #MEASURE == "STE"
         ) |>
  # let's focus on cols location, time value, because none
  # of the other cols contain information, i.e., all their values
  # are the same

    select(obsTime, COUNTRY, obsValue)

wide_out <- sel %>%
  pivot_wider(names_from = COUNTRY,
              values_from = obsValue)


library(echarts4r)
library(dplyr)

wide_out |>
  e_charts(obsTime) |>
  e_line(CHE) |>
  e_line(DEU) |>
  e_line(AUT) |>
  e_line(ITA) |>
  e_line(FRA) |>
  e_line(USA) |>
  e_tooltip(trigger = "axis")
  