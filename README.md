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

# Blochmanniella Genome assembly
01_minys_blochmannia.sh was used to assemble endosymbiont genome.  

# Blochmanniella pipeline (endosymbiont)
1. Run "00_extract_blochmannia.sh" to extraxct blochmannia reads.
2. Run "01_align_blochmannia.sh" to align blochmannia reads.
3. Run "02_genotyping_blochmannia.sh" to genotype. Note: "--ploidy 1" was used during genotyping.
4. Run "03_merge_blochmannia.sh" to merge all individuals into VCF format 
5. Run "04_filter_blochmannia.sh" to filter SNPs for downstream analyses.

# Analyses

**Population Structure**
1. Run "01_PCA_analysis" to perform Principal component analysis for both host and endosymbiont.
2. Run "02_Admixture.sh" to perform ADMIXTURE analysis.

**Phylogeny of Host**
1. 01_concatenate_vcf_files.sh: Concatenate the vcf files.
2. 02_camp_sp_genome_filtered.fasta.fai: Reference index file
3. 03_phylo_50kbp.r: This creates the tree_50kbp/ directory containing the phylo50kbp_array.sh submission script. Submit "phylo50kbp_array.sh" to array job for running.
4. 04_combine_trees_Camponotus.r: Combine all individual RAxML_bipartitions.tre files into a single file.
5. 05_species_trees.sh: contains script to generate Maximum Clade Credibility tree using DendroPy and a species tree using ASTRAL.

**Phylogeny of endosymbiont**

I used https://github.com/edgardomortiz/vcf2phylip/blob/master/vcf2phylip.py to convert vcf format snps to phylip format and then ran RAxML analysis.

**EEMS**

*Host* 
1. 01_host_vcf2diffs_script.R: Convert vcf filre to .diffs.
2. laevigatus_eems.coord: File with sample coordinates
3. laevigatus_eems.diffs: Genetic distances for eems
4. laevigatus_eems.outer: Outer boundries for EEMS
5. laevigatus_eems.params: Contains parameter for EEMS
6. _run_camplaevi_eems.sh: Slurm array job for EEMS

*Endosymbiont*
1. 01_endosymbiont_vcf2diffs_script.R: Convert vcf filre to .diffs.
2. blochmannia_eems.coord: File with sample coordinates
3. blochmannia_eems.diffs: Genetic distances for eems
4. blochmannia_eems.outer: Outer boundries for EEMS
5. blochmannia_eems.params: Contains parameter for EEMS
6. _run_blochmannia_eems.sh: Slurm array job for EEMS

**Relatedness**
1. 01_concatenate_vcf_files.sh: Concatenate the vcf files.
2. 01b_filter_relatedness.sh: filtering script for relatedness analysis.
3. 02_move_files_convert.sh: convert simple vcf to .related format.
4. 03_plot_kinship-relatedness.r: plotting script for relatedness analsys.
5. vcf_to_related.r: script to convert vcf to related for the analysis.

**GADMA**
1. _01_make_GADMA_input.sh: run --preview and make SFS for GADMA.
2. _02_GADMA_run.sh: contains script to run GADMA.
3. param_easySFS_3_gadma_years101020.txt: parameters used in GADMA




