#!/bin/sh
#SBATCH --chdir=./
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --mem-per-cpu=32G
#SBATCH --partition=quanah
#SBATCH --time=48:00:00
#SBATCH --job-name=gadma

cd /lustre/scratch/sboyane/camptexa/09_gadma

#source activate easySFS
source activate gadma_env

# initiaul run
# run preview to finalise --projection
#~/easySFS/easySFS.py -i combined_gadma_camptexa.vcf  -p popmap_gadma.txt --preview

/home/sboyane/anaconda3/envs/gadma_env/bin/gadma -p param_file.txt 

