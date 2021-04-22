#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Fuel Efficiency Data: Fit linear models"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("cyl", "Number of cylinders", choices=c(4,6,8), multiple = TRUE),
            h3("Intercept"),
            textOutput("intercept"),
            h3("Slope"),
            textOutput("slope")
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("plot_mpgwt", brush = brushOpts(id="brush"))
        )
    )
))
