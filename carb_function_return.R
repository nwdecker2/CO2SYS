## Value
  ## The function returns a data frame containing the following columns:

## S <-  Salinity

## T <-  Temperature in degrees Celsius

## Patm <-  Surface atmospheric pressure in atm

## P <- Hydrostatic pressure in bar

## pH <- pH

## CO2 <- CO2 concentration (mol/kg)

## pCO2 <- "standard" pCO2, CO2 partial pressure computed at in situ temperature
##          and atmospheric pressure (µatm)

## fCO2 <- "standard" fCO2, CO2 fugacity computed at in situ temperature 
##          and atmospheric pressure (µatm)

## pCO2pot <- "potential" pCO2, CO2 partial pressure computed at potential 
##          temperature and atmospheric pressure (µatm)

## fCO2pot <- "potential" fCO2, CO2 fugacity computed at potential temperature 
##          and atmospheric pressure (µatm)

## pCO2insitu <-  "in situ" pCO2, CO2 partial pressure computed at in situ 
##          temperature and total pressure (atm + hydrostatic) (µatm)

## fCO2insitu <- "in situ" fCO2, CO2 fugacity computed at in situ temperature 
##          and total pressure (atm + hydrostatic) (µatm)

## HCO3 <- HCO3 concentration (mol/kg)

## CO3 <- CO3 concentration (mol/kg)

## DIC <- DIC concentration (mol/kg)

## ALK <- ALK, total alkalinity (mol/kg)

## OmegaAragonite <- Omega aragonite, aragonite saturation state

## OmegaCalcite <- Omega calcite, calcite saturation state

## Warning: 
##   pCO2 estimates below 100 m are subject to considerable uncertainty. 
##   See Weiss (1974) and Orr et al. (2015)
