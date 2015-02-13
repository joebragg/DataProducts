library(shiny)
library(ggplot2)

if(!file.exists("data/vehicles.csv")){
   download.file("http://www.fueleconomy.gov/feg/epadata/vehicles.csv.zip",
                 destfile="data/vehicles.csv.zip")
   unzip("data/vehicles.csv.zip",exdir="data")
}
vehicle.data<-read.csv("data/vehicles.csv")

shinyUI(pageWithSidebar(
   
   headerPanel("Vehicle Data Explorer"),
   
   sidebarPanel(
      selectInput('x', 'X', names(vehicle.data),selected='year'),
      selectInput('y', 'Y', names(vehicle.data),selected='youSaveSpend'),
      selectInput('color', 'Color', c('None', names(vehicle.data)),selected='None')
      ),
   mainPanel(
      plotOutput('plot'),
      verbatimTextOutput("xout"),
      verbatimTextOutput("yout"),
      verbatimTextOutput("colorout")
   )
   
))