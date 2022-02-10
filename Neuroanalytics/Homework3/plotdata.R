options(stringsAsFactors = FALSE)

#create vectors for the length of the loops

tp_data_files <- list.files(pattern = "donortp_")
ph_data_files <- list.files(pattern = "donorph_")

#create count for if statement controlling new plot creation
counter <- 0

#create variable to control counter for first tp of every graph, fp = first points
fp_counter <- 2

#create variable for title
title <- 1
#create a for loop for the time point series, reading the time points into dataframes


  for (i in 1:length(tp_data_files)){
  #create variable to manipulate for each point in the loop
  tp_data <- read.table(tp_data_files[i], header = TRUE)
 
   #create variable to match each phenotype at each time point
  ph_data <- read.table(ph_data_files[i],header = TRUE)
  
  #create dataframe with both new variables
  graph <- data.frame(tp_data, ph_data)
  #increment counter
  counter <- counter + 1
  
  #if statement to plot each new graph at first timepoint
    if(counter == 1){
      plot(graph, main = title, xlab = "Timepoint", ylab = "Phenotype", type = "p")
      title <- title + 1
}else {
      points(graph)
}
  if(counter == fp_counter){
    plot(graph, main = title, xlab = "Timepoint", ylab = "Phenotype", type = "p")
    title <- title + 1
  }
  #increment fp_counter so every tenth cycle creates new plot
  fp_counter <- fp_counter + 0.1
}
