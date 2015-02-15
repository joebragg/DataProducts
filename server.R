shinyServer(
   function(input, output) {
      yrsubset<-reactive({
         subset(vehicle.data,(vehicle.data$Year>=input$yrs[1])&(vehicle.data$Year<=input$yrs[2]))
      })
      
      output$plot <- renderPlot({
         p <- ggplot(yrsubset(), aes_string(x=input$x, y=input$y)) + geom_point()
         
         if (input$color != 'None')
            p <- p + aes_string(color=input$color)
         
         print(p)
      })
      
      output$xout <- renderPrint({input$x})
      output$yout <- renderPrint({input$y})
      output$colorout <- renderPrint({input$color})
   }
)