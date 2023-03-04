###---------
# Choosing the best lines to update the crossing blocks
# Strategy two: best individuals from populations F3 and F5 based on 'ebv'
###---------

Parents_public_update = c(F5_public.sel,F3_public.sel)
Parents_public_update = selectInd(Parents_public_update, nInd= nParents_public, selectTop = TRUE, use = "ebv")

