#!/bin/bash
#SBATCH --chdir=./
#SBATCH --job-name=pca
#SBATCH --partition=nocona
#SBATCH --nodes=1 --ntasks=8
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=16G


#mkdir /lustre/scratch/sboyane/camplaevi/05_filtered_vcf/20kbp_pca
cd /lustre/scratch/sboyane/camptexa/05_filtered_vcf

grep "#" scaffold0001.recode.vcf > pca_camptexa_20kbp.all.vcf

for i in $( ls *recode.vcf ); do
grep -v "#" $i >> pca_camptexa_20kbp.all.vcf;
done


#PCA for Host 
~/anaconda3/bin/plink --vcf pca_camptexa_20kbp.all.vcf --allow-extra-chr --double-id --set-missing-var-ids @:# --pca --out pca_20kbp_camptexa 

#PCA for Endosymbiont
cd /lustre/scratch/sboyane/camptexa/01_blochmannia/05_filtered_vcf
 
~/anaconda3/bin/plink --vcf bloch_camptexa_final.recode.vcf  --allow-extra-chr --double-id --set-missing-var-ids @:# --pca --out pca_camptexa_bloch


