#
# This is a Shiny web application. You can run the application by clicking
# the "Run App" button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
#load libraries
library(shiny)
library(tidyverse)
library(urbnthemes)
#set urban theme branding
set_urbn_defaults()

# set shiny options
options(shiny.sanitize.errors = TRUE)
options(scipen = 999)



# create user interface
ui <- fluidPage(

  # make sure shiny.css is in www/
  # if not, delete the following line
  theme = "shiny.css",
  #add input to select quantitative variable
  selectInput("quantitative", 
              label = h3("Select Quantitative Variable"), 
              choices = c("Height" = "height", "Mass" = "mass"),
              selected = "height"), 
  #add input to select categorical variable
  selectInput("categorical", 
              label = h3("Select Categorical Variable"), 
              choices = c("Name" = "name", 
                          "Skin Color" = "skin_color",
                          "Hair Color" = "hair_color",
                          "Homeworld" = "homeworld")),
  #create plot
  plotOutput("my_plot")


)

# create server session
server <- function(input, output) {

#create output plot
output$my_plot <- renderPlot({
  starwars %>%
    slice(1:10) %>%
    select(cat = contains(input$categorical), 
           quant = contains(input$quantitative)) %>% 
    ggplot() + 
    geom_col(mapping = aes(x = cat, y = quant))
    
  
})
  
}

# build shiny application
shinyApp(ui = ui, server = server)
