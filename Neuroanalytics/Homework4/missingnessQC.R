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

#create variable for testing missingness (2.5% because counting two columns)
missingness <- (SNPpairs * 0.025);

#create text file 

file.create("bad_names.txt")  

#create dataframe for filling with SNPS
df <- data.frame()

#add first row of .ped file to df
df <- cbind(SNPdata[,1])
#write all names into the file
for (z in 1:SNPpaitents){
  #create variable to count through SNP pairs
  SNPfilter <- SNPsorted[,c(z*2-1,z*2)];
  
  SNPfilter2 <- SNPsorted[z,]; 
  
  #count number of zeros in each row
  res <- rowSums(SNPfilter2 == 0);
  
  if(res > missingness){
    cat(map[z,2], paste("\n"), file = "bad_names.txt",append = TRUE);
  }
  if(res < missingness){
    df <- cbind(df, SNPfilter)
    write.table(df, "hapmap1_nomissing.ped")
    cat(map[z,], paste("\n"), file = "hapmap1_nomissing.map")
  }
}