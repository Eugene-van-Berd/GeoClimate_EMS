# Загрузка базы данных из 'data/raw'
library(readxl)
list.files("data/raw")
brain_data_raw <- read_excel("data/raw/database_2024-11-09.xlsx")

# Загрузка индексов геомагнитной активности из GFZ, Potsdam
library(httr)
library(jsonlite)
response_Ap <- GET("https://kp.gfz-potsdam.de/app/json/?start=2006-01-01T00:00:00Z&end=2022-12-31T23:59:59Z&index=Ap")
GFZ_Potsdam_Ap_raw <- fromJSON(content(response_Ap, "text", encoding = "UTF-8"))

# Загрузка индексов геомагнитной активности из WDC for Geomagnetism, Kyoto
library(readr)
WDC_Kyoto_Dst_raw <- read_fwf("data/raw/WDC_Kyoto.dat", 
                          fwf_widths( c(3, 2, 2, 1, 2, 2, 1, 1, 2, 4, rep(4, 24), 4) )
                          )
          
