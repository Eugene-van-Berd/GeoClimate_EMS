## Загрузка базы данных из 'data/raw'
library(readxl)
list.files("data/raw")
data_raw <- read_excel("data/raw/database_2024-11-09.xlsx")
