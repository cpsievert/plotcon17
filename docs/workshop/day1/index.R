## ---- include = FALSE----------------------------------------------------
knitr::opts_chunk$set(
  eval = FALSE,
  message = FALSE,
  fig.width = 10,
  fig.height = 4,
  comment = "#>",
  collapse = TRUE
)

## ---- eval = TRUE--------------------------------------------------------
str(mtcars)

## ---- eval = TRUE--------------------------------------------------------
nms <- names(mtcars)
nms

## ---- eval = TRUE--------------------------------------------------------
library(magrittr)
mtcars %>% names()

## ---- eval = TRUE--------------------------------------------------------
# read left-to-right
mtcars %>% names() %>% length()


# not inside out
length(names(mtcars))

## ------------------------------------------------------------------------
library(albersusa)
usa <- usa_sf("laea")

library(dplyr)
usa %>%
 select(name, pop_2010, geometry) %>%
 View()

## ---- echo = FALSE, eval = TRUE------------------------------------------
library(albersusa)
library(dplyr)

## ---- eval = TRUE--------------------------------------------------------
usa_sf("laea") %>% select(pop_2010, geometry) %>% plot()

## ------------------------------------------------------------------------
library(plotly)
usa_sf <- mutate(
  usa_sf("laea"), txt = paste("The state of", name, "had \n", pop_2010, "people in 2010")
)
p <- ggplot(usa_sf) + 
  geom_sf(aes(fill = pop_2010, text = txt)) 
ggplotly(p, tooltip = "text")

## ------------------------------------------------------------------------
class(p)
#> [1] "gg"     "ggplot"
gg <- ggplotly(p, tooltip = "text")
class(gg)
#> [1] "plotly"     "htmlwidget"

## ---- eval = TRUE--------------------------------------------------------
barchart <- list(
  data = list(list(
    x = c("a", "b", "c"),
    y = c(1, 2, 3),
    type = "bar"
  ))
)
plotly:::to_JSON(barchart, pretty = TRUE)

## ---- eval = TRUE--------------------------------------------------------
str(barchart$data)
identical(barchart$data, barchart[["data"]])

## ---- eval = TRUE--------------------------------------------------------
str(barchart["data"])

## ---- eval = TRUE--------------------------------------------------------
str(mtcars["vs"])
str(mtcars[["vs"]])

## ---- eval = TRUE--------------------------------------------------------
library(plotly)
as_widget(barchart)

## ---- eval = TRUE--------------------------------------------------------
# plot_ly() adds some useful abstractions that we'll get to later
plot_ly() %>%
  add_bars(
    x =  c("a", "b", "c"),
    y = c(1, 2, 3), 
    unsupported = "nonsense"
  )

## ------------------------------------------------------------------------
# In recent versions of RStudio -- View(gg$x)
plotly_json(gg)

## ------------------------------------------------------------------------
gg2 <- gg %>%
  style(mode = "markers+lines", traces = 2) %>%
  layout(title = "A map of 2010 population", margin = list(t = 30))

## ------------------------------------------------------------------------
# The 'x' element stores the list converted to JSON
# plotly_json() just provides a more pleasant interface to gg$x
str(gg2$x$data[[2]])

## ------------------------------------------------------------------------
d <- gg$x$data[[52]]
add_polygons(gg, x = d$x, y = d$y, color = I("red"), inherit = FALSE)

## ------------------------------------------------------------------------
# In recent versions of RStudio -- View(plotly:::Schema)
schema()

