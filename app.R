

library(shiny)
library(tidyverse)
library(ggplot2)
library(dplyr)
library(rsconnect)




# import Impaired Driver Death Data data


IDV_05_14 

ui <- fluidPage(
  titlePanel("Alcohol Influenced Vehicle Deaths"),
  
      sliderInput(inputId = "Alcohol-Impaired Driving Deaths",
                  label = "Total Number of Impaired Driver Deaths by State from 2005-2014",
                  min = 90,
                  max =  max(IDV_05_14$`Alcohol-Impaired Driving Deaths`, na.rm = TRUE),
                  value = c(0, max(IDV_05_14$`Alcohol-Impaired Driving Deaths`, na.rm = TRUE))),
  selectInput(inputId = "State",
              label = "State",
              choices = sort(unique(IDV_05_14$State)),
              multiple = TRUE),
  
      plotOutput("drunkdeaths"), 
  tableOutput("totaldrunkdeaths")
    )

      server <- function(input, output) {
        output$drunkdeaths <- renderPlot({
          IDV_05_14 %>%
            filter(
                   `Alcohol-Impaired Driving Deaths` >= input$`Alcohol-Impaired Driving Deaths`[1],
                   `Alcohol-Impaired Driving Deaths` <= input$`Alcohol-Impaired Driving Deaths`[2]) %>%
          ggplot(aes(`Alcohol-Impaired Driving Deaths`)) + 
            geom_histogram() 
            
        })
        output$totaldrunkdeaths <- renderTable({
          IDV_05_14 %>%
            filter(`Alcohol-Impaired Driving Deaths` >= input$`Alcohol-Impaired Driving Deaths`[1],
                   `Alcohol-Impaired Driving Deaths` <= input$`Alcohol-Impaired Driving Deaths`[2]) %>%
            count(`Alcohol-Impaired Driving Deaths`)
        })
          
        
        
      }
      
        shinyApp(ui = ui, server = server)
        
        
        
        ui <- fluidPage(
          numericInput("num", "Maximum slider value", 5),
          uiOutput("slider")
        )
        
        server <- function(input, output) {
          output$slider <- renderUI({
            sliderInput("slider", "Slider", min = 0,
                        max = input$num, value = 0)
          })
        }
        
        shinyApp(ui = ui, server = server)
        
        
        
        
        
        
        
      
        
        
      
      
      