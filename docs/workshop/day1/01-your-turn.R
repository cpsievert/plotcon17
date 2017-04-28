library(plotly)
library(albersusa)

usa_sf <- usa_sf("laea")

p <- ggplot(usa_sf) + 
  geom_sf(aes(fill = pop_2010, text = name)) 
# you can ignore the warning about text...
ggplotly(p)

# Want to outline the state on hover?
# Use SharedData to assign an "interaction unit"
# By default, each row is the "interaction unit" (in this case, state)
library(crosstalk)
usa_sd <- SharedData$new(usa_sf)

# same as before
p <- ggplot(usa_sd) + 
  geom_sf(aes(fill = pop_2010, text = name)) 

# Outline the polygons on hover
ggplotly(p) %>%
  highlight(
    "plotly_hover", opacityDim = 1, 
    selected = attrs_selected(line = list(color = "black"))
  )