#####-----------------------------------------------
#Track population, hybrid and parents performances for GS scenarios
#####-----------------------------------------------

###>>>-------- 1. Hybrid Mean
hybridMean[year] = meanG(Hybrid)

###>>>-------- 2. Accuracy of the genomic selection
accF5[year] = cor(F5_public.ebv@gv,F5_public.ebv@ebv)
accF3[year] = cor(F3_public.ebv@gv,F3_public.ebv@ebv)

###>>>-------- 3. Genetic mean in the Parents
parent_mean[year] = meanG(Parents_public_update)
parent_var[year] = varG(Parents_public_update)


