options(stringsAsFactors = FALSE)
library(tidyverse)
library(tidyr)

#set up variables for file reading
both_sexes <- "20414.gwas.imputed_v3.both_sexes.tsv"

#read in file
tboth_sexes <- read.table(both_sexes, header=FALSE)

#write variable creating index list for low p-values
pval <- which(tboth_sexes[,11] < 10^-4)

#create empty data frame
eframe <- matrix(NA,nrow = nrow(tboth_sexes),ncol = 14)

framesplit <- str_split(tboth_sexes$V1, ":", n=4)
#split up first column
#I'm writing this at 6:00 AM, 2/24/2022.Unfortunatley I have been up all night trying to resolve some issues
#The str_split command, as well as other split commands I apply to the data set crash my R
#I have been unable to resolve a work around and have been working on the Homework through the weekend
#I am very sorry I wasn't able to resolve the problem. 
