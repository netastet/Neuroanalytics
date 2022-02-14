options(stringsAsFactors = FALSE);

#variables for file names 

SNPped <- "hapmap1.ped";
SNPmap <- "hapmap1.map";
qt <- "qt.phe";

#create variable for dataframe
SNPdata <- read.table(SNPped);

#create sorted data frame ignoring first 6 columns 
SNPsorted <- SNPdata[,7:ncol(SNPdata)];

#create a number of columns equal to the number of pairs in the .ped
SNPpairs <- ncol(SNPsorted)/2

#create a number of rows equal to the number of patients/samples
SNPpaitents <- nrow(SNPsorted)

#empty matrix
SNP <- matrix(NA,nrow=SNPpaitents,ncol=SNPpairs)


#loop through files
for (i in 1:SNPpairs){
  #variable sorting for desired SNPs
  SNPfilter <- SNPsorted[,c(i*2-1,i*2)];
  
  #variable for genotypes
  genoEmpty <- which(SNPfilter[, 1]==0 & SNPfilter[,2]==0);
  genohomo <- which(SNPfilter[,1]==1 & SNPfilter[,2]==1);
  genohomoalt <- which(SNPfilter[,1]==2 & SNPfilter[,2]==2);
  genohetero <- which(SNPfilter[,1]==1 & SNPfilter[,2]==2) | (SNPfilter[,1]==2 & SNPfilter[,2]==1)
  
  #reset matrix
  SNPmatrix <- matrix(NA, nrow=SNPpaitents, ncol=1);
  SNPmatrix[genoEmpty] = NA;
  SNPmatrix[genohomo] = 0;
  SNPmatrix[genohomoalt] = 1;
  SNPmatrix[genohetero] = 2;
  
  #set matrix back up 
  SNP[,i] <- SNPmatrix;

  }

#Pull row names for each patient
rownames(SNP) = SNPdata[,1];
map <- read.table(SNPmap);
colnames(SNP) = map$V2;

#read .phe file
phenotype = read.table(qt);
phenotyperead = phenotype$V3


#pdf to store file
pdf("genotypeassociation2.pdf");

#plotfile

for (g in 1:100){
  plot(SNP[,g],phenotyperead,main=colnames(SNP)[g],xlab="Genotype",ylab="Phenotype");
}

#close pdf
dev.off()
