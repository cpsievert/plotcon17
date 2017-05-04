library(plotly)
library(crosstalk)

carz <- SharedData$new(cars)
base <- plot_ly(carz, color = I("black"), showlegend = FALSE)
p1 <- base %>% add_markers(x = ~speed, y = ~dist)
p2 <- base %>% add_histogram(x = ~speed, nbinsx = 30)
p3 <- base %>% add_histogram(y = ~dist, nbinsy = 20)

subplot(
  p2, plotly_empty(), p1, p3,
  nrows = 2, shareX = TRUE, shareY = TRUE
) %>% 
  layout(barmode = "overlay") %>%
  highlight("plotly_selected")
