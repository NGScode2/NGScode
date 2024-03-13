
####Constructing stage-specific modification for Fig. 4D-E
nohup bedtools intersect -a stage1_k9_peaks.broadPeak -b stage2_k9_peaks.broadPeak  -v > stage1_k9spe1.bed
nohup bedtools intersect -a stage1_k9spe1.bed -b stage3_k9_peaks.broadPeak  -v > stage1_k9specific.bed

####Constructing non-stage-specific modification for Fig. 4D-E
nohup bedtools intersect -a stage1_k9_peaks.broadPeak -b stage1_k9specific.bed -v > stage1_k9nonspecific.bed
