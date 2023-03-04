#!/bin/bash
#SBATCH --job-name=alphasim.%j
#SBATCH --mail-type=END
#SBATCH --mail-user=deamorimpeixotom@ufl.edu
#SBATCH --account=mresende
#SBATCH --qos=mresende
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4GB
#SBATCH --time=05:00:00
#SBATCH --output=1.tmp/alphasim.%a.array.%A.out
#SBATCH --error=2.error/alphasim.%a.array.%A.err
#SBATCH --array=1-150

module purge; module load R/4.1

INPUT=$(head -n $SLURM_ARRAY_TASK_ID INPUT.FILE.txt | tail -n 1)

echo $INPUT
Rscript RUNME.R $INPUT ${rep} ${VarGE} 
