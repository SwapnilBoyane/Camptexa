options(scipen=999)

####################################
####################################
# functions used in below sections
####################################
####################################

# read in a small vcf (don't use for large vcf files)
read_vcf <- function(input_file) {
  header <- readLines(input_file)
  header <- header[grep('^#C', header)]
  header <- strsplit(header, "\t")[[1]]
  vcf <- read.table(input_file, header=F)
  colnames(vcf) <- header
  return(vcf)
}

####################################
####################################
# calculate kinship coefficients
# estimate the R0, R1, and KING-robust kinship stats for each comparison
####################################
####################################

# read in vcf  
x <- read_vcf("camptexa_20kbp.vcf")

# keep only genotypes
x <- x[,10:ncol(x)]
for(a in 1:ncol(x)) {
	x[,a] <- substr(x[,a], 1, 3)
}

# determine all the pairwise comparisons desired
individuals <- colnames(x)
comps <- t(combn(individuals, 2))

output <- data.frame(ind1=as.character(comps[,1]), ind2=as.character(comps[,2]))

# calculate the A, B, C, D, E, F, G, H, I categories for each pairwise comparison
n_sites <- list()
AA <- list()
BB <- list()
CC <- list()
DD <- list()
EE <- list()
FF <- list()
GG <- list()
HH <- list()
II <- list()
for(a in 1:nrow(output)) {
	a_rep1 <- x[,colnames(x) == output[a,1]]
	a_rep2 <- x[,colnames(x) == output[a,2]]
	
	# remove sites with missing data in one individual
	keep <- ((a_rep1 == "./."	| a_rep2 == "./.") == FALSE)
	a_rep1 <- a_rep1[keep]
	a_rep2 <- a_rep2[keep]
	
	# report number of sites and each combination of genotypes
	n_sites[[a]] <- length(a_rep1)
	AA[[a]] <- length(a_rep1[a_rep1 == "0/0" & a_rep2 == "0/0"])
	BB[[a]] <- length(a_rep1[a_rep1 == "0/1" & a_rep2 == "0/0"])
	CC[[a]] <- length(a_rep1[a_rep1 == "1/1" & a_rep2 == "0/0"])
	DD[[a]] <- length(a_rep1[a_rep1 == "0/0" & a_rep2 == "0/1"])
	EE[[a]] <- length(a_rep1[a_rep1 == "0/1" & a_rep2 == "0/1"])
	FF[[a]] <- length(a_rep1[a_rep1 == "1/1" & a_rep2 == "0/1"])
	GG[[a]] <- length(a_rep1[a_rep1 == "0/0" & a_rep2 == "1/1"])
	HH[[a]] <- length(a_rep1[a_rep1 == "0/1" & a_rep2 == "1/1"])
	II[[a]] <- length(a_rep1[a_rep1 == "1/1" & a_rep2 == "1/1"])
}
output <- data.frame(ind1=as.character(output$ind1), ind2=as.character(output$ind2), n_sites=as.numeric(n_sites), A=as.numeric(unlist(AA)), B=as.numeric(unlist(BB)), C=as.numeric(unlist(CC)), D=as.numeric(unlist(DD)), E=as.numeric(unlist(EE)), F=as.numeric(unlist(FF)), G=as.numeric(unlist(GG)), H=as.numeric(unlist(HH)), I=as.numeric(unlist(II)))

# calculate the R0, R1, and KING-robust kinship stats for each pairwise comparison
R0 <- (output$C + output$G) / (output$E)
R1 <- (output$E) / (output$B + output$D + output$H + output$F + output$C + output$G)
KINGrobust <- (output$E - 2 * (output$C + output$G)) / (output$B + output$D + output$H + output$F + 2 * output$E)

# add these to output
output <- cbind(output, R0, R1, KINGrobust)

# write the output
write.table(output, file="camptexa_kinship.txt", sep="\t", quote=F, col.names=T, row.names=F)


####################################
####################################
# plot
####################################
####################################

par(mar=c(5,5,1,1))
par(mfrow=c(1,2))

plot(output$R1, output$R0)
plot(output$R1, output$KINGrobust)







