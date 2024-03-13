rm(list=ls())

library(ggplot2)
library(ggrepel)

setwd("I:\\ofu\\CHIP\\Valcone")
data = read.delim("file.txt", header = T    
)
head(data)

data$threshold = factor(ifelse(data$P_value < 0.05 & abs(data$M_value) >= 0.58, 
                               ifelse(data$M_value>= 0.58 ,'Up','Down'),'NoSignifi'),levels=c('Up','Down','NoSignifi'))
ggplot(data,aes(x=M_value,y=-log10(P_value),color=threshold))+
  geom_point(size=3)+
  scale_color_manual(values=c("#ff4757","#546de5","#d2dae2"))+
  #geom_text_repel(
  #data = data[data$P_value<0.05&abs(data$M_value)>1,],
  #aes(label = geneId),
  # size = 3,
  # segment.color = "black", show.legend = FALSE )+
  theme_bw()+
  theme(
    legend.title = element_blank()
  )+xlim(-3,3) + ylim(0,20) +
  ylab('-log10 (P_value)')+
  xlab('log2 (FoldChange)')+
  geom_vline(xintercept=c(-0.58,0.58),lty=3,col="black",lwd=0.5) +
  geom_hline(yintercept = -log10(0.05),lty=3,col="black",lwd=0.5)

ggsave("file.pdf",width = 10,height = 8)