###############################################################################
## AlphaSimR code for sweet corn breeding
## This is the first script of the simulation
## All other script will be called by this one
###############################################################################

###------------------------------------------------------------------------
###   1. Setting up the environment
###------------------------------------------------------------------------
##>>>----------- Setting the environment
rm(list = ls())

require(AlphaSimR)

setwd(" ") # Change here for your path

options(echo=TRUE)
args = commandArgs(trailingOnly=TRUE)
rep <- as.numeric(args[1])
VarGE <- as.numeric(args[2])

##>>>----------- Setting the scenarios
source("GlobalParameters.R")

# Initialize variables for results
hybridMean =
  accF3 = 
  accF5 = 
  parent_mean = 
  parent_var =
  rep(NA_real_,burninYears+futureYears)

# Empty list for public breeding program
output = list(hybridMean=NULL,
              accF3=NULL,
              accF5=NULL,
              parent_mean = NULL,
              parent_var = NULL)

# Save results
saveRDS(output,sprintf("Scenario_CONVe_r%s_GE%s.rds",rep,VarGE))
saveRDS(output,sprintf("Scenario_CONVe_HTP_r%s_GE%s.rds",rep,VarGE))
saveRDS(output,sprintf("Scenario_GSe_r%s_GE%s.rds",rep,VarGE))
saveRDS(output,sprintf("Scenario_GSe_HTP_r%s_GE%s.rds",rep,VarGE))

###------------------------------------------------------------------------
### 2.Setting up the base population
###------------------------------------------------------------------------

###>>>>----------------- Creating parents and Starting the pipeline
# Create initial parents and set testers and hybrid parents
source("CreatParents.R")

# Fill breeding pipeline with unique individuals from initial parents
source("FillPipeline.R")

###>>>>----------------- p-values for Genotype-by-environment effects
b.f=burninYears+futureYears

# p-values for GxY effects
Pgy = 0.5 + rnorm(b.f,0,0.03)

# p-values for GxYxE effects
Pgye1 = 0.9 + rnorm(b.f,0,0.03)
Pgye2 = 0.1 + rnorm(b.f,0,0.03)
Pgye = c(Pgye1,Pgye2)
Pgye = sample(Pgye,b.f, replace=F)

###------------------------------------------------------------------------
###  3. Burn-in Phase 
###------------------------------------------------------------------------

for(year in 1:(burninYears)){           
  cat("Working on Year:",year,"\n")                               
  pgy = Pgy[year]                                                      
  pgye = Pgye[year]
  
  source("UpdateParents_public.R") #Pick new parents
  source("Burnin_cycle.R") #Advances public yield trials by a year
  source("UpdateResults_public.R") #Track summary data
  
  source("UpdateParents_private.R") #Pick new parents and testers
  source("Advance_cycle_private.R") #Advances private yield trials by a year
  
  if ((year %% 1)==0){
    source("UpdateTesters.R") #Pick new testers
    
    
  }
}

#Save burn-in to load later use
save.image(sprintf("tmp_r%s_GE%s.rda",rep,VarGE))

###------------------------------------------------------------------------
###  4. Scenario 1 - Baseline plus early recycling (CONVe)
###------------------------------------------------------------------------
# 4.0 Loading the scenarios
load(sprintf("tmp_r%s_GE%s.rda",rep,VarGE))

# 4.1 Looping through the years
cat("Working on Scenario 1\n")
for(year in (burninYears+1):(burninYears+futureYears)){            
  cat("Working on Year:",year,"\n")                   
  pgy = Pgy[year]                                                      
  pgye = Pgye[year]
  
  #Private program
  source("UpdateParents_private.R") 
  source("Advance_cycle_private.R") 
  
  if ((year %% 1)==0){
    source("UpdateTesters.R")
  }
  
  ##Scenario baseline
  source("UpdateParents.R")
  source("Advance_cycle_BS.R")
  source("UpdateResults_BS.R")
  
}

# 4.2 Read the RDS
output = readRDS(sprintf("Scenario_CONVe_r%s_GE%s.rds",rep,VarGE))
output = list(hybridMean=rbind(output$hybridMean,hybridMean),
              accF3=rbind(output$accF3,accF3),
              accF5=rbind(output$accF5,accF5),
              parent_mean=rbind(output$parent_mean,parent_mean),
              parent_var=rbind(output$parent_var,parent_var))

# 4.3 Saving the results
saveRDS(output, sprintf("Scenario_CONVe_r%s_GE%s.rds",rep,VarGE))

###------------------------------------------------------------------------
###  5. Scenario 2 - Baseline plus early recycling and HTP (CONVe_HTP)
###------------------------------------------------------------------------
# 5.0 Loading the scenarios
load(sprintf("tmp_r%s_GE%s.rda",rep,VarGE))

# 5.1 Looping through the years
cat("Working on Scenario 2\n")
for(year in (burninYears+1):(burninYears+futureYears)){            
  cat("Working on Year:",year,"\n")                   
  pgy = Pgy[year]                                                      
  pgye = Pgye[year]
  
  #Private program
  source("UpdateParents_private.R") 
  source("Advance_cycle_private.R") 
  
  if ((year %% 1)==0){
    source("UpdateTesters.R")
  }
  
  # Scenario baseline
  source("UpdateParents.R")
  source("Advance_cycle_BSp.R") 
  source("UpdateResults_BS.R") 
}

# 5.2 Read the RDS
output = readRDS(sprintf("Scenario_CONVe_HTP_r%s_GE%s.rds",rep,VarGE))
output = list(hybridMean=rbind(output$hybridMean,hybridMean),
              accF3=rbind(output$accF3,accF3),
              accF5=rbind(output$accF5,accF5),
              parent_mean=rbind(output$parent_mean,parent_mean),
              parent_var=rbind(output$parent_var,parent_var))

# 5.3 Saving the results
saveRDS(output, sprintf("Scenario_CONVe_HTP_r%s_GE%s.rds",rep,VarGE))

###------------------------------------------------------------------------
###  6. Scenario 3 - Genomic selection with early selection (GSe)
###------------------------------------------------------------------------
# 6.0 Loading the scenarios
load(sprintf("tmp_r%s_GE%s.rda",rep,VarGE))

# 6.1 Looping through the years
cat("Working on Scenario 3\n")
for(year in (burninYears+1):(burninYears+futureYears)){            
  cat("Working on Year:",year,"\n")                   
  pgy = Pgy[year]                                                      
  pgye = Pgye[year]
  
  # Private program
  source("UpdateParents_private.R") 
  source("Advance_cycle_private.R") 
  
  if ((year %% 1)==0){
    source("UpdateTesters.R") #Pick new testers
  }
  
  # Scenario GS
  
  if(year==(burninYears+1)){
    gsModel = RRBLUP(c(F1_public,F2_public), use = "pheno", snpChip = 1)
    F3_public.ebv = setEBV(F3_public.s0,gsModel) 
    F3_public.sel = selectWithinFam(F3_public.ebv, nInd = 2, selectTop = TRUE,use="ebv") 
    
    F5_public.ebv = setEBV(F5_public.s0,gsModel) 
    F5_public.sel = selectWithinFam(F5_public.ebv, nInd = 1, selectTop = TRUE,use="ebv") 
    F5_public.sel = selectInd(F5_public.sel, nInd = 150, selectTop = TRUE, use="ebv")
    
  }
  
  source("UpdateParents_GS.R") 
  source("Advance_cycle_GS.R") 
  source("UpdateResults_GS.R") 

}

# 6.2 Read the RDS
output = readRDS(sprintf("Scenario_GSe_r%s_GE%s.rds",rep,VarGE))
output = list(hybridMean=rbind(output$hybridMean,hybridMean),
              accF3=rbind(output$accF3,accF3),
              accF5=rbind(output$accF5,accF5),
              parent_mean=rbind(output$parent_mean,parent_mean),
              parent_var=rbind(output$parent_var,parent_var))

# 6.3 Saving the results
saveRDS(output, sprintf("Scenario_GSe_r%s_GE%s.rds",rep,VarGE))

###------------------------------------------------------------------------
###  7. Scenario 4 - Genomic selection with early selection and HTP (GSe_HTP)
###------------------------------------------------------------------------
# 7.0 Loading the scenarios
load(sprintf("tmp_r%s_GE%s.rda",rep,VarGE))

# 7.1 Looping through the years
cat("Working on Scenario 4\n")
for(year in (burninYears+1):(burninYears+futureYears)){            
  cat("Working on Year:",year,"\n")                   
  pgy = Pgy[year]                                                      
  pgye = Pgye[year]
  
  #Private program
  source("UpdateParents_private.R") 
  source("Advance_cycle_private.R") 
  
  if ((year %% 1)==0){
    source("UpdateTesters.R") #Pick new testers
  }
  
  # Scenario GS
  if(year==(burninYears+1)){
    gsModel = RRBLUP(c(F1_public,F2_public), use = "pheno", snpChip = 1)
    F3_public.ebv = setEBV(F3_public.s0,gsModel)
    F3_public.sel = selectWithinFam(F3_public.ebv, nInd = 2, selectTop = TRUE,use="ebv")
    
    F5_public.ebv = setEBV(F5_public.s0,gsModel)
    F5_public.sel = selectWithinFam(F5_public.ebv, nInd = 1, selectTop = TRUE,use="ebv")
    F5_public.sel = selectInd(F5_public.sel, nInd = 150, selectTop = TRUE, use="ebv")
  }
  
  source("UpdateParents_GS.R") 
  source("Advance_cycle_GSp.R") 
  source("UpdateResults_GS.R") 
  
}

# 7.2 Read the RDS
output = readRDS(sprintf("Scenario_GSp_r%s_GE%s.rds",rep,VarGE))
output = list(hybridMean=rbind(output$hybridMean,hybridMean),
              accF3=rbind(output$accF3,accF3),
              accF5=rbind(output$accF5,accF5),
              parent_mean=rbind(output$parent_mean,parent_mean),
              parent_var=rbind(output$parent_var,parent_var))

# 7.3 Saving the results
saveRDS(output, sprintf("Scenario_GSe_HTP_r%s_GE%s.rds",rep,VarGE))

###------------------------------------------------------------------------
###  8. Removing the .rda files
###------------------------------------------------------------------------
file.remove(sprintf("tmp_r%s_GE%s.rda",rep,VarGE))


####### The end 




