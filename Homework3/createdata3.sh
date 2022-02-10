#!/bin/bash
#create files

# make series of files
for x in {001..100}
  do
      #create 10 data files for each donor and fill with fake data, with a header for the phenotype
      for y in {001..10}
        do
          touch donorph_${x}_tp${y}.txt
          echo -ne "phenotype\n$RANDOM\n$RANDOM\n$RANDOM\n$RANDOM\n$RANDOM\n" > donorph_${x}_tp${y}.txt
          #create tp for each pheontype
          touch donortp_${x}_tp${y}.txt
          echo -ne "tp\n${y}\n${y}\n${y}\n${y}\n${y}\n" > donortp_${x}_tp${y}.txt
        done
  done
