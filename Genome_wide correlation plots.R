##################################correlation###########################
setwd("I:\\ofu\\WGBS genome")
library(ggplot2)
library(ggpubr)
library(tidyverse)
library(ggpmisc)
library(gridExtra)

date<- read.csv("HistoneModification.csv",header = T ) # 
head(date)


qq1<- ggplot(date,
             aes(x = H3K9me3, y = H3K27me3)) +
  stat_density2d(aes(fill = ..density..^0.25),
                 show.legend = F,
                 geom = "tile",
                 contour = FALSE,
                 nrpoints =200,
                 nbin =200) +
  scale_fill_continuous(low = "white", high = "#00468B") +
  stat_cor() +
  theme_bw(base_size = 16) +
  theme(panel.grid = element_blank(),
        strip.background = element_blank(),
        aspect.ratio = 0.9,plot.title = element_text(hjust = 0.5)) +
 
  xlim(-5,5) + ylim(-5,5) +
  xlab('H3K9me3') +
  ylab('H3K27me3')+ggtitle("stage")
