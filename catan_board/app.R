#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library("magrittr")
library("purrr")
library("fs")
library("magick")
library("here")
library(shiny)
library(tidyverse)

setwd("/Users/emmavestesson/Documents/GitHub/bdown/")
tiles <- fs::dir_ls("catan hexes")
tiles <- c(rep("catan hexes/wood.png",4), rep("catan hexes/sheep.png",4), rep("catan hexes/wheat.png",4), rep("catan hexes/clay.png" ,3),
           rep("catan hexes/rock.png",3), "catan hexes/desert.png" )
number_tiles <- c("5", "2", "6", "3", "8", "10", "9", "12","11","4", "8","10","9", "4", "5", "6", "3", "11" )

read_append <- . %>%
  magick::image_read() %>%
  magick::image_append()

info <- read_append(tiles[[1]]) %>%
  magick::image_info()
height <- info$height
width <- info$width



# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   actionButton("recalc", "Shuffle that board!"),
   imageOutput("img"),
   textOutput("number_tiles")
   

)

# Define server logic required to draw a histogram
server <- function(input, output) {


tiles1 <- eventReactive(input$recalc, {
  sample(tiles)
})
desert_loc <- reactive(grep("catan hexes/desert.png", tiles1(), ignore.case = FALSE, perl = FALSE, value = FALSE,
                     fixed = FALSE, useBytes = FALSE, invert = FALSE))

# number_tiles <- renderText(append(number_tiles, " ", after = desert_loc-1))
# tiles_image <- purrr::map(tiles, read_append)
# tiles_with_prob <- map2(tiles_image, number_tiles, ~image_annotate(.x,paste(.y), gravity = "south", location = "+0+20",
#                                                                      degrees = 0, size = 19))
# board <- image_blank(width = width * 6,
#                              height = width * 5 ,
#                              col = "blue")
# info_board <- image_info(board)
# y_adj <- height/5
# x_adj <- -width/2
# board <- image_composite(board, tiles_with_prob[[1]], offset=paste0("+", 2*width + x_adj,
#                                                                             "+", 0 + y_adj) )
# board <- image_composite(board, tiles_with_prob[[2]], offset=paste0("+", 3*width + x_adj,
#                                                                             "+", 0 + y_adj))
# board <- image_composite(board, tiles_with_prob[[3]], offset=paste0("+", 4*width + x_adj,
#                                                                             "+", 0 + y_adj))
# board <- image_composite(board, tiles_with_prob[[4]], offset=paste0("+", 4.5*width + x_adj,
#                                                                             "+", height*0.75 + y_adj))
# board <- image_composite(board, tiles_with_prob[[5]], offset=paste0("+", 5*width + x_adj,
#                                                                             "+", 2*height*0.75 + y_adj))
# board <- image_composite(board, tiles_with_prob[[6]], offset=paste0("+", 4.5*width + x_adj,
#                                                                             "+", 3*height*0.75 + y_adj))
# board <- image_composite(board, tiles_with_prob[[7]], offset=paste0("+", 4*width + x_adj,
#                                                                             "+", 4*height*0.75 + y_adj))
# board <- image_composite(board, tiles_with_prob[[8]], offset=paste0("+", 3*width + x_adj,
#                                                                             "+", 4*height*0.75 + y_adj))
# board <- image_composite(board, tiles_with_prob[[9]], offset=paste0("+", 2*width + x_adj,
#                                                                             "+", 4*height*0.75 + y_adj))
# board <- image_composite(board, tiles_with_prob[[10]], offset=paste0("+", 1.5*width + x_adj,
#                                                                              "+", 3*height*0.75 + y_adj))
# board <- image_composite(board, tiles_with_prob[[11]], offset=paste0("+", 1*width + x_adj,
#                                                                              "+", 2*height*0.75 + y_adj))
# board <- image_composite(board, tiles_with_prob[[12]], offset=paste0("+", 1.5*width + x_adj,
#                                                                              "+", 1*height*0.75 + y_adj))
# board <- image_composite(board, tiles_with_prob[[13]], offset=paste0("+", 2.5*width + x_adj,
#                                                                              "+", 1*height*0.75 + y_adj))
# board <- image_composite(board, tiles_with_prob[[14]], offset=paste0("+", 3.5*width + x_adj,
#                                                                              "+", 1*height*0.75 + y_adj))
# board <- image_composite(board, tiles_with_prob[[15]], offset=paste0("+", 4*width + x_adj,
#                                                                              "+", 2*height*0.75 + y_adj))
# board <- image_composite(board, tiles_with_prob[[15]], offset=paste0("+", 3.5*width + x_adj,
#                                                                              "+", 3*height*0.75 + y_adj))
# board <- image_composite(board, tiles_with_prob[[17]], offset=paste0("+", 2.5*width + x_adj,
#                                                                              "+", 3*height*0.75 + y_adj))
# board <- image_composite(board, tiles_with_prob[[18]], offset=paste0("+", 2*width + x_adj,
#                                                                              "+", 2*height*0.75 + y_adj))
# board <- image_composite(board, tiles_with_prob[[19]], offset=paste0("+", 3*width + x_adj,
#                                                                              "+", 2*height*0.75 + y_adj))
# 
# 
# output$img <- renderImage({
#   tmpfile <- tiles1()$board %>%
#     image_write(tempfile(fileext='jpg'), format = 'jpg')
# 
#   # Return a list
#   list(src = tmpfile, contentType = "image/jpeg")
# })
}

# Run the application 
shinyApp(ui = ui, server = server)

