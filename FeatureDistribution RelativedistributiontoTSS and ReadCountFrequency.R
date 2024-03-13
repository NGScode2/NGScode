setwd("D:\\CHIP-seq\\202305a")
library(ChIPseeker)
library(GenomicFeatures)
library(ggplot2)
library(ggupset)
library(ggplotify)
library(Vennerable)
library(ggimage)
library(clusterProfiler)
library(GenomeInfoDb)
library(ggVennDiagram)

####
OF_TxDb <- makeTxDbFromGFF("OF_genomic.gtf")

ofu<- getSampleFiles()
head(ofu)

##

options(ChIPseeker.ignore_1st_exon =TRUE)

options( ChIPseeker.ignore_1st_intron =TRUE)

options( ChIPseeker.ignore_downstream=TRUE)

options( ChIPseeker.ignore_promoter_subcategory =TRUE)
peakAnnoList4 <- lapply(ofu, annotatePeak, TxDb=OF_TxDb,
                        tssRegion=c(-3000, 3000),
                        verbose=FALSE,
                        addFlankGeneInfo=TRUE,
                        flankDistance=5000)
A1<- plotDistToTSS(peakAnnoList4)+theme(plot.title = element_text(hjust = 0.6))
ggsave("Relative distribution to TSS.pdf",width = 6,height = 4)
A2<- plotAnnoBar(peakAnnoList4)
ggsave("Feature Distribution.pdf",width = 6,height = 4)
############ #Read Count Frequency
plotPeakProf2(ofu, upstream = rel(0.2), downstream = rel(0.2),
              conf = 0.95, by = "gene", type = "body",
              TxDb = OF_TxDb, facet = "row", nbin = 800)

plotAvgProf2(ofu, TxDb = OF_TxDb, upstream=3000, downstream=3000, conf = 0.95,
             xlab="Genomic Region (5'->3')", ylab = "Read Count Frequency")