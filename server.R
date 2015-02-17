shinyServer(
   function(input, output,session) {
      
      yrsubset<-reactive({
         subset(vehicle.data,(vehicle.data$Year>=input$yrs[1])&(vehicle.data$Year<=input$yrs[2]))
      })
      
      observe({
         yr_options<-as.list(input$yrs[1]:input$yrs[2])
         names(yr_options)<-input$yrs[1]:input$yrs[2]
         
         updateSelectInput(session, "yr",
                           choices = c('None',yr_options),
                           selected = input$yr)
         
         mk_vector<-unique(subset(vehicle.data,(vehicle.data$Year==input$yr))$Make)
         mk_options<-as.list(as.character(mk_vector))
         names(mk_options)<-as.character(mk_vector)
         
         updateSelectInput(session, "mk",
                           choices = c('None',mk_options),
                           selected = input$mk)

         mdl_vector<-unique(subset(vehicle.data,(vehicle.data$Year==input$yr & vehicle.data$Make==input$mk))$Model)
         mdl_options<-as.list(as.character(mdl_vector))
         names(mk_options)<-as.character(mdl_vector)
         
         updateSelectInput(session, "mdl",
                           choices = c('None',mdl_options),
                           selected = input$mdl)
         
      })
      
      output$plot <- renderPlot({
         p <- ggplot(yrsubset(), aes_string(x=input$x, y=input$y)) + geom_point()
         
         if (input$color != 'None')
            p <- p + aes_string(color=input$color)
         
         if (input$smooth)
            p <- p + geom_smooth()
         
         if (input$mdl!="None"){
            vehsel<-subset(vehicle.data,(vehicle.data$Year==input$yr &
                                            vehicle.data$Make==input$mk &
                                            vehicle.data$Model==input$mdl))
            p <- p + geom_point(data=vehsel,shape=13,size=5,colour="red")
         }
         
         print(p)
      })
      
      output$xout <- renderPrint({input$x})
      output$yout <- renderPrint({input$y})
      output$colorout <- renderPrint({input$color})
   }
)