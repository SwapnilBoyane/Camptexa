#!/bin/sh
#SBATCH --chdir=./
#SBATCH --job-name=filter
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --partition=nocona
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G

export PATH=~/bcftools/usr/local/bin:$PATH
source activate vcftools

# define main working directory\
workdir=/lustre/scratch/sboyane/camptexa/01_blochmannia

# run bcftools to merge the vcf files\
#run vcftools with SNP output spaced 20kbp\
#for PCA, EEMS, IBD \
#Filter 1 (in 04_vcf folder)\

vcftools --vcf ${workdir}/04_vcf/blochmannia_camptexa.vcf --keep keeplist_ingroup.txt  --max-missing 1.0  --min-alleles 2 --max-alleles 2  --max-maf 0.49 \
 --recode --recode-INFO-all --out ${workdir}/05_filtered_vcf/bloch_camptexa_final_no_OG

## for phylogeny
vcftools --vcf ${workdir}/04_vcf/blochmannia_camptexa.vcf  --max-missing 0.7  --max-alleles 2  --max-maf 0.49  --recode --recode-INFO-all --out ${workdir}/05_filtered_vcf/blochmannia_camptexa_final
/home/sboyane/anaconda3/bin/bgzip ${workdir}/05_filtered_vcf/blochmannia_camptexa_final.vcf
/home/sboyane/anaconda3/bin/tabix ${workdir}/05_filtered_vcf/blochmannia_camptexa_final.vcf.gz
