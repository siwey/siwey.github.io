library(OECD)
library(tidyverse)
library(echarts4r)
rm(list=ls())


df <- get_dataset("LFS_SEXAGE_I_R",
                  filter = list(c("CHE","DEU","FRA","AUT","ITA"),"MW",c("2554"),"EPR"))

sel <- df %>%
  filter(FREQ == "A",
         obsTime >= 2010
         #        MEASURE == "STE"
  ) %>%
  # let's focus on cols location, time value, because none
  # of the other cols contain information, i.e., all their values
  # are the same
  select(obsTime, COUNTRY, obsValue)

wide_out <- sel %>%
  pivot_wider(names_from = COUNTRY,
              values_from = obsValue)

wide_out |>
  e_charts(obsTime) |>
  e_text_style(
    fontSize=16) |>
  e_x_axis(axisLabel=list(rotate=45, fontSize=16)) |>
  e_line(serie = CHE,name="Schweiz") |>
  e_line(serie = DEU, name="Deutschland") |>
  e_line(serie = AUT,name="Oesterreich") |>
  e_line(serie = ITA, name="Italien") |>
  e_line(serie = FRA, name="Frankreich") |>
  # e_format_y_axis(suffix = "%") |>
  e_y_axis(axisLabel=list(rotate=0, fontSize=16)) |>
  #e_format_y_axis(suffix = "%") |>
  #e_labels(fontSize = 4) |>
  e_tooltip(trigger = "axis")
