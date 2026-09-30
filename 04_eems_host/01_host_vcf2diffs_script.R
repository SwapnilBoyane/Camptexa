
options(scipen=999)

library("vcfR")


# Compute the diffs matrix using the "mean allele frequency"
# imputation method
bed2diffs_v2 <- function(genotypes) {
  
  nIndiv <- nrow(genotypes)
  nSites <- ncol(genotypes)
  missing <- is.na(genotypes)
  
  ## Impute NAs with the column means (= twice the allele frequencies)
  geno_means <- colMeans(genotypes, na.rm = TRUE)
  # nIndiv rows of genotype means
  geno_means <- matrix(geno_means, nrow = nIndiv, ncol = nSites, byrow = TRUE) 
  
  ## Set the means which correspond to observed genotypes to 0
  geno_means[missing == FALSE] <- 0
  ## Set the missing genotypes to 0 (used to be NA) 
  genotypes[missing == TRUE] <- 0
  genotypes <- genotypes + geno_means
  
  similarities <- genotypes %*% t(genotypes) / nSites
  self_similarities <- diag(similarities)
  vector1s <- rep(1, nIndiv)
  
  diffs <- 
    self_similarities %*% t(vector1s) + 
    vector1s %*% t(self_similarities) - 2 * similarities
  diffs
}


vcf <- read.vcfR("texanus_eems.vcf")

genotypes <- vcfR2genlight(vcf) 

genotype_matrix <-as.matrix(genotypes)

diff_matrix <- bed2diffs_v2(genotypes = genotype_matrix)

write.table(diff_matrix, "texanus_eems.diffs", col.names = F, row.names = F, quote = F, sep='\t')
