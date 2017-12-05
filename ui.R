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
        tabsetPanel(
          tabPanel("Locations", plotOutput("locations")),
          tabPanel("Formal Education", plotOutput("education")),
          tabPanel("University", plotOutput("university"))
          #tabPanel("Summary", verbatimTextOutput("summary")),
          #tabPanel("Table", tableOutput("table"))
        )
      )    
    )
  )
)
