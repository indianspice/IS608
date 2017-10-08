#
# Often you are asked whether particular States are improving their
# mortality rates (per cause) faster than, or slower than, the national 
# average. Create a visualization that lets your clients see this for 
# themselves for one cause of death at the time. Keep in mind that the 
# national average should be weighted by the national population.
#

library(shiny)
url <- "https://raw.githubusercontent.com/indianspice/IS608/master/Assign3/cleaned-cdc-mortality-1999-2010-2.csv"
mdata <- read.csv(url, stringsAsFactors = FALSE)

#Extract unique states and disease
states <- unique(mdata$State)
causes <- unique(mdata$ICD.Chapter)

#Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    #Application title
    titlePanel("Mortality Improvement by State"),
    
    #Dropdown state and cause
    sidebarLayout(
        sidebarPanel(selectInput("state_name", "State:", choices = states)
                     , radioButtons("cause_name", "Select disease - cause of Death:",
                                    c("Infectious & parasitic" = "Certain infectious and parasitic diseases"    , 
                                      "Neoplasms" = "Neoplasms",
                                      "Blood & blood-forming & immune mechanism disorders" = "Diseases of the blood and blood-forming organs and certain disorders involving the immune mechanism",
                                      "Endocrine, nutritional & metabolic" = "Endocrine, nutritional and metabolic diseases",
                                      "Mental & behavioural disorders" = "Mental and behavioural disorders",
                                      "Nervous system" = "Diseases of the nervous system",
                                      "Ear & mastoid process" = "Diseases of the ear and mastoid process",
                                      "Circulatory system"  = "Diseases of the circulatory system",
                                      "Respiratory system" = "Diseases of the respiratory system",
                                      "Digestive system" = "Diseases of the digestive system",
                                      "Skin & subcutaneous tissue" = "Diseases of the skin and subcutaneous tissue",
                                      "Musculoskeletal system & connective tissue" = "Diseases of the musculoskeletal system and connective tissue",
                                      "Genitourinary system" = "Diseases of the genitourinary system",
                                      "Pregnancy, childbirth & the puerperium" = "Pregnancy, childbirth and the puerperium",
                                      "Conditions originating in the perinatal period" = "Certain conditions originating in the perinatal period",
                                      "Congenital malformations, deformations & chromosomal abnormalities" = "Congenital malformations, deformations and chromosomal abnormalities",
                                      "Symptoms, signs & abnormal clinical & laboratory findings, not classified" = "Symptoms, signs and abnormal clinical and laboratory findings, not elsewhere classified",
                                      "External causes of morbidity & mortality" = "External causes of morbidity and mortality"))
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("causev")
        )
    )
))
