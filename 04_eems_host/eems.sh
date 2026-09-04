#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=eems
#SBATCH --partition nocona
#SBATCH --nodes=1 --ntasks=8
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=16G
#SBATCH --array=1-20
#SBATCH --output=slurm-%A_%a.out

source activate eems

cd /lustre/scratch/sboyane/camptexa/eems

PARAMS_FILE="eems_run${SLURM_ARRAY_TASK_ID}.params"

# Unique seed per run (avoids all chains starting from the same MCMC seed)
SEED=$((1000 + SLURM_ARRAY_TASK_ID))

/lustre/work/sboyane/eems/runeems_snps/src/runeems_snps --params "$PARAMS_FILE" --seed "$SEED"
