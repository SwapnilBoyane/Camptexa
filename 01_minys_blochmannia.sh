#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=minys1
#SBATCH --partition=nocona
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --time=48:00:00
#SBATCH --mem=8G
#SBATCH --array=1-14

source activate minys

# define main working directory #Sets the main directory where input files are stored
workdir=/lustre/scratch/sboyane/camptexa

#define file for array job  #Reads the nth line (matching SLURM_ARRAY_TASK_ID) from basenames.txt
basename_array=$( head -n${SLURM_ARRAY_TASK_ID} ${workdir}/basenames_minys.txt | tail -n1 )


# Run MinYS
~/anaconda3/bin/MinYS.py \
    -1 ${workdir}/00_fastq/${basename_array}_R1.fastq.gz \
    -2 ${workdir}/00_fastq/${basename_array}_R2.fastq.gz \
    -ref /lustre/work/sboyane/ref/bloch/C145_quercicola.fasta \
    -out ${workdir}/01_blochmannia/01_minys/${basename_array} \
    -nb-cores 12

