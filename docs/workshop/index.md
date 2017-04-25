# R Workshop at plotcon 2017

## Getting Started

Before we start, make sure you can successfully install all [the dependencies](https://github.com/cpsievert/plotcon17/blob/master/DESCRIPTION) on your machine:

```r
if (!require(devtools)) install.packages("devtools")
devtools::install_github("cpsievert/plotcon17")
```

## Outline

The workshop will roughly follow this outline (inspired by the [plotly for R book](https://cpsievert.github.io/plotly_book/)):

* A tale of 2 interfaces
    * Converting **ggplot2** via `ggplotly()`.
    * Directly interfacing to plotly.js with `plot_ly()`.
    * Augmenting `ggplotly()` via `layout()` and friends.
    * Accessing and leveraging **ggplot2** internals.
    * Accessing any plot spec via `plotly_json()`.
  
* The `plot_ly()` cookbook
    * Scatter traces
    * Maps
    * Bars & histograms
    * Boxplots
    * 2D frequencies
    * 3D plots

* Arranging multiple views
    * Arranging htmlwidget objects
    * Merging plotly objects into a subplot
    * Navigating many views
  
* Multiple linked views
    * Linking views with shiny
    * Linking views without shiny
    * Linking views "without shiny, inside shiny"

* Animating views
    * Key frame animations
    * Linking animated views
  
### IF WE HAVE TIME
  
* Advanced topics
    * Adding custom behavior with [the plotly.js API](https://plot.ly/javascript/plotlyjs-function-reference) and `htmlwidgets::onRender()`.
    * Translating ggplot2 geoms to plotly
  
