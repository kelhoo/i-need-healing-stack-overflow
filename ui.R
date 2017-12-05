#Shiny App
#ui File

library(shiny)
library(dplyr)
source("Data_Manipulation.R")
professions = get.filtered.data(c("Professional")) %>% unique()
degrees = get.filtered.data(c("FormalEducation")) %>% unique()

shinyUI(fluidPage(
  
  # Application title
  titlePanel(""),
  
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("profession", 
                         choices = professions$Professional,
                         label = "Profession",
                         selected = professions$Professional),
      checkboxGroupInput("education",
                         choices = degrees$FormalEducation,
                         label = "Formal Education",
                         selected = degrees$FormalEducation)
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
