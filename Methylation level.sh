


computeMatrix scale-regions -p 4 -R Genome.Chr.gene.bed -S CpG_n_d.bed.bw CpG_p_d.bed.bw CpG_d.bed.bw -b 2000 -a 2000 --regionBodyLength 3000 --binSize 50 --skipZeros -o mC_all_bs501.gz --outFileNameMatrix mC_all_bs50.tab			
plotProfile -m mC_all_bs501.gz -out mC_all_bs501.pdf --perGroup --plotHeight 8 --plotWidth 8 --colors blue orange green purple
