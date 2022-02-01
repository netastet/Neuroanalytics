#!/bin/bash
#first loop to create 50 folders for each donor, second loop creates 10 files per folder with data

for i in {1..50}
  do
    echo "making file donor_{$i}"
    mkdir donor_${i}
      for f in {1..10}
        do
          touch donor_${i}_tp${f}.txt;
          echo -ne "data\n$RANDOM\n$RANDOM\n$RANDOM\n$RANDOM\n$RANDOM" > donor_${i}_${f}.txt;
done
done
