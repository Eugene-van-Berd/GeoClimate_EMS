#Eugene-van-Berd: Загрузка локальных файлов (исходные данные и Tidy) 

library(tidyverse)
library(readxl)
library(readr)

##Перечень локальных файлов
list.files("data/raw")

##Загрузка исходных данных
brain_data_raw <- read_excel("data/raw/database_2024-11-09.xlsx")  #База данных о вызовах скорой помощи в Иркутске (2006 - 2022 года)
GFZ_Potsdam_Ap <- read_csv("data/raw/GFZ_Potsdam.csv")             #Индексы геомагнитной активности (Ap) из GFZ, Potsdam (2006 - 2022 года)
WDC_Kyoto_Dst <- read_fwf("data/raw/WDC_Kyoto.dat",                #Индексы геомагнитной активности (Dst) из WDC, Kyoto (2006 - 2022 года)
                          fwf_widths( c(3, 2, 2, 1, 2, 2, 1, 1, 2, 4, rep(4, 24), 4) )) %>% transmute( 
                            Date = as.Date(paste0(X9,X2,"-",X3,"-",X5)), Dst_day_mean = X35)         

##Загрузка Tidy data для анализа
brain_data <- read_csv("data/raw/brain_data.csv")



 