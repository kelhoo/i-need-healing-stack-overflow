#Shiny App
#Server File

library(shiny)
library(ggplot2)
source("Data_Manipulation.R")
all_data = get.full.data()

shinyServer(function(input, output) {
  output$locations = renderPlot({
    locations = all_data %>% select(c("Country", "Professional", "FormalEducation")) %>% 
      filter(Professional == input$profession, FormalEducation == input$education) %>% 
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
      filter(Professional == input$profession) %>% 
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
  
  output$university = renderPlot({
    university <- all_data %>%
      filter(Professional == input$profession, FormalEducation == input$education) %>%
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
})
