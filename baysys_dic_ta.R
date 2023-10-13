## This file will perform the calculation using DIC and TA
##
##
library(seacarb)
library(tidyverse)
library(janitor)
library(here)
library(readxl)

baysys_data <- read_excel(here("BaySys Data/Baysys_Team4_All_data_2017-2018.xlsx"))
met_baysys <- read_excel(here("BaySys Data/BaySys_2018_Met&Rad.xlsx"))

baysys_data <- clean_names(baysys_data) 
met_baysys <- clean_names(met_baysys) 


## Need to clean up the Salinity. There are samples without measurements
## but for those the average salinity will be taken (different column).
## if there still is no salinity or temperature, the row must be discarded.

baysys_data$salinity <- ifelse(is.na(baysys_data$sal_psu), baysys_data$salinity_average, baysys_data$sal_psu)
baysys_clean <- baysys_data[complete.cases(as.numeric(baysys_data$salinity)), ]
baysys_data <- baysys_clean

## need to clean var1 and var2 still
baysys_clean2 <- baysys_data[complete.cases(as.numeric(baysys_data$dic)), ]
baysys_data <- baysys_clean2
## This cleaned up both columns

flag <- "15"                              ## 15 for Alk and DIC
var1 <- as.numeric(baysys_data$ta)        ## Alk
var2 <- as.numeric(baysys_data$dic)       ## DIC
s <- as.numeric(baysys_data$salinity)     ## Salinity range 20.17 to 34.65 psu
t <- as.numeric(baysys_data$temp_deg_c)   ## Temperature range -1.46 to 6.97 c
Patm <- ((as.numeric(met_baysys$atmospheric_pressure))/101.3)  
P <- ((as.numeric(baysys_data$press_db))/10)  
k1k2 <- "mp2" 
long <- baysys_data$longitude_degree_east  
lat <- baysys_data$latitude_degrees_north 

baysys_carb <- carb(flag, var1, var2, s, t, Patm, P, Pt=0, Sit=0,
     k1k2, kf="dg", ks="d", pHscale="T", b="l10",
     warn="y", eos="eos80", long, lat)
baysys_carb <- clean_names(baysys_carb)

final_data <- merge(baysys_carb, baysys_data, by= "dic")