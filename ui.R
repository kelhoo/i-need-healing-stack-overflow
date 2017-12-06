#Shiny App
#ui File

library(shiny)
library(dplyr)
library(plotly)
library(shinythemes)
source("Data_Manipulation.R")
professions = get.filtered.data(c("Professional")) %>% unique()
degrees = get.filtered.data(c("FormalEducation")) %>% unique()
majors = get.filtered.data(c("MajorUndergrad")) %>% unique()
sizes = get.filtered.data(c("CompanySize")) %>% unique()
DEFAULT_HEIGHT = "1000px"
shinyUI(fluidPage(
  theme = shinytheme("sandstone"),
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
          tabPanel("Locations", plotOutput("locations", height = DEFAULT_HEIGHT)),
          #tabPanel("Formal Education", plotOutput("education")),
          tabPanel("University", plotOutput("university", height = DEFAULT_HEIGHT)),
          tabPanel("Major", plotOutput("major", height = DEFAULT_HEIGHT))
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
          tabPanel("Education", plotOutput("education", height = DEFAULT_HEIGHT)),
          tabPanel("Job Satisfaction", plotOutput("job_satisfaction", height = DEFAULT_HEIGHT)),
          tabPanel("Years Programming", plotlyOutput("years", height = DEFAULT_HEIGHT))
        )
      )
    )),
    tabPanel("Page 3", sidebarLayout(
      sidebarPanel(),
      mainPanel(
        tabsetPanel(
          #tabPanel("Education", plotOutput("education")),
          tabPanel("Languages", plotOutput("languages", height = DEFAULT_HEIGHT)),
          tabPanel("Company Sizes", plotOutput("sizes", height = DEFAULT_HEIGHT))
        )
      )
    ))
  ))
  )
)
