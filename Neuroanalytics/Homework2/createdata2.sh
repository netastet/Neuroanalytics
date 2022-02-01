#!/bin/bash
#create files

#make directory for fakedata

mkdir 100donors
#set up first set of directories, x indicates number of donor in sequence
for x in {001..100}
  do
  #create directory for each donor
    echo "making file donor_${x}"
    mkdir donor_${x}
      #create 10 data files for each donor and fill with fake data
      for y in {001..010}
        do
          touch donor_${x}_tp${y}.txt
          echo -ne "data\n$RANDOM\n$RANDOM\n$RANDOM\n$RANDOM\n$RANDOM" > donor_${x}_tp${y}.txt
          mv donor_${x}_tp${y}.txt donor_${x}
        done
      echo "moving donor_${x} to 100donors"
      mv donor_${x} 100donors
  done
