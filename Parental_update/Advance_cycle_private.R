################################################################################################
#Advance breeding program - Private program
################################################################################################

######----------------------------------  Year 7  ---------------------------------#######
F8_private = self(F7_private.sel, nProgeny = 6, parents = NULL, keepParents = FALSE) # Fall
F8_private = setPheno(F8_private,reps=2, p=pgy) # Winter
F8_private.sel = selectWithinFam(F8_private, nInd = 1, selectTop = TRUE) # Winter
F8_private.sel = selectInd(F8_private.sel, nInd = 5, selectTop = TRUE) # Winter

######----------------------------------  Year 6  ---------------------------------#######
F7_private = self(F6_private.sel, nProgeny = 6, parents = NULL, keepParents = FALSE) # Fall
F7_private = setPheno(F7_private,reps=2, p=pgy) # Winter
F7_private.sel = selectWithinFam(F7_private, nInd = 1, selectTop = TRUE) # Winter
F7_private.sel = selectInd(F7_private.sel, nInd = 15, selectTop = TRUE) # Winter

######----------------------------------  Year 5  ---------------------------------#######
F6_private = self(F5_private.sel, nProgeny = 6, parents = NULL, keepParents = FALSE) # Fall
F6_private = setPheno(F6_private,reps=2, p=pgy) # Winter
F6_private.sel = selectWithinFam(F6_private, nInd = 1, selectTop = TRUE) # Winter
F6_private.sel = selectInd(F6_private.sel, nInd = length(F6_private.sel@id) * 0.5, selectTop = TRUE) # Winter

######----------------------------------  Year 4 ---------------------------------#######
F5_private = self(F4_private.sel, nProgeny = 6, parents = NULL, keepParents = FALSE) # Fall
F5_private = setPheno(F5_private,reps=2, p=pgy) # Winter
F5_private.sel = selectWithinFam(F5_private, nInd = 1, selectTop = TRUE) # Winter
F5_private.sel = selectInd(F5_private.sel, nInd = length(F5_private.sel@id) * 0.15, selectTop = TRUE) # Winter

######----------------------------------  Year 3  ---------------------------------#######
F4_private = self(F3_private.sel, nProgeny = 6, parents = NULL, keepParents = FALSE) # Fall
F4_private = setPheno(F4_private,reps=2, p=pgy) # Winter
F4_private.sel = selectWithinFam(F4_private, nInd = 2, selectTop = TRUE) # Winter
F4_private.sel = selectInd(F4_private.sel, nInd = length(F4_private.sel@id) * 0.2, selectTop = TRUE) # Winter

######----------------------------------  Year 2  ---------------------------------#######
F3_private = self(F2_private.sel, nProgeny = 6, parents = NULL, keepParents = FALSE) # Fall
F3_private = setPheno(F3_private,reps=1, p=pgy) # Winter
F3_private.sel = selectWithinFam(F3_private, nInd = 2, selectTop = TRUE) # Winter

######----------------------------------  Year 1  ---------------------------------#######
F1_private = randCross(Parents_private_update, nCrosses_private, ignoreSexes = TRUE) # Spring
F2_private = self(F1_private, nProgeny = 10, parents = NULL, keepParents = FALSE) # Fall
F2_private = setPheno(F2_private,reps=1, p=pgy) # Winter
F2_private.sel = selectWithinFam(F2_private, nInd = 5, selectTop = TRUE) # Winter
