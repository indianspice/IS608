#
# Sharon Morris


library(shiny)
library(dplyr)
library(ggplot2)


url <- "https://raw.githubusercontent.com/indianspice/IS608/master/Assign3/cleaned-cdc-mortality-1999-2010-2.csv"
mdata <- read.csv(url, stringsAsFactors = FALSE)

#Extract unique states and disease
states <- unique(mdata$State) 
causes <- unique(mdata$ICD.Chapter) 


nat_avg <- mdata[, c('State', 'Year', 'Deaths', 'Population', 'Crude.Rate')] %>% 
    group_by(mdata$ICD.Chapter, Year) %>%
    summarize(Rate = 1e5 * sum(Deaths) / sum(Population))
    
#Define server logic required to visulaize the data
shinyServer(function(input, output) {
    
    sub_mdataS <- reactive({
        subset(mdata, mdata$State %in% input$states)
        })
        
        sub_mdataC <- reactive({
            st <- sub_mdataC()
                subset(st, st$ICD.Chapter == input$causes)
        })
        
     nat <- reactive({
         subset(nat_avg, nat_avg$meta$ICD.Chapter == input$causes)
     })
     
  
    
   output$causev <- renderPlot({
      
            ggplot(sub_mdataC(), aes(x=Year, y=Crude.Rate, color = State)) +
            geom_smooth(mdata = nat(), aes(x= Year, y= Rate, color = 0),
                        linetype = 2, size = 1.5, method = 'loess', fill = NA) + 
         theme_bw()
        
    })
})
#})