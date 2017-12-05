#Shiny App
#Server File

library(shiny)
library(ggplot2)
source("Data_Manipulation.R")
locations = get.filtered.data("Country") %>% group_by(Country) %>% summarise(total = n()) %>% filter(total>600)

shinyServer(function(input, output) {
  output$locations = renderPlot({
    ggplot(locations, aes(x=Country, y=total)) + geom_col() %>% coord_flip()
  })
})
