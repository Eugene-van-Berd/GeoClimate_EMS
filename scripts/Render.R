# Eugene-van-Berd: Рендеринг Rmd файлов в HTML (и Markdown) c выводом в папку 'data/docs'

library(tidyverse)
library(rmarkdown)

list.files()
"1. Transform.Rmd"
"2. EDA.Rmd"
"3. Models.Rmd" 

# Путь к нужному Rmd файлу (список файлов можно посмотреть тут - list.files() / list.files("scripts"))
input_file <- "3. Models.Rmd" 

# Рендерим файл
render(input = input_file, 
       output_dir = "data/docs", 
       output_file = str_replace(basename(input_file), "Rmd", "html"))




