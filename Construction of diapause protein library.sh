
makeblastdb -in OFprotein.fasta -input_type fasta -dbtype prot -parse_seqids -out OFprotein.fa 

blastp -query sequence.fasta -out ofuseq.blast -db OFprotein.fa -outfmt 6 -evalue 1e-5 -num_threads 4

