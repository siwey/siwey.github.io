#rm(list=ls())

library(OECD)
library(tidyverse)
library(echarts4r)
library(webshot2)
webshot::install_phantomjs()

# labor market example for Switzerland
dataset <- "STLABOUR"

#dstruc <- get_data_structure(dataset)
#df <- data.frame(dstruc$SUBJECT$id,dstruc$SUBJECT$label)
#t <- head(dstruc)
#dstruc$MEASURE LREMTT

#LRUN55TT LRUNTTTT
filter_list <- list("CHE",c('LFWA55TT','LFWA24TT','LFEM55TT','LFEM24TT'), 'STSA', 'A')
de <- get_dataset(dataset,filter=filter_list)

sel <- de %>%
  filter(obsTime >= 1900
         #SUBJECT == c("LREM55TT",'LRUNTTTT')
  ) |>

  
  select(obsTime, SUBJECT, obsValue)

wide_out <- sel %>%
  pivot_wider(names_from = SUBJECT,
              values_from = obsValue)
wide_out$LFAC55TT[[1]][1]



wide_out |>
  e_charts(obsTime) |>
  e_text_style(fontSize=10) |>
  e_format_y_axis(suffix="%") |>
  e_x_axis(axisLabel=list(interval=0,rotate=45, fontSize=30)) |>
  e_y_axis(axisLabel=list(rotate=0, fontSize=30)) |>
  e_format_y_axis(suffix="%") |>
  e_line(LFWA55TT, name = "Working age population 55-64 years",showSymbol=FALSE,lineStyle=list(width=3.5,type = "dashed"),color="red") |>
  e_line(LFWA24TT, name = "Working age population 15-24 years",showSymbol=FALSE,lineStyle=list(width=3.5,type = "dashed"),color="green") |>
  e_line(LFEM55TT, name = "Employed population 55-64 years",showSymbol=FALSE,lineStyle=list(width=3.5),color="red") |>
  e_line(LFEM24TT, name = "Employed age population 15-24 years",showSymbol=FALSE,lineStyle=list(width=3.5),color="green") |>
  # e_line(LFEM55TT, name = "Employed population",lineStyle=list(width=3.5)) |>
  #e_tooltip(trigger="axis" |>
  e_tooltip(formatter = htmlwidgets::JS("
      function(params){
        return('<strong>' + params.name + 
                '</strong><br />' + 
                parseFloat((params.value[1] * 10) / 10).toFixed(0) +'%') 
                }")
  ) |>
  e_legend(orient = 'horizontal',type = "plain", top = 5) #|>





