#Shiny App
#Server File

library(shiny)
library(ggplot2)
library(plotly)
source("Data_Manipulation.R")
all_data = get.full.data()

shinyServer(function(input, output) {
  output$locations = renderPlot({
    locations = all_data %>% select(c("Country", "Professional", "FormalEducation", "MajorUndergrad")) %>% 
      filter(Professional %in% input$profession, FormalEducation %in% input$education, MajorUndergrad %in% input$major) %>% 
      group_by(Country) %>% 
      summarise(total = n()) %>% 
      arrange(desc(total))
    min_total = locations$total[10]
    locations = locations %>% filter(total >= min_total)
    
    ggplot(locations, aes(x=Country, y=total)) + 
      geom_col() + 
      coord_flip() + 
      labs(title = "Number of Programmers in Each Country", y="Number of People")
  })
  
  #Makes bar plot of the different Formal Education based on profession
  output$education = renderPlot({
    education <- all_data %>% 
      filter(Professional %in% input$profession2) %>% 
      select("FormalEducation") %>% 
      group_by(FormalEducation) %>% 
      summarise(total = n())
    
    ggplot(education, aes(x=education$FormalEducation, y=education$total, fill=education$FormalEducation)) + 
      geom_bar(stat="identity") +
      theme(axis.title.x=element_blank(),
            axis.text.x=element_blank(),
            axis.ticks.x=element_blank()) +
      labs(title="Types of Formal Education Programmers had", fill = "Education Type", y = "Total")
  })
  
  #renders a piechart of people currently enrolled in University
  output$university = renderPlot({
    university <- all_data %>%
      filter(Professional %in% input$profession, FormalEducation %in% input$education, MajorUndergrad %in% input$major) %>%
      select("University") %>%
      group_by(University) %>%
      summarise(total = n())
    
    slices <- university$total
    lbls <- university$University
    pct <- round(slices/sum(slices)*100)
    lbls <- paste(lbls, pct)
    lbls <- paste(lbls,"%",sep="")
    pie(slices,labels = lbls, col=rainbow(length(lbls)),
        main="Pie Chart of Currently Enrolled")
  })
  
  output$major = renderPlot({
    majors = all_data %>% 
      select(c("MajorUndergrad", "Professional", "FormalEducation")) %>% 
      filter(Professional %in% input$profession, FormalEducation %in% input$education, MajorUndergrad %in% input$major) %>% 
      group_by(MajorUndergrad) %>% 
      summarise(total = n()) %>% 
      arrange(desc(total))
    
    percent = round(majors$total*100/sum(majors$total), 0)
    pie(majors$total, 
        labels = paste0(majors$MajorUndergrad, " ", percent, "%"), 
        col=rainbow(nrow(majors), start = 0.05), 
        main = "Pie Chart of Undergraduate Majors",
        init.angle = 30)
  })
  
  output$job_satisfaction = renderPlot({
    careers = get.filtered.data(c("MajorUndergrad", "Professional", "JobSatisfaction")) %>% 
      filter(Professional %in% input$profession2, JobSatisfaction != "NA")
    
    ggplot(careers, aes(x=MajorUndergrad, y=JobSatisfaction)) + 
      geom_boxplot(col = rainbow(careers$MajorUndergrad %>% unique() %>% length)) + 
      coord_flip() + 
      labs(title = "Box Plot of Job Satisfaction Based on Major", x="Undergraduate Major", y="Job Satisfaction")
  })
  
  output$languages = renderPlot({
    data <- all_data %>%
      select("HaveWorkedLanguage") %>%
      group_by(HaveWorkedLanguage) %>%
      summarise(total = n()) %>%
      filter(total > 500, HaveWorkedLanguage != "NA") %>%
      arrange(desc(total))
    
    ggplot(data, aes(x=data$HaveWorkedLanguage, y=data$total, fill=data$HaveWorkedLanguage)) + 
      geom_bar(stat="identity") +
      theme(axis.title.x=element_blank(),
            axis.text.x=element_blank(),
            axis.ticks.x=element_blank()) +
      labs(title="Languages Programmers Used", fill = "Languages", y = "Total")
  })

  #renders a piechart of years programmed
  output$years <- renderPlotly({
    years <- all_data %>%
      filter(Professional %in% input$profession2, YearsProgram != "null") %>%
      select("YearsProgram") %>%
      group_by(YearsProgram) %>%
      summarise(total = n())
    
    plot_ly(years, labels = years$YearsProgram, values = years$total, type = 'pie') %>%
      layout(showlegend = TRUE)
  })
})
