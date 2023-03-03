#Replace oldest hybrid parent with parent of best inbreds# Replace oldest hybrid parent with parent of best inbreds
# Created for replacing the parents in the public breeding program in the burnin period

Parents_public_update = c(Parents_public_update,F7_public.sel,F6_public.sel)
Parents_public_update = selectInd(Parents_public_update, nInd= nParents_public, selectTop = TRUE)

