options(stringsAsFactors = FALSE);
library(tidyverse);
library(ggplot2);
#variables for file names 

SNPped <- "hapmap1.ped";
SNPmap <- "hapmap1.map";
qt <- "qt.phe";

#convert qt.phe to tibble
qt.table <- read.table(qt)

qt.tibble <- tibble(qt.table)

#plot qt.tible and past to pdf

file.create(file='phenohisto.pdf')
pdf('phenohisto.pdf')
qt.plot <- ggplot(data=qt.tibble) + ggtitle("number of pheontypes in donor population") + labs(y="p count", x = "p value") + geom_histogram(mapping = aes(x=V3))
print(qt.plot)
dev.off()