########################## KEGG enrichment############################################
rm(list=ls())
setwd("D:\\ofu\\KEGG")

library(ggplot2)
library(tidyverse)
library(clusterProfiler)
library(AnnotationHub)

data = read.csv("file.csv", header = T)
head(data)

hub <- AnnotationHub()
query(hub,"Ostrinia furnacalis")

ofu.OrgDb <- hub[["AH108719"]]

id1=bitr(data$non_diapause, 'SYMBOL', c("ENTREZID"), ofu.OrgDb)
id2=bitr(data$pre_diapause, 'SYMBOL', c("ENTREZID"), ofu.OrgDb)
id3=bitr(data$diapause, 'SYMBOL', c("ENTREZID"), ofu.OrgDb)

C1 <- bitr_kegg(id1$ENTREZID,fromType="ncbi-geneid",
                toType="kegg",organism='ofu')
C2 <- bitr_kegg(id2$ENTREZID,fromType="ncbi-geneid",
                toType="kegg",organism='ofu')
C3 <- bitr_kegg(id3$ENTREZID,fromType="ncbi-geneid",
                toType="kegg",organism='ofu')


Kogene=list("non_diapause"=C1$kegg,
            "pre_diapause"=C2$kegg,
            "diapause"=C3$kegg
            
)

eKEGG <- compareCluster( Kogene,
                         organism="ofu",
                         fun = "enrichKEGG",
                         keyType='kegg',
                         pvalueCutoff=0.05,
                         qvalueCutoff=1,
                         pAdjustMethod = "none",
)

#eKEGGG <- simplify(eKEGG, cutoff=0.7, by="p.adjust", select_fun=min)

dotplot(eKEGG, 
        color='p.adjust',
        showCategory = 5,
        title = " compare GO enrichment ",
        label_format=50)+
  scale_color_gradientn(colours=c("#E64B35", "#4DBBD5"),
                        guide=guide_colorbar(reverse=TRUE, order=1)) +
  guides(size = guide_legend(override.aes=list(shape=1))) +
  theme(panel.grid.major.y = element_line(linetype='dotted', color='#808080'),
        panel.grid.major.x = element_blank(),
        axis.text.x = element_text(angle = 45, hjust = 1))

ggsave("more_nov_gene.pdf",width = 8.5,height = 8)
write.csv(eKEGG,"more_nov_geneKEGG.csv")