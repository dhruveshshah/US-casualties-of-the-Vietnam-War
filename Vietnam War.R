#Installing required libraries
install.packages("ggplot2")
install.packages("plyr")
install.packages("RColorBrewer")
install.packages("maps")
install.packages("sp")
install.packages("Amelia")

library(ggplot2)
library(plyr)
library(sp)
library(RColorBrewer)
library(maps)
library(Amelia)

setwd("..\Kaggle\\Vietnam_War")
str(data)
#Load data
data <- read.csv('..Kaggle\\Vietnam_War\\VietnamConflict.csv', na.strings=c("","NA")) 
# load Vietnam Map
gadm <- readRDS("..Kaggle\\Vietnam_War\\Vietnam_GADM_MAP_1.rds")
head(data)

#resize plot output
options(repr.plot.width=5, repr.plot.height=15)
# missing data plot
missmap(data, rank.order = TRUE, x.cex = 0.8, y.cex = 1.5)
# change dates into date format
data$BIRTH_YEAR <- as.Date(as.character(data$BIRTH_YEAR), "%Y%m%d")
data$FATALITY_DATE <- as.Date(as.character(data$FATALITY_DATE), "%Y%m%d")
str(data)

# calculating the frequency across the military divisions
branch_count <- as.data.frame(table(data$BRANCH))
# print frequency table
branch_count
total_casualties<-sum(branch_count$Freq)
cat("Total US casualties is:", total_casualties)
branch_count["percentage"]<-round((branch_count$Freq/total_casualties)*100,2)
branch_count
ggplot(branch_count,aes(x=branch_count$Var1, y=percentage))+
  geom_bar(stat = "identity",position = "dodge")+
  ggtitle("Branch Distribution")+
  theme(plot.title = element_text(hjust=0.5))+
  xlab("Branch")+
  ylab("Frequency")+
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust=0.4))+
  ylim(0,100)+
  geom_text(aes(label=paste(sprintf("%0.1f",percentage))),vjust=-0.3,size=3)+
  theme(legend.position = "none")+
  theme_bw()

#Distribution of casualties across Marital Statuses
marital_status<-as.data.frame(table(data$MARITAL_STATUS))
marital_status
marital_status["percentage"]<-round((marital_status$Freq/sum(marital_status$Freq))*100,2)
marital_status
ggplot(marital_status,aes(x=marital_status$Var1,y=percentage))+
  theme_bw()+
  xlab("Marital Status")+
  ylab("Frequency")+
  ggtitle("Marital Status")+
  geom_histogram(stat = "identity",position='dodge')+
  geom_text(aes(label=paste(sprintf("%0.2f",percentage))),vjust=-0.3,size=3)+
  theme(legend.justification ="right")+
  theme(axis.text.x = element_text(angle=45, hjust=1, vjust = 1.0))

#Distribution of casualties across religious beliefs
religious<-as.data.frame(table(data$RELIGION))
religious
religious_count<-sum(religious$Freq)
religious["percentage"]<-round((religious$Freq/religious_count)*100,2)
religious_order<-religious[order(-religious$percentage),]
religious_order

#Tree Map
religious$label <- paste(religious$Var1, religious$percentage, sep = " : ")
religious$label<-paste0(religious$label,"%")
install.packages("treemap")
library(treemap)
treemap(religious,index= c("label"), vSize = "percentage",title="Casualties distribution across Ethnicity",
        force.print.labels = FALSE,fontsize.title = 15,
        fontsize.labels = 10,vColor = "percentage" ,type = "value")
