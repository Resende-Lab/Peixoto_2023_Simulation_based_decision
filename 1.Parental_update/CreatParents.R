#####---------------------------------------------------------------------------
##### Creating the base genome
#####---------------------------------------------------------------------------

library(AlphaSimR)

#############################################################################################################
########-------------- Initializing the Program: Creating the founder population -------------------#########
#############################################################################################################
###----- Seeting up one set.seed for each replication
set.seed(123)

n = sample(0:100000, 50, replace = FALSE)

set.seed(n[rep])

###---- Creating the founder population

founderPop <- runMacs(nInd = nParents, nChr = 10, segSites = nQtl+nSnp, inbred = FALSE,
                      species = "MAIZE", split = 30, ploidy = 2L,
                      manualCommand = NULL, manualGenLen = NULL)


#############################################################################################################
########------------------------------- Setting the traits parameters ------------------------------#########
#############################################################################################################


SP <- SimParam$new(founderPop)
SP$restrSegSites(nQtl,nSnp)
if(nSnp>0){
  SP$addSnpChip(nSnp)
}
SP$addTraitADG(nQtl,mean=MeanG,var=VarG,
               varGxE=VarGE,meanDD=ddMean,varDD=ddVar,varEnv=0)
SP$setVarE(H2=H2)


#############################################################################################################
########------------------------------- Setting the initial individuals -----------------------------########
#############################################################################################################
###>>> ------ Parents from the initial population for public breeding program
Parents_public = newPop(founderPop[1:50])
Parents_public_update = Parents_public

nCrosses_public = 50 

###>>> ------ Parents from the initial population for private breeding program
Parents_private = newPop(founderPop[(101):(200)])
Parents_private_update = Parents_private

nCrosses_private = 200 

###>>> ------ Set the test cross parents for later yield trials
nElite = 5
nTester1 = 1
nTester2 = 3
nTester3 = 5

Elite_private = selectInd(Parents_private,nElite,use="gv")
Elite_private = Elite_private[nElite:1]
Tester1_private = Elite_private[1:nTester1]
Tester2_private = Elite_private[1:nTester2]
Tester3_private = Elite_private[1:nTester3]

repTC1 = 2
repTC2 = 5
repTC3 = 20

