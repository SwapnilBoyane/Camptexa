#!/bin/sh
#SBATCH --chdir=./
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --mem-per-cpu=32G
#SBATCH --partition=quanah
#SBATCH --time=48:00:00
#SBATCH --job-name=easysfs

cd /lustre/scratch/sboyane/camptexa/09_gadma

source activate easySFS

# run easySFS, first in preview mode then for real based on the preview

~/easySFS/easySFS.py \
  -i camptexa_gadma_biallelic.vcf \
  -p popmap_gadma.txt \
  -o easysfs_out_new \
  -a --proj=4, 10, 20 --total-length 196670629
