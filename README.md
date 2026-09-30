# Camptexa
#Phylogeography of **Camponotus texanus** and its endosymbiont

# C. texanus pipeline (host)
1. set up directories
2. Run "01_align_host.sh" to align host fastq files.
3. Run "01a_depth.sh" for coverage and "plot_coverage.R" was used to plot covergae of host and endosymbiont genomes.
4. Run "02_genotype_host.sh" to genotype host genomes.
5. Run "02a_genotype_site_per_indivi_host.sh" to conut total genotyped sites.
6. Run "03_merge_vcf_host.sh" to merge all individuals into VCF format 
7. Run "04_filter_host.sh"to filter SNPs for downstream analyses. This script includes filtering scheme for all downstream analyses.

# Blochmanniella genome assembly
01_minys_blochmannia.sh was used to assemble endosymbiont genome.  

# Blochmanniella pipeline (endosymbiont)
1. Run "00_extract_blochmannia.sh" to extraxct blochmannia reads.
2. Run "01_align_blochmannia.sh" to align blochmannia reads.
3. Run "02_genotyping_blochmannia.sh" to genotype. Note: "--ploidy 1" was used during genotyping.
4. Run "03_merge_blochmannia.sh" to merge all individuals into VCF format 
5. Run "04_filter_blochmannia.sh" to filter SNPs for downstream analyses.

# Analyses

**01_population_structure**
1. Run "pca_host_endosymbiont.sh" to perform Principal component analysis for both host and endosymbiont.
2. Run "admixture_host.sh" to perform ADMIXTURE analysis of host.

**02_genetic_diversity**
1. 01_calculate_het_per_ind.R script to calculate observed heterozygosity.
2. _run_heterozygosity.sh submission script.

**03_host_phylogeny**
1. camp_sp_genome_filtered.fasta.fai: Reference genome index file
2. "phylo50kbp_array.sh" phylogeny submission script.
3. "create_fasta_from_vcf.r", "create_fasta.r", "popmap_phylo.txt", "tree_helper_chrom.txt", "tree_helper_end.txt", "tree_helper_start.txt" supporting files for phylo50kbp_array.sh script.
4. combine_trees_Camponotus.r: Combine all individual RAxML_bipartitions.tre files into a single file.
5. species_trees.sh: contains script to generate Maximum Clade Credibility tree using DendroPy and a species tree using ASTRAL.

**Phylogeny of endosymbiont**

I used https://github.com/edgardomortiz/vcf2phylip/blob/master/vcf2phylip.py to convert vcf format snps to phylip format and then ran RAxML analysis.

**04_eems_endosymbiont**

1. 01_endosymbiont_vcf2diffs_script.R: Convert vcf file to .diffs.
2. eems.coord: File with sample coordinates
3. eems.diffs: Genetic distances for eems
4. eems.outer: Outer boundries for eems
5. eems_run1.params to eems_run20.params: Contains parameter for eems 20 runs.
6. eems_run1_20.sh: Slurm array job for eems

**04_eems_host**

1. 01_host_vcf2diffs_script.R: Convert vcf file to .diffs.
2. eems.coord: File with sample coordinates
3. eems.diffs: Genetic distances for eems
4. eems.outer: Outer boundries for eems
5. "eems_run1.params" to "eems_run20.params": Contains parameter for eems 20 runs.
6. eems_run1_20.sh: Slurm array job for eems

**05_demographic_analysis**

1. 01_make_GADMA_input.sh: run --preview and make SFS for GADMA.
2. 02_GADMA_run.sh: contains script to run GADMA.
3. param_file.txt: parameters used in GADMA
4. popmap_gadma.txt: sample id for GADMA
   




