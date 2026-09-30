#!/bin/sh
#SBATCH --chdir=./
#SBATCH --job-name=heterozygosity
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --partition=nocona
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=32G


module load gcc/10.1.0
module load r/4.3.0
R

cd /lustre/scratch/sboyane/camptexa/08_OH

#Rscript calculate_heterozygosity.r

Rscript calculate_het_per_ind.R
