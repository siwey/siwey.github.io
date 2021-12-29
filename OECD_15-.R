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
  "LRUNTTTT",
  "STSA"
#  "A"
)
d <- get_dataset(dataset,filt)
sel <- d %>%
  filter(FREQUENCY == "A",
         obsTime >= 2010
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
  e_text_style(
    fontSize=16) |>
  e_x_axis(axisLabel=list(rotate=45, fontSize=16)) |>
  e_y_axis(max=13) |>
  e_bar(serie = CHE,name="Schweiz") |>
  e_line(serie = DEU, name="Deutschland") |>
  e_line(serie = AUT,name="Oesterreich") |>
  e_line(serie = ITA, name="Italien") |>
  e_line(serie = FRA, name="Frankreich") |>
 # e_format_y_axis(suffix = "%") |>
  e_y_axis(axisLabel=list(rotate=0, fontSize=16)) |>
  e_axis_labels(
    x = "",
    y = "[%]"
  ) |>
  #e_format_y_axis(suffix = "%") |>
    #e_labels(fontSize = 4) |>
  e_tooltip(trigger = "axis")

