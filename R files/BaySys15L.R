library(tidyverse)
library(seacarb)
library(janitor)
library(here)
library(readxl)
library(writexl)

# Load the Cleaned Data

cleaned_baysys_data <- read_excel(here("BaySys Data/cleaned_baysys_data.xlsx"))

# Final Calculation
baysys_carb <- carb(flag = "15",
                    cleaned_baysys_data$var1,
                    cleaned_baysys_data$var2,
                    cleaned_baysys_data$s,
                    cleaned_baysys_data$t,
                    (cleaned_baysys_data$Patm)/101.3, # divided by 101.3 for unit conversion
                    (cleaned_baysys_data$p)/10, # divided by 10 for unit conversion
                    Pt=0,
                    Sit=0,
                    k1k2 = "l", # K1 and K2 from Lueker et al. (2000)
                    kf="dg", # Dickson and Riley (1979)
                    ks="d", # Dickson (1990)
                    pHscale="T", # Total Scale
                    b="l10", # Lee et al. (2010)
                    warn="y", # Shows warnings if T or S are out of range
                    eos="teos10", 
                    long, lat) %>% 
  mutate(sid = cleaned_baysys_data$sid) %>% 
  select(sid, everything()) %>% 
  select(everything(), -flag)

# Short dataframe creation to log the constants used

baysys_calls <- data.frame(
  flag = 15,
  Pt = c(0),
  Sit = c(0),
  k1k2 = c("l"),
  kf = c("dg"),
  ks = c("d"),
  pHscale = c("T"),
  b = c("l10"),
  warn = c("y"),
  eos = c("teos10")
)


# Save the Output
write_xlsx(list(seacarb_output = baysys_carb, 
                baysys_calls = baysys_calls),
           path = here("Output Files/15_l_teos.xlsx"))


