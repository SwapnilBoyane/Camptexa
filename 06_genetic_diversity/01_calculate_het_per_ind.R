
# List all of the VCF files
vcfs <- list.files(pattern="*simple.vcf")

# list all individual ID 
individual_names <- c(
  "C258", "C259", "C351", "C354", "C357",
  "C360", "C361", "C364", "C367", "C369",
  "C424", "C426", "C428", "C430", "C431",
  "C432")

# Write column headers to 'output.het.txt'
write(
  c(
    "VCF",
    paste0(individual_names, "_total_sites"),
    paste0(individual_names, "_het_sites")
  ),
  file = "camptexa_output.het.txt",
  ncolumns = 33,
  sep = "\t"
)

# loop over each VCF file to calculate total and het sites
for (a in 1:length(vcfs)) { 
  # Vectors for output
  indiv_het_sites <- c()
  indiv_total <- c()
  
  # Read the VCF file
  vcf_file <- read.table(vcfs[a], stringsAsFactors = FALSE)
  
  # Extract only genotype columns
  vcf_indiv <- vcf_file[, 5:(5 + length(individual_names) - 1)]
  
  # Loop through individuals
  for (b in 1:length(individual_names)) {
    indiv <- vcf_indiv[, b]
    
    # Remove missing genotypes "./."
    indiv <- indiv[indiv != "./."]
    
    # Remove phasing info (convert 0|1 to 0/1)
    indiv <- gsub("\\|", "/", indiv)
    
    # Total non-missing sites
    indiv_total[b] <- length(indiv)
    
    # Heterozygous sites (0/1)
    indiv_het_sites[b] <- length(indiv[indiv == "0/1"])
  }
  
  # Create output row
  output_rep <- c(vcfs[a], indiv_total, indiv_het_sites)
  
  # wite output file
  write(output_rep, file = "camptexa_output.het.txt", append = TRUE, ncolumns = (1 + length(individual_names) * 2), sep = "\t")
}

# calculate OH

# Read the file
data <- read.table("camptexa_output.het.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)

# Remove the VCF column
individual_data <- data[, -1]

# First 28 columns = total sites
total_sites <- individual_data[, 1:16]

# Next 28 columns = het sites
het_sites <- individual_data[, 17:32]

#  Sum across all scaffolds
# Sum total sites for each individual
total_sites_sum <- colSums(total_sites) 
# Sum het sites for each individual
het_sites_sum <- colSums(het_sites)     

# Now calculate observed heterozygosity
observed_het <- het_sites_sum / total_sites_sum

# Create a final table
# clean individual names
individual_names <- gsub("_total_sites", "", names(total_sites))  
individual_names <- gsub("\\.", "-", individual_names) 

final_output <- data.frame(
  Individual = individual_names,
  Total_Sites = total_sites_sum,
  Het_Sites = het_sites_sum,
  Observed_Heterozygosity = observed_het
)

# Save
write.table(final_output, file = "observed_heterozygosity_camptexa.txt", sep = "\t", quote = FALSE, row.names = FALSE)

