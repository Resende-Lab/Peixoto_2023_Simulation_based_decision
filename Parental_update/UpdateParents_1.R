###---------
# Choosing the best lines to update the crossing blocks
# Strategy One: best individuals from the first testcrosses
###---------

Parents_public_update = F6_public.sel
Parents_public_update = selectInd(Parents_public_update, nInd= nParents_public, selectTop = TRUE)

