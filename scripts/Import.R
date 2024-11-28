#Eugene-van-Berd: Загрузка локальных файлов (исходные данные и Tidy) 

library(tidyverse)
library(readxl)
library(readr)

##Перечень локальных файлов
list.files("data/raw")

##Загрузка исходных данных
brain_data_raw <- read_excel("data/raw/database_2024-11-09.xlsx")  #База данных о вызовах скорой помощи в Иркутске (2006 - 2022 года)

GFZ_Potsdam_Ap <- read_csv("data/raw/GFZ_Potsdam.csv")  #Индексы геомагнитной активности (Ap) из GFZ, Potsdam (2006 - 2022 года)

WDC_Kyoto_Dst <- read_fwf("data/raw/WDC_Kyoto.dat",  #Индексы геомагнитной активности (Dst) из WDC, Kyoto (2006 - 2022 года)
                          fwf_widths( c(3, 2, 2, 1, 2, 2, 1, 1, 2, 4, rep(4, 24), 4) )) %>% transmute( 
                            Date = as.Date(paste0(X9,X2,"-",X3,"-",X5)), Dst_day_mean = X35)         

Obs_Ebre_SSC <- tibble()  #Данные о событиях SSC и SI из Observatori de l'Ebre (2006 - 2022 года)
for (i in (2006:2022)) {
  
  link <- paste0("data/raw/SC_data/ssc_", i, "_d.txt")
  
  Obs_Ebre_SSC %>% rbind(
    
      read_tsv(link, col_names = "raw") %>% 
        filter(str_starts(raw, paste0(i))) %>% 
        transmute(Date = str_replace_all( str_trunc(raw, width = 10, ellipsis = ""),
                                          " ", "-") %>% as.Date(),  
                  Storm = factor(str_remove_all(raw, "-") %>% str_trunc(width = 2, side = "left",  ellipsis = ""), 
                                 levels = c("SI", "SC"), labels = c("Sudden_Impulse", "Sudden_Storm"))) 
      
  ) -> Obs_Ebre_SSC
  
}
Obs_Ebre_SSC <- Obs_Ebre_SSC %>% 
  count(Date, Storm) %>%
  pivot_wider(names_from = Storm, values_from = n)


Roshydromet_Irkutsk <- read_fwf("data/raw/Roshydromet_Irkutsk.dat",  #Погода в Иркутске из Росгидромет (1882 - 2023 года)
                          fwf_widths( c(5, 1,  4, 1, 2, 1, 2, 1, 1, 1, 5, 1, 1, 1, 5, 1, 1, 1, 5, 1, 1, 1, 5, 1, 1, 1  ))) %>% 
  select(where(is.numeric)) %>% 
  transmute( 
    Date = as.Date(paste0(X3,"-",X5,"-",X7)), 
    Temp_min = X11, Temp_mean = X15, Temp_max = X19, 
    Precipitation = X23
    ) 


SIDC_SILSO <- read_delim("data/raw/SIDC_SILSO.csv",  #Международного числа солнечных пятен из SIDC, Brussels (1818 - 2024 года)
           delim = ";", col_names = FALSE)  %>% 
  transmute(Date = as.Date(paste0(X1,"-",X2,"-",X3)), 
            Sunspot_n = as.numeric(X5)
  )


##Загрузка Tidy data для анализа
brain_data <- read_csv("data/raw/brain_data.csv")



 