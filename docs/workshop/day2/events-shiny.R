library(ggplot2)
library(shiny)

ui <- fluidPage(
  plotOutput("plotID", brush = brushOpts(id = "plotBrushID")),
  verbatimTextOutput("brushInfo")
)

server <- function(input, output) {
  
  output$plotID <- renderPlot({
    ggplot(mtcars, aes(wt, mpg)) + geom_point()
  })
  
  output$brushInfo <- renderPrint({
    cat("input$plot_brush:\n")
    str(input$plotBrushID)
  })
  
}

shinyApp(ui, server)