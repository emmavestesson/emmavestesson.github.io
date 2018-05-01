

library(shiny)
library(leaflet)
library(leaflet.extras)
library(tidyverse)
library(sf)
library(ggmap)

ui <- fluidPage(
  leafletOutput("mymap"),
  h3(textOutput("selected_var")),
  # actionButton("remove", "Remove chains"),
  actionButton("recalc", "Generate new lunch option"),
  textInput("caption", "Caption",  "90 long acre"), 
  h3(textOutput("start1"))
  
)

# Define server 
server <- function(input, output, session) {

  cov_gar <- readRDS(file="cov_gar.rds")

  points <- eventReactive(input$recalc, {
 
    sample_n(cov_gar,1)
  }, ignoreNULL = FALSE)
 
start1 <- eventReactive(input$caption, 
                        {geocode(paste0(input$caption))})
# start <- geocode("90 long acre")
 #   eventReactive(input$caption, {
 #   geocode("90 long acre")
 # }, ignoreNULL = FALSE)
 
  # create the interactive map...
  output$mymap <- renderLeaflet({
    leaflet(padding = 0, options= leafletOptions( minZoom=10, maxZoom=18) ) %>% 
      addTiles()  %>%
      addMarkers( group = "The office",
                        lng = start1()$lon,
                        lat = start1()$lat, 
                  popup="The office") %>% 
      addCircleMarkers( group = "All lunch places",
                          lng = st_coordinates(cov_gar)[,1],
                          lat = st_coordinates(cov_gar)[,2],
                          radius = 8, weight = 0.25,
                          stroke = TRUE, opacity = 75,
                          fill = TRUE, fillColor = "deeppink",
                          fillOpacity = 100,
                          popup = cov_gar$label,
                          color = "white") %>%
      addCircleMarkers(data = points(), group="Random lunch place", 
                       radius = 8, weight = 0.25,
                       stroke = TRUE, opacity = 100,
                       fill = TRUE, fillColor = "purple",
                       fillOpacity = 100,     
                       popup = points()$label,
                       color = "white") %>% 

      addLayersControl(
        overlayGroups = c("All lunch places", "Random lunch place"),
        options = layersControlOptions(collapsed = FALSE))
      
  })
  
  output$selected_var <- renderText({ 
    paste0("Maybe you should go to ",points()$name, " for lunch? It is ", points()$distance, "m from the office.") 
  })
  output$value <- renderText({ input$caption })
}

# Run the application 
shinyApp(ui = ui, server = server)

