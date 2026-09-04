#!/bin/sh
#SBATCH --chdir=./
#SBATCH --job-name=phylo
#SBATCH --nodes=1 --ntasks=2
#SBATCH --partition=nocona
#SBATCH --time=48:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --array=1
#-965

#load modules
module load intel bcftools
module load gcc/10.1.0
module load r/4.3.0
R

# Set the number of runs that each SLURM task should do
PER_TASK=7

# Calculate the starting and ending values for this task based
# on the SLURM task and the number of runs per task.
START_NUM=$(( ($SLURM_ARRAY_TASK_ID - 1) * $PER_TASK + 1 ))
END_NUM=$(( $SLURM_ARRAY_TASK_ID * $PER_TASK ))

# Print the task and run range
echo This is task $SLURM_ARRAY_TASK_ID, which will do runs $START_NUM to $END_NUM

# Run the loop of runs for this task.
for (( run=$START_NUM; run<=$END_NUM; run++ )); do
	echo This is SLURM task $SLURM_ARRAY_TASK_ID, run number $run

	chrom_array=$( head -n${run} tree_helper_chrom.txt | tail -n1 )

	start_array=$( head -n${run} tree_helper_start.txt | tail -n1 )

	end_array=$( head -n${run} tree_helper_end.txt | tail -n1 )

	gunzip -cd /lustre/scratch/sboyane/camptexa/08_phylo/scaffold0001.recode.vcf.gz | grep "#" > /lustre/scratch/sboyane/camptexa/08_phylo/windows/${chrom_array}__${start_array}__${end_array}.recode.vcf

	~/anaconda3/bin/tabix /lustre/scratch/sboyane/camptexa/08_phylo/${chrom_array}.recode.vcf.gz ${chrom_array}:${start_array}-${end_array} >> /lustre/scratch/sboyane/camptexa/08_phylo/windows/${chrom_array}__${start_array}__${end_array}.recode.vcf

	~/anaconda3/envs/vcftools/bin/bcftools query -f '%POS\t%REF\t%ALT[\t%GT]\n' /lustre/scratch/sboyane/camptexa/08_phylo/windows/${chrom_array}__${start_array}__${end_array}.recode.vcf > /lustre/scratch/sboyane/camptexa/08_phylo/windows/${chrom_array}__${start_array}__${end_array}.simple.vcf

	Rscript create_fasta.r /lustre/scratch/sboyane/camptexa/08_phylo/windows/${chrom_array}__${start_array}__${end_array}.simple.vcf popmap_phylo.txt

	raxmlHPC-PTHREADS-SSE3 -T 2 -f a -x 50 -m GTRCAT -p 253 -N 100 -s /lustre/scratch/sboyane/camptexa/08_phylo/windows/${chrom_array}__${start_array}__${end_array}.fasta -n ${chrom_array}__${start_array}__${end_array}.tre -w /lustre/scratch/sboyane/camptexa/08_phylo/windows/

	rm /lustre/scratch/sboyane/camptexa/08_phylo/windows/${chrom_array}__${start_array}__${end_array}.recode.vcf
	rm /lustre/scratch/sboyane/camptexa/08_phylo/windows/${chrom_array}__${start_array}__${end_array}.simple.vcf
	rm /lustre/scratch/sboyane/camptexa/08_phylo/windows/${chrom_array}__${start_array}__${end_array}.fasta
	rm /lustre/scratch/sboyane/camptexa/08_phylo/windows/RAxML_bestTree.${chrom_array}__${start_array}__${end_array}.tre
	rm /lustre/scratch/sboyane/camptexa/08_phylo/windows/RAxML_bipartitionsBranchLabels.${chrom_array}__${start_array}__${end_array}.tre
	rm /lustre/scratch/sboyane/camptexa/08_phylo/windows/RAxML_info.${chrom_array}__${start_array}__${end_array}.tre

done
