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


# Investigate how taxi was reported
unique(unlist(clean_dat$`VEHICLE TYPE CODE 1`))

# Create data set where taxis are involved
taxi_types <- c('Taxi', 'TAXI', 'YELLOW TAXI', 'yellow taxi', 'yellow cab', 'CAB', 'cab')
taxi_accident <- clean_dat %>% 
  filter(`VEHICLE TYPE CODE 1` %in% taxi_types | `VEHICLE TYPE CODE 2` %in% taxi_types | `VEHICLE TYPE CODE 3` %in% taxi_types | `VEHICLE TYPE CODE 4` %in% taxi_types | `VEHICLE TYPE CODE 5` %in% taxi_types)


# Plot data to get feel for trends
## Agg data by month-year
taxi_accident_month <- taxi_accident %>% 
  mutate(month = month(`CRASH DATE`),
         year = year(ymd(`CRASH DATE`))) %>% 
  group_by(month,year) %>% 
  summarise(count = n()) %>% 
  relocate(year,month) %>% 
  unite('year_month', year:month, sep = '-', remove = F) %>% 
  mutate(year_month = ym(year_month))
  

ggplot(taxi_accident_month, aes(x=year_month, y = count)) +
  geom_line() +
  geom_point() +
  theme_minimal()










