rm(list=ls())

library(OECD)
library(tidyverse)

# labor market example for Switzerland
dataset <- "STLABOUR"

dstruc <- get_data_structure(dataset)
df <- data.frame(dstruc$SUBJECT$id,dstruc$SUBJECT$label)
#t <- head(dstruc)
#dstruc$MEASURE 
#LRUN55TT LREM55TT
filter_list <- list(c("AUT","ITA","CHE","DEU","FRA"), 'LRUNTTTT', 'STSA', 'A')

de <- get_dataset(dataset,filter=filter_list)

de_plot <- de[de$obsTime>=2000,]
de_plot$obsTime <- as.integer(de_plot$obsTime)

def <- data.frame(
  xVal=de_plot$obsTime,
  yVal=de_plot$obsValue
)

library(ggplot2)

qplot(data = de_plot, x = obsTime, y = obsValue, color = LOCATION, geom = "line") +
  labs(x = NULL, y = "Unemployment rate [%]", color = NULL,
       title = "Unemployment rate 15 years and more")

#ggplot(data=df, aes(x=xVal, y=yVal, group=1)) +
#  geom_line()




