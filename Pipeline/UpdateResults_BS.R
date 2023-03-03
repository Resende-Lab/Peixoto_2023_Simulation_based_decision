#####-----------------------------------------------
#Track population, hybrid and parents performances
#####-----------------------------------------------
###>>>-------- 1. Hybrid Mean
hybridMean[year] = meanG(Hybrid)

###>>>-------- 2. Accuracy of the phenotic selection
accF5[year] = cor(F5_public.phen@gv,F5_public.phen@pheno)
accF3[year] = cor(F3_public.phen@gv,F3_public.phen@pheno)

###>>>-------- 3. Genetic mean in the Parents
parent_mean[year] = meanG(Parents_public_update)
parent_var[year] = varG(Parents_public_update)

