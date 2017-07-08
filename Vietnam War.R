install.packages("ggplot2")
library(ggplot2)
install.packages("plyr")
library(plyr)
install.packages("RColorBrewer")
library(RColorBrewer)
install.packages("maps")
library(maps)
install.packages("sp")
library(sp)
library(Amelia)

setwd("..\\Kaggle\\Vietnam_War")

#Load data
data <- read.csv('..Kaggle\\Vietnam_War\\VietnamConflict.csv', na.strings=c("","NA")) 
# load Vietnam Map
gadm <- readRDS("..Kaggle\\Vietnam_War\\Vietnam_GADM_MAP_1.rds")
head(data)

#resize plot output
options(repr.plot.width=5, repr.plot.height=5)
# missing data plot
missmap(data)
# change dates into date format
data$BIRTH_YEAR <- as.Date(as.character(data$BIRTH_YEAR), "%Y%m%d")
data$FATALITY_DATE <- as.Date(as.character(data$FATALITY_DATE), "%Y%m%d")

