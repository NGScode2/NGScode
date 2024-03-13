############Adaptor sequence trimming#######################
trimmomatic PE -threads 16 file_1.fq.gz file_2.fq.gz file_1.clean.fq.gz file_1.unpaired.fq.gz file_2.clean.fq.gz file_2.unpaired.fq.gz ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

###########Building a reference genome index######################
bowtie2-build dm6.fa dm6

###########Aligning######################
bowtie2 -p 6 -q -x /mnt/e/chipseq/dm6 -1 file_1_clean.fq.gz -2 file_2_clean.fq.gz -S file_clean.sam &
samtools view -@6 -b file_clean.sam > file.bam &

##########Sorting######################
for i in *.bam
do 
samtools sort ${i} -o ${i%.bam}.sorted.bam
done

############Remove duplicates############
ls *sorted.bam |while read id
do 
     picard MarkDuplicates  REMOVE_DUPLICATES=true  I= ${id} O= ${id%sorted.bam}_deduplicate.bam  M= ${id}.log &  
done

###########Building index######################
for i in *.bam
do 
samtools index ${i}
done

###########Callpeak######################
macs2 callpeak -f BAM -c Input_1.deduplicate.bam -t file_1.deduplicate.bam -n file1_input -g dm --outdir /mnt/i/chipseq/peaks --bdg -q 0.05
