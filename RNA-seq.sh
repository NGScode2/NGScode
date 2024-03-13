#RNA-seq

hisat2-build -p 4 ofu.fa ofu
hisat2 -p 4 -x ofu -1 simple_1.clean.fq.gz -2 simple_2.clean.fq.gz -S simple.sam &

for i in *.sam
do 
samtools view -@4 -b ${i} > ${i%.sam}.bam
done

for i in *.sorted.bam
do 
samtools index ${i}
done

for i in *.sorted.bam
	do
	/home/sinxlook/software/subread-2.0.2-Linux-x86_64/bin/featureCounts  -p -T 6 -t exon -g gene_id -a /mnt/i/ofu/CHIP/Genome/OF_genomic.gtf -o ${i%.clean.fq.pos.sorted.bam}_counts.txt  ${i}
	done
