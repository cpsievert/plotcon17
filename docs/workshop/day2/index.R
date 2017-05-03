## ---- include = FALSE----------------------------------------------------
#> knitr::opts_chunk$set(
#>   message = FALSE,
#>   fig.width = 10,
#>   fig.height = 4,
#>   comment = "#>",
#>   collapse = TRUE,
#>   eval = FALSE
#> )

## ---- eval = TRUE--------------------------------------------------------
library(plotly)
txhousing

## ------------------------------------------------------------------------
#> Abilene <- subset(txhousing, city == "Abilene")
#> p <- ggplot(Abilene, aes(month, sales, group = year)) +
#>   geom_line()
#> ggplotly(p, dynamicTicks = "x")

## ------------------------------------------------------------------------
#> p <- ggplot(Abilene, aes(month, sales, frame = year)) +
#>   geom_line()
#> ggplotly(p)

## ------------------------------------------------------------------------
#> p <- plot_ly(Abilene, x = ~month, y = ~log(sales), frame = ~year, showlegend = F)
#> add_lines(p)

## ------------------------------------------------------------------------
#> p <- ggplot(Abilene, aes(month, sales)) +
#>   geom_line(aes(group = year), alpha = 0.2) +
#>   geom_line(aes(frame = year), color = "red")
#> ggplotly(p)

## ------------------------------------------------------------------------
#> animation_opts(
#>   ggplotly(p), frame = 1000, easing = "elastic"
#> )

## ------------------------------------------------------------------------
#> animation_button(
#>    ggplotly(p), x = 1, xanchor = "right", y = 1, yanchor = "middle"
#> )

## ------------------------------------------------------------------------
#> animation_slider(
#>    ggplotly(p), currentvalue = list(prefix = "YEAR ", font = list(color = "red"))
#> )

## ------------------------------------------------------------------------
#> data(gapminder, package = "gapminder")
#> gg <- ggplot(gapminder, aes(gdpPercap, lifeExp, color = continent, size = pop)) +
#>   geom_point(alpha = 0.1) +
#>   geom_point(aes(frame = year, ids = country)) +
#>   scale_x_log10()
#> ggplotly(gg) %>% animation_opts(1000, redraw = FALSE)

## ------------------------------------------------------------------------
#> library(crosstalk)
#> d <- SharedData$new(Abilene, ~year)
#> p <- ggplot(d, aes(month, sales)) +
#>   geom_line(aes(group = year))
#> ggplotly(p, tooltip = "year")

## ------------------------------------------------------------------------
#> d <- subset(txhousing, city %in% c("Galveston", "Midland", "Odessa", "South Padre Island"))
#> sd <- SharedData$new(d, ~year)
#> p <- ggplot(sd, aes(month, median, group = year)) + geom_line() +
#>   facet_wrap(~city, ncol = 2)
#> (gg <- ggplotly(p, tooltip = "year"))

## ------------------------------------------------------------------------
#> txhousing %>%
#>   select(median, volume, listings, inventory) %>%
#>   GGally::ggpairs() %>% ggplotly() %>% highlight("plotly_selected")

## ------------------------------------------------------------------------
#> highlight(gg, "plotly_hover")

## ------------------------------------------------------------------------
#> highlight(gg, defaultValues = "2006")

## ------------------------------------------------------------------------
#> highlight(
#>   gg, dynamic = TRUE, persistent = TRUE, selectize = TRUE
#> )

## ------------------------------------------------------------------------
#> highlight(
#>   gg, dynamic = TRUE, persistent = TRUE,
#>   selected = attrs_selected(mode = "markers+lines", marker = list(symbol = "x"))
#> )

## ------------------------------------------------------------------------
#> demo("highlight-pipeline", package = "plotly")

## ------------------------------------------------------------------------
#> demo("highlight-binned-target", package = "plotly")

## ------------------------------------------------------------------------
#> demo("highlight-binned-target", package = "plotly")

## ------------------------------------------------------------------------
#> a <- SharedData$new(Abilene, ~month)
#> p <- ggplot(a, aes(month, sales, frame = year)) +
#>   geom_line() + geom_point()
#> highlight(ggplotly(p), "plotly_selected")

## ------------------------------------------------------------------------
#> g <- SharedData$new(gapminder, ~continent)
#> gg <- ggplot(g, aes(gdpPercap, lifeExp, color = continent, frame = year)) +
#>   geom_point(aes(size = pop, ids = country)) +
#>   geom_smooth(se = FALSE, method = "lm")
#> ggplotly(gg + scale_x_log10())

## ------------------------------------------------------------------------
#> demo("tour-USArrests", package = "plotly")

## ------------------------------------------------------------------------
#> tx <- SharedData$new(txhousing)
#> widgets <- bscols(widths = c(12, 12, 12),
#>   filter_select("city", "Cities", tx, ~city),
#>   filter_slider("sales", "Sales", tx, ~sales),
#>   filter_checkbox("year", "Years", tx, ~year, inline = TRUE)
#> )
#> widgets

## ------------------------------------------------------------------------
#> bscols(
#>   widths = c(4, 8), widgets,
#>   plot_ly(tx, x = ~date, y = ~median, showlegend = FALSE) %>%
#>     add_lines(color = ~city, colors = "black", connectgaps = FALSE) # bug in plotly.js?
#> )

## ------------------------------------------------------------------------
#> library(leaflet)
#> sd <- SharedData$new(quakes)
#> p <- plot_ly(sd, x = ~depth, y = ~mag) %>% add_markers(alpha = 0.5) %>% highlight("plotly_selected")
#> map <- leaflet(sd) %>% addTiles() %>% addCircles()
#> bscols(p, map)

