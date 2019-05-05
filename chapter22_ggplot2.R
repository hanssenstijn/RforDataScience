# get clean ws
rm(list=ls())

# load lib
library(tidyverse)
library(ggrepel)

# add lables : labs()
# may add caption and subtitle
ggplot(mpg, aes(displ, hwy)) +
    geom_point(aes(color = class)) +
    geom_smooth(se = FALSE) +
    labs(
        title = paste(
            "Fuel efficiency generally decreases with engine size"
        ))

# add axis names and legend title
ggplot(mpg, aes(displ, hwy)) +
    geom_point(aes(color = class)) +
    geom_smooth(se = FALSE) +
    labs(
        x = "Engine displacement (L)",
        y = "Highway fuel economy (mpg)",
        colour = "Car type"
    )

# add mathematical equations as labels
df <- tibble(
    x = runif(10),
    y = runif(10)
)
ggplot(df, aes(x, y)) +
    geom_point() +
    labs(
        x = quote(sum(x[i] ^ 2, i == 1, n)),
        y = quote(alpha + beta + frac(delta, theta))
    )

# annotations
# gemo_text() label points by text
# first group the top cars
best_in_class <- mpg %>%
    group_by(class) %>%
    filter(row_number(desc(hwy)) == 1)
# next use the labels from the filter of top cars in the plot
ggplot(mpg, aes(displ, hwy)) +
    geom_point(aes(color = class)) +
    geom_text(aes(label = model), data = best_in_class)

# use geom label to make it easier to read
# place rectangle behind the text
ggplot(mpg, aes(displ, hwy)) +
    geom_point(aes(color = class)) +
    geom_label(
        aes(label = model),
        data = best_in_class,
        nudge_y = 2,
        alpha = 0.5
    )

# make sure that overlayed text boxes are readable
ggplot(mpg, aes(displ, hwy)) +
    geom_point(aes(color = class)) +
    geom_point(size = 3, shape = 1, data = best_in_class) +
    ggrepel::geom_label_repel(
        aes(label = model),
        data = best_in_class
    )

# Use geom_hline() and geom_vline() to add reference lines.
# Use geom_rect() to draw a rectangle around points of interest.
# Use geom_segment() with the arrow argument to draw attention
# to a point with an arrow.

# Axis Ticks and Legend Keys
# override the y axis
ggplot(mpg, aes(displ, hwy)) +
    geom_point() +
    scale_y_continuous(breaks = seq(15, 40, by = 5))

# dont want to share the axis numbers
ggplot(mpg, aes(displ, hwy)) +
    geom_point() +
    scale_x_continuous(labels = NULL) +
    scale_y_continuous(labels = NULL)

# change color set
ggplot(mpg, aes(displ, hwy)) +
    geom_point(aes(color = drv)) +
    scale_color_brewer(palette = "Set1")

# assign specific colors
presidential %>%
    mutate(id = 33 + row_number()) %>%
    ggplot(aes(start, id, color = party)) +
    geom_point() +
    geom_segment(aes(xend = end, yend = id)) +
    scale_colour_manual(
        values = c(Republican = "red", Democratic = "blue")
    )

# change the theme of the plot
ggplot(mpg, aes(displ, hwy)) +
    geom_point(aes(color = class)) +
    geom_smooth(se = FALSE) +
    theme_bw()

#ggsave() for saving the plot

# resizing figures in markdown
# --> fig.width, fig.height, fig.asp, out.width, and out.height.
