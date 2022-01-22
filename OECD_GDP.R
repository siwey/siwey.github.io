library(OECD)
library(tidyverse)
library(echarts4r)


# labor market example for Switzerland
a <- get_datasets()
dataset <- "GOV_DEBT"

dstruc <- get_data_structure(dataset)
df <- data.frame(dstruc$VAR_DESC$description,dstruc$VAR_DESC$id)
#t <- head(dstruc)
#dstruc$MEASURE LREMTT

#LRUN55TT LRUNTTTT c("AUT","CHE","ITA","DEU","FRA")
filter_list <- list(c("AUT","CHE","ITA","DEU","FRA"),'NET','A','USD','1')
de <- get_dataset(dataset,filter=filter_list)

sel <- de %>%
  filter(obsTime >= 2000
         #MEASURE == "STE"
  ) |>
  # let's focus on cols location, time value, because none
  # of the other cols contain information, i.e., all their values
  # are the same
  
  select(obsTime, COU, obsValue)

wide_out <- sel %>%
  pivot_wider(names_from = COU,
              values_from = obsValue)

wide_out |>
  e_charts(obsTime) |>
  e_text_style(fontSize=18) |>
  e_format_y_axis(suffix="%") |>
  e_x_axis(axisLabel=list(interval=1,rotate=0, fontSize=30)) |>
  e_y_axis(axisLabel=list(rotate=0, fontSize=30)) |>
  e_format_y_axis(suffix="%") |>
  e_line(CHE, name = "Schweiz",lineStyle=list(width=1.5)) |>
  e_line(DEU, name = "Deutschland",lineStyle=list(width=1.5)) |>
  e_line(AUT, name = "Österreich",lineStyle=list(width=1.5)) |>
  e_line(ITA, name = "Italien",lineStyle=list(width=1.5)) |>
  e_line(FRA, name = "Frankreich",lineStyle=list(width=1.5)) |>
  e_tooltip(trigger="axis") |>
  e_legend(orient = 'horizontal', top = 20)
