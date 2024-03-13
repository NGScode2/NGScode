#######################################Heatmap for Fig. 3J#####################################
setwd("I:\\ofu\\CHIP\\headmap")
library(ComplexHeatmap)
library(colorspace)
#install.packages("view")
#library(view)
data <- as.matrix(read.csv("heatmap.csv", row.names = 1))
head(data)

stage = c("1" = "#B9534C", "2" = "#00A087E5", "3" = "#3C5488E5", "0" = "gray")

Heatmap(
  data, 
  name = "modification", 
  row_km= 5,
  row_km_repeats = 100,
  cluster_columns = F,
  cluster_rows = T,
  col = stage,
  show_row_names = F,
  show_column_dend = F,
  show_row_dend = F,
  column_names_side = c("top"),
  border = T,
  border_gp = gpar(col = 'black', lwd = 1),
)


hm <- Heatmap(
  data, 
  name = "modification", 
  row_km= 5,
  row_km_repeats = 100,
  cluster_columns = F,
  cluster_rows = T,
  col = stage,
  show_row_names = F,
  show_column_dend = F,
  show_row_dend = F,
  column_names_side = c("top"),
  border = T,
  border_gp = gpar(col = 'black', lwd = 1),
)

dhm <- draw(hm)

options('max.print'=10000)

row_order(dhm)