## Pedotransfer function for Bulk Density
rm(list=ls())
set.seed (12567)

library(randomForestSRC)
#library(ggRandomForests)
library(ggplot2)
library(scales)
#library(rgdal)
library(grid)
library(gridExtra)
library(clhs)
library(caret)
library(terra)

########## Import the package dataset to build PTF

load("env-data/soil/Geo_Peds06132016.Rda")
#Subset pedons for depth less than 200 cm
Peds_200 <- subset(Geo_Peds, Geo_Peds$depth <= 200)

# Extract BD model variables
fm = bd ~ soc + ph_h2o + sand + clay + depth + structsize + structtype + surf_geology + province + hzn_desg

## Missing values distribution:
sel <- (Peds_200[,all.vars(fm)])
summary(sel)


# Extract complete cases for comparison
sel.complete <- complete.cases(sel)
summary(sel.complete)
## 41,878 complete (or 20%)
Peds_complete <- sel[sel.complete,]

# Create latin hypercube sample with 50% of complete data (50% selected for speed)
cs <- clhs(Peds_complete, size  = nrow(Peds_complete)/2, progress = FALSE, simple = FALSE)

# Create calibration dataframe of latin hypercube samples
calib_data <- cs$sampled_data
rfsrc_BD <- rfsrc(fm, data=calib_data, ntree=150)

########## import my data to use the model on websoilsurvey data then Francois texture data
soil_data_d <- read_csv("env-data/soil/data_for_bulk_density.csv")

# Run the model with websoilsurvey data

bd_predict <- predict.rfsrc(rfsrc_BD, newdata = soil_data_d) 
bd_predict$predicted

# Run the model with francois 2022-2023 texture data
soil_data_francois <- read_csv("env-data/soil/data_for_bulk_density.csv")

bd_predict <- predict.rfsrc(rfsrc_BD, newdata = soil_data_d) 
bd_predict$predicted




