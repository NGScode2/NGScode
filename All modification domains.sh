#All modification domains
cat stage1_modification_peaks.broadPeak stage2_modification_peaks.broadPeak stage3_modification_peaks.broadPeak > allstage_modification_peaks.broadPeak			
sort -k1,1 -k2,2n allstage_modification_peaks.broadPeak > allstage_modification_peaks_sort.broadPeak
bedtools merge -i allstage_modification_peaks_sort.broadPeak > allstage_modification_peaks.bed

bedtools multicov -bams n_d_k9_deduplicate.bam p_d_k9_deduplicate.bam d_k9_deduplicate.bam In_n_d_deduplicate.bam In_p_d_deduplicate.bam In_d_deduplicate.bam -bed allk9peaks.bed > allk9peaks.count.bed