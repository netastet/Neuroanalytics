#!/bin/bash
#script for putting donor data files into folders then folders into directory fakedata, to be used after make-donors.sh
#need to make fakedata directory first
mkdir fakedata
#first part sets up numbers to correspond with previous 50 donors created
for i in {1..50}
  do
    #second part moves files previously created to appropriate directories
    for f in {1..10}
      do
        mv donor_${i}_tp${f}.txt donor_${i}
      done
      #moves all directories to new directory
  mv donor_${i} fakedata
  #removes write permissions
  chmod a-w fakedata/donor_${i}/*.txt
done
