#!/bin/bash
#source activate deeptools
 tail -n +2 mm10_knownCanonical.txt \
	 | awk 'BEGIN {FS="\t";OFS="\t"};{ 
	  if($5 == "+")
		  print $1, $2, ($2+1), $4;  
	  else if($5 == "-") 
		  print $1, $3, ($3 +1), $4;}' \
	 > mm10_knownCanonical.txt.tss.bed
computeMatrix reference-point \
	--referencePoint center \
	-b 5000 -a 5000 \
	-R mm10_knownCanonical.txt.tss.bed \
	-S *.STAR.genome.sorted.bam.cpm.bw \
	-p "max" \
	-bl mm10.blacklistedRegions.bed \
	--skipZeros -o RNA-seq_tss.gz
plotHeatmap --matrixFile RNA-seq_tss.gz \
	--outFileName RNA-seq_tss.png
