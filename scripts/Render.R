##Eugene-van-Berd: Рендеринг Rmd файлов в HTML (и Markdown) c выводом в папку 'data/docs'

library(tidyverse)
library(rmarkdown)

render(
  input = "GeoClimate_EMS.Rmd",
  output_dir = "data/docs",
  output_file = "GeoClimate_EMS.html"
)

# Путь к Rmd файлу
list.files()
input_file <- "scripts/EDA_BES.Rmd"

# Рендерим файл
render(input = input_file, 
       output_dir = "data/docs", 
       output_file = str_replace(basename(input_file), "Rmd", "html"))




