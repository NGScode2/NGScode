###################headmap for Fig.2C-E ###################

bamCompare -p 4 --binSize 10 -b1 stage_H3K9me3_deduplicate.bam -b2 stage_input_deduplicate.bam --scaleFactorsMethod readCount --operation log2 -o stage_H3K9me3.bw

computeMatrix reference-point -S stage_H3K9me3.bw stage_H3K27me3.bw -R stage_H3K9me3_peaks.broadPeak stage_H3K27me3_peaks.broadPeak --referencePoint center -a 3000 -b 3000 -p 4 --missingDataAsZero --skipZeros -out d.gz
plotHeatmap -m d.gz -out d10.svg --refPointLabel center --zMin -3 --zMax 3 --plotTitle diapause --colorList  "#4DBBD5,#EDF0F1,#E64B35"

###################headmap for Supplemental Fig. S3A-B ###################
computeMatrix reference-point -S n_d_k27.bw p_d_k27.bw d_k27.bw -R n_d_k27_peaks --referencePoint center -a 3000 -b 3000 -p 4 --missingDataAsZero --skipZeros -out K27n_d-ndvsd.gz
plotHeatmap -m K27n_d-ndvsd.gz -out K27n_d.svg --heatmapHeight 3 --refPointLabel center --regionsLabel gene --plotTitle H3K27me3 --colorList  "#4DBBD5,#EDF0F1,#E64B35"

computeMatrix reference-point -S n_d_k9.bw p_d_k9.bw d_k9.bw -R n_d_k9_peaks --referencePoint center -a 3000 -b 3000 -p 4 --missingDataAsZero --skipZeros -out K9n_d-ndvsd.gz
plotHeatmap -m K9n_d-ndvsd.gz -out K9n_d1.svg --refPointLabel center --regionsLabel gene --plotTitle H3K9me3 --colorList  "#4DBBD5,#EDF0F1,#E64B35"