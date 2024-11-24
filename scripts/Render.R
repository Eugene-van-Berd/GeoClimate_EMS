##Eugene-van-Berd: Рендеринг GeoClimate_EMS.Rmd в HTML и Markdown c выводом в папку 'data/docs'

library(rmarkdown)

render(
  input = "GeoClimate_EMS.Rmd",       
  output_dir = "data/docs",            
  output_file = "GeoClimate_EMS.html" 
)
