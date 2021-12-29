rm(list=ls())

setwd("/Users/simonwey/Repos/siwey.github.io/")


library(echarts4r)
library(viridisLite)
library(jsonlite)
library(tidyverse)
library(readxl)

xlsx_exa <- read_excel("ALQ_Kt.xlsx",sheet=1)#,range ="" "d19:d44")
xlsx_exa <- xlsx_exa[4:29,c(1,3)]

stat <- read_excel("Kantons_Abk.xlsx",range ="a2:b27",col_names=FALSE)
stat$...1[4]="Basel-Landschaft"
stat$...1[16]="St. Gallen"
#xlsx_exa <- read_excel("https://www.bfs.admin.ch/bfsstatic/dam/assets/18784196/master",range = "A3:EI11")


names(xlsx_exa)[1] <- c("Cantons")

d <- data.frame(
  name=xlsx_exa$Cantons,
  values=xlsx_exa$...3
)
#d$values <- paste(d$values, "%", sep="")

d$name[25] <- "Genève"
d$name[10] <- "Fribourg"
d$name[24] <- "Neuchâtel"
d$name[22] <- "Vaud"
d$name[23] <- "Valais"
d$name[21] <- "Ticino"


d$name[]

json_ch <- jsonlite::read_json(
  "georef-switzerland-kanton.geojson"
)

d$values <- round(as.numeric(d$values), 3)

a <- 16
b<-0


d |>
  e_charts(name) |>
  e_map_register("CH", json_ch) |>
  e_map(serie=values, map="CH") |>
  #e_visual_map(min=b, max=a,style="percent") |>
  e_visual_map(values, 
               show=TRUE, 
               type="piecewise",
               splitList = list(
                 list(min = 4.1,max=5.0, label="4-5 %"),
                 list(min = 3.1,max=4.0,label="3-4 %"),
                 list(min = 2.1, max = 3.0,label="2-3 %"),
                 list(min = 1.0, max = 2.0,label="1-2 %")
               ),
               top = "10%",left = "0%") |>#,min=a,max=b) |>
  e_tooltip(trigger = "item",style="percent") |>
  e_theme("london")
  
