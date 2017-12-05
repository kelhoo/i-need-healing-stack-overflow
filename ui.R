#Shiny App
#ui File

library(shiny)
library(dplyr)
source("Data_Manipulation.R")
professions = get.filtered.data(c("Professional")) %>% unique()

shinyUI(fluidPage(
  
  # Application title
  titlePanel(""),
  
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("profession", 
                         choices = professions$Professional,
                         label = "Profession",
                         selected = professions$Professional)
      ),
    
      mainPanel(
        plotOutput("locations")
      )    
    )
  )
)
