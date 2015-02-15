# library(shiny)
# library(ggplot2)


shinyServer(
   function(input, output) {
      
      vehicle.data<-read.csv("data/vehicles.csv")[,c("year","make","model","VClass",
                                                     "cylinders","displ","trany","drive","evMotor","fuelType1","fuelType2",
                                                     "city08","highway08","comb08","cityA08","highwayA08","combA08",
                                                     "fuelCost08","fuelCostA08","youSaveSpend","co2TailpipeGpm",
                                                     "charge120","charge240")]
      
      names(vehicle.data)<-c("Year","Make","Model","Vehicle_Class",
                             "Cylinders","Displacement","Transmission","Drive","evMotor","Fuel_Type","Alt_Fuel_Type",
                             "City_MPG","Highway_MPG","Combined_MPG","City_Alt_MPG","Highway_Alt_MPG","Comb_Alt_MPG",
                             "Fuel_Cost","Alt_Fuel_Cost","You_Save_Spend","CO2_Tailpipe_GPM",
                             "Charge_Time_120","Charge_Time_240")
      
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