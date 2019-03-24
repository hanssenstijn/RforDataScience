# Data visualization with ggplot2
library(tidyverse)

# data from packages from outside the tidyverse:
# install.packages(c("nycflights13", "gapminder", "Lahman"))
library(nycflights13)
library(gapminder)
library(Lahman)

# plot colors in class
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, color = class))

# plot on size
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, size = class))

# transparency of the points
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

# To facet your plot by a single variable, use facet_wrap().
# The first argument of facet_wrap() should be a formula, which you create
# with ~ followed by a variable name (here "formula" is the name of a
# data structure in R, not a synonym for "equation"). The variable that
# you pass to facet_wrap() should be discrete:
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy)) +
    facet_wrap(~ class, nrow = 2)

# To facet your plot on the combination of two variables, add
# facet_grid() to your plot call. The first argument of facet_grid()
# is also a formula.
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy)) +
    facet_grid(drv ~ cyl)

# If you place mappings in a geom function, ggplot2 will treat them as
# local mappings for the layer. It will use these mappings to extend or
# overwrite the global mappings for that layer only. This makes it possible
# to display different aesthetics in different layers:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
    geom_point(mapping = aes(color = class)) +
    geom_smooth()

# example, you might want to
# display a bar chart of proportion, rather than count
ggplot(data = diamonds) +
    geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))
# If `group = 1` is not included, then all the bars in the plot will have the same height, a height of 1.


# use stat_sum mary(), which summarizes the y values for each unique x value
ggplot(data = diamonds) +
    stat_summary(mapping = aes(x = cut, y = depth),
        fun.ymin = min,
        fun.ymax = max,
        fun.y = median)

# position = "dodge" places overlapping objects directly beside one another.
ggplot(data = diamonds) +
    geom_bar(mapping = aes(x = cut, fill = clarity),position = "dodge")

# You can avoid this gridding by setting the position adjustment to
# "jitter." position = "jitter" adds a small amount of random noise
# to each point.
ggplot(data = mpg) +
    geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")

# coord_flip() switches the x- and y-axes. This is useful 
# (for example) if you want horizontal boxplots.
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
    geom_boxplot() +
    coord_flip()
