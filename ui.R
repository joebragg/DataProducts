shinyUI(pageWithSidebar(
   
   headerPanel("Vehicle Data Explorer"),
   
   sidebarPanel(
      sliderInput('yrs','Year Range',value = c(1995,2012), min = 1984, max = 2016, step = 1),
      selectInput('x', 'X', names(vehicle.data),selected='Combined_MPG'),
      selectInput('y', 'Y', names(vehicle.data),selected='Fuel_Cost'),
      selectInput('color', 'Color', c('None', names(vehicle.data)),selected='None'),
      HTML('The data for this Vehicle Data Explorer comes from the CSV file with MPG data
            from 1984 to 2016 at <a href=http://www.fueleconomy.gov/feg/download.shtml>fueleconomy.gov</a>.
           <p>Just move the slider for the range of years you wish to see and select the 
           data to use for the X & Y axis and for the Color of the points.</p>')
   ),
   mainPanel(
      plotOutput('plot',height="800px"),
      verbatimTextOutput("xout"),
      verbatimTextOutput("yout"),
      verbatimTextOutput("colorout")
   )
))