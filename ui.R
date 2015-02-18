shinyUI(fluidPage(
   
   titlePanel("Vehicle Data Explorer"),
   
   sidebarLayout(
      
      sidebarPanel(
         HTML('See Instructions Below'),
         
         sliderInput('yrs','Year Range',value = c(1995,2012), min = 1984, max = 2016, step = 1),
         selectInput('x', 'X', names(vehicle.data),selected='Combined_MPG'),
         selectInput('y', 'Y', names(vehicle.data),selected='Fuel_Cost'),
         selectInput('color', 'Color', c('None', names(vehicle.data)),selected='None'),
         checkboxInput('smooth', 'Smooth'),
         selectInput('yr', 'Year', c('None'),selected='None'),
         selectInput('mk', 'Make', c('None'),selected='None'),
         selectInput('mdl', 'Model', c('None'),selected='None'),
         
         HTML('<p>The data for this Vehicle Data Explorer comes from the CSV file with
            MPG data from 1984 to 2016 at 
            <a href=http://www.fueleconomy.gov/feg/download.shtml>fueleconomy.gov</a>.
           <h3>Instructions</h3>
           <p>Move the slider for the range of years you wish to see and select the 
           data to use for the X & Y axis and for the Color of the points. If you would like to see a smoothing 
           curve, check the Smooth checkbox. Note: Smoothing will only happen if 
           there are sufficient unique values to support 10 knots.</p>
           <p>If you would like to see where a particular vehicle is on the plot, select the year,
           make and model of the vehicle and red cross hatched circle(s) will indicate its position(s).</p>')
      ),
      
      mainPanel(
         plotOutput('plot',height="800px")
      )
   )
))