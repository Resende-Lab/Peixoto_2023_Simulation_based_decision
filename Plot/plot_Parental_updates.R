################################################################################
##### Plotting the outputs of analyses
################################################################################
require(cowplot)
require(ggplot2)
require(AlphaSimR)

####>>>>------------ Environment
rm(list=ls())

setwd(" ") # Change to your directory

####-----------------------------------------------------------------------------------
##>>>------- 1. Reading the rds files outputs 
####-----------------------------------------------------------------------------------

####>>>>------------ Preparing the scenarios
Scenarios = c("CONV","CONVe", "GS", "GSe") #Scenarios names

Reps = c(1:50)
Var_GxE = c("GE0", "GE30", "GE120")
rawData = vector("list", length = (length(Reps)*length(Scenarios)))
i = 0L
b.f = 50

####>>>>------------ Creat an empty dataframe
df = data.frame(Year = character(), 
                Scenario = character(), 
                Var_GxE = character(), 
                rep = numeric(),
                hybridMean = numeric(), 
                accF3=numeric(),
                accF5=numeric(),
                parent_mean=numeric(),
                parent_var=numeric())
                
####>>>>------------ Fullfil the dataframe

for (Scenario in Scenarios){
  for (Rep in Reps){
    for (GxE in Var_GxE){
      
      i = i+1L
      FILE = paste0("Scenario_", Scenario,  "_r" , Rep, "_", GxE,  ".rds")
      tmp = readRDS(FILE)
      
      fl = do.call(rbind.data.frame, tmp)
      df0 = as.data.frame(t(fl), row.names = TRUE)
      
      data = data.frame(Year = -19:30, Scen = rep(Scenario, b.f),rep = rep(Rep, b.f), Var_GxE = rep(GxE, b.f),   df0)
      
      df = rbind(df, data)
      
      }
    }
  }

####-----------------------------------------------------------------------------------
##>>>------- 2. Chance the names of the variables to appear in the graph   
####-----------------------------------------------------------------------------------
df1<-df

df1$Var_GxE = sub("GE0","GxE 0", df1$Var_GxE)
df1$Var_GxE = sub( "GE30", "GxE 30", df1$Var_GxE)
df1$Var_GxE = sub( "GE120", "GxE 120", df1$Var_GxE)

df1$Scen = sub("BSe","CONVe", df1$Scen)
df1$Scen = sub( "BS", "CONV", df1$Scen)


####-----------------------------------------------------------------------------------
##>>>------ 3. Plotting   
####-----------------------------------------------------------------------------------

###>>>-------- Plotting Population Mean

#Summarize the values of reps for CI
temp = ddply(df1,c("Year","Scen","Var_GxE"), summarize,
             mean = mean(parent_mean),
             se = sd(parent_mean)/sqrt(length(Reps)),
             upper.ci = mean + qnorm(0.975) * se,
             lower.ci = mean - qnorm(0.975) * se)


#Summarize the values over reps for Standard error
temp = ddply(df1,c("Year","Scen","Var_GxE"), summarize,
             mean = mean(parent_mean),
             se = sd(parent_mean)/sqrt(length(Reps)))

                          
temp$Var_GxE <- factor(temp$Var_GxE, levels = c("GxE 0", "GxE 30" ,"GxE 120"))


#tiff("PopMean.tiff", width = 16, height = 8, units = 'in', res = 450)
ggplot(temp,aes(x=Year,y=mean,color=Scen))+
  facet_wrap(~Var_GxE, ncol = 3) +
  geom_line(aes(color=Scen),size=1)+
  geom_line(aes(linetype=Scen))+
  geom_ribbon(aes(x=Year,ymin=mean-se,ymax=mean+se, fill=Scen),alpha=0.2,linetype=0)+
  theme(panel.grid.minor=element_blank(),
        panel.grid.major.y=element_blank(),
        panel.grid.major.x=element_blank(),
        plot.title = element_text(size = 18, hjust = 0.5, face = "bold"),
        legend.title = element_blank(),
        legend.text = element_text(size=16),
        legend.position = "bottom",
        legend.key = element_blank(),
        legend.key.width =   unit(2, 'cm'),
        axis.text = element_text(size = 15,colour = "black"),
        axis.title = element_text(size = 18),
        strip.text = element_text(face = "bold", size = 28, colour = 'blue'))+
  guides(alpha="none",color=guide_legend(override.aes=list(fill=NA)))+
  guides(linetype = guide_legend(override.aes = list(size = 2)))+
  scale_x_continuous("Year",limits=c(0,30))+
  scale_y_continuous("Population mean",expand = c(0, 0), limits = c(NA, NA), sec.axis = dup_axis(name = element_blank()))
#dev.off()

###>>>-------- Plotting Population Variance 
#Summarize the values of reps for CI
temp = ddply(df1,c("Year","Scen","Var_GxE"), summarize,
             mean = mean(parent_var),
             se = sd(parent_var)/sqrt(length(Reps)),
             upper.ci = mean + qnorm(0.975) * se,
             lower.ci = mean - qnorm(0.975) * se)


#Summarize the values over reps for Standard error
temp = ddply(df1,c("Year","Scen","Var_GxE"), summarize,
             mean = mean(parent_var),
             se = sd(parent_var)/sqrt(length(Reps)))

temp$Var_GxE <- factor(temp$Var_GxE, levels = c("GxE 0", "GxE 30" ,"GxE 120"))

#tiff("PopVar-1.tiff", width = 16, height = 8, units = 'in', res = 450)
ggplot(temp,aes(x=Year,y=mean,color=Scen))+
  facet_wrap(~Var_GxE, ncol = 3) +
  geom_line(aes(color=Scen),size=1)+
  geom_line(aes(linetype=Scen))+
  geom_ribbon(aes(x=Year,ymin=mean-se,ymax=mean+se, fill=Scen),alpha=0.2,linetype=0)+
  theme(panel.grid.minor=element_blank(),
        panel.grid.major.y=element_blank(),
        panel.grid.major.x=element_blank(),
        plot.title = element_text(size = 18, hjust = 0.5, face = "bold"),
        legend.title = element_blank(),
        legend.text = element_text(size=16),
        legend.position ="bottom",
        legend.key = element_blank(),
        legend.key.width =   unit(2, 'cm'),
        axis.text = element_text(size = 15,colour = "black"),
        axis.title = element_text(size = 18),
        strip.text = element_text(face = "bold", size = 28, colour = 'blue'))+
  guides(alpha="none",color=guide_legend(override.aes=list(fill=NA)))+
  guides(linetype = guide_legend(override.aes = list(size = 2)))+
  scale_x_continuous("Year",limits=c(0,30))+
  scale_y_continuous("Population variance",expand = c(0, 0), limits = c(NA, NA), sec.axis = dup_axis(name = element_blank()))
#dev.off()

###>>>-------- Plotting Hybrid Mean 

#Summarize the values of reps
temp = ddply(df1,c("Year","Scen","Var_GxE"), summarize,
             mean = mean(hybridMean),
             se = sd(hybridMean)/sqrt(length(Reps)))

temp$Var_GxE <- factor(temp$Var_GxE, levels = c("GxE 0","GxE 30", "GxE 120"))

#tiff("HybMean.tiff", width = 16, height = 8, units = 'in', res = 450)
ggplot(temp1,aes(x=Year,y=mean,color=Scen))+
  facet_wrap(~Var_GxE, ncol = 3) +
  geom_line(aes(color=Scen),size=1)+
  geom_line(aes(linetype=Scen))+
  #geom_ribbon(aes(x=Year,ymin=mean-se,ymax=mean+se, fill=Scen),alpha=0.2,linetype=0)+
  theme(panel.grid.minor=element_blank(),
        panel.grid.major.y=element_blank(),
        panel.grid.major.x=element_blank(),
        plot.title = element_text(size = 18, hjust = 0.5, face = "bold"),
        legend.title = element_blank(),
        legend.text = element_text(size=16),
        legend.position = "bottom",
        legend.key = element_blank(),
        axis.text = element_text(size = 15,colour = "black"),
        axis.title = element_text(size = 18),
        strip.text = element_text(face = "bold", size = 28, colour = 'blue'))+
  guides(alpha="none",color=guide_legend(override.aes=list(fill=NA)))+
  scale_x_continuous("Year",limits=c(0,30))+
  scale_y_continuous("Hybrid mean",expand = c(0, 0), limits = c(NA, NA), sec.axis = dup_axis(name = element_blank()))
#dev.off()




