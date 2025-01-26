# API Data Extraction Script 

## Packages
library(tidyverse)
library(httr)
library(jsonlite)

## Geomagnetic indices (GFZ, Potsdam)
response_Ap <- GET("https://kp.gfz-potsdam.de/app/json/?start=2006-01-01T00:00:00Z&end=2022-12-31T23:59:59Z&index=Ap")
GFZ_Potsdam_Ap_raw <- fromJSON(content(response_Ap, "text", encoding = "UTF-8"))
GFZ_Potsdam_Ap <- tibble(Date = as.Date(ymd_hms(GFZ_Potsdam_Ap_raw$datetime)),
                         Ap_mean = GFZ_Potsdam_Ap_raw$Ap)

response_Kp <- GET("https://kp.gfz-potsdam.de/app/json/?start=2006-01-01T00:00:00Z&end=2022-12-31T23:59:59Z&index=Kp")
GFZ_Potsdam_Kp_raw <- fromJSON(content(response_Kp, "text", encoding = "UTF-8"))
GFZ_Potsdam_Kp <- tibble(Date = as.Date(ymd_hms(GFZ_Potsdam_Kp_raw$datetime)),
       Point = rep(c("K_00", "K_03", "K_06", "K_09", "K_12", "K_15", "K_18", "K_21"), 6209),
       Kp = GFZ_Potsdam_Kp_raw$Kp) %>% 
  pivot_wider(names_from = Point, values_from = Kp) %>% 
  rowwise() %>% 
  mutate(across(starts_with("K"), ~ifelse(. == -1, NA, .)),
         Kp_Sum = sum(c_across(starts_with("K")), na.rm = FALSE)
  )


## Calendar (isDayOff)
DayOff <- c()
for (i in 2006:2022){
 
  response <- GET(paste0("https://isdayoff.ru/api/getdata?year=",i)) %>% 
                content("text", encoding = "UTF-8") %>% strsplit("") %>% unlist()
            
  DayOff <- c(DayOff, as.logical(as.numeric(response)))

}

calendar <- tibble(
  Date = seq.Date(from = as.Date("2006-01-01"), to = as.Date("2022-12-31"), by = "day"), 
  Year = year(Date), Season = case_when(month(Date) %in% c(1, 2, 12) ~ "Winter", 
                                        month(Date) %in% c(3, 4, 5) ~ "Spring",
                                        month(Date) %in% c(6, 7, 8) ~ "Summer",
                                        month(Date) %in% c(9, 10, 11) ~ "Autumn" ), 
  Month = month(Date, label = TRUE, abbr = FALSE,  locale = "ENG"), DayOff = DayOff )

## Local storage
write_csv(GFZ_Potsdam_Ap, "data/raw/GFZ_Potsdam.csv") 
write_csv(GFZ_Potsdam_Kp, "data/raw/GFZ_Potsdam_Kp.csv") 
write_csv(calendar, "data/raw/Calendar.csv") 
