## Рендеринг RMarkdown документа в HTML и Markdown, вывод в папку 'data/docs'
rmarkdown::render(
  input = "GeoClimate_EMS.Rmd",       
  output_dir = "data/docs",            
  output_file = "GeoClimate_EMS.html" 
)
