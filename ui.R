#Shiny App
#ui File

library(shiny)
library(dplyr)
library(plotly)
source("Data_Manipulation.R")
professions = get.filtered.data(c("Professional")) %>% unique()
degrees = get.filtered.data(c("FormalEducation")) %>% unique()
majors = get.filtered.data(c("MajorUndergrad")) %>% unique()

shinyUI(fluidPage(
  
  # Application title
  titlePanel(""),
  
  shinyUI(navbarPage("My Application",
    tabPanel("Page 1", sidebarLayout(
      
      sidebarPanel(
        checkboxGroupInput("profession", 
                           choices = professions$Professional,
                           label = "Profession",
                           selected = professions$Professional),
        checkboxGroupInput("education",
                           choices = degrees$FormalEducation,
                           label = "Formal Education",
                           selected = degrees$FormalEducation),
        checkboxGroupInput("major",
                           choices = majors$MajorUndergrad,
                           label = "Undergraduate Majors",
                           selected = majors$MajorUndergrad)
      ),
      
      mainPanel(
        tabsetPanel(
          tabPanel("Locations", plotOutput("locations")),
          #tabPanel("Formal Education", plotOutput("education")),
          tabPanel("University", plotOutput("university")),
          tabPanel("Major", plotOutput("major"))
          #tabPanel("Job Satisfaction", plotOutput("job_satisfaction"))
          #tabPanel("Summary", verbatimTextOutput("summary")),
          #tabPanel("Table", tableOutput("table"))
        )
      )    
    )), 
    tabPanel("Page 2", sidebarLayout(
      sidebarPanel(
        checkboxGroupInput("profession2", 
                           choices = professions$Professional,
                           label = "Profession",
                           selected = professions$Professional)
      ),
      mainPanel(
        tabsetPanel(
          tabPanel("Education", plotOutput("education")),
          tabPanel("Job Satisfaction", plotOutput("job_satisfaction")),
          tabPanel("Years Programming", plotlyOutput("years", height = "700px"))
        )
      )
    )),
    tabPanel("Page 3", sidebarLayout(
      sidebarPanel(),
      mainPanel(
        tabsetPanel(
          #tabPanel("Education", plotOutput("education")),
          tabPanel("Languages", plotOutput("languages"))
        )
      )
    ))
  ))
  )
)
