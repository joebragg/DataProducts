library(shiny)
library(ggplot2)

shinyServer(
   function(input, output) {
      
      if(!file.exists("data/vehicles.csv")){
         download.file("http://www.fueleconomy.gov/feg/epadata/vehicles.csv.zip",
                       destfile="data/vehicles.csv.zip")
         unzip("data/vehicles.csv.zip",exdir="data")
      }
      
      vehicle.data<-read.csv("data/vehicles.csv")
      
      output$plot <- renderPlot({
         p <- ggplot(vehicle.data, aes_string(x=input$x, y=input$y)) + geom_point()
         
         if (input$color != 'None')
            p <- p + aes_string(color=input$color)
         
         print(p)
         })
      output$xout <- renderPrint({input$x})
      output$yout <- renderPrint({input$y})
      output$colorout <- renderPrint({input$color})
      }
   )