carb() 
## Parameters of the seawater carbonate system
##      Note: carbb() can be used to inlcude boron

## Description
## Returns parameters of the seawater carbonate system.

## Usage
carb(flag, var1, var2, S=35, T=25, Patm=1, P=0, Pt=0, Sit=0,
     k1k2="x", kf="x", ks="d", pHscale="T", b="u74", gas="potential",
     warn="y", eos="eos80", long=1.e20, lat=1.e20)


## Arguments

flag 
## Select the couple of variables available. The flags which can be used are:
## flag = 1 pH and CO2 given
## flag = 2 CO2 and HCO3 given
## flag = 3 CO2 and CO3 given
## flag = 4 CO2 and ALK given
## flag = 5 CO2 and DIC given
## flag = 6 pH and HCO3 given
## flag = 7 pH and CO3 given
## flag = 8 pH and ALK given
## flag = 9 pH and DIC given
## flag = 10 HCO3 and CO3 given
## flag = 11 HCO3 and ALK given
## flag = 12 HCO3 and DIC given
## flag = 13 CO3 and ALK given
## flag = 14 CO3 and DIC given
## flag = 15 ALK and DIC given
## flag = 21 pCO2 and pH given
## flag = 22 pCO2 and HCO3 given
## flag = 23 pCO2 and CO3 given
## flag = 24 pCO2 and ALK given
## flag = 25 pCO2 and DIC given

var1 <- value of the first variable in mol/kg, except for pH and for pCO2 in µatm

var2 <- enter value of the second variable in mol/kg, except for pH

S <- Salinity

T <- Temperature in degrees Celsius

Patm <- Surface atmospheric pressure in atm

P <- Hydrostatic pressure in bar (surface = 0)

Pt <- Concentration of total phosphate in mol/kg; set to 0 if NA

Sit <- Concentration of total silicate in mol/kg; set to 0 if NA

k1k2 <- "l" for using K1 and K2 from Lueker et al. (2000),
        "m02" from Millero et al.(2002),
        "m06" from Millero et al. (2006),
        "m10" from Millero (2010),
        "mp2" from Mojica Prieto et al. (2002),
        "p18" from Papadimitriou et al. (2018),
        "r" from Roy et al. (1993),
        "sb21" from Shockman & Byrne (2021),
        "s20" from Sulpis et al. (2020), and
        "w14" from Waters et al. (2014).
        "x" is the default flag; 
        the default value is then "l", 
        except if T is outside the range 2 to 35oC and/or 
        S is outside the range 19 to 43. 
        In these cases, the default value is "w14".
        
kf <-  "pf" for using Kf from Perez and Fraga (1987) and
       "dg" for using Kf from Dickson and Riley (1979 in Dickson and Goyet, 1994).
       "x" is the default flag; 
       the default value is then "pf", except if T is outside the 
       range 9 to 33oC and/or S is outside the range 10 to 40. 
       In these cases, the default is "dg".
      
ks <-  "d" for using Ks from Dickon (1990), 
       "k" for using Ks from Khoo et al. (1977),
        default is "d"

pHscale <-  choice of pH scale: "T" for the total scale, 
                                "F" for the free scale and
                                "SWS" for using the seawater scale,
                                default is "T" (total scale)
                                
b <-  Concentration of total boron. 
      "l10" for the Lee et al. (2010) formulation or
      "u74" for the Uppstrom (1974) formulation, 
      default is "u74"
      
gas <- used to indicate the convention for INPUT pCO2
        i.e., when it is an input variable (flags 21 to 25): 
        "insitu" indicates it is referenced to in situ pressure an in situ temperature; 
        "potential" indicates it is referenced To 1 atm pressure and potential temperature; and 
        "standard" indicates it is referenced to 1 atm pressure and in situ temperature. 
        All three options should give identical results at surface pressure. 
        This option is not used when pCO2 is not an input variable 
        (flags 1 to 15). The default is "potential".
      
warn <-  "y" to show warnings when T or S go beyond the valid range for constants;
         "n" to supress warnings. 
         The default is "y".
         
eos <- "teos10" to specify T and S according to Thermodynamic Equation Of Seawater
        - 2010 (TEOS-10); "eos80" to specify T and S according to EOS-80.

long <- longitude of data point, used when eos parameter is "teos10"
        as a conversion parameter from absolute to practical salinity.
        
lat <- latitude of data point, used when eos parameter is "teos10".