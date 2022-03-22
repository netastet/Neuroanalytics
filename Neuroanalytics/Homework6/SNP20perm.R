options(stringsAsFactors = FALSE);

#number of permutations

nperms <- 10000;


## must redo all code, following class 12

options(stringsAsFactors = FALSE);
library(tidyverse);

#get all input files
fped <- 'hapmap1.ped';
fphe <- 'qt.phe';
fmap <- 'hapmap1.map';

#set outputs
fsnp <- 'highmissingsnps.txt';
fpedout <- 'hapmap1_nomissing.ped';
fmapout <- 'hapmap1_nomissing.map';
flowafsnps <- 'lowafsnps.txt';
flowafmap <- 'hapmap1_nomissing_AF.map';
flowafped <- 'hapmap1_nomissing_AF.ped';
fpdf <- 'phenoxgeno.pdf';

#read in ped file
ped <- read.table(fped);

#transfrom bep file into readable SNP data

##remove six columns that are not SNP info
tmpSNPs <- ped[,c(7:ncol(ped))];

##get total number of SNPs, each SNP is two columns so divide the number of columns by 2 
nSNPs <- ncol(tmpSNPs)/2

##Get the total number of individuals (equals rows in ped file)
ndonors <-nrow(ped);

#show output the total number of SNPs and donors
cat('There are ',nSNPs, 'SNPs \n');
cat('There are ',ndonors, 'donors \n');

#Reformat the file to have 
## 0 = NA
## 1 = homozygous for allele 1 = 0
## 2 = heterozygous = 1 
## 2 = homozygous for allele 2 = 2

#make output matrix
SNPs <- matrix(NA,nrow=ndonors,ncol=nSNPs);

#make loop over each pair of columns in the tmpSNPs matrix
#1,2 ... 3,4 ... 5,6 ...
# this is (2*1-1, 2*i)
for (i in 1:nSNPs){
  
  #make empty vector containing the recoded SNP values
  snprecode <- matrix(NA,nrow=ndonors,ncol=1)
  
  #get both columns representing one SNP in one chart
  onesnp <- tmpSNPs[,c(2*i-1,2*i)];
  
  #classify each SNP into 5 categories
  NAind <- which(onesnp[,1]==0 & onesnp[,2]==0);
  hom1ind <- which(onesnp[,1]==1 & onesnp[,2]==1);
  hetind <- which((onesnp[,1]==1 & onesnp[,2]==2) | (onesnp[,1]==2 & onesnp[,2]==1));
  hom2ind <- which(onesnp[,1]==2 & onesnp[,2]==2); 
  
  #recode SNPS to allele
  snprecode[NAind] <- NA;
  snprecode[hom1ind] <- 0;
  snprecode[hetind] <- 1;
  snprecode[hom2ind] <- 2;
  
  #save to matrix
  SNPs[,i] <- snprecode;
}

#use map file to label which SNP is being referred to in the SNPs file
map <- read.table(fmap);

#Check to see if number of SNPs in the map file equals number of SNPs in ped file
if(nrow(map)!=nSNPs){
  cat('Something is wrong! The number of SNPs in the map file is not equal to the number of SNPs in the ped file','\n');
}

#SNPs are in the same order so they can be assigned names using the map file
colnames(SNPs) <- map$V2;

#assign row names to each subject using ped
rownames(SNPs) <- ped[,1];

phe <- read.table(fphe);
pheno <- phe$V3;

plot(SNPs[,20],pheno,main=colnames(SNPs)[20],xlab="Genotype",ylab="Phenotype");

#create tibble for permutating
tperm <- tibble(x=SNPs[,20],y=pheno);

#get coefficients for plotting permutation linear model
lm(tperm);

ggplot(data=tperm) + geom_point(mapping=aes(x=x,y=y)) +geom_abline(mapping=aes(intercept=1.8344,slope=-0.0237));

#create empty matrix for permuted x column
betaperm <- matrix(NA, nrow=nperms,ncol=1);

#create variable for sampled x column
permutedx <- sample(tperm$x);

#permutate data
for(i in 1:nperms){
  permmodel <- lm(tperm$y~sample(tperm$x));
  betaperm[i] <- coef(permmodel)[2];
}

#create tibble of randomly sampled permutations
perm <- tibble(betaperm=betaperm[,1])

#mean across column
perm %>% summarize(mean(betaperm))

#plot data 
pngplot <- ggplot(data=perm) + geom_histogram(mapping=aes(x=betaperm)) + geom_vline(mapping = aes(xintercept=1.8344))

png(file="plot1.png", width = 500, height = 500)

pngplot

dev.off()