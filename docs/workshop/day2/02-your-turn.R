library(leaflet)
library(crosstalk)
library(plotly)

sd <- SharedData$new(quakes)
stations <- filter_slider("station", "Number of Stations", sd, ~stations)

p <- plot_ly(sd, x = ~depth, y = ~mag) %>% 
  add_markers(alpha = 0.5) %>% 
  highlight("plotly_selected")

map <- leaflet(sd) %>% 
  addTiles() %>% 
  addCircles()

tags <- bscols(
  widths = c(6, 6, 3), 
  p, map, stations
)

# res contains path to a temporary file
(res <- htmltools::html_print(tags))

# rename it to 'tmp.html'
file.rename(
  res, sub("index.html", "tmp.html", res, fixed = TRUE)
)

# we need the library assets, as well as the HTML file
src <- dir(dirname(res), full.names = TRUE)

# finally, copy over from the temporary directory, to the current directory
file.copy(src, ".", recursive = TRUE)

# delete the files, if you wish
# unlink(c("tmp.html", "lib"), recursive = TRUE)
