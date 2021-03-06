rm(list=ls())
setwd("/Users/simonwey/Repos/siwey.github.io/")
library(echarts4r)
library(viridisLite)
library(jsonlite)
library(tidyverse)
library(readxl)
  
xlsx_exa <- read_xlsx("UE_Grossregionen.xlsx",sheet=3)#,range ="" "B36:cv43")
#xlsx_exa <- read_excel("https://www.bfs.admin.ch/bfsstatic/dam/assets/18784196/master",range = "A3:EI11")
xlsx_exa <- xlsx_exa[9:15,]
#xlsx_exa <- xlsx_exa[-1,]
names(xlsx_exa)[1] <- c("Regions")
  
d <- data.frame(
  name=xlsx_exa$Regions,
  values=xlsx_exa$...12
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
                  list(min = 7.1,max=8.0, label="7-8 %"),
                  list(min = 6.1,max=7.0,label="6-7 %"),
                  list(min = 4.1, max = 5.0,label="4-5 %"),
                  list(min = 3.1, max = 4.0,label="3-4 %"),
                  list(min = 2.0, max = 3.0,label="2-3 %")
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
  e_theme("infographic") # chalk, essos, auritus, red,mint, inspired, helianthus, grey,dark-digerati, carp