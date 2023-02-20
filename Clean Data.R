NYC Bike map: https://www.nycbikemaps.com/maps/manhattan-bike-map/
Citi Bike Todd S.:https://toddwschneider.com/posts/a-tale-of-twenty-two-million-citi-bikes-analyzing-the-nyc-bike-share-system/

library(tidyverse)
library(data.table)
library(lubridate)

a<-'F:\\Taxi_Data\\Collision Data'
setwd(a) 

# Data has 1950700 obs
raw_dat <- fread('Motor_Vehicle_Collisions_-_Crashes.csv')

# Remove obs with invalide coordinates
clean_dat <- raw_dat %>% 
  drop_na(LATITUDE) %>% 
  filter(LATITUDE != 0)

# Make date col date objecy
clean_dat$`CRASH DATE` <- mdy(clean_dat$`CRASH DATE`)

# Create data set where cyclists are involved
bike_accident <- clean_dat %>% 
  filter(`NUMBER OF CYCLIST INJURED` >0 | `NUMBER OF CYCLIST KILLED` >0)

# Create data set where taxis are involved
taxi_accident <- clean_dat %>% 
  filter(`VEHICLE TYPE CODE 1` == 'Taxi' | `VEHICLE TYPE CODE 2` == 'Taxi' | `VEHICLE TYPE CODE 3` == 'Taxi' | `VEHICLE TYPE CODE 4` == 'Taxi' | `VEHICLE TYPE CODE 5` == 'Taxi' | `VEHICLE TYPE CODE 1` == 'TAXI' | `VEHICLE TYPE CODE 2` == 'TAXI' | `VEHICLE TYPE CODE 3` == 'TAXI' | `VEHICLE TYPE CODE 4` == 'TAXI' | `VEHICLE TYPE CODE 5` == 'TAXI')





