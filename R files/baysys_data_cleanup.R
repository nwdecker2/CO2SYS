library(tidyverse)
library(seacarb)
library(janitor)
library(here)
library(readxl)
library(writexl)
library(geosphere)

# Read data
baysys_data <- read_excel(here("BaySys Data/Baysys_Team4_All_data_2017-2018.xlsx"))
met_baysys <- read_excel(here("BaySys Data/BaySys_2018_Met&Rad.xlsx"))

# Clean column names
baysys_data <- baysys_data %>%
  clean_names() %>% 
  rename(longitude = longitude_degree_east) %>% 
  rename(latitude = latitude_degrees_north) 
met_baysys <- met_baysys %>%
  clean_names()

# combine the dataframes based on thier longitude and latitude

find_closest_location <- function(lat1, lon1, met_baysys) {
  distances <- distVincentySphere(
    cbind(lon1, lat1),
    cbind(met_baysys$longitude, met_baysys$latitude)
  )
  closest_row <- which.min(distances)
  closest_location <- met_baysys[closest_row, ]
  return(closest_location)
}

baysys_total <- baysys_data %>%
  rowwise() %>%
  do({
    closest_location <- find_closest_location(.$latitude, .$longitude, met_baysys)
    bind_cols(data.frame(.), closest_location)
  })


# Creates a new dataframe with cleaned data and exports its as xlsx
cleaned_baysys_data <- baysys_total %>%
  select(sid, 
         ta, 
         dic,
         sal_psu,
         salinity_average, 
         temp_deg_c,
         atmospheric_pressure,
         press_db,
         longitude...4,
         latitude...5) %>% 
  rename(long = longitude...4) %>% 
  rename(lat = latitude...5) %>%
  rename(var1 = ta) %>% 
  rename(var2 = dic) %>% 
  rename(Patm = atmospheric_pressure) %>% 
  rename(p = press_db) %>% 
  rename(t = temp_deg_c) %>% 
  mutate(across(-sid, as.numeric)) %>% 
  mutate(s = ifelse(!is.na(sal_psu), sal_psu, salinity_average)) %>% 
  drop_na(var1, var2, t, s, Patm) %>% 
  mutate(sal_psu = NULL) %>% 
  mutate(salinity_average = NULL) %>% 
  write_xlsx(path = here("BaySys Data/cleaned_baysys_data.xlsx"))

# Temp Range: -1.8 - 22
# S Range: 0 - 34.6
