rm(list=ls())

setwd("/Users/simonwey/Repos/Report_Unemploy/")


library(echarts4r)
library(viridisLite)
library(jsonlite)
library(tidyverse)
library(readxl)

xlsx_exa <- read_excel("Arbeitslosenquoten.xlsx",sheet=1)#,range ="" "d19:d44")
xlsx_exa <- xlsx_exa[c(6,10,14,18,22,26,30),c(2,30)]

#xlsx_exa <- xlsx_exa[-1,]
names(xlsx_exa)[1] <- c("Regions")
  
d <- data.frame(
  name=xlsx_exa$Regions,
  values=xlsx_exa$...30
)
  
d$values <- round(as.numeric(d$values),1)
  
d$name[1] <- "Région lémanique"
d$name[7] <- "Ticino"
  
  
json_ch <- jsonlite::read_json(
    "https://raw.githubusercontent.com/mbannert/maps/master/ch_bfs_regions.geojson"
  )
  
d |>
  e_charts(name) |>
  e_map_register("CH", json_ch) |>
  e_map(serie=values, map="CH") |>
  e_text_style(fontSize=16) |>
  e_visual_map(values, 
               show=TRUE, 
               type="piecewise",
                splitList = list(
                  list(min = 3.5, max = 4.0,label="3.5-4.0 %"),
                  list(min = 3.0, max = 3.49,label="3.0-3.5 %"),
                  list(min = 2.5, max = 2.99,label="2.5-3.0 %"),
                  list(min = 2.0, max = 2.49,label="2.0-2.5 %")
                ),
               top = "10%",left = "0%") |>#,min=a,max=b) |>
  e_tooltip(
  formatter = htmlwidgets::JS("
      function(params){
        return('<strong>' + params.name + 
                '</strong><br />Wert: ' + parseFloat((params.value * 10) / 10).toFixed(1) +'%') 
                }
    ")
  ) |>
  e_theme("london") # chalk, essos, auritus, red,mint, inspired, helianthus, grey,dark-digerati, carp