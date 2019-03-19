###Map the reads to the reference genome for sample 01X
bwa aln -n 0.01 -l 100 -o 1 -d 12 -e 12 -t 8 Tcas_reference_5_2.fa Sample_01X_R1.fastq > Sample_01X_R1.sai

bwa aln -n 0.01 -l 100 -o 1 -d 12 -e 12 -t 8 Tcas_reference_5_2.fa Sample_01X_R2.fastq > Sample_01X_R2.sai

bwa sampe Tcas_reference_5_2.fa Sample_01X_R1.sai Sample_01X_R2.sai Sample_01X_R1.fastq Sample_01X_R2.fastq > Sample_01X.sam