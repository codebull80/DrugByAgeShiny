library(shiny)
library(tidyverse)
library(plotly)
library(stringr)

fileUrl <- "https://raw.githubusercontent.com/fivethirtyeight/data/master/drug-use-by-age/drug-use-by-age.csv"
download.file(fileUrl, "drug-use-by-age.csv", method="curl")

d    <- read_csv("drug-use-by-age.csv", na = "-")
ageclass <- d$age

names <-names(d)[3:28] 
data<- tibble(group = names) %>%
add_column(count = NA)


   shinyServer(function(input, output) {
     
     
     

  output$selected_age_use <- renderPlotly({
    
     g <- filter(d, age == input$age_sel) 
     
      data$count<- as.numeric(t(g)[3:28]) 
      
        use <- filter(data, str_detect(group, "_use$" ))
        frequency <- filter(data, str_detect(group, "_frequency$" )) 
        
    bp <-    ggplot(data=use, aes(x= reorder(group, count), y=count)) + 
              
      geom_col() +
      ylim(0,100)+
      coord_flip() + 
      labs(x = "Substance", y = "Percentage of those in an age group who used each substance in the past 12 months") +
      theme_minimal()
    
    ggplotly(bp) 
    
    
  })
  
  output$selected_age_frequency <- renderPlotly({
    
    g <- filter(d, age == input$age_sel) 
    
    data$count<- as.numeric(t(g)[3:28]) 
    
    use <- filter(data, str_detect(group, "_use$" ))
    frequency <- filter(data, str_detect(group, "_frequency$" )) 
    
    
    bars <- ggplot(data=frequency, aes(x= reorder(group, count), y=count)) +
      geom_col() +
      coord_flip() + 
      labs(x = "Substance", y = "Median number of times a user in an age group used each substance in the past 12 months") +
      theme_minimal()
    
    ggplotly(bars) 
    
  })
  
})
