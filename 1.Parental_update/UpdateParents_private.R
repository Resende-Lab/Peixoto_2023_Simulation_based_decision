# Replace oldest parents with new inbreds
# Created for replacing the parents in the private breeding program

Parents_private_update = c(Parents_private_update,F8_private.sel,F7_private.sel)
Parents_private_update = selectInd(Parents_private_update, nInd= nParents_private,selectTop = TRUE)

