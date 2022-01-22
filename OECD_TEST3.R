rm(list=ls())

library(OECD)
library(tidyverse)

# labor market example for Switzerland
dataset <- "STLABOUR"

dstruc <- get_data_structure(dataset)
df <- data.frame(dstruc$SUBJECT$id,dstruc$SUBJECT$label)
#t <- head(dstruc)
#dstruc$MEASURE LREMTT

#LRUN55TT LRUNTTTT
filter_list <- list(c("AUT","ITA","CHE","DEU","FRA"), 'LREMTTTT', 'STSA', 'A')
de <- get_dataset(dataset,filter=filter_list)

sel <- de %>%
  filter(obsTime >= 2010
         #MEASURE == "STE"
  ) |>
  # let's focus on cols location, time value, because none
  # of the other cols contain information, i.e., all their values
  # are the same
  
  select(obsTime, LOCATION, obsValue)

wide_out <- sel %>%
  pivot_wider(names_from = LOCATION,
              values_from = obsValue)

wide_out |>
  e_charts(obsTime) |>
  e_line(CHE, name = "Schweiz",lineStyle=list(width=3.5)) |>
  e_line(DEU, name = "Deutschland",lineStyle=list(width=3.5)) |>
  e_line(AUT, name = "Österreich",lineStyle=list(width=3.5)) |>
  e_line(ITA, name = "Italien") |>
  e_line(FRA, name = "Frankreich") |>
  #e_tooltip(trigger="a
  #e_text_style(fontSize=30) |>
  #e_format_x_axis(suffix = "%") |>
  e_tooltip(formatter = htmlwidgets::JS("
      function(params){
        return('<strong>' + params.name + 
                '</strong><br />' + 
                parseFloat((params.value[1] * 10) / 10).toFixed(0) +'%') 
                }")
  ) |>
  e_legend(orient = 'horizontal', top = 30) |>
  #e_format_y_axis(suffix="%") |>
  e_axis_stagger() |>
  
  #  formatter = e_axis_formatter(fon)
  #)

  e_x_axis(axisLabel=list(fontSize=20)) |>
  e_y_axis(axisLabel=list(fontSize=20)) |>
  e_format_y_axis(suffix="%") 
  #e_format_y_axis(suffix = "%",axisLabel=list(fontSize=20)) # |>
  #e_y_axis(axisLabel=list(fontSize=20),suffix="%")

