#Eugene-van-Berd: Выгрузка геомагнитных индексов из GFZ, Potsdam 

library(tidyverse)
library(httr)
library(jsonlite)

response_Ap <- GET("https://kp.gfz-potsdam.de/app/json/?start=2006-01-01T00:00:00Z&end=2022-12-31T23:59:59Z&index=Ap")
GFZ_Potsdam_Ap_raw <- fromJSON(content(response_Ap, "text", encoding = "UTF-8"))
GFZ_Potsdam_Ap <- tibble(Date = as.Date(ymd_hms(GFZ_Potsdam_Ap_raw$datetime)),
                         Ap_mean = GFZ_Potsdam_Ap_raw$Ap)

##Локальное храненение данных 
write_csv(GFZ_Potsdam_Ap, "data/raw/GFZ_Potsdam.csv") 