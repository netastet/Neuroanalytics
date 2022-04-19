options(stringsAsFactors = FALSE)

#load dependencies
library(rhdf5)
library(ggplot2)
library(ggfortify)

##Data Entry

#file name of sample file including HDF5 format
data <- "LocustDemoData.hdf5"

#Variable input for frequency/sampling rate in Hertz
SR <- 15000

#Variable input for time collecting (ST = Sample time) in seconds
ST <- 20

#variable for number of channels 
channenum <- 4

## Data Matrix Creation 

#time coefficient for calculating seconds given the sample rate and the time spent sampling
timeco <- (ST/(ST*SR))

#number of samples
sampnum <- (ST*SR)

#create matrix for voltage data
voltdata <- matrix(NA,nrow = 4,ncol = sampnum)

for (i in 1:channenum){
  #convert number to string for indexing hdf5 data
  k<-toString(i)
  #read data from h5 file into voltage data matrix
  voltdata[i,]<-h5read(data,k)
}

#create matrix for plotting data against time
voltrace <- matrix(NA,nrow=(sampnum),ncol=(1+channenum))
#convert colnames to numbers, the column past 1 represents the channel equal to 1-the column name
colnames(voltrace)<-c(1:(1+channenum))

#fill matrix column with time points and voltage data

for (i in 1:sampnum){
  #add time point to each position on x axis, i indexes the row
  voltrace[i,1]<-(timeco*i)
  
  #add in voltage data
  for (g in 1:channenum){
    #do to nature of rhdf5 system, we must convert some numbers to strings to access the right parts of the file
    h<-toString(g)
    #where i is the row and g+1 is the column and voltdata:g is the column and i is the row
    voltrace[i,g+1]<-voltdata[g,i]
  }
}

## Plotting Data

#convert voltrace to data frame for easier management
voltrace.df<-as.data.frame(voltrace)

for(i in 1:channenum){
  #channel number variable for plotting
  j<-(i+1)
  
  #variable for y plotting (your voltage data from one channel)
  y<-voltrace.df[,j]
  
  #plot graphs of each Channel over time
  plot(voltrace[,1],y,xlab = "seconds", ylab = "mV", main = paste("Channel", i),type="l")
}

##Spike Detection

#create MAD matrix for MAD sorting
madmatrix<-matrix(NA,nrow = 1,ncol = channenum)

#change column names to correspond to channels
colnames(madmatrix)<-c(1:channenum)

#loop for finding optimal detection threshold for data
for(i in 1:channenum){
  #corresponds to channel in matrix
  j<-i+1
  madmatrix[,i]<-mad(voltrace[,j])
}

#create empty matrix to fill with time and amplitude points of each waveform
voltfinal<-matrix(NA,nrow=0,ncol=1+channenum)

#change column names
colnames(voltfinal)<-c(1:(channenum+1))

#change to dataframe
voltfinal1<-as.data.frame(voltfinal)

#constant to convert time coefficient to one millisecond (standard refractory period of a neuron)
milli<-((.001/timeco)-1)

#constant for cutoff on amplitude detection
cutoff<-sampnum-50-1

#empty matricies for testing values against each other (peak detection)
peakdetect<-matrix(NA,nrow = 0,ncol = 1+channenum)

#name columns
colnames(peakdetect)<-1:(channenum+1)

#convert to data frames
peakdetect1<-as.data.frame(peakdetect)
peakdetect2<-as.data.frame(peakdetect)

#Loop through voltrace to find spikes based on detection threshold set by mad
  for(i in 1:channenum){
    j<-i+1
    p<-j+1
    q<-j+2
    r<-j+3
    s<-j-1
    t<-j-2
    u<-j-3
    
    #indexing variables for peak detection
    thresholds<-which(voltrace.df[,j]>madmatrix[,i])
    threshlength<-length(thresholds)
    for(k in 1:threshlength){
      #variable for voltrace indexing relative to thresholds
      l<-thresholds[k]
      m<-l+49
      n<-l-49
      o<-voltrace.df[l,j]
      #if statement to check if enough room to cut
      if(l>50 & l<cutoff){
     
       #plug in values to peakdetect matricies
      peakdetect1<- rbind(peakdetect1,voltrace.df[l:m,])
      peakdetect2<- rbind(peakdetect2,voltrace.df[l:n,])
      
      #create test values for highest in matricies
      peakmax1<-max(peakdetect1[,j])
      peakmax2<-max(peakdetect2[,j])
      
      #detect if peak, if so then record
      if(o == peakmax1 & o == peakmax2){
        voltfinal1<-rbind(voltfinal1,voltrace.df[l,])
      }
      #reset matricies
      #empty matricies for testing values against each other (peak detection)
      peakdetect<-matrix(NA,nrow = 0,ncol = 1+channenum)
      
      #name columns
      colnames(peakdetect)<-1:(channenum+1)
      
      #convert to data frames again
      peakdetect1<-as.data.frame(peakdetect)
      peakdetect2<-as.data.frame(peakdetect)
      }
    }
    if(i == 1){
      plot(voltfinal1[,j],voltfinal1[,p],main = paste("Channel", i, "vs Channel", j))
      plot(voltfinal1[,p],voltfinal1[,q],main = paste("Channel", i, "vs Channel", p))
      plot(voltfinal1[,q],voltfinal1[,r],main = paste("Channel", i, "vs Channel", q))
    }
  }

#run pca on data collected
tetrode.pca<-prcomp(voltfinal1[2:5],center=TRUE,scale. = TRUE)

#summarize data
sumary(tetrode.pca)

#kmeans cluster the data
kmeans(voltfinal1[,2:(channenum+1)], 10, iter.max = 10, nstart = 1)
