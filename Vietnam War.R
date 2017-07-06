#Installing required libraries
library(ggplot2)
library(plyr)
library(RColorBrewer)
library(maps)
library(sp)
library(Amelia)

#Load data
data <- read.csv('/kaggle/input/VietnamConflict.csv', na.strings=c("","NA")) 
# load Vietnam Map
gadm <- readRDS("/kaggle/input/Vietnam_GADM_MAP_1.rds")
head(data)