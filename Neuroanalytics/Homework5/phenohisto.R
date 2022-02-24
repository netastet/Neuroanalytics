options(stringsAsFactors = FALSE);
library(tidyverse);
#variables for file names 

SNPped <- "hapmap1.ped";
SNPmap <- "hapmap1.map";
qt <- "qt.phe";

qt.table <- read.table(qt)