library(shiny)
library(tidyverse)
library(plotly)

fileUrl <- "https://raw.githubusercontent.com/fivethirtyeight/data/master/drug-use-by-age/drug-use-by-age.csv"
download.file(fileUrl, "drug-use-by-age.csv", method="curl")

d    <- read_csv("drug-use-by-age.csv", na = "-")
ageclass <- d$age

shinyUI(fluidPage(
  
  
  # Application title
  titlePanel("Drug Use By Age Data"),
  
  "The National Survey on Drug Use and Health (NSDUH) series (formerly titled National Household Survey on Drug Abuse) primarily measures the prevalence and correlates of drug use in the United States. 
  The surveys are designed to provide quarterly, as well as annual, estimates. Information is provided on the use of illicit drugs, alcohol, and tobacco among members of United States households aged 12 and older.",
  
  sidebarLayout(
    sidebarPanel(
      "Select an age cathegory",
      selectInput("age_sel",
                  "Age",
                  ageclass)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      
      plotlyOutput("selected_age_use"),
      
      plotlyOutput("selected_age_frequency")
      
    )
  ),
  
  "References",
  "United States Department of Health and Human Services. Substance Abuse and Mental Health Services Administration. Center for Behavioral Health Statistics and Quality. National Survey on Drug Use and Health, 2012. Inter-university Consortium for Political and Social Research [distributor], 2015-11-23. https://doi.org/10.3886/ICPSR34933.v3"
)) 
