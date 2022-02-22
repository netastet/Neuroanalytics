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

#Pull row names for each patient
rownames(SNP) = SNPdata[,1];
map <- read.table(SNPmap);

#read .phe file
phenotype = read.table(qt);
phenotyperead = phenotype$V3;

#create variable for testing frequency
missingness <- ((SNPpaitents * 2 )* 0.05);

toomuch <- ((SNPpaitents * 2) * 0.95)

#create text file 

file.create("bad_names_frequency.txt")  

#create dataframe for filling with SNPS
df <- data.frame()

df < cbind(SNPdata[,1])

write.table(df, "")

file.create("hapmap1_nomissing_AF.map")

#write all names into the file
for (z in 1:SNPpairs){
  #create variable to count through SNP pairs
  SNPfilter <- SNPsorted[,c(z*2-1,z*2)];
  
  SNPfilter2 <- SNPsorted[z,]; 
  
  df <- colSums(SNPfilter)
  
  if(df < missingness){
    cat(map[z,2], paste("\n"), file = "bad_names_frequency.txt",append = TRUE)
  }
  if(df > toomuch){
    cat(map[z,2], paste("\n"), file = "bad_names_frequency.txt",append = TRUE)
  }
  if(df > missingness & df < toomuch){
    write.table(df, "hapmap1_nomissing_AF.ped", append = TRUE)
    rbind(map[z,], file = "hapmap1_nomissing_AF.map")
  }
}