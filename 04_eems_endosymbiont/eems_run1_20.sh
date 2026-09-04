#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=eems_blochmannia
#SBATCH --partition nocona
#SBATCH --nodes=1 --ntasks=8
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=16G
#SBATCH --array=1-20
#SBATCH --output=slurm-bloch-%A_%a.out

source activate eems

cd /lustre/scratch/sboyane/camptexa/camptexa/01_blochmannia/05_filtered_vcf/eems

# Each array task runs its own params file: eems_run1.params ... eems_run20.params
PARAMS_FILE="eems_run${SLURM_ARRAY_TASK_ID}.params"

# Unique seed per run, offset from the host-genome run's seeds (1001-1020)
# to keep them clearly distinguishable if you ever compare logs side by side
SEED=$((2000 + SLURM_ARRAY_TASK_ID))

/lustre/work/sboyane/eems/runeems_snps/src/runeems_snps --params "$PARAMS_FILE" --seed "$SEED"
