#####-----------------------------------------------
#Replace the old testers by new elite lines that come from the private breeding program
#####-----------------------------------------------

# 1. Selecting the top ranked from private breeding program 
Elite_private = c(Elite_private,Parents_private_update)
Elite_private = selectInd(Elite_private, nInd = nElite, selectTop = TRUE,use="gv")

# 2. Update testers
Tester1_private = Elite_private[1:nTester1]
Tester2_private = Elite_private[1:nTester2]
Tester3_private = Elite_private[1:nTester3]
