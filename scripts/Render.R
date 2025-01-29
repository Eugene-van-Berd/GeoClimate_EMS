# Rendering Rmd files to HTML (and Markdown) with output to the 'data/docs' folder

## Packages
library(tidyverse)
library(rmarkdown)

## Rendering Files
input_file <- c("1. Transform.Rmd", "2. EDA.Rmd", "3. Models.Rmd")

for (i in input_file){
  render(input = i, 
         output_dir = "data/docs", 
         output_file = str_replace(basename(i), "Rmd", "html"))
}




