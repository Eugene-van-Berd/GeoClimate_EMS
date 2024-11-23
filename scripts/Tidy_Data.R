#Преобразование данных в tidy формат, подготовка для анализа.
library(tidyverse)
library(skimr)

#Индекс Ap за 2006-2022гг
GFZ_Potsdam_Ap <- tibble(Date = as.Date(ymd_hms(GFZ_Potsdam_Ap_raw$datetime)),
                         Ap_day_mean = GFZ_Potsdam_Ap_raw$Ap)

#Индекс Dst за 2006-2022гг
WDC_Kyoto_Dst <- WDC_Kyoto_Dst_raw %>% 
  transmute(
    Date = as.Date(paste0(X9,X2,"-",X3,"-",X5)), 
    Dst_day_mean = X35
  ) 

#Данные для исследования
skim(data_raw)

data <- data_raw %>% 
  transmute(
    Date = dmy(Дата), EMS = `Вызов СМП с диагнозом ОНМК у всех пациентов старше 25 лет`, 
    Sunspot_n = `Международное число солнечных пятен`, F10.7 = `Cкорректированный (F10.7)`, 
    Temp_min = `Минимальная температура`, Temp_max = `Максимальная температура`, 
    Temp_mean = `Средняя температура`, Temp_var = Temp_max - Temp_min,
    Wind = `Скорость ветра`, Precipitation = `Количество осадков`,
    Pressure_8 = `Атмосферное давление на уровне станции в 8:00`, 
    Pressure_17 = `Атмосферное давление на уровне станции в 17:00`, 
    Pressure_mean = `Атмосферное давление в среднем за сутки, С (Т)`, 
    
    #Индексы геомагнитной активности берем из открытых источников
    #Много пропусков: Количество умерших, Магнитная буря
    #Разбивку по полу и возрастной группе рассмотрим позже:
    
    #EMS_male_1 = `Количество вызовов СМП с диагнозом ОНМК у мужчин 25-44 лет`, 
    #EMS_male_2 = `Количество вызовов СМП с диагнозом ОНМК у мужчин 45-54 лет`, 
    #EMS_male_3 = `Количество вызовов СМП с диагнозом ОНМК у мужчин старше 55 лет`, 
    #EMS_female_1 = `Количество вызовов СМП с диагнозом ОНМК у женщин 25-44 лет`, 
    #EMS_female_2 = `Количество вызовов СМП с диагнозом ОНМК у женщин 45-54 лет`, 
    #EMS_female_3 = `Количество вызовов СМП с диагнозом ОНМК у женщин старше 55 лет`, 
    
  ) %>% 
  mutate(across(starts_with("Pressure"), ~ if_else(. < 700, NA, .))) %>% 
  filter(!is.na(Date)) %>% 
  left_join(GFZ_Potsdam_Ap, by = join_by(Date)) %>% 
  left_join(WDC_Kyoto_Dst, by = join_by(Date))
  
skim(data)
data %>% head()
  

  