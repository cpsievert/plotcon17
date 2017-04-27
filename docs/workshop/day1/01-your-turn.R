library(plotly)
library(albersusa)

usa_sf <- usa_sf("laea")

p <- ggplot(usa_sf) + 
  geom_sf(aes(fill = pop_2010, text = name)) 
# you can ignore the warning about text...
ggplotly(p)


# SharedData allows you define an "interaction unit"
library(crosstalk)
usa_sd <- SharedData$new(usa_sf)

p <- ggplot(usa_sd) + 
  geom_sf(aes(fill = pop_2010, text = name)) 

# Outline the polygons on hover
ggplotly(p) %>%
  highlight(
    "plotly_hover", opacityDim = 1, 
    selected = attrs_selected(line = list(color = "black"))
  )