options(stringsAsFactors = FALSE);
library(tidyverse);
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
  #create empty vector recording recoded values
  SNPrecode <- matrix(NA,nrow=SNPpaitents,ncol=1)
  
  #variable sorting for desired SNPs, a set of paired columns representing alleles 
  SNPfilter <- SNPsorted[,c(i*2-1,i*2)];
  
  #variable for genotypes
  genoEmpty <- which(SNPfilter[, 1]==0 & SNPfilter[,2]==0);
  genohomo <- which(SNPfilter[,1]==1 & SNPfilter[,2]==1);
  genohomoalt <- which(SNPfilter[,1]==2 & SNPfilter[,2]==2);
  genohetero <- which((SNPfilter[,1]==1 & SNPfilter[,2]==2) | (SNPfilter[,1]==2 & SNPfilter[,2]==1))
  
  #reset matrix
  SNPrecode[genoEmpty] = NA;
  SNPrecode[genohomo] = 1;
  SNPrecode[genohomoalt] = 2;
  SNPrecode[genohetero] = 0;
  
  #save values to a matrix where NA is an empty SNP, 1 is homozygous for the first allele, 2 is homozygous for the second allele, and 0 is heterozygous
  SNP[,i] <- SNPrecode;
  
}

#Pull row names for each patient
map <- read.table(SNPmap);
colnames(SNP) = map$V2;

#read .phe file
phenotypep = read.table(qt);
phenotyperead = phenotypep$V3
#calculate missingness rate for each donor

missingness <- colSums(is.na(SNP)/SNPpaitents)

missingnesstrig <- which(missingness>0.05)

#get names of columns
missingnames <- colnames(SNP)[missingnesstrig]

#write table and file

write.table(missingnames, file='bad_names_2.txt', quote = FALSE, row.names = FALSE, col.names = FALSE)

#remove all missingnames
map.nomissing <- map[-missingnesstrig,];

#write .map file
write.table(map.nomissing, file="hampmap_nomissing.map", quote=FALSE,row.names = FALSE,col.names = FALSE)

#remove all missing values
SNP.nobdata <- SNP[,-missingnesstrig]
SNP.nobdata.ma <- matrix(NA, nrow=SNPpaitents,ncol=(2*ncol(SNP.nobdata)))

for (i in 1:ncol(SNP.nobdata)){
  NAind <- which(is.na(SNP.nobdata[,i]));
  hom1ind <- which(SNP.nobdata[,i]==0);
  hetind <- which(SNP.nobdata[,i]==1);
  hom2ind <- which(SNP.nobdata[,i]==2);
  
  new.ped <- i*2-1;
  new.ped2 <- i*2;
  
  SNP.nobdata.ma[NAind,new.ped] <-0;
  SNP.nobdata.ma[NAind,new.ped2] <-0;
  SNP.nobdata.ma[hom1ind,new.ped] <-1;
  SNP.nobdata.ma[hom1ind,new.ped2] <-1;
  SNP.nobdata.ma[hetind,new.ped] <-1;
  SNP.nobdata.ma[hetind,new.ped2] <-2;
  SNP.nobdata.ma[hom2ind,new.ped] <-2;
  SNP.nobdata.ma[hom2ind,new.ped2] <-2;
}

#create file with first 6 columns to ped file
ped.cols <- cbind(SNPdata[,1:6],SNP.nobdata);
write.table(ped.cols,file="hampmap_nomissing.map", quote = FALSE, row.names = FALSE, col.names = FALSE)

#create allele frequency measure
nomispatients <- colSums(!is.na(SNP.nobdata));
AF <- colSums(SNP.nobdata,na.rm = TRUE)/(nomispatients*2)
mfinder <- which(AF>0.5);
mfinderSNPs <- colnames(SNP.nobdata)[mfinder]

ped.SNPs.mfinder <- matrix(NA, nrow=SNPpaitents,ncol=(ncol(mfinderSNPs)))

for (i in 1:ncol(mSNPs.finder)){
  NAind <- which(is.na(mSNPs.finder[,i]));
  hom1ind <- which(mSNPs.finder[,i]==0);
  hetind <- which(mSNPs.finder[,i]==1);
  hom2ind <- which(mSNPs.finder[,i]==2);
  
  newpedind1 <- i*2-1;
  newpedind2 <- i*2;
  
  ped.SNPs.mfinder[NAind,newpedind1] <- 0;
  ped.SNPs.mfinder[NAind, newpedind2] <- 0;
  ped.SNPs.mfinder[hom1ind, newpedind1] <- 1;
  ped.SNPs.mfinder[hom1ind, newpedind2] <- 1;
  ped.SNPs.mfinder[hetind, newpedind1] <- 1;
  ped.SNPs.mfinder[hetind, newpedind2] <- 2;
  ped.SNPs.mfinder[hom2ind, newpedind1] <- 2;
  ped.SNPs.mfinder[hom2ind, newpedind2] <- 2;
}

ped.filter <- cbind(SNPdata[1:6], ped.SNPs.mfinder);

file.create(file = 'genohisto.pdf');
pdf('genohisto.pdf');
for( i in 1:ncol(mSNPs.finder)){
  temp <- data.frame(phenotype=phenotyperead, ped.SNPs.mfinder[,i]);
  colnames(temp)[2] <- "SNP"
  plotting <- ggplot(data=temp) + geom_histogram(mapping=aes(x=SNP,y=phenotype,group=SNP))+labs(title=colnames(mSNPs.finder)[i]);
  print(plotting)
}
dev.off();

