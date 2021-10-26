library(tidyverse)
library(lubridate)
library(parsedate)
library(readxl)
library(here)

chl <- read_csv(here("original_data", "IYSchl_Hunt&Pakhomov.xlsx - Chl data.csv")) %>% 
  mutate(Date = dmy(Date),
         eventDate = format_iso_8601(as.POSIXct(paste(Date, Time), 
                                                          format="%Y-%m-%d %H:%M:%S", 
                                                          tz="Asia/Kamchatka")),
         eventDate = str_replace(eventDate, "\\+00:00", "Z"),
         year = year(eventDate),
         month = month(eventDate),
         day = day(eventDate),
         time = hms::as_hms(ymd_hms(eventDate)),
         cruise = "GoA2019",
         station = paste(cruise, Station, sep="_Stn"),
         profile = paste(station, "profile1", sep=":")) %>% 
  select(cruise, station, profile, eventDate, year, month, day, time, Latitude:Longitude, Depth:Region) 
  

write_csv(chl, here("standardized_data", "IYS_NISKIN_chl_phaeo.csv"))
