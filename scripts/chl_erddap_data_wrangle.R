library(tidyverse)
library(lubridate)
library(parsedate)
library(readxl)
library(here)

chl <- read_csv(here("original_data", "IYSchl_Hunt&Pakhomov.xlsx - Chl data.csv")) %>% 
  mutate(Date = dmy(Date),
         dateTime = format_iso_8601(as.POSIXct(paste(Date, Time), 
                                                          format="%Y-%m-%d %H:%M:%S", 
                                                          tz="Asia/Kamchatka")),
         year = year(dateTime),
         month = month(dateTime),
         day = day(dateTime),
         time = hms::as_hms(ymd_hms(dateTime)),
         cruise = "GoA2019",
         station = paste(cruise, Station, sep="_Stn"),
         profile = paste(station, "profile1", sep=":")) %>% 
  select(cruise, station, profile, dateTime, year, month, day, time, Latitude:Longitude, Depth:Region) 
  

write_csv(chl, here("standardized_data", "IYS_NISKIN_chl_phaeo.csv"))
