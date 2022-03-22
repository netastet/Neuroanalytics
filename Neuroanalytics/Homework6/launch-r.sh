#!/bin/bash

#SBATCH -p general
#SBATCH -N 1
#SBATCH -n 17
#SBATCH --mem=10g
#SBATCH -t 02-00:00:00

Rscript permutations.R
