#!/bin/bash

#SBATCH --job-name=haplo_puffin	#give jobs a name
#SBATCH --account=ec34		#current project that we are on
#SBATCH --nodes=4		#number of nodes/CPU
#SBATCH --ntasks=4		#how many tasks to run simutanously
#SBATCH --time=24:00:00		#how long the job will go for
#SBATCH --mem=20G		#how much memory

## Set up job environment
set -o errexit 			# Exit script on any error
set -o nounset 		 	# Treat any unset variables as an error

module --quiet purge 		#this resets the module environment, always good to start clean!

#Usually you load a number of modules below
#module load <module name>	#this loads a specific "module" allowing you to run programs installed on the cluster

## DO SOMETHING

##ACCEPT argument
FILENAME=$1

module load BIOS-IN5410/HT-2023
##Make a NEW directory called gvcf.
mkdir -p $SUBMITDIR/gvcf

##RUN HAPLOTYPE CALLER
gatk HaplotypeCaller -R \
/fp/homes01/u01/ec-bendikb/BIOS-IN5410/puffin_PCA/PuffinDataset/Reference/Puffin_ReferenceGenome.NU.MT.FINAL.fasta \
 -L Chr_13 -I $FILENAME --ploidy 2 -O gvcf/$FILENAME.gvcf.gz -ERC GVCF \
2> gvcf/HaploCaller_$FILENAME.out

echo "$FILENAME HaplotypeCalled"

## Message that you are done with the job
echo "Finished running jobs"
