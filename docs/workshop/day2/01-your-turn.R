# https://github.com/ropensci/plotly/issues/957

library(plotly)
library(gapminder)

accumulate_by <- function(dat, var) {
  var <- lazyeval::f_eval(var, dat)
  lvls <- plotly:::getLevels(var)
  dats <- lapply(seq_along(lvls), function(x) {
    cbind(dat[var %in% lvls[seq(1, x)], ], frame = lvls[[x]])
  })
  dplyr::bind_rows(dats)
}

g <- accumulate_by(gapminder, ~year)

gg <- ggplot(g, aes(gdpPercap, lifeExp, ids = country, color = country)) +
  geom_path(aes(frame = frame), alpha = 0.4) +
  scale_x_log10() +
  theme(legend.position = "none")

ggplotly(gg, tooltip = "country") %>% 
  animation_opts(1000)
