########################################################################################
##### Advance breeding program - Conventional program
#########################################################################################

######------------------------------  Year 5  ---------------------------------------#######
F10_public = self(F9_public.sel, nProgeny = 1, parents = NULL, keepParents = FALSE) # Fall
TC3 = setPhenoGCA(F9_public.sel, Tester3_private,reps=repTC3,p=pgy) # Winter

F11_public = self(F10_public, nProgeny = 1, parents = NULL, keepParents = FALSE) # Winter
TC3 = selectInd(TC3,nInd=2, selectTop = TRUE) # Winter
F10_public.sel = F10_public[F10_public@mother%in%TC3@id]
F11_public.sel = F11_public[F11_public@mother%in%F10_public.sel@id] # Winter

Hybrid = hybridCross(F9_public.sel, Tester3_private,crossPlan = "testcross") # Fall
Hybrid = setPheno(Hybrid,reps=repTC3,p=pgy) # Winter
Hybrid = selectInd(Hybrid,nInd=2, selectTop = TRUE) # Winter

######------------------------------  Year 4  ---------------------------------------#######
F8_public = self(F7_public.sel, nProgeny = 1, parents = NULL, keepParents = FALSE) # Fall
TC2 = setPhenoGCA(F7_public.sel, Tester2_private,reps=repTC2,p=pgy) # Fall/Winter

F9_public = self(F8_public, nProgeny = 1, parents = NULL, keepParents = FALSE) # Winter
TC2 = selectInd(TC2,nInd=15, selectTop = TRUE) # Winter
F8_public.sel = F8_public[F8_public@mother%in%TC2@id]
F9_public.sel = F9_public[F9_public@mother%in%F8_public.sel@id] # Winter

######------------------------------  Year 3  ---------------------------------------#######
F6_public = self(F5_public.s0, nProgeny = 3, parents = NULL, keepParents = FALSE) # Fall
F5_public.phen = setPheno(F5_public.s0,reps=1, p=pgye) # Fall
F5_public.sel = selectWithinFam(F5_public.phen, nInd = 2, selectTop = TRUE) # Fall
F5_public.sel = selectInd(F5_public.sel, nInd = 150, selectTop = TRUE) # Winter
F6_public.s0 = F6_public[F6_public@mother%in%F5_public.sel@id] # Fall

TC1 = setPhenoGCA(F5_public.sel,Tester1_private,reps=repTC1,p=pgy) # Fall/Winter
TC1 = selectInd(TC1,nInd=100, selectTop = TRUE) # Winter
F7_public = self(F6_public.s0, nProgeny = 1, parents = NULL, keepParents = FALSE) # Winter
F6_public.sel = F6_public.s0[F6_public.s0@mother%in%TC1@id]
F6_public.sel = selectWithinFam(F6_public.sel, nInd = 1, selectTop = TRUE) 
F7_public.sel = F7_public[F7_public@mother%in%F6_public.sel@id]

######------------------------------  Year 2  ---------------------------------------#######
F4_public = self(F3_public.s0, nProgeny = 4, parents = NULL, keepParents = FALSE) # Fall
F3_public.phen = setPheno(F3_public.s0,reps=1, p=pgye) # Fall
F3_public.sel = selectWithinFam(F3_public.phen, nInd = 2, selectTop = TRUE) # Fall
F4_public.s0 = F4_public[F4_public@mother%in%F3_public.sel@id] # Fall

F5_public = self(F4_public.s0, nProgeny = 4, parents = NULL, keepParents = FALSE) # Winter
F4_public.s0 = setPheno(F4_public.s0,reps=2, p=pgy) # Winter
F4_public.sel = selectWithinFam(F4_public.s0, nInd = 2, selectTop = TRUE) # Winter
F4_public.sel = selectInd(F4_public.sel, nInd = 300, selectTop = TRUE) # Winter
F5_public.s0 = F5_public[F5_public@mother%in%F4_public.sel@id]


######------------------------------  Year 1  ---------------------------------------#######
F1_public = randCross(Parents_public_update, nCrosses_public, ignoreSexes = TRUE) # Spring
F2_public = self(F1_public, nProgeny = 10, parents = NULL, keepParents = FALSE) # Fall
F3_public = self(F2_public, nProgeny = 6, parents = NULL, keepParents = FALSE) # Winter
F2_public = setPheno(F2_public,reps=2, p=pgy) # Winter
F2_public.sel = selectWithinFam(F2_public, nInd = 4, selectTop = TRUE) # Winter
F3_public.s0 = F3_public[F3_public@mother%in%F2_public.sel@id] # Winter

