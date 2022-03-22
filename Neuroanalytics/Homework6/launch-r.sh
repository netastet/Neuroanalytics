#!/bin/bash

#SBATCH -p general
#SBATCH -N 1
#SBATCH -n 100
#SBATCH --mem=4g
#SBATCH -t 02-00:00:00

Rscript SNP20perm.R
