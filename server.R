#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
data(mtcars)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    output$plot_mpgwt <- renderPlot({
        cyls <- input$cyl
        plotdata <- mtcars[mtcars$cyl %in% cyls,]
        plot(plotdata$wt, plotdata$mpg,
             xlab="Weight", ylab="MPG",
             main = "MPG by Weight for models with selected cylinders",
             xlim=c(1,4), ylim=c(10,40),
             col=plotdata$cyl, pch=19, cex=3)
    })
    
    model <- reactive({
        brushed_data <- brushedPoints(mtcars, input$brush, xvar = "wt", yvar = "mpg")
        if(nrow(brushed_data) < 2){
            return(NULL)
        }
        lm(mpg ~ wt, data = brushed_data)
    })
    
    output$intercept <- renderText({
        if(is.null(model)){
            "No model found"
        } else{
            model()[[1]][1]
        }
    })
    
    output$slope <- renderText({
        if(is.null(model)){
            "No model found"
        } else{
            model()[[1]][2]
        }
    })

})
