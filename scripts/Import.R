# Загрузка базы данных из 'data/raw'
library(readxl)
list.files("data/raw")
data_raw <- read_excel("data/raw/database_2024-11-09.xlsx")

# Загрузка индексов геомагнитной активности из GFZ_Potsdam
library(httr)
library(jsonlite)
library(tidyverse)

## API-запросы
response_Kp <- GET("https://kp.gfz-potsdam.de/app/json/?start=2006-01-01T00:00:00Z&end=2024-10-31T23:59:59Z&index=Kp")
response_ap <- GET("https://kp.gfz-potsdam.de/app/json/?start=2006-01-01T00:00:00Z&end=2024-10-31T23:59:59Z&index=ap")
response_Ap <- GET("https://kp.gfz-potsdam.de/app/json/?start=2006-01-01T00:00:00Z&end=2024-10-31T23:59:59Z&index=Ap")

## Парсинг JSON
GFZ_Potsdam_Kp <- fromJSON(content(response_Kp, "text", encoding = "UTF-8"))
GFZ_Potsdam_ap <- fromJSON(content(response_ap, "text", encoding = "UTF-8"))
GFZ_Potsdam_Ap <- fromJSON(content(response_Ap, "text", encoding = "UTF-8"))

## Сборка данных
tibble(datetime = GFZ_Potsdam_Kp$datetime, 
       Kp = GFZ_Potsdam_Kp$Kp, 
       datetime_ap = GFZ_Potsdam_ap$datetime, 
       ap = GFZ_Potsdam_ap$ap
       )

