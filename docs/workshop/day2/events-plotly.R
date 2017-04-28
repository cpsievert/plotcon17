library(plotly)
library(shiny)

# plotlyOutput(), not plotOutput()
ui <- fluidPage(
  plotlyOutput("plotID"),
  verbatimTextOutput("brushInfo")
)

server <- function(input, output) {
  
  # renderPlotly(), not renderPlot()
  output$plotID <- renderPlotly({
    p <- ggplot(mtcars, aes(wt, mpg)) + geom_point()
    layout(ggplotly(p), dragmode = "select")
  })
  
  output$brushInfo <- renderPrint({
    event_data("plotly_selected")
  })
  
}

shinyApp(ui, server)