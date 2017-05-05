library(sf)
library(dplyr)
library(albersusa)

usa <- usa_sf("laea")

# st_centroid gets the center POINT of polygons
uscenter <- usa %>% 
  st_centroid() %>%
  mutate(
    x = sapply(geometry, "[[", 1),
    y = sapply(geometry, "[[", 2)
  )

# the base map
map <- ggplot() + 
  geom_sf(data = usa, aes(fill = pop_2010))

# with an annotation for Wyoming 
map + 
  geom_text(
    data = filter(uscenter, name == "Wyoming"), 
    aes(x, y, label = name), color = "white", size = 2
  )
ggplotly()

# All the states!!!
# Pro tip: swap out geom_text() for ggrepel::geom_text_repel()
# Unfortunately, ggplotly() doesn't (yet) support it, hopefully soon!
map +
  geom_text(data = uscenter, aes(x, y, label = name))
ggplotly()


# Add text *on click*!!
library(crosstalk)
uscentersd <- SharedData$new(uscenter)
p <- ggplot() + 
  geom_sf(data = usa, aes(fill = pop_2010, text = paste("Population", pop_2010))) +
  geom_text(
    data = uscentersd, alpha = 0,
    aes(x, y, label = name, text = "Click to label me")
  )
ggplotly(p, tooltip = "text") %>%
  highlight(
    persistent = TRUE, 
    selected = attrs_selected(
      hoverinfo = "none",
      textfont = list(color = "black")
    )
  )
