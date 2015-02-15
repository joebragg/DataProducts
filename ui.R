library(shiny)
library(ggplot2)

if(!file.exists("data/vehicles.csv")){
   download.file("http://www.fueleconomy.gov/feg/epadata/vehicles.csv.zip",
                 destfile="data/vehicles.csv.zip")
   unzip("data/vehicles.csv.zip",exdir="data")
}
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

shinyUI(pageWithSidebar(
   
   headerPanel("Vehicle Data Explorer"),
   
   sidebarPanel(
      sliderInput('yrs','Year Range',value = c(1995,2012), min = 1984, max = 2016, step = 1),
      selectInput('x', 'X', names(vehicle.data),selected='Combined_MPG'),
      selectInput('y', 'Y', names(vehicle.data),selected='Fuel_Cost'),
      selectInput('color', 'Color', c('None', names(vehicle.data)),selected='None')
   ),
   mainPanel(
      plotOutput('plot',height="800px"),
      verbatimTextOutput("xout"),
      verbatimTextOutput("yout"),
      verbatimTextOutput("colorout")
   )
   
))