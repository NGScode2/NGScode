#############Adaptor sequence trimming#######################
trimmomatic PE -threads 16 file_1.fq.gz file_2.fq.gz file_1.clean.fq.gz file_1.unpaired.fq.gz file_2.clean.fq.gz file_2.unpaired.fq.gz ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

############Building a reference genome index using Bismark#######################
bismark_genome_preparation --bowtie2 ofu_genomic

############Aligning methylation data#######################
bismark --bowtie2 -N 0 -L 20 --quiet --un --ambiguous --bam --parallel 30 -o file ofu_genomic -1 file_1.clean.fq.gz -2 file_2.clean.fq.gz 

############Remove duplicates############
deduplicate_bismark -p --bam file.bam -o file.deduplicate

############Extracting methylated sites###########
bismark_methylation_extractor --buffer_size 3G -p --comprehensive --no_overlap -ignore 5 --ignore_r2 5 --bedGraph --counts --cytosine_report --report --genome_folder /mnt/i/ofu/WGBS/ofu_genomic /mnt/i/ofu/WGBS/02.Bam/sortBam/n_d1_n.bam -o /mnt/i/ofu/WGBS/02.Bam/sortBam/bismark_methylation/n_d1

