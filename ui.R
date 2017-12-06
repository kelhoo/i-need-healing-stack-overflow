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
  
  shinyUI(navbarPage("Programming, Is It For You?",
    tabPanel("Students", sidebarLayout(
      
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
          tabPanel("University", plotOutput("university", height = DEFAULT_HEIGHT)),
          tabPanel("Major", plotOutput("major", height = DEFAULT_HEIGHT))
        )
      )    
    )), 
    tabPanel("Employees", sidebarLayout(
      
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
    tabPanel("Additional Information", sidebarLayout(
      sidebarPanel(),
      mainPanel(
        tabsetPanel(
          tabPanel("Languages", plotOutput("languages", height = DEFAULT_HEIGHT)),
          tabPanel("Company Sizes", plotOutput("sizes", height = DEFAULT_HEIGHT))
        )
      )
    ))
  ))
  )
)
