# Peixoto_2023_Simulation_based_decision

This is a repository with the scripts of the paper: Simulation Based Decision Making and Implementation of Tools in Hybrid Crop Breeding Pipelines (Peixoto et al. 2023).

### Especifications

Within both main folders you can find a RUNME.R file. This file will call via 'source()' function all other files inside each folder. In the way that it is, you can run the repetitions for each scenario in parallel. We used the HiPerGator, The University of Florida supercomputer for running all analyses. The code was run in R 4.0.0 and AlphaSimR 1.0.4. In addition, the folder Plot contains the script for plotting the outputs of both set of simulations.

### Contents

**1.Parental_update folder**: This folder contains the script for running the first question of the manuscript: which is the best strategy to update the crossing block at each cycle?

Four scenarios were implemented:

i. CONV: Conventional breeding program (phenotypic selection) with parents of the new cycle coming from the top ranked individuals at the first testcross.  
ii. CONVe: Conventional breeding program (phenotypic selection) with parents of the new cycle selected from the top ranked individuals in F3/F5 populations.  
iii. GS: Genomic selection breeding program with parents of the new cycle coming from the top ranked individuals at the first testcross.  
iv. GSe: Genomic selection breeding program with parents of the new cycle selected from the top ranked individuals in F3/F5 populations.  

**2.HTP_vs_GS folder**: This folder has the script for the second question of the paper: the feasibility of implementation of genomic selection and high-throughput phenotyping in a hybrid breeding program.

Four scenarios were evaluated (all with early selection, i.e., parents of the new cycle selected from the top ranked individuals in F3/F5 populations):

i. CONVe: Conventional breeding program.   
ii. CONVe_HTP: conventional breeding program with high-throughput phenotyping.   
iii. GSe: conventional breeding program with genomic selection.   
iv. GSe_HTP: conventional breeding program with genomic selection and high-throughput phenotyping.   

**Plot folder**: This folder contains a script to plot the graphs as an outcome of the analyses.

Any question about the analyses, please, contact me!

Marco


M.Sc. Marco Antonio Peixoto  
Email: deamorimpeixotom@ufl.edu  
Page: https://marcopxt.github.io/  
