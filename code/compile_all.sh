#!/bin/bash
#SBATCH -p icelake
#SBATCH -N 1
#SBATCH -n 16
#SBATCH --time=02:00:00   
#SBATCH --mem=128GB       
#SBATCH -o /hpcfs/users/a1018048/dsa_comparison/slurm/%x_%j.out
# SBATCH -e /hpcfs/users/a1018048/dsa_comparison/slurm/%x_%j.err
#SBATCH --mail-type=END
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=stephen.pederson@adelaide.edu.au

## Activate the mamba environment
source /home/a1018048/.bashrc
mamba activate /home/a1018048/mambaforge/envs/dsa_comparison

WD=/hpcfs/users/a1018048/dsa_comparison

## AR
F=${WD}/analysis/zr75_ar_e2_e2dht.Rmd
echo -e "Compiling ${F}"
R -e "rmarkdown::render_site('${F}')" 

## ER
F=${WD}/analysis/zr75_er_e2_e2dht.Rmd
echo -e "Compiling ${F}"
R -e "rmarkdown::render_site('${F}')" 

## H3K27ac
F=${WD}/analysis/zr75_h3k27ac_e2_e2dht.Rmd
echo -e "Compiling ${F}"
R -e "rmarkdown::render_site('${F}')" 

F=${WD}/analysis/index.Rmd
echo -e "Compiling ${F}"
R -e "rmarkdown::render_site('${F}')" 