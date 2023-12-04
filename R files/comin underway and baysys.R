library(dplyr)
library(here)
library(readxl)
library(janitor)
library(writexl)

## load data
underway <- read_xlsx(here("BaySys Data/underwaypco2.xlsx"), 
                      sheet = "Working") %>%
  clean_names() %>% 
  rename(lat = latitude) %>% 
  rename(long = longitude) %>% 
  mutate(across(c('lat', 'long'), round, 2))

baysysdata <- read_xlsx(here("BaySys Data/cleaned_baysys_data.xlsx"),
                        sheet = "co2sys_l") %>% 
  mutate(across(c('lat', 'long'), round, 2))
  
# First, filter rows from underway based on lat and long in baysysdata
filtered_uw <- underway %>%
  semi_join(baysysdata, by = c("lat", "long"))

# Second, calculate the average value of pco2sw for each lat and long combination in y
avg_pco2sw <- filtered_uw %>%
  group_by(long, lat) %>%
  summarize(avg_pco2sw = mean(p_co2sw, na.rm = TRUE))

# Third, add the average values to the corresponding rows in x
result <- baysysdata %>%
  left_join(avg_pco2sw, by = c("lat", "long"))

write_xlsx(result, here("Output Files/baysys_w_uw.xlsx"))

