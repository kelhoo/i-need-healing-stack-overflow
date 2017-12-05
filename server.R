#Shiny App
#Server File

library(shiny)
library(ggplot2)
source("Data_Manipulation.R")
all_data = get.full.data()

shinyServer(function(input, output) {
  output$locations = renderPlot({
    locations = all_data %>% select(c("Country", "Professional")) %>% 
      filter(Professional == input$profession) %>% 
      group_by(Country) %>% 
      summarise(total = n())
    
    ggplot(locations %>% filter(), aes(x=Country, y=total)) + 
      geom_col() + 
      coord_flip() + 
      labs(title = "Number of Programmers in Each Country", y="Number of People")
  })
})
